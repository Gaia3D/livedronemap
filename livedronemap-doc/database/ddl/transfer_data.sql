-- FK, Index는 별도 파일로 분리.
drop table if exists transfer_data cascade;

-- 전송된 데이터 
create table transfer_data(
	transfer_data_id				bigint,
	drone_proejct_id				bigint				not null,
	data_type						char(1),
	file_name						varchar(100),
	file_path						varchar(255),
	attributes						jsonb,
	shooting_date					timestamp with time zone,
	transfer_sucessyn				char(1),
	constraint transfer_data_id_pk	primary key (transfer_data_id),
);

comment on table transfer_data is '전송된 데이터 관리';
comment on column transfer_data.transfer_data_id is 'transfer data 고유번호';
comment on column transfer_data.drone_proejct_id is 'drone project 고유번호';
comment on column transfer_date.data_type is '데이터 구분 ( 0 : 개별정사영상, 1 : 후처리영상)';
comment on column transfer_data.file_name is '전송된 파일 이름';
comment on column transfer_data.file_path is '전송된 파일 경로';
comment on column transfer_data.attributes is '전송된 데이터에 대한 속성 정보';
comment on column transfer_data.transfer_time is '촬영 일시';
comment on column transfer_data.transfer_sucessyn is '데이터 전송 성공 유무 ( Y : 성공, N : 실패 )';
