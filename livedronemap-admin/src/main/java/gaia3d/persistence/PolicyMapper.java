package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Policy;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Repository
public interface PolicyMapper {

	/**
	 * 운영 정책 정보
	 * @return
	 */
	Policy getPolicy();
	
	/**
	 * 운영 정책 사용자 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyUser(Policy policy);
	
	/**
	 * 운영 정책 패스워드 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyPassword(Policy policy);
	
	/**
	 * Geo Server 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyGeoServer(Policy policy);
	
	/**
	 * Rest API 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyRestAPI(Policy policy);
	
	/**
	 * project 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyProject(Policy policy);
	
	/**
	 * 운영 정책 알림 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyNotice(Policy policy);
	
	/**
	 * 운영 정책 보안 수정
	 * @param policy
	 * @return
	 */
	int updatePolicySecurity(Policy policy);
	
	/**
	 * 운영 정책 기타 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyContent(Policy policy);
	
	/**
	 * 사용자 파일 업로딩 정책 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyUserUpload(Policy policy);
	
	/**
	 * 사이트 정보 수정
	 * @param policy
	 * @return
	 */
	int updatePolicySite(Policy policy);
	
	/**
	 * BackOffice 설정
	 * @param policy
	 * @return
	 */
	int updatePolicyBackoffice(Policy policy);
	
	/**
	 * 제품정보 설정
	 * @param policy
	 * @return
	 */
	int updatePolicySolution(Policy policy);
}
