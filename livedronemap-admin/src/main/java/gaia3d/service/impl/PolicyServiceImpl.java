package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.Policy;
import gaia3d.service.PolicyService;

import gaia3d.persistence.PolicyMapper;

/**
 * mago3d 운영 정책
 * @author jeongdae
 *
 */
@Service
public class PolicyServiceImpl implements PolicyService {

	@Autowired
	private PolicyMapper policyMapper;
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	@Transactional(readOnly=true)
	public Policy getPolicy() {
		return policyMapper.getPolicy();
	}
	
	/**
	 * 운영 정책 사용자 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyUser(Policy policy) {
		return policyMapper.updatePolicyUser(policy);
	}
	
	/**
	 * 운영 정책 패스워드 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyPassword(Policy policy) {
		return policyMapper.updatePolicyPassword(policy);
	}
	
	/**
	 * Geo Server 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyGeoServer(Policy policy) {
		return policyMapper.updatePolicyGeoServer(policy);
	}
	
	/**
	 * rest api 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyRestAPI(Policy policy) {
		return policyMapper.updatePolicyRestAPI(policy);
	}
	
	/**
	 * 운영 정책 알림 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyNotice(Policy policy) {
		return policyMapper.updatePolicyNotice(policy);
	}
	
	/**
	 * 운영 정책 보안 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicySecurity(Policy policy) {
		return policyMapper.updatePolicySecurity(policy);
	}
	
	/**
	 * 운영 정책 기타 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyContent(Policy policy) {
		return policyMapper.updatePolicyContent(policy);
	}
	
	/**
	 * 사용자 파일 업로딩 정책 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyUserUpload(Policy policy) {
		return policyMapper.updatePolicyUserUpload(policy);
	}
	
	/**
	 * 사이트 정보 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicySite(Policy policy) {
		return policyMapper.updatePolicySite(policy);
	}
	
	/**
	 * BackOffice 설정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyBackoffice(Policy policy) {
		return policyMapper.updatePolicyBackoffice(policy);
	}
	
	/**
	 * 제품정보 설정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicySolution(Policy policy) {
		return policyMapper.updatePolicySolution(policy);
	}
}
