//package gaia3d.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestHeader;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//
//import gaia3d.config.PropertiesConfig;
//import gaia3d.domain.APIHeader;
//import gaia3d.domain.APIResult;
//import gaia3d.domain.APIValidationType;
//import gaia3d.domain.CacheManager;
//import gaia3d.domain.FileInfo;
//import gaia3d.domain.Policy;
//import gaia3d.domain.TokenLog;
//import gaia3d.domain.TransferDataResource;
//import gaia3d.service.APILogService;
//import gaia3d.service.TokenLogService;
//import gaia3d.service.TransferDataService;
//import gaia3d.util.FileUtil;
//import gaia3d.util.WebUtil;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//public class TransferDataController {
//	
//	@Autowired
//	private TransferDataService transferDataService;
//	
//
//	/**
//	 * 
//	 * @param request
//	 * @return
//	 */
//	@PostMapping("/transfer-data")
//	public ResponseEntity<APIResult> insertTransferData(MultipartHttpServletRequest request, 
//														@RequestParam("file") MultipartFile multipartFile, 
//														@RequestHeader("live_drone_map") String customHeader) {
//		log.info("@@@@@@@@@@ transfer data insert api call");
//		
//		
//		
//		return new ResponseEntity<APIResult>(aPIResult, httpStatus);
//	}
//}
