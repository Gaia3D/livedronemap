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
	drone_project_id				int,
	drone_id						int,							
	drone_project_name				varchar(256)					not null,
	shooting_area					varchar(100),
	shooting_latitude1				numeric(13,10),
	shooting_longitude1				numeric(13,10),
	shooting_latitude2				numeric(13,10),
	shooting_longitude2				numeric(13,10),
	shooting_latitude3				numeric(13,10),
	shooting_longitude3				numeric(13,10),
	shooting_latitude4				numeric(13,10),
	shooting_longitude4				numeric(13,10),
	location		 				GEOGRAPHY(POINT, 4326),
	shooting_date					timestamp with time zone,
	status							char(1)							default	'0',
	description						varchar(256),
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone		default now(),
	constraint drone_project_pk		primary key (drone_project_id)
);

comment on table drone_project is '��� ������Ʈ ����';
comment on column drone_project.drone_project_id is '������Ʈ ������ȣ';
comment on column drone_project.drone_id is '��� ����Ű';
comment on column drone_project.drone_project_name is '������Ʈ ��';
comment on column drone_project.shooting_area is '�Կ� ����';
comment on column drone_project.shooting_latitude1 is '�Կ� ���� ������ ����1';
comment on column drone_project.shooting_longitude1 is '�Կ� ���� ������ �浵1';
comment on column drone_project.shooting_latitude2 is '�Կ� ���� ������ ����2';
comment on column drone_project.shooting_longitude2 is '�Կ� ���� ������ �浵2';
comment on column drone_project.shooting_latitude3 is '�Կ� ���� ������ ����3';
comment on column drone_project.shooting_longitude3 is '�Կ� ���� ������ �浵3';
comment on column drone_project.shooting_latitude4 is '�Կ� ���� ������ ����4';
comment on column drone_project.shooting_longitude4 is '�Կ� ���� ������ �浵4';
comment on column drone_project.location is 'Multi Polygon';
comment on column drone_project.shooting_date is '�Կ� �Ͻ�';
comment on column drone_project.status is '����. 0:�غ���, 1:����/�׽�Ʈ, 2:���� ���翵��, 3:��ó�� ���� , 4:������Ʈ ����, 5:����';
comment on column drone_project.description is '����';
comment on column drone_project.update_date is '������';
comment on column drone_project.insert_date is '�����';
