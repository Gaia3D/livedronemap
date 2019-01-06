package gaia3d.domain;

public enum TransferDataStatus {

	// 상태. 0 : 전송 완료, 1 : 이미지 후처리 완료, 2 : 이미지 후처리 실패, 3 : 이미지 후처리 에러(호출실패)
	RECEIVE("0"), CONVERTER_COMPLETE("1"), CONVERTER_FAIL("2"), CONVERTER_ERROR("3");
	
	private String status;
	
	TransferDataStatus(String status) {
		this.status = status;
	}
	
	public String getStatus() {
		return this.status;
	}
}
