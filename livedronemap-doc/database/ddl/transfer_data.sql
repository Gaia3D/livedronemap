-- FK, Index는 별도 파일로 분리.
drop table if exists transfer_data cascade;

-- 전송된 데이터 
create table transfer_data(
	transfer_data_id				bigint,
	drone_proejct_id				bigint,				not null,
	image_type						char(1),
	orthoretified_image_count		bigint				default 0,
	processing_image_count			bigint				default 0,
	total_image_count				bigint				default 0,
	transfer_time					timestamp with time zone,
	transfer_sucessyn				char(1),
	constraint transfer_data_id_pk	primary key (transfer_data_id),
);

comment on table transfer_data is '전송된 데이터 관리';
comment on column transfer_data.transfer_data_id is 'transfer data 고유번호';
comment on column transfer_data.drone_proejct_id is 'drone project 고유번호';
comment on column transfer_date.image_type is '데이터 구분 ( 0 : 개별정사영상, 1 : 후처리영상)';
comment on column transfer_data.orthoretified_image_count is '개별정사영상 갯수';
comment on column transfer_data.processing_image_count is '후처리영상 갯수';
comment on column transfer_data.total_image_count is '전체 영상의 갯수';
comment on column transfer_data.transfer_time is '전송 시간';
comment on column transfer_data.transfer_sucessyn is '데이터 전송 성공 유무 ( Y : 성공, N : 실패 )';
