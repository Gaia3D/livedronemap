package gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import gaia3d.domain.Policy;
import gaia3d.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/policy/")
public class PolicyController {
	
	@Autowired
	private PolicyService policyService;
	
	@GetMapping(value = "input-policy.do")
	public ModelAndView modifyPolicy(Model model) {
		
		Policy policy = policyService.getPolicy();
		log.info("@@@@@@@@@@ policy = {}", policy);
		
		return new ModelAndView("/policy/input-policy");
	}

	/**
	 * 사용자 파일 업로딩 정보 수정
	 * @param request
	 * @param policy
	 * @return
	 */
	@PostMapping(value = "ajax-update-policy-userupload.do")
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

		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
}
