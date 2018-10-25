package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.RestTemplateResponseErrorHandler;
import gaia3d.domain.APIURL;
import gaia3d.domain.CacheManager;
import gaia3d.domain.DroneProject;
import gaia3d.domain.FileInfo;
import gaia3d.domain.ImageInfo;
import gaia3d.domain.OrthoDetectedObject;
import gaia3d.domain.OrthoImage;
import gaia3d.domain.PostProcessingImage;
import gaia3d.domain.ProjectStatus;
import gaia3d.domain.TransferData;
import gaia3d.domain.TransferDataResource;
import gaia3d.domain.TransferDataStatus;
import gaia3d.domain.TransferDataType;
import gaia3d.persistence.TransferDataMapper;
import gaia3d.service.DroneProjectService;
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
	private RestTemplateBuilder restTemplateBuilder;
	@Autowired
	private RestTemplateResponseErrorHandler restTemplateResponseErrorHandler;
	
	@Autowired
	private DroneProjectService droneProjectService;
	@Autowired
	private PostProcessingImageService postProcessingImageService;
	@Autowired
	private OrthoDetectedObjectService orthoDetectedObjectService;
	@Autowired
	private OrthoImageService orthoImageService;
	@Autowired
	private TransferDataMapper transferDataMapper;
	
	/**
	 * all list transfer data by drone_project_id
	 * @param drone_project_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<TransferData> getListTransferData(Integer drone_project_id) {
		return transferDataMapper.getListTransferData(drone_project_id);
	}
	
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
		transferData.setOrtho_detected_object_count(transferDataResource.getDetected_objects().size());
		transferData.setDrone_latitude(transferDataResource.getDrone().getLatitude());
		transferData.setDrone_longitude(transferDataResource.getDrone().getLongitude());
		transferData.setDrone_altitude(transferDataResource.getDrone().getAltitude());
		transferData.setDrone_roll(transferDataResource.getDrone().getRoll());
		transferData.setDrone_pitch(transferDataResource.getDrone().getPitch());
		transferData.setDrone_yaw(transferDataResource.getDrone().getYaw());
		transferData.setShooting_date(transferDataResource.getShooting_date());
		int result = transferDataMapper.insertTransferData(transferData);
		
		String projectStatus = null;
		Long imageId = null;
		OrthoImage orthoImage = null;
		PostProcessingImage postProcessingImage = null;
		int ortho_image_count = 0;
		int postprocessing_image_count = 0;
		int ortho_detected_object_count = 0;
		if(TransferDataType.ORTHO_IMAGE.getDataType().equals(transferData.getData_type())) {
			orthoImage = new OrthoImage();
			orthoImage.setDrone_project_id(transferDataResource.getDrone_project_id());
			orthoImage.setTransfer_data_id(transferData.getTransfer_data_id());
			orthoImage.setFile_name(fileInfo.getFile_name());
			orthoImage.setFile_real_name(fileInfo.getFile_real_name());
			orthoImage.setFile_path(fileInfo.getFile_path());
			orthoImage.setFile_size(fileInfo.getFile_size());
			orthoImage.setFile_ext(fileInfo.getFile_ext());
			orthoImageService.insertOrthoImage(orthoImage);
			ortho_image_count++;
			
			for(OrthoDetectedObject orthoDetectedObject : transferDataResource.getDetected_objects()) {
				orthoDetectedObject.setDrone_project_id(transferDataResource.getDrone_project_id());
				orthoDetectedObject.setOrtho_image_id(orthoImage.getOrtho_image_id());
				orthoDetectedObjectService.insertOrthoDetectedObject(orthoDetectedObject);
				ortho_detected_object_count++;
			}
			
			projectStatus = ProjectStatus.ORTHO_IMAGE.getStatus();
			imageId = orthoImage.getOrtho_image_id();
		} else if(TransferDataType.POSTPROCESSING_IMAGE.getDataType().equals(transferData.getData_type())) {
			postProcessingImage = new PostProcessingImage();
			postProcessingImage.setDrone_project_id(transferDataResource.getDrone_project_id());
			postProcessingImage.setTransfer_data_id(transferData.getTransfer_data_id());
			// TODO 이 컬럼은 없는게 맞는거 같음
			postProcessingImage.setFile_type(null);
			postProcessingImage.setFile_name(fileInfo.getFile_name());
			postProcessingImage.setFile_real_name(fileInfo.getFile_real_name());
			postProcessingImage.setFile_path(fileInfo.getFile_path());
			postProcessingImage.setFile_size(fileInfo.getFile_size());
			postProcessingImage.setFile_ext(fileInfo.getFile_ext());
			postProcessingImageService.insertPostProcessingImage(postProcessingImage);
			postprocessing_image_count++;
			
			projectStatus = ProjectStatus.POSTPROCESSING_IMAGE.getStatus();
			imageId = postProcessingImage.getPostprocessing_image_id();
		}
		
		String status = null;
		try {
			HttpStatus httpStatus = callImageProcessing(transferDataResource.getDrone_project_id(), 
										transferDataResource.getData_type(), 
										imageId, 
										fileInfo.getFile_path() + fileInfo.getFile_real_name(),
										transferDataResource.getShooting_date());
			
			if(HttpStatus.OK.equals(httpStatus)) {
				transferData.setStatus(TransferDataStatus.CONVERTER_COMPLETE.getStatus());
				status = TransferDataStatus.CONVERTER_COMPLETE.getStatus();
			} else {
				transferData.setStatus(TransferDataStatus.CONVERTER_FAIL.getStatus());
				status = TransferDataStatus.CONVERTER_FAIL.getStatus();
			}
		} catch (Exception e) {
			transferData.setStatus(TransferDataStatus.CONVERTER_ERROR.getStatus());
			status = TransferDataStatus.CONVERTER_ERROR.getStatus();
		} finally {
			DroneProject droneProject = new DroneProject();
			droneProject.setDrone_project_id(transferDataResource.getDrone_project_id());
			droneProject.setStatus(projectStatus);
			droneProject.setOrtho_image_count(ortho_image_count);
			droneProject.setPostprocessing_image_count(postprocessing_image_count);
			droneProject.setOrtho_detected_object_count(ortho_detected_object_count);
			String location = String.format("POINT (%f %f)", transferData.getDrone_longitude(), transferData.getDrone_latitude());
			droneProject.setLocation(location);
			
			log.info("*************** ortho = {}, postprocessing = {}, ortho_detected_object_count={}", ortho_image_count, postprocessing_image_count, ortho_detected_object_count);
			droneProjectService.updateDroneProject(droneProject);
			
			transferDataMapper.updateTransferData(transferData);
			if(TransferDataType.ORTHO_IMAGE.getDataType().equals(transferData.getData_type())) {
				orthoImage.setStatus(status);
				orthoImageService.updateOrthoImage(orthoImage);
			} else {
				postProcessingImage.setStatus(status);
				postProcessingImageService.updatePostProcessingImage(postProcessingImage);
			}
		}
		
		return result;
	}
	
	private HttpStatus callImageProcessing(Integer projectId, String dataType, Long imageId, String fileNameFullPath, String imageDate) {
		ImageInfo imageInfo = new ImageInfo();
		imageInfo.setProjectId(projectId);
		imageInfo.setDataType(dataType);
		imageInfo.setImageId(imageId);
		imageInfo.setImagePath(fileNameFullPath);
		imageInfo.setImageDate(imageDate);
		
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<ImageInfo> entity = new HttpEntity<>(imageInfo, headers);
			
		String url = CacheManager.getPolicy().getRest_api_converter_url() + APIURL.CONVERTER.getUrl();
		RestTemplate restTemplate = restTemplateBuilder.errorHandler(restTemplateResponseErrorHandler)
									.setConnectTimeout(5000)
									.setReadTimeout(5000)
									.build();
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
		log.info("callImageProcessing status code = {}", response.getStatusCodeValue());
		log.info("callImageProcessing body = {}", response.getBody());
		return response.getStatusCode();
	}
}
