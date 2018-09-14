-- FK, Index는 별도 파일로 분리.
drop table if exists transfer_data cascade;
drop table if exists individual_data cascade;
drop table if exists postprocessing_data cascade;


-- 전송된 데이터 관리
create table transfer_data(
	transfer_data_id				bigint,
	drone_project_id				bigint						not null,
	data_name						varchar(100),
	data_type						char(1),
	attributes						jsonb,
	project_image_count				int							default 0;
	shooting_date					timestamp with time zone,
	transfer_sucessyn				char(1),
	constraint transfer_data_id_pk	primary key (transfer_data_id),
);

comment on table transfer_data is '전송된 데이터 관리';
comment on column transfer_data.transfer_data_id is 'transfer data 고유번호';
comment on column transfer_data.drone_proejct_id is 'drone project 고유번호';
comment on column transfer_data.data_name is '데이터 이름';
comment on column transfer_date.data_type is '데이터 타입( 0 : 개별 정사영상, 1 : 후처러 영상)';
comment on column transfer_data.attributes is '속성 정보';
comment on column transfer_data.transfer_time is '전송 일시';
comment on column transfer_data.transfer_sucessyn is '데이터 전송 성공 유무 ( Y : 전송 성공, N : 전송 실패 )';


-- 개별 정사영상 데이터 관리
create table individual_data(
	individual_data_id				bigint,
	transfer_data_id				bigint						not null,
	individual_data_key				varchar(128)				not null,
	file_name						varchar(100)				not null,
	file_path						varchar(256)				not null,
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone	default now(),
	
	constraint individual_dataa_pk	primary key (individual_data_id),

);

comment on table individual_data is '개별정사영상 데이터 관리';
comment on column individual_data.individual_data_id is '개별정사영상 데이티 관리고유번호';
comment on column individual_data.transfer_data_id is '전송된 데이터 관리 고유번호';
comment on column individual_data.individual_data_key is '개별정사영상 식별키';
comment on column individual_data.file_name is '개별정사영상 파일명';
comment on column individual_data.file_path is '개별정사영상 파일경로';
comment on column individual_data.update_date is '수정일';
comment on column individual_data.insert_date is '등록일';


-- 후처리 영상 데이터 관리
create table postprocessing_data(
	postprocessing_data_id			bigint,
	postprocessing_data_key			varchar(128)				not null,
	file_name						varchar(100)				not null,
	file_path						varchar(256)				not null,
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone	default now(),
	constraint postprocessing_data_pk		primary key (postprocessing_data_id)
);

comment on table individual_data is '후처리영상 데이터 관리';
comment on column individual_data.individual_data_id is '후처리영상 데이티 관리고유번호';
comment on column individual_data.transfer_data_id is '전송된 데이터 관리 고유번호';
comment on column individual_data.individual_data_key is '후처리영상 식별키';
comment on column individual_data.file_name is '후처리영상 파일명';
comment on column individual_data.file_path is '후처리영상 파일경로';
comment on column individual_data.update_date is '수정일';
comment on column individual_data.insert_date is '등록일';
