package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.APIResult;
import gaia3d.domain.APIURL;
import gaia3d.domain.CacheManager;
import gaia3d.domain.FileInfo;
import gaia3d.domain.ImageInfo;
import gaia3d.domain.OrthoDetectedObject;
import gaia3d.domain.OrthoImage;
import gaia3d.domain.PostProcessingImage;
import gaia3d.domain.TransferData;
import gaia3d.domain.TransferDataResource;
import gaia3d.domain.TransferDataType;
import gaia3d.persistence.TransferDataMapper;
import gaia3d.service.OrthoDetectedObjectService;
import gaia3d.service.OrthoImageService;
import gaia3d.service.PostProcessingImageService;
import gaia3d.service.TransferDataService;
import lombok.extern.slf4j.Slf4j;

/**
 * transfer data insert
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Service
public class TransferDataServiceImpl implements TransferDataService {

	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Autowired
	private PostProcessingImageService postProcessingImageService;
	@Autowired
	private OrthoDetectedObjectService orthoDetectedObjectService;
	@Autowired
	private OrthoImageService orthoImageService;
	@Autowired
	private TransferDataMapper transferDataMapper;
	
	/**
	 * transfer data insert
	 * @param fileInfo
	 * @param transferDataResource
	 * @return
	 */
	@Transactional
	public int insertTransferData(FileInfo fileInfo, TransferDataResource transferDataResource) {
		
		TransferData transferData = new TransferData();
		transferData.setDrone_project_id(transferDataResource.getDrone_project_id());
		transferData.setData_type(transferDataResource.getData_type());
		transferData.setFile_name(transferDataResource.getFile_name());
		transferData.setDetected_objects_count(transferDataResource.getDetected_objects().size());
		transferData.setDrone_latitude(transferDataResource.getDrone().getLatitude());
		transferData.setDrone_longitude(transferDataResource.getDrone().getLongitude());
		transferData.setDrone_altitude(transferDataResource.getDrone().getAltitude());
		transferData.setDrone_roll(transferDataResource.getDrone().getRoll());
		transferData.setDrone_pitch(transferDataResource.getDrone().getPitch());
		transferData.setDrone_yaw(transferDataResource.getDrone().getYaw());
		transferData.setShooting_date(transferDataResource.getShooting_date());
		int result = transferDataMapper.insertTransferData(transferData);
		
		Long imageId = null;
		if(TransferDataType.ORTHO_IMAGE.getDataType().equals(transferData.getData_type())) {
			OrthoImage orthoImage = new OrthoImage();
			orthoImage.setTransfer_data_id(transferData.getTransfer_data_id());
			orthoImage.setFile_name(fileInfo.getFile_name());
			orthoImage.setFile_real_name(fileInfo.getFile_real_name());
			orthoImage.setFile_path(fileInfo.getFile_path());
			orthoImage.setFile_size(fileInfo.getFile_size());
			orthoImage.setFile_ext(fileInfo.getFile_ext());
			orthoImageService.insertOrthoImage(orthoImage);
			
			for(OrthoDetectedObject orthoDetectedObject : transferDataResource.getDetected_objects()) {
				orthoDetectedObject.setOrtho_image_id(orthoImage.getOrtho_image_id());
				orthoDetectedObjectService.insertOrthoDetectedObject(orthoDetectedObject);
			}
			
			imageId = orthoImage.getOrtho_image_id();
		} else if(TransferDataType.POSTPROCESSION_IMAGE.getDataType().equals(transferData.getData_type())) {
			PostProcessingImage postProcessingImage = new PostProcessingImage();
			postProcessingImage.setTransfer_data_id(transferData.getTransfer_data_id());
			// TODO 이 컬럼은 없는게 맞는거 같음
			postProcessingImage.setFile_type(null);
			postProcessingImage.setFile_name(fileInfo.getFile_name());
			postProcessingImage.setFile_real_name(fileInfo.getFile_real_name());
			postProcessingImage.setFile_path(fileInfo.getFile_path());
			postProcessingImage.setFile_size(fileInfo.getFile_size());
			postProcessingImage.setFile_ext(fileInfo.getFile_ext());
			postProcessingImageService.insertPostProcessingImage(postProcessingImage);
			
			imageId = postProcessingImage.getPostprocessing_image_id();
		}
		
		callImageProcessing(transferDataResource.getDrone_project_id(), 
							transferDataResource.getData_type(), 
							imageId, 
							fileInfo.getFile_path() + fileInfo.getFile_real_name(),
							transferDataResource.getShooting_date());
		
		return result;
	}
	
	private void callImageProcessing(Integer projectId, String dataType, Long imageId, String fileNameFullPath, String imageDate) {
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(projectId);
		imageInfo.setDataType(dataType);
		imageInfo.setImageId(imageId);
		imageInfo.setImagePath(fileNameFullPath);
		imageInfo.setImageDate(imageDate);
		
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<ImageInfo> request = new HttpEntity<>(imageInfo, headers);
		
		RestTemplate restTemplate = new RestTemplate();
		String url = CacheManager.getPolicy().getRest_api_converter_url() + APIURL.CONVERTER.getUrl();
		log.info("url = {}", url);
		ResponseEntity<APIResult> aPIResult = restTemplate.postForEntity(url, request, APIResult.class);
		log.info("callImageProcessing status code = {}", aPIResult.getStatusCodeValue());
		log.info("callImageProcessing aPIResult body = {}", aPIResult.getBody());
	}
}
