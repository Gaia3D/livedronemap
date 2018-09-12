-- FK, Index는 별도 파일로 분리.
drop table if exists individual_data_log cascade;

-- 개별 정사영상 데이터 이력 관리
create table individual_data_log(
	individual_data_log_id				bigint,
	drone_proejct_id				bigint				not null,
	file_name
	file_path
	attribute
	detect_ship_count
	detect_oil_count
	
	constraint individual_data_log_pk	primary key (individual_data_log_id),

);

comment on table individual_data_log is '개별정사영상 데이터 관리';
comment on column individual_data_log.individual_data_log_id is '고유번호';
