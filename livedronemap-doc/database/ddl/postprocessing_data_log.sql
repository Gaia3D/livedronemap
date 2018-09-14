-- FK, Index는 별도 파일로 분리.
drop table if exists postprocessing_data_log cascade;


-- 후처리 영상 데이터 이력 관리
create table postprocessing_data_log(
	postprocessing_data_log_id					bigint,
	
	constraint postprocessing_data_log_pk	primary key (postprocessing_data_log_id)
);

comment on table postprocessing_data is '후처리 영상 데이터 관리';
comment on column postprocessing_data.postprocessing_data_id is '후처리 영상 데이터 관리 고유 번호';
