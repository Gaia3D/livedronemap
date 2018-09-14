-- FK, Index는 별도 파일로 분리.
drop table if exists real_time_data cascade;

-- 개별 정사영상 데이터 관리
create table real_time_data(
	real_time_data_id				bigint,
	drone_proejct_id				bigint				not null,
	file_name
	file_path
	attribute
	detect_ship_count
	detect_oil_count
	
	constraint real_time_data_pk	primary key (real_time_data_id),

);

comment on table real_time_data is '개별정사영상 데이터 관리';
comment on column real_time_data.real_time_data_id is '고유번호';
