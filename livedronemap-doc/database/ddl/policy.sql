drop table if exists policy cascade;

-- ���å
create table policy(
	policy_id								int,
	
	user_id_min_length						int					default 5,
	user_fail_login_count					int					default 3,
	user_fail_lock_release					varchar(3)			default '30',
	user_last_login_lock					varchar(3)			default '90',
	user_duplication_login_yn				char(1)				default 'N',
	user_login_type							char(1)				default '0',
	user_update_check						char(1)				default '0',
	user_delete_check						char(1)				default '0',
	user_delete_type						char(1)				default '0',
	
	password_change_term 					varchar(3)			default '30',
	password_min_length						int					default 8,
	password_max_length						int					default 32,
	password_eng_upper_count 				int					default 1,
	password_eng_lower_count 				int					default 1,
	password_number_count 					int					default 1,
	password_special_char_count 			int					default 1,
	password_continuous_char_count 			int					default 3,
	password_create_type					char(1)				default '0',
	password_create_char					varchar(32)			default '!@#',
	password_exception_char					varchar(10)			default '<>&',
	
	geoserver_enable						varchar(1)			default 'Y',
	geoserver_wms_version					varchar(5)			default '1.1.1',
	geoserver_background_url				varchar(256),
	geoserver_background_workspace			varchar(60),
	geoserver_background_layer				varchar(60),
	geoserver_background_format				varchar(30),
	geoserver_terrain_url					varchar(256),
	geoserver_terrain_workspace				varchar(60),
	geoserver_terrain_layer					varchar(60),
	geoserver_terrain_format				varchar(30),
	geoserver_data_url						varchar(256),
	geoserver_data_workspace				varchar(60),
	geoserver_data_format					varchar(30),
	geoserver_user							varchar(256),
	geoserver_password						varchar(256),
	
	rest_api_converter_url					varchar(256),
	rest_api_encryption_yn					char(1)				default 'Y',
	rest_api_token_max_age					int					default 120,
	
	project_drone_expired_time				varchar(3)			default '90',
	project_max_idle_time					varchar(2)			default '10',
	
	notice_service_yn						char(1)				default 'Y',
	notice_service_send_type				char(1)				default '0',
	notice_risk_yn							char(1)				default 'N',
	notice_risk_send_type					char(1)				default '0',
	notice_risk_grade						char(1)				default '0',
	
	security_session_timeout_yn				char(1)				default 'N',
	security_session_timeout				varchar(4)			default '30',
	security_user_ip_check_yn				char(1)				default 'N',
	security_session_hijacking				char(1)				default '0',
	security_sso							char(1)				default '0',
	security_sso_token_verify_time			int					default 3,
	security_log_save_type					char(1)				default '0',
	security_log_save_term					varchar(3)			default '2',
	security_dynamic_block_yn				char(1)				default 'N',
	security_api_result_secure_yn			char(1)				default 'N',
	security_masking_yn						char(1)				default 'Y',
	
	content_cache_version					int					default 1,
	content_main_widget_count				int					default 6,
	content_main_widget_interval			int					default 65,
	content_monitoring_interval				int					default 1,
	content_statistics_interval				char(1)				default '0',
	content_load_balancing_interval			int					default 10,
	content_menu_group_root					varchar(60)			default 'LiveDroneMap',
	content_user_group_root					varchar(60)			default 'LiveDroneMap',
	content_client_group_root				varchar(60)			default 'LiveDroneMap',
	
	user_upload_type						varchar(256)		default 'tif,tfw,png,pgw,jpg,jpeg,jgw',
	user_upload_max_filesize				int					default 500,
	user_upload_max_count					int					default 50,
	
	site_name								varchar(60),
	site_admin_name							varchar(64),
	site_admin_mobile_phone					varchar(256),
	site_admin_email						varchar(256),
	site_product_log						varchar(256),
	site_company_log						varchar(256),
	
	backoffice_email_host					varchar(30),
	backoffice_email_port					int,
	backoffice_email_user					varchar(32),
	backoffice_email_password				varchar(256),
	backoffice_user_db_driver				varchar(20),
	backoffice_user_db_url					varchar(256),
	backoffice_user_db_user					varchar(32),
	backoffice_user_db_password				varchar(256),
	
	solution_name							varchar(64),
	solution_version						varchar(30),
	solution_company						varchar(45),
	solution_company_phone					varchar(256),
	solution_manager						varchar(60),
	solution_manager_phone					varchar(256),
	solution_manager_email					varchar(256),
	
	insert_date								timestamp with time zone			default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '���å';
comment on column policy.policy_id is '������ȣ';

comment on column policy.user_id_min_length is '����� ���̵� �ּ� ����. �⺻�� 5';
comment on column policy.user_fail_login_count is '����� �α��� ���� Ƚ��';
comment on column policy.user_fail_lock_release is '����� �α��� ���� ��� ���� �Ⱓ';
comment on column policy.user_last_login_lock is '����� ������ �α������� ���� ��� �Ⱓ';
comment on column policy.user_duplication_login_yn is '�ߺ� �α��� ��� ����. Y : ���, N : ������(�⺻��)';
comment on column policy.user_login_type is '����� �α��� ���� ���. 0 : �Ϲ�(���̵�/��й�ȣ(�⺻��)), 1 : �����(����߰�), 2 : �Ϲ� + OTP, 3 : �Ϲ� + ������, 4 : OTP + ������, 5 : �Ϲ� + OTP + ������';
comment on column policy.user_update_check is '����� ���� ������ Ȯ��';
comment on column policy.user_delete_check is '����� ���� ������ Ȯ��';
comment on column policy.user_delete_type is '����� ���� ���� ���. 0 : ����(�⺻��), 1 : ������(DB ����)';

comment on column policy.password_change_term is '�н����� ���� �ֱ� �⺻ 30��';
comment on column policy.password_min_length is '�н����� �ּ� ���� �⺻ 8';
comment on column policy.password_max_length is '�н����� �ִ� ���� �⺻ 32';
comment on column policy.password_eng_upper_count is '�н����� ���� �빮�� ���� �⺻ 1';
comment on column policy.password_eng_lower_count is '�н����� ���� �ҹ��� ���� �⺻ 1';
comment on column policy.password_number_count is '�н����� ���� ���� �⺻ 1';
comment on column policy.password_special_char_count is '�н����� Ư�� ���� ���� 1';
comment on column policy.password_continuous_char_count is '�н����� ���ӹ��� ���� ���� 3';
comment on column policy.password_create_type is '�ʱ� �н����� ���� ���. 0 : ����� ���̵� + �ʱ⹮��(�⺻��), 1 : �ʱ⹮��';
comment on column policy.password_create_char is '�ʱ� �н����� ���� ���ڿ�. ���� ���ε� ��';
comment on column policy.password_exception_char is '�н������ ����Ҽ� ���� Ư������(XSS). <,>,&,��������ǥ,ū����ǥ';

comment on column policy.geoserver_enable is 'geoserver �������';
comment on column policy.geoserver_wms_version is 'geoserver wms ����';
comment on column policy.geoserver_background_url is 'geoserver ������� url';
comment on column policy.geoserver_background_workspace is 'geoserver ������� �۾�����';
comment on column policy.geoserver_background_layer is 'geoserver ������� ���̾�';
comment on column policy.geoserver_background_format is 'geoserver ������� ��û ����';
comment on column policy.geoserver_terrain_url is 'geoserver ���� url';
comment on column policy.geoserver_terrain_workspace is 'geoserver ���� �۾�����';
comment on column policy.geoserver_terrain_layer is 'geoserver ���� ���̾�';
comment on column policy.geoserver_terrain_format is 'geoserver ���� ��û ����';
comment on column policy.geoserver_data_url is 'geoserver ���� ������ url';
comment on column policy.geoserver_data_workspace is 'geoserver ���� ������ �۾�����';
comment on column policy.geoserver_data_format is 'geoserver ���� ������ ��û ����';
comment on column policy.geoserver_user is 'geoserver ����� ����';
comment on column policy.geoserver_password is 'geoserver ��й�ȣ';

comment on column policy.rest_api_converter_url is 'rest api converter url(��Ʈ������)';
comment on column policy.rest_api_encryption_yn is 'rest api ��ȣȭ ����. Y : ���(�⺻��), N : ������';
comment on column policy.rest_api_token_max_age is 'rest api ��ū ��ȿ �ð�, �⺻ 120��';

comment on column policy.project_drone_expired_time is '��� ��ȿ �Ⱓ, �⺻�� 90(��)';
comment on column policy.project_max_idle_time is '������Ʈ �ִ� ��� �ð�, �⺻�� 10�ð�';

comment on column policy.notice_service_yn is '�˸� ���� ��� ����. Y : ���, N : ������(�⺻��)';
comment on column policy.notice_service_send_type is '�˸� �߼� ��ü. 0 : SMS(�⺻��), 1 : �̸���, 2 : �޽���';
comment on column policy.notice_risk_yn is '�˸� ��� �߻���. Y : ���, N ������(�⺻��)';
comment on column policy.notice_risk_send_type is '�˸� ��� �߼� ��ü. 0 : SMS(�⺻��), 1 : �̸���, 2 : �޽���';
comment on column policy.notice_risk_grade is '�˸� �߼� ��� ���. 1 : 1���(�⺻��), 2 : 2���, 3 : 3���';

comment on column policy.security_session_timeout_yn is '���� ���� Ÿ�Ӿƿ�. Y : ���, N ������(�⺻��)';
comment on column policy.security_session_timeout is '���� ���� Ÿ�Ӿƿ� �ð�. �⺻�� 30��';
comment on column policy.security_user_ip_check_yn is '�α��� ����� IP üũ ����. Y : ���, N ������(�⺻��)';
comment on column policy.security_session_hijacking is '���� ���� ������ŷ ó��. 0 : ������, 1 : ���(�⺻��), 2 : OTP �߰� ���� ';
comment on column policy.security_sso is '���� SSO. 0 : ������(�⺻��), 1 : TOKEN ����';
comment on column policy.security_sso_token_verify_time is '���� Single Sign-On ��ū ��ȿ�ð�(�д���). �⺻ 3��';
comment on column policy.security_log_save_type is '���� �α� ���� ���. 0 : DB(�⺻��), 1 : ����';
comment on column policy.security_log_save_term is '���� �α� ���� �Ⱓ. 2�� �⺻��';
comment on column policy.security_dynamic_block_yn is '���� ���� ����. Y : ���, N ������(�⺻��)';
comment on column policy.security_api_result_secure_yn is 'API ��� ��ȣȭ ���. Y : ���, N ������(�⺻��)';
comment on column policy.security_masking_yn is '�������� ����ŷ ó��. Y : ���(�⺻��), N ������';

comment on column policy.content_cache_version is 'css, js ���ſ� cache version.';
comment on column policy.content_main_widget_count is '���� ȭ�� ���� ǥ�� ����. �⺻ 6��';
comment on column policy.content_main_widget_interval is '���� ȭ�� ���� Refresh ����. �⺻ 65��(����͸� ���� 60�ʿ� ���� �ð� ���� ���)';
comment on column policy.content_statistics_interval is '��� �⺻ �˻� �Ⱓ. 0 : 1�� ����, 1 : ��/�Ϲݱ�, 2 : �б� ����, 3 : �� ����';
comment on column policy.content_menu_group_root is '�޴� �׷� �ֻ��� �׷��';
comment on column policy.content_user_group_root is '����� �׷� �ֻ��� �׷��';
comment on column policy.content_client_group_root is 'Ŭ���̾�Ʈ �׷� �ֻ��� �׷��';

comment on column policy.user_upload_type is '���ε� ���� Ȯ����. tif,tfw,png,pgw,jpg,jpeg,jgw';
comment on column policy.user_upload_max_filesize is '�ִ� ���ε� ������(����M). 500M';
comment on column policy.user_upload_max_count is '1ȸ, �ִ� ���ε� ���� ��. 50��';
	
comment on column policy.site_name is '���񽺸�';
comment on column policy.site_admin_name is '����Ʈ �����ڸ�';
comment on column policy.site_admin_mobile_phone is '����Ʈ ������ �ڵ��� ��ȣ';
comment on column policy.site_admin_email is '����Ʈ ������ �̸���';
comment on column policy.site_product_log is '��� �ַ�� �ΰ� �̹���';
comment on column policy.site_company_log is 'Footer ȸ�� �ΰ� �̹���';

comment on column policy.backoffice_email_host IS 'Email ���� ���� host';
comment on column policy.backoffice_email_port IS 'Email ���� ���� ��Ʈ';
comment on column policy.backoffice_email_user IS 'Email ���� ���� �����';
comment on column policy.backoffice_email_password IS 'Email ���� ���� ��й�ȣ';
comment on column policy.backoffice_user_db_driver IS '����� DB ���� Driver';
comment on column policy.backoffice_user_db_url IS '����� DB ���� URL';
comment on column policy.backoffice_user_db_user IS '����� DB ���� �����';
comment on column policy.backoffice_user_db_password IS '����� DB ���� ��й�ȣ';

comment on column policy.solution_name IS '��ǰ��';
comment on column policy.solution_version IS '��ǰ ����';
comment on column policy.solution_company IS '��ǰ ȸ���';
comment on column policy.solution_company_phone IS '��ǰ ȸ�� ����ó';
comment on column policy.solution_manager IS '��ǰ ȸ�� �����';
comment on column policy.solution_manager_phone IS '��ǰ ȸ�� ����� ��ȭ��ȣ';
comment on column policy.solution_manager_email IS '��ǰ ȸ�� ����� �̸���';

comment on column policy.insert_date is '�����';