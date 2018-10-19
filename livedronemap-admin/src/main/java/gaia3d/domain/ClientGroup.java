package gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/**
 * @author jwpark
 *
 */
@Getter
@Setter
@ToString
public class ClientGroup {
	
	// 상태 : 사용중
	public static final String IN_USE = "Y";
	
	// 그룹 고유번호
	private Integer client_group_id;
	// 그룹 키
	private String group_key;
	// 클라이언트 그룹명
	private String group_name;
	// 부모 고유번호
	private Integer parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer view_order;
	// 자식 존제 유무 ( Y : 존재, N : 존재안함(기본))
	private String child_yn;
	// 삭제 불가 (Y : 기본, N : 선택)
	private String default_yn;
	// 사용 유무(Y : 사용, N : 사용안함)
	private String use_yn;
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	
}
