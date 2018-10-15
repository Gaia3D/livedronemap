package gaia3d.domain;

public enum ProjectStatus {

	// 0:준비중, 1:점검/테스트, 2:개별 정사영상, 3:후처리 영상 , 4:프로젝트 종료, 5:에러
	PREPARE("0"), TEST("1"), ORTHO_IMAGE("2"), POSTPROCESSING_IMAGE("3"), COMPLETE("3"), ERROR("5");
	
	private String status;
	
	ProjectStatus(String status) {
		this.status = status;
	}
	
	public String getStatus() {
		return this.status;
	}
}
