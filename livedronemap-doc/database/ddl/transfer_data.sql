-- FK, Index는 별도 파일로 분리.
drop table if exists transfer_data cascade;
drop table if exists ortho_image cascade;
drop table if exists ortho_detected_object cascade;
drop table if exists postprocessing_image cascade;


-- 전송 데이티
create table transfer_data(
	transfer_data_id				bigint,
	drone_project_id				int						not null,
	user_id							varchar(32),
	data_type						char(1),
	file_name						varchar(256),
	detected_objects_count			int						default 0,
	status							char(1)					default '0',
	drone_latitude					numeric(13,10),
	drone_longitude					numeric(13,10),
	drone_altitude					numeric(13,10),
	drone_roll						numeric(13,10),
	drone_pitch						numeric(13,10),
	drone_yaw						numeric(13,10),
	shooting_date					timestamp with time zone,
	insert_date						timestamp with time zone default now(),
	constraint transfer_data_id_pk	primary key (transfer_data_id)
);

comment on table transfer_data is '전송 데이터';
comment on column transfer_data.transfer_data_id is 'transfer data 고유번호';
comment on column transfer_data.drone_project_id is 'drone project 고유번호';
comment on column transfer_data.user_id is '사용자 아이디';
comment on column transfer_data.data_type is '데이터 타입. 0 : 개별 정사 영상, 1 : 후처리 영상';
comment on column transfer_data.file_name is '파일 이름';
comment on column transfer_data.detected_objects_count is '객체 탐지 개수';
comment on column transfer_data.status is '상태. 0 : 전송 완료, 1 : 후처리 완료';
comment on column transfer_data.drone_latitude is '드론 위도';
comment on column transfer_data.drone_longitude is '드론 경도';
comment on column transfer_data.drone_altitude is '드론 높이';
comment on column transfer_data.drone_roll is '드론 roll';
comment on column transfer_data.drone_pitch is '드론 pitch';
comment on column transfer_data.drone_yaw is '드론 흔들림';
comment on column transfer_data.shooting_date is '촬영일';
comment on column transfer_data.insert_date is '등록일';


-- 개별 정사 영상
create table ortho_image(
	ortho_image_id								bigint,
	transfer_data_id							bigint								not null,
	file_name									varchar(100)						not null,
	file_real_name								varchar(100)						not null,
	file_path									varchar(256)						not null,
	file_size									varchar(12)							not null,
	file_ext									varchar(10)							not null,
	status										char(1)								default '0',
	insert_date									timestamp with time zone			default now(),
	constraint ortho_image_pk primary key (ortho_image_id)	
);

comment on table ortho_image is '개별 정사 영상';
comment on column ortho_image.ortho_image_id is '고유번호';
comment on column ortho_image.transfer_data_id is '전송 데이터 고유번호';
comment on column ortho_image.file_name is '파일 이름';
comment on column ortho_image.file_real_name is '파일 실제 이름';
comment on column ortho_image.file_path is '파일 경로';
comment on column ortho_image.file_size is '파일 사이즈';
comment on column ortho_image.file_ext is '파일 확장자';
comment on column ortho_image.status is '상태. 0 : 전송 완료, 1 : 이미지 후처리 완료';
comment on column ortho_image.insert_date is '등록일';


-- 후처리 영상
create table postprocessing_image(
	postprocessing_image_id						bigint,
	transfer_data_id							bigint								not null,
	file_type									char(1)								default '0',
	file_name									varchar(100)						not null,
	file_real_name								varchar(100)						not null,
	file_path									varchar(256)						not null,
	file_size									varchar(12)							not null,
	file_ext									varchar(10)							not null,
	status										char(1)								default '0',
	insert_date									timestamp with time zone			default now(),
	constraint postprocessing_image_pk primary key (postprocessing_image_id)	
);

comment on table postprocessing_image is '후처리 영상';
comment on column postprocessing_image.postprocessing_image_id is '고유번호';
comment on column postprocessing_image.transfer_data_id is '전송 데이터 고유번호';
comment on column postprocessing_image.file_type is '파일 유형';
comment on column postprocessing_image.file_name is '파일 이름';
comment on column postprocessing_image.file_real_name is '파일 실제 이름';
comment on column postprocessing_image.file_path is '파일 경로';
comment on column postprocessing_image.file_size is '파일 사이즈';
comment on column postprocessing_image.file_ext is '파일 확장자';
comment on column postprocessing_image.status is '상태. 0 : 전송 완료';
comment on column postprocessing_image.insert_date is '등록일';


-- 객체 탐지
create table ortho_detected_object(
	ortho_detected_object_id					bigint,
	ortho_image_id								bigint								not null,
	object_type									varchar(100),
	geometry		 							GEOGRAPHY(POINT, 4326),
	detected_date								timestamp with time zone,
	bounding_box_geometry 						geometry(MultiPolygon, 4326),
	major_axis									int,
	minor_axis									int,
	orientation									int,
	bounding_box_area							int,
	length										int,
	speed										int,
	insert_date									timestamp with time zone			default now(),
	constraint ortho_detected_object_pk primary key (ortho_detected_object_id)	
);

comment on table ortho_detected_object is '객체 탐지';
comment on column ortho_detected_object.ortho_detected_object_id is '고유번호';
comment on column ortho_detected_object.ortho_image_id is '개별 정사 영상 고유번호';
comment on column ortho_detected_object.object_type is '객체 타입';
comment on column ortho_detected_object.geometry is 'geometry';
comment on column ortho_detected_object.detected_date is '발견일';
comment on column ortho_detected_object.bounding_box_geometry is 'bounding box 공간 정보';
comment on column ortho_detected_object.major_axis is '최대';
comment on column ortho_detected_object.minor_axis is '최소';
comment on column ortho_detected_object.orientation is '방향';
comment on column ortho_detected_object.bounding_box_area is 'bounding box 면적';
comment on column ortho_detected_object.length is '길이';
comment on column ortho_detected_object.speed is '속도';
comment on column ortho_detected_object.insert_date is '등록일';



