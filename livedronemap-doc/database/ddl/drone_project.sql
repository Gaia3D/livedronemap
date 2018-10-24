drop table if exists drone cascade;
drop table if exists drone_project cascade;


-- ��� ����
create table drone(
	drone_id					int,
	drone_name					varchar(100)					not null,
	insert_date					timestamp with time zone		default now(),
	constraint drone_pk 		primary key (drone_id)
);

comment on table drone is '��� ����';
comment on column drone.drone_id is '��� ������ȣ';
comment on column drone.drone_name is '��� ��';
comment on column drone.insert_date is '�����';


-- ��� ������Ʈ ����
create table drone_project(
	drone_project_id					int,
	drone_id							int,							
	drone_project_name					varchar(256)					not null,
	drone_project_type					varchar(1)						default '0',
	shooting_area						varchar(100),
	shooting_upper_left_latitude		numeric(13,10),
	shooting_upper_left_longitude		numeric(13,10),
	shooting_upper_right_latitude		numeric(13,10),
	shooting_upper_right_longitude		numeric(13,10),
	shooting_lower_right_latitude		numeric(13,10),
	shooting_lower_right_longitude		numeric(13,10),
	shooting_lower_left_latitude		numeric(13,10),
	shooting_lower_left_longitude		numeric(13,10),
	location		 					GEOGRAPHY(POINT, 4326),
	shooting_date						timestamp with time zone,
	status								char(1)							default	'0',
	description							varchar(256),
	ortho_image_count					int default 0,
	postprocessing_image_count			int default 0,
	ortho_detected_object_count			int default 0,
	update_date							timestamp with time zone,
	insert_date							timestamp with time zone		default now(),
	constraint drone_project_pk			primary key (drone_project_id)
);

comment on table drone_project is '��� ������Ʈ ����';
comment on column drone_project.drone_project_id is '������Ʈ ������ȣ';
comment on column drone_project.drone_id is '��� ����Ű';
comment on column drone_project.drone_project_name is '������Ʈ ��';
comment on column drone_project.drone_project_type is '������Ʈ ����. 0:���� ������Ʈ, 1:�ùķ��̼� ������Ʈ';
comment on column drone_project.shooting_area is '�Կ� ����';
comment on column drone_project.shooting_upper_left_latitude is '�Կ� ���� ������ �»�� ����';
comment on column drone_project.shooting_upper_left_longitude is '�Կ� ���� ������ �»�� �浵';
comment on column drone_project.shooting_upper_right_latitude is '�Կ� ���� ������ ���� ����';
comment on column drone_project.shooting_upper_right_longitude is '�Կ� ���� ������ ���� �浵';
comment on column drone_project.shooting_lower_right_latitude is '�Կ� ���� ������ ���ϴ� ����';
comment on column drone_project.shooting_lower_right_longitude is '�Կ� ���� ������ ���ϴ� �浵';
comment on column drone_project.shooting_lower_left_latitude is '�Կ� ���� ������ ���ϴ� ����';
comment on column drone_project.shooting_lower_left_longitude is '�Կ� ���� ������ ���ϴ� �浵';
comment on column drone_project.location is '�߽���';
comment on column drone_project.shooting_date is '�Կ� ���� �Ͻ�';
comment on column drone_project.status is '����. 0:�غ���, 1:����/�׽�Ʈ, 2:���� ���翵��, 3:��ó�� ���� , 4:������Ʈ ����, 5:����, 6:����';
comment on column drone_project.description is '����';
comment on column drone_project.ortho_image_count is '�������� ���� ����(�ߺ�,�ӵ�����)';
comment on column drone_project.postprocessing_image_count is '��ó�� ���� ����(�ߺ�,�ӵ�����)';
comment on column drone_project.ortho_detected_object_count is '��ü Ž�� ����(�ߺ�,�ӵ�����)';
comment on column drone_project.update_date is '������';
comment on column drone_project.insert_date is '�����';
