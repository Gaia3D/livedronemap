package gaia3d.domain;

public enum ProcessingResult {
	PROCESSING_SUCCESS("1"), PROCESSING_FAIL("2");
	
	private String status;
	
	ProcessingResult(String status) {
		this.status = status;
	}
	
	public String getStatus() {
		return status;
	}
	
}
