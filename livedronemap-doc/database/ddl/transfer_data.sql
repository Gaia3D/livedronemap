-- FK, Index�� ���� ���Ϸ� �и�.
drop table if exists transfer_data cascade;
drop table if exists ortho_image cascade;
drop table if exists ortho_detected_object cascade;
drop table if exists postprocessing_image cascade;


-- ���� ����Ƽ
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

comment on table transfer_data is '���� ������';
comment on column transfer_data.transfer_data_id is 'transfer data ������ȣ';
comment on column transfer_data.drone_project_id is 'drone project ������ȣ';
comment on column transfer_data.user_id is '����� ���̵�';
comment on column transfer_data.data_type is '������ Ÿ��. 0 : ���� ���� ����, 1 : ��ó�� ����';
comment on column transfer_data.file_name is '���� �̸�';
comment on column transfer_data.detected_objects_count is '��ü Ž�� ����';
comment on column transfer_data.status is '����. 0 : ���� �Ϸ�, 1 : ��ó�� �Ϸ�';
comment on column transfer_data.drone_latitude is '��� ����';
comment on column transfer_data.drone_longitude is '��� �浵';
comment on column transfer_data.drone_altitude is '��� ����';
comment on column transfer_data.drone_roll is '��� roll';
comment on column transfer_data.drone_pitch is '��� pitch';
comment on column transfer_data.drone_yaw is '��� ��鸲';
comment on column transfer_data.shooting_date is '�Կ���';
comment on column transfer_data.insert_date is '�����';


-- ���� ���� ����
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

comment on table ortho_image is '���� ���� ����';
comment on column ortho_image.ortho_image_id is '������ȣ';
comment on column ortho_image.transfer_data_id is '���� ������ ������ȣ';
comment on column ortho_image.file_name is '���� �̸�';
comment on column ortho_image.file_real_name is '���� ���� �̸�';
comment on column ortho_image.file_path is '���� ���';
comment on column ortho_image.file_size is '���� ������';
comment on column ortho_image.file_ext is '���� Ȯ����';
comment on column ortho_image.status is '����. 0 : ���� �Ϸ�, 1 : �̹��� ��ó�� �Ϸ�';
comment on column ortho_image.insert_date is '�����';


-- ��ó�� ����
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

comment on table postprocessing_image is '��ó�� ����';
comment on column postprocessing_image.postprocessing_image_id is '������ȣ';
comment on column postprocessing_image.transfer_data_id is '���� ������ ������ȣ';
comment on column postprocessing_image.file_type is '���� ����';
comment on column postprocessing_image.file_name is '���� �̸�';
comment on column postprocessing_image.file_real_name is '���� ���� �̸�';
comment on column postprocessing_image.file_path is '���� ���';
comment on column postprocessing_image.file_size is '���� ������';
comment on column postprocessing_image.file_ext is '���� Ȯ����';
comment on column postprocessing_image.status is '����. 0 : ���� �Ϸ�';
comment on column postprocessing_image.insert_date is '�����';


-- ��ü Ž��
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

comment on table ortho_detected_object is '��ü Ž��';
comment on column ortho_detected_object.ortho_detected_object_id is '������ȣ';
comment on column ortho_detected_object.ortho_image_id is '���� ���� ���� ������ȣ';
comment on column ortho_detected_object.object_type is '��ü Ÿ��';
comment on column ortho_detected_object.geometry is 'geometry';
comment on column ortho_detected_object.detected_date is '�߰���';
comment on column ortho_detected_object.bounding_box_geometry is 'bounding box ���� ����';
comment on column ortho_detected_object.major_axis is '�ִ�';
comment on column ortho_detected_object.minor_axis is '�ּ�';
comment on column ortho_detected_object.orientation is '����';
comment on column ortho_detected_object.bounding_box_area is 'bounding box ����';
comment on column ortho_detected_object.length is '����';
comment on column ortho_detected_object.speed is '�ӵ�';
comment on column ortho_detected_object.insert_date is '�����';



