-- FK, Index는 별도 파일로 분리.
drop table if exists individual_orthophoto_log cascade;

-- 개별 정사영상 데이터 이력 관리
create table individual_orthophoto_log(
	individual_orthophoto_log_id				bigint,
	drone_proejct_id					bigint				not null,
	file_name
	file_path
	attribute
	detect_ship_count
	detect_oil_count
	
	constraint individual_orthophoto_log_pk	primary key (individual_orthophoto_log_id),

);

comment on table individual_orthophoto_log is '개별 정사영상 데이터 이력 관리';
comment on column individual_orthophoto_log.individual_orthophoto_log_id is '개별 정사영상 데이터 이력 관리 고유키';
