package gaia3d.domain;

public enum TransferDataType {

	ORTHO_IMAGE("0"), POSTPROCESSING_IMAGE("1");
	
	private String dataType;
	
	TransferDataType(String dataType) {
		this.dataType = dataType;
	}
	
	public String getDataType() {
		return this.dataType;
	}
}
