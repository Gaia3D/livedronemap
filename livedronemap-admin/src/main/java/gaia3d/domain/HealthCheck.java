package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Cheon JeongDae
 *
 */
@ToString
@Setter
@Getter
public class HealthCheck {
	
	// health check key
	public static final String DRONE_STATUS = "DRONE";
	public static final String AI_STATUS = "AI";
	public static final String CONVERTER_STATUS = "CONVERTER_STATUS";
	
	public static final String ALIVE = "ALIVE";
	public static final String DOWN = "DOWN";
	public static final String UNKNOWN = "UNKNOWN";
	
	private String servide_id;
	private String service_name;
}
