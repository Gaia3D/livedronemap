package gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import gaia3d.config.CacheConfig;
import gaia3d.domain.CacheType;
import gaia3d.domain.CacheName;
import gaia3d.domain.CacheParams;
import gaia3d.domain.CacheManager;
import gaia3d.domain.Policy;
import gaia3d.domain.Project;
import gaia3d.security.Crypt;
import gaia3d.service.PolicyService;

import lombok.extern.slf4j.Slf4j;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/config/")
public class PolicyController {
	
	@Autowired
	CacheConfig cacheConfig;
	@Autowired
	private PolicyService policyService;
	
	/**
	 * 운영 정책 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-policy")
	public String modifyPolicy(Model model) {
		
		Policy policy = policyService.getPolicy();
		log.info("@@@@@@@@@@ policy = {}", policy);
		
		policy.setSite_admin_mobile_phone(policy.getViewSiteAdminMobilePhone());
		policy.setSite_admin_email(policy.getViewSiteAdminEmail());
		policy.setBackoffice_user_db_url(Crypt.decrypt(policy.getBackoffice_user_db_url()));
		policy.setBackoffice_user_db_user(Crypt.decrypt(policy.getBackoffice_user_db_user()));
		policy.setBackoffice_user_db_password(Crypt.decrypt(policy.getBackoffice_user_db_password()));
		policy.setSolution_company_phone(policy.getViewSolutionCompanyPhone());
		policy.setSolution_manager_phone(policy.getViewSolutionManagerPhone());
		policy.setSolution_manager_email(policy.getViewSolutionManagerEmail());
		
		if(policy.getBackoffice_user_db_password() != null && policy.getBackoffice_user_db_password().length() > 4) {
//			policy.setBackoffice_user_db_password("****" + policy.getBackoffice_user_db_password().substring(4));
		}
		
		policy.setServer_ip(CacheManager.getServerIp());
		
		model.addAttribute("policy", policy);
		
//		model.addAttribute("policyUser", policy);
//		model.addAttribute("policyPassword", policy);
//
//		model.addAttribute("policySecurity", policy);
//		model.addAttribute("policyContent", policy);
//		model.addAttribute("policyOs", policy);
//		model.addAttribute("policyBackoffice", policy);
//		model.addAttribute("policySite", policy);
//		model.addAttribute("policySolution", policy);
		
		return "/config/modify-policy";
	}
	
	/**
	 * 운영 정책 사용자 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-user")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyUser(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0
					|| policy.getUser_id_min_length() == null || policy.getUser_id_min_length() < 4
					|| policy.getUser_fail_login_count() == null || policy.getUser_fail_login_count().intValue() <= 0
//					|| policy.getUser_fail_lock_release() == null || "".equals(policy.getUser_fail_lock_release())
					|| policy.getUser_last_login_lock() == null || "".equals(policy.getUser_last_login_lock())
					|| policy.getUser_duplication_login_yn() == null || "".equals(policy.getUser_duplication_login_yn())
//					|| policy.getUser_login_type() == null || "".equals(policy.getUser_login_type())
//					|| policy.getUser_update_check() == null || "".equals(policy.getUser_update_check())
//					|| policy.getUser_delete_check() == null || "".equals(policy.getUser_delete_check())
//					|| policy.getUser_delete_type() == null || "".equals(policy.getUser_delete_type())
//					|| policy.getUser_device_modify_yn() == null || "".equals(policy.getUser_device_modify_yn())
					) {
				result = "policy.user.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyUser(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}

	/**
	 * 운영 정책 패스워드 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-password")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyPassword(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0
					|| policy.getPassword_change_term() == null || "".equals(policy.getPassword_change_term())
					|| policy.getPassword_min_length() == null || policy.getPassword_min_length() <=0
					|| policy.getPassword_eng_upper_count() == null || policy.getPassword_eng_upper_count().intValue() < 0
					|| policy.getPassword_eng_lower_count() == null || policy.getPassword_eng_lower_count().intValue() < 0
					|| policy.getPassword_number_count() == null || policy.getPassword_number_count().intValue() < 0
					|| policy.getPassword_special_char_count() == null || policy.getPassword_special_char_count().intValue() < 0
					|| policy.getPassword_continuous_char_count() == null || policy.getPassword_continuous_char_count().intValue() < 0
//					|| policy.getPassword_create_char() == null || "".equals(policy.getPassword_create_char())
					) {
				result = "policy.password.invalid";
				map.put("result", result);
				return map;
			}
			
			if( policy.getPassword_eng_upper_count().intValue() == 0 && policy.getPassword_eng_lower_count().intValue() == 0 
					&& policy.getPassword_number_count().intValue() == 0 && policy.getPassword_special_char_count().intValue() == 0 ) {
				result = "policy.password.role.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyPassword(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}

	/**
	 * Geo Server 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-geoserver")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyGeoServer(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0) {
				result = "policy.geo.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyGeoServer(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * rest api
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-rest-api")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyRestAPI(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0) {
				result = "policy.restapi.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyRestAPI(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * project
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-project")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyProject(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0) {
				result = "policy.project.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyProject(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 운영 정책 알림 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-notice")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyNotice(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0
					|| policy.getNotice_service_yn() == null || "".equals(policy.getNotice_service_yn())
					|| policy.getNotice_service_send_type() == null || "".equals(policy.getNotice_service_send_type())
//					|| policy.getNotice_approval_request_yn() == null || "".equals(policy.getNotice_approval_request_yn())
//					|| policy.getNotice_approval_sign_yn() == null || "".equals(policy.getNotice_approval_sign_yn())
//					|| policy.getNotice_password_update_yn() == null || "".equals(policy.getNotice_password_update_yn())
//					|| policy.getNotice_approval_delay_yn() == null || "".equals(policy.getNotice_approval_delay_yn())
					|| policy.getNotice_risk_yn() == null || "".equals(policy.getNotice_risk_yn())
					|| policy.getNotice_risk_send_type() == null || "".equals(policy.getNotice_risk_send_type())
					|| policy.getNotice_risk_grade() == null || "".equals(policy.getNotice_risk_grade())
					) {
				result = "policy.notice.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyNotice(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 운영 정책 보안 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-security")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicySecurity(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0
					|| policy.getSecurity_session_timeout_yn() == null || "".equals(policy.getSecurity_session_timeout_yn())
					|| (Policy.Y.equals(policy.getSecurity_session_timeout_yn()) && (policy.getSecurity_session_timeout() == null || "".equals(policy.getSecurity_session_timeout())))
					|| policy.getSecurity_session_hijacking() == null || "".equals(policy.getSecurity_session_hijacking())
					|| policy.getSecurity_sso() == null || "".equals(policy.getSecurity_sso())
					|| policy.getSecurity_log_save_type() == null || "".equals(policy.getSecurity_log_save_type())
					|| policy.getSecurity_log_save_term() == null || "".equals(policy.getSecurity_log_save_term())
					|| policy.getSecurity_dynamic_block_yn() == null || "".equals(policy.getSecurity_dynamic_block_yn())
					) {
				result = "policy.security.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicySecurity(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 운영 정책 컨텐트 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-content")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyContent(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if( ( policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0 )
					|| ( policy.getContent_cache_version() == null || policy.getContent_cache_version().intValue() < 0)
					|| ( policy.getContent_main_widget_count() == null || policy.getContent_main_widget_count().intValue() < 0 )
					|| ( policy.getContent_main_widget_interval() == null || policy.getContent_main_widget_interval().intValue() < 5 )) {
				result = "policy.content.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyContent(policy);

			// TODO 모니터링 로그 간격 처리 process 추후 개발 여부 고민
//			if("UNIX".equals(ConfigCache.getOsType())) {
//				// TODO 모니터링 대몬에게 kill -SIGHUB pid 실행해 줘야 함
//				String sysmodPid = FileUtil.getPIDFromFile(DAEMON_PID_PATH + "otp_sysmond.pid");
//				boolean isProcessAlive = FileUtil.isProcessAlive(sysmodPid, "otp_sysmond");
//				if(isProcessAlive) {
//					// 프로세스에게 시그널을 보냄
//					String[] params = { "-SIGHUP", sysmodPid };
//					CommonsExecHelper.execute("kill", params);
//				} else {
//					// 프로세스 재실행
//					String demonKillCommand = SHELL + "sysmond_daemon_start.sh";
//					CommonsExecHelper.execute(demonKillCommand);
//				}
//			}
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사용자 파일 업로딩 정보 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-userupload")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyUserUpload(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if( ( policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0 )
					|| ( policy.getUser_upload_type() == null || "".equals(policy.getUser_upload_type()) )
					|| ( policy.getUser_upload_max_filesize() == null || policy.getUser_upload_max_filesize().longValue() < 0l )
					|| ( policy.getUser_upload_max_count() == null || policy.getUser_upload_max_count().intValue() < 0 )) {
				result = "policy.userupload.invalid";
				map.put("result", result);
				return map;
			}
			
			policyService.updatePolicyUserUpload(policy);

			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 사이트 정보 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-site")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicySite(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
//			log.info("@@ policy = {} ", policy);
//			if( ( policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0 )) {
//				result = "policy.site.invalid";
//				map.put("result", result);
//				return map.toString();
//			}
//			
//			if(policy.getServer_ip() == null || "".equals(policy.getServer_ip()) || !WebUtil.isIP(policy.getServer_ip())) {
//				result = "policy.os.server_ip.invalid";
//				map.put("result", result);
//				return map.toString();
//			}
//			
//			WebUtil.setServerIp(CACHE_FILE, policy.getServer_ip());
//			configCacheController.reloadServerIp();
//			
//			policy.setSite_admin_mobile_phone(Crypt.encrypt(policy.getSite_admin_mobile_phone()));
//			policy.setSite_admin_email(Crypt.encrypt(policy.getSite_admin_email()));
//			policyService.updatePolicySite(policy);

			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 시스템 시간 재설정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-os")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyOs(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		String timeType = "";
		String timeValue = "";
		try {
//			log.info("@@ policy = {} ", policy);
//			if( ( policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0 ) ) {
//				result = "policy.os.invalid";
//				map.put("result", result);
//				return map;
//			}
//			// -i : 수동설정 / -t : ntp server
//			if ("".equals(policy.getOs_ntp())) {
//				String systemTime = policy.getOs_ntp_day() + " " + policy.getOs_ntp_hour() + ":" + policy.getOs_ntp_minute() + ":00";
//				timeType = "-i";
//				timeValue = "'" + systemTime + "'";
//			} else {
//				timeType = "-t";
//				timeValue = policy.getOs_ntp();
//			}
//			
//			// config system date - -i : 직접입력 / -t ntp 서버 동기화
//			String command = SHELL + Policy.SERVER_DATE_SHELL;
//			String[] arrayParam = new String[] {timeType, timeValue};
//			Map<String, Object> executeResult = CommonsExecHelper.executeParam(command, arrayParam);
//			
//			boolean isSuccess = (boolean) executeResult.get("isSuccess");
//			if (isSuccess) {
//				// 하드웨어 시간을 동기화
//				String hwclockCommand = SHELL + Policy.SERVER_DATE_HWCLOCK_SHELL;
//				CommonsExecHelper.execute(hwclockCommand);
//				
//				policyService.updatePolicyOs(policy);
//			} else {
//				result = (String) executeResult.get("message");
//			}
			
			// TODO OS 시간 설정 후 
			// /sbin/hwclock --systohc --localtime
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		log.info("@@ result = {} ", result);
		map.put("result", result);
		return map;
	}
	
	/**
	 * BackOffice 정보 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-backoffice")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicyBackoffice(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if( ( policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0 )) {
				result = "policy.backoffice.invalid";
				map.put("result", result);
				return map;
			}
			
			policy.setBackoffice_email_password(Crypt.encrypt(policy.getBackoffice_email_password()));
			policy.setBackoffice_user_db_url(Crypt.encrypt(policy.getBackoffice_user_db_url()));
			policy.setBackoffice_user_db_user(Crypt.encrypt(policy.getBackoffice_user_db_user()));
			policy.setBackoffice_user_db_password(Crypt.encrypt(policy.getBackoffice_user_db_password()));
			policyService.updatePolicyBackoffice(policy);

			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 제품 정보 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-solution")
	@ResponseBody
	public Map<String, String> ajaxUpdatePolicySolution(HttpServletRequest request, Policy policy) {
		Map<String, String> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ policy = {} ", policy);
			if(policy.getPolicy_id() == null || policy.getPolicy_id().intValue() <= 0
					|| policy.getSolution_name() == null || "".equals(policy.getSolution_name())
					|| policy.getSolution_version() == null || "".equals(policy.getSolution_version())
					|| policy.getSolution_manager() == null || "".equals(policy.getSolution_manager())) {
				result = "policy.solution.invalid";
				map.put("result", result);
				return map;
			}
			
			policy.setSolution_company_phone(Crypt.encrypt(policy.getSolution_company_phone()));
			policy.setSolution_manager_phone(Crypt.encrypt(policy.getSolution_manager_phone()));
			policy.setSolution_manager_email(Crypt.encrypt(policy.getSolution_manager_email()));
			
			policyService.updatePolicySolution(policy);
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.POLICY);
			cacheParams.setCacheType(CacheType.BROADCAST);
			cacheConfig.loadCache(cacheParams);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
}
