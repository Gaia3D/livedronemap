drop table if exists api_log cascade;
drop table if exists external_service cascade;

-- API ȣ�� �̷�
create table api_log(
	api_log_id					bigint,
	service_code				varchar(100)		not null,
	service_name				varchar(100)		not null,
	client_ip					varchar(45)			not null,
	client_server_name			varchar(30),
	api_key						varchar(256)		not null,
	device_kind					varchar(1)			not null,
	request_type 				varchar(20)			not null,
	user_id						varchar(32),
	user_ip						varchar(45),
	data_count					int,
	data_delimiter				varchar(3),
	phone						varchar(256),
	email						varchar(256),
	messanger					varchar(256),
	field1						varchar(256),
	field2						varchar(256),
	field3						varchar(256),
	field4						varchar(256),
	field5						varchar(256),
	success_yn					char(1),
	business_success_yn			char(1),
	result_message				varchar(1000),
	business_result_message		varchar(1000),
	result_value1				varchar(256),
	result_value2				varchar(256),
	result_value3				varchar(256),
	result_value4				varchar(256),
	result_value5				varchar(256),
	insert_date				timestamp 			with time zone			default now(),
	constraint api_log_pk primary key (api_log_id)	
);

comment on table api_log is 'API ȣ�� �̷�';
comment on column api_log.api_log_id is '����Ű';
comment on column api_log.service_code is 'API �ڵ�';
comment on column api_log.service_name is 'API �̸� ';
comment on column api_log.client_ip is '���� ������ ��û�� Client IP';
comment on column api_log.client_server_name is '���� ������ ��û�� ������';
comment on column api_log.api_key is 'API KEY';
comment on column api_log.device_kind is '��� ��ü( 0 : ��, 1 : ��Ÿ)';
comment on column api_log.request_type is '���� ��û Ÿ��. ���� : ADMIN_PASSWORD, �׽�Ʈ : ADMIN_TEST, �α��� : ADMIN_LOGIN, �׽�Ʈ : USER_TEST, �α��� : USER_LOGIN, �ܺ� : API';
comment on column api_log.user_id is '����� ���̵�';
comment on column api_log.user_ip is '����� IP';
comment on column api_log.data_count is '������ �Ǽ�';
comment on column api_log.data_delimiter is '������ ������';
comment on column api_log.phone is '��ȭ��ȣ';
comment on column api_log.email is 'email';
comment on column api_log.messanger is '�޽���';
comment on column api_log.field1 is '�ӽ� �ʵ�1';
comment on column api_log.field2 is '�ӽ� �ʵ�2';
comment on column api_log.field3 is '�ӽ� �ʵ�3';
comment on column api_log.field4 is '�ӽ� �ʵ�4';
comment on column api_log.field5 is '�ӽ� �ʵ�5';
comment on column api_log.success_yn is 'API ȣ�� ���� ����( Y : ����, N : ���� )';
comment on column api_log.business_success_yn is '���� ���� �߻� ����(������ �߻������� �����ص� �Ǵ� ���, Y : ����, N : ����)';
comment on column api_log.result_message is '���� ȣ�� �޽���';
comment on column api_log.business_result_message is '���� ȣ�� �޽���';
comment on column api_log.result_value1 is '��� ��1';
comment on column api_log.result_value2 is '��� ��2';
comment on column api_log.result_value3 is '��� ��3';
comment on column api_log.result_value4 is '��� ��4';
comment on column api_log.result_value5 is '��� ��5';
comment on column api_log.insert_date is '�����';


create table api_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);


alter table only api_log_2018 add constraint api_log_2018_pk primary key (api_log_id);
alter table only api_log_2019 add constraint api_log_2019_pk primary key (api_log_id);
alter table only api_log_2020 add constraint api_log_2020_pk primary key (api_log_id);
alter table only api_log_2021 add constraint api_log_2021_pk primary key (api_log_id);
alter table only api_log_2022 add constraint api_log_2022_pk primary key (api_log_id);
alter table only api_log_2023 add constraint api_log_2023_pk primary key (api_log_id);
alter table only api_log_2024 add constraint api_log_2024_pk primary key (api_log_id);
alter table only api_log_2025 add constraint api_log_2025_pk primary key (api_log_id);
alter table only api_log_2026 add constraint api_log_2026_pk primary key (api_log_id);
alter table only api_log_2027 add constraint api_log_2027_pk primary key (api_log_id);
alter table only api_log_2028 add constraint api_log_2028_pk primary key (api_log_id);
alter table only api_log_2029 add constraint api_log_2029_pk primary key (api_log_id);
alter table only api_log_2030 add constraint api_log_2030_pk primary key (api_log_id);
alter table only api_log_2031 add constraint api_log_2031_pk primary key (api_log_id);


-- Private API
create table external_service (
	external_service_id			bigint,
	service_code				varchar(30)			not null,
	service_name				varchar(60)			not null,
	service_type				char(1)				not null,
	server_ip					varchar(45)			not null,
	api_key						varchar(256)		not null,
	url_scheme					varchar(10)			not null,
	url_host					varchar(256)		not null,
	url_port					int					not null,
	url_path					varchar(256),			
	status						char(1)				default '0',
	default_yn					char(1)				default 'N',
	description					varchar(256),
	extra_key1					varchar(50),
	extra_key2					varchar(50),
	extra_key3					varchar(50),
	extra_value1				varchar(50),
	extra_value2				varchar(50),
	extra_value3				varchar(50),
	insert_date				timestamp with time zone			default now(),
	constraint external_service_pk primary key (external_service_id)	
);

comment on table external_service is 'Private API';
comment on column external_service.external_service_id is '����Ű';
comment on column external_service.service_code is '���� �ڵ�';
comment on column external_service.service_name is '���񽺸�';
comment on column external_service.service_type is '���� ����. 0 : Cache(ĳ�� Reload)';
comment on column external_service.server_ip is '���� IP';
comment on column external_service.api_key is 'API KEY';
comment on column external_service.url_scheme is '����� ��������';
comment on column external_service.url_host is 'ȣ��Ʈ';
comment on column external_service.url_port is '��Ʈ';
comment on column external_service.url_path is '���, ���ҽ� ��ġ';
comment on column external_service.status is '����. 0 : ���, 1 : �̻��';
comment on column external_service.default_yn is '���� �Ұ�, Y : �⺻, N : ����';
comment on column external_service.description is '����';
comment on column external_service.extra_key1 is '���� Ű 1';
comment on column external_service.extra_key2 is '���� Ű 2';
comment on column external_service.extra_key3 is '���� Ű 3';
comment on column external_service.extra_value1 is '���� Ű �� 1';
comment on column external_service.extra_value2 is '���� Ű �� 2';
comment on column external_service.extra_value3 is '���� Ű �� 3';
comment on column external_service.insert_date is '�����';

