drop table if exists api_log cascade;
drop table if exists external_service cascade;

-- API 호출 이력
create table api_log(
	api_log_id					bigint,
	client_id					int,
	client_name					varchar(30),
	request_ip					varchar(45),
	user_id						varchar(32),
	url							varchar(256),
	status_code					int,
	message						varchar(256),
	insert_date					timestamp 			with time zone			default now(),
	constraint api_log_pk primary key (api_log_id)	
);

comment on table api_log is 'API 호출 이력';
comment on column api_log.api_log_id is '고유키';
comment on column api_log.client_id is 'client 고유키';
comment on column api_log.client_name is 'client명(중복)';
comment on column api_log.request_ip is 'request IP';
comment on column api_log.user_id is 'user id';
comment on column api_log.url is 'url';
comment on column api_log.status_code is 'http status code';
comment on column api_log.message is '상세 메시지';
comment on column api_log.insert_date is '등록일';


create table api_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (api_log);
create table api_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20320101000000000000', 'YYYYMMDDHH24MISSUS') )
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
comment on column external_service.external_service_id is '고유키';
comment on column external_service.service_code is '서비스 코드';
comment on column external_service.service_name is '서비스명';
comment on column external_service.service_type is '서비스 유형. 0 : Cache(캐시 Reload)';
comment on column external_service.server_ip is '서버 IP';
comment on column external_service.api_key is 'API KEY';
comment on column external_service.url_scheme is '사용할 프로토콜';
comment on column external_service.url_host is '호스트';
comment on column external_service.url_port is '포트';
comment on column external_service.url_path is '경로, 리소스 위치';
comment on column external_service.status is '상태. 0 : 사용, 1 : 미사용';
comment on column external_service.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column external_service.description is '설명';
comment on column external_service.extra_key1 is '여분 키 1';
comment on column external_service.extra_key2 is '여분 키 2';
comment on column external_service.extra_key3 is '여분 키 3';
comment on column external_service.extra_value1 is '여분 키 값 1';
comment on column external_service.extra_value2 is '여분 키 값 2';
comment on column external_service.extra_value3 is '여분 키 값 3';
comment on column external_service.insert_date is '등록일';

