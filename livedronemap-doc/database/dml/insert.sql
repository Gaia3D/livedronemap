-- ����� �׷� ���̺� �⺻�� �Է�
insert into user_group(
	user_group_id, group_key, group_name, parent, depth, view_order, default_yn, use_yn, description
) values(
	1, 'SUPER_ADMIN', '���� ������', 0, 1, 1, 'Y', 'Y', '�⺻��'
), 
(
	2, 'USER', '�����', 0, 1, 2, 'Y', 'Y', '�⺻��'
);

-- ���� ������ ���
insert into user_info(
	user_id, user_group_id, user_name, password, salt, user_role_check_yn, last_login_date
) values (
	'admin', 1, '���۰�����', '$2a$10$fkiRMbYDuDlnZ.pLZjn5z.U.TDTmh8PTAasMzKi0Btgsp0wzKY4ty', '$2a$10$fkiRMbYDuDlnZ.pLZjn5z.', 'N', now()
);

-- � ��å
insert into policy(	policy_id, rest_api_encryption_yn,
					geoserver_data_url, geoserver_data_workspace, geoserver_data_format, 
					geoserver_user, geoserver_password,
					rest_api_converter_url) 
			values( 1, 'N',
					'http://localhost:8080/geoserver', 'livedronemap', 'image/png',
					'mkKxoOOBBWrvZK6yCF8l8w==', 'GjKX1+xXvjlIl65JNgVFzg==',
					'http://localhost:9090/');

insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'droneProjectWidget', 1, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'transferDataListWidget', 2, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'tokenLogListWidget', 3, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'simulationLogListWidget', 4, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'userWidget', 5, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'healthCheckLogListWidget', 6, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'accessLogWidget', 7, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'dbcpWidget', 8, 'admin' );
insert into widget(	widget_id, name, view_order, user_id) values(NEXTVAL('widget_seq'), 'dbSessionWidget', 9, 'admin' );

commit;
