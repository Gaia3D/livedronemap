package gaia3d.domain;

public enum APIURL {

	CONVERTER("/converter/images"),
	CHECK_AI("/check/beacon"), // 시립대 health check
	CHECK_DRONE("/check/drone"), // 드론 health check
	SIMULATION_AI("/check/sim/from_ldm"), // 모의 테스트, 시립대 부터
	SIMULATION_DRONE("/check/sim/from_drone"); // 모의 테스트, 드론부터(미완)
	
	private String url;
	
	APIURL(String url) {
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
}
