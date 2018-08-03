package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.Policy;

@Repository
public interface PolicyMapper {
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	Policy getPolicy();
	
	/**
	 * 사용자 파일 업로딩 정책 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyUserUpload(Policy policy);

}
