drop table if exists health_check_log cascade;

-- API 호출 이력
create table health_check_log(
	health_check_log_id					bigint,
	client_id							int,
	client_name							varchar(30),
	status								varchar(10),
	status_code							int,
	message								text,
	insert_date							timestamp 			with time zone			default now(),
	constraint health_check_log_pk 		primary key (health_check_log_id)	
);

comment on table health_check_log is '상태 점검 이력';
comment on column health_check_log.health_check_log_id is '고유키';
comment on column health_check_log.client_id is 'client 고유키';
comment on column health_check_log.client_name is 'client명(중복)';
comment on column health_check_log.status is '상태 점검 상태';
comment on column health_check_log.status_code is 'http status code';
comment on column health_check_log.message is '상세 메시지';
comment on column health_check_log.insert_date is '등록일';


create table health_check_log_2018 (
	check ( insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2019 (
	check ( insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2020 (
	check ( insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2021 (
	check ( insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2022 (
	check ( insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2023 (
	check ( insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2024 (
	check ( insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2025 (
	check ( insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2026 (
	check ( insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2027 (
	check ( insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2028 (
	check ( insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2029 (
	check ( insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2030 (
	check ( insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);
create table health_check_log_2031 (
	check ( insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and insert_date < to_timestamp('20320101000000000000', 'YYYYMMDDHH24MISSUS') )
) inherits (health_check_log);


alter table only health_check_log_2018 add constraint health_check_log_2018_pk primary key (health_check_log_id);
alter table only health_check_log_2019 add constraint health_check_log_2019_pk primary key (health_check_log_id);
alter table only health_check_log_2020 add constraint health_check_log_2020_pk primary key (health_check_log_id);
alter table only health_check_log_2021 add constraint health_check_log_2021_pk primary key (health_check_log_id);
alter table only health_check_log_2022 add constraint health_check_log_2022_pk primary key (health_check_log_id);
alter table only health_check_log_2023 add constraint health_check_log_2023_pk primary key (health_check_log_id);
alter table only health_check_log_2024 add constraint health_check_log_2024_pk primary key (health_check_log_id);
alter table only health_check_log_2025 add constraint health_check_log_2025_pk primary key (health_check_log_id);
alter table only health_check_log_2026 add constraint health_check_log_2026_pk primary key (health_check_log_id);
alter table only health_check_log_2027 add constraint health_check_log_2027_pk primary key (health_check_log_id);
alter table only health_check_log_2028 add constraint health_check_log_2028_pk primary key (health_check_log_id);
alter table only health_check_log_2029 add constraint health_check_log_2029_pk primary key (health_check_log_id);
alter table only health_check_log_2030 add constraint health_check_log_2030_pk primary key (health_check_log_id);
alter table only health_check_log_2031 add constraint health_check_log_2031_pk primary key (health_check_log_id);


