package gaia3d.domain;

public enum SimulationLevel {
	ALL("0"), CLIENT("1"), INNER("2");
	
	private String code;
	
	SimulationLevel(String code) {
		this.code = code;
	}
	
	public String getCode() {
		return code;
	}
	
}
