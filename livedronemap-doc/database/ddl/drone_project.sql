drop table if exists drone cascade;
drop table if exists drone_project cascade;


-- 드론 정보
create table drone(
	drone_id					int,
	drone_name					varchar(100)					not null,
	insert_date					timestamp with time zone		default now(),
	constraint drone_pk 		primary key (drone_id)
);

comment on table drone is '드론 정보';
comment on column drone.drone_id is '드론 고유번호';
comment on column drone.drone_name is '드론 명';
comment on column drone.insert_date is '등록일';


-- 드론 프로젝트 정보
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

comment on table drone_project is '드론 프로젝트 정보';
comment on column drone_project.drone_project_id is '프로젝트 고유번호';
comment on column drone_project.drone_id is '드론 고유키';
comment on column drone_project.drone_project_name is '프로젝트 명';
comment on column drone_project.shooting_area is '촬영 지역';
comment on column drone_project.shooting_latitude1 is '촬영 시작 지점의 위도1';
comment on column drone_project.shooting_longitude1 is '촬영 시작 지점의 경도1';
comment on column drone_project.shooting_latitude2 is '촬영 시작 지점의 위도2';
comment on column drone_project.shooting_longitude2 is '촬영 시작 지점의 경도2';
comment on column drone_project.shooting_latitude3 is '촬영 시작 지점의 위도3';
comment on column drone_project.shooting_longitude3 is '촬영 시작 지점의 경도3';
comment on column drone_project.shooting_latitude4 is '촬영 시작 지점의 위도4';
comment on column drone_project.shooting_longitude4 is '촬영 시작 지점의 경도4';
comment on column drone_project.location is 'Multi Polygon';
comment on column drone_project.shooting_date is '촬영 일시';
comment on column drone_project.status is '상태. 0:준비중, 1:점검/테스트, 2:개별 정사영상, 3:후처리 영상 , 4:프로젝트 종료, 5:에러';
comment on column drone_project.description is '설명';
comment on column drone_project.update_date is '수정일';
comment on column drone_project.insert_date is '등록일';
