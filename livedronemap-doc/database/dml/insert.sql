-- 사용자 그룹 테이블 기본값 입력
insert into user_group(
	user_group_id, group_key, group_name, parent, depth, view_order, default_yn, use_yn, description
) values(
	1, 'SUPER_ADMIN', '슈퍼 관리자', 0, 1, 1, 'Y', 'Y', '기본값'
), 
(
	2, 'USER', '사용자', 0, 1, 2, 'Y', 'Y', '기본값'
);

-- 슈퍼 관리자 등록
insert into user_info(
	user_id, user_group_id, user_name, password, salt, user_role_check_yn, last_login_date
) values (
	'admin', 1, '슈퍼관리자', '$2a$10$fkiRMbYDuDlnZ.pLZjn5z.U.TDTmh8PTAasMzKi0Btgsp0wzKY4ty', '$2a$10$fkiRMbYDuDlnZ.pLZjn5z.', 'N', now()
);

-- 운영 정책
insert into policy(	policy_id, rest_api_encryption_yn, rest_api_converter_url
					geoserver_data_url, geoserver_data_workspace, geoserver_data_format, 
					geoserver_user, geoserver_password,
					rest_api_converter_url) 
			values( 1, 'N',
					'http://localhost:8080/geoserver', 'dronemap', 'image/png',
					'mkKxoOOBBWrvZK6yCF8l8w==', 'GjKX1+xXvjlIl65JNgVFzg==',
					'http://localhost:9090/');

commit;

commit;
