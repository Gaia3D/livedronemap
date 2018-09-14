-- FK, Index는 별도 파일로 분리.
drop table if exists postprocessing_data cascade;

-- 후처리 영상 데이터 관리
create table postprocessing_data(
	postprocessing_data_id				bigint,
	
	constraint postprocessing_data_pk		primary key (postprocessing_data_id)
);

comment on table postprocessing_data is '후처리 영상 데이터 관리';
comment on column postprocessing_data_id is '고유번호';
