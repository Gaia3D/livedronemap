drop table if exists drone_project cascade;

-- 프로젝트 관리
create table drone_project(
	drone_project_id				bigint,
	drone_id						int,							
	drone_project_name				varchar(256)					not null,
	shooting_area					varchar(100),
	shooting_date					timestamp with time zone,
	shooting_start_latitude			numeric(13,10),
	shooting_start_longitude		numeric(13,10),
	shooting_end_latitude			numeric(13,10),
	shooting_end_longitude			numeric(13,10),
	status							char(1)							default	'0',
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone		default now(),
	constraint drone_project_pk		primary key (drone_project_id)
);

comment on table drone_project is '프로젝트';
comment on column drone_project.drone_project_id is 'project 고유번호';
comment on column drone_project.drone_id is 'drone 고유번호';
comment on column drone_project.drone_project_name is 'project 이름';
comment on column drone_project.shooting_area is '촬영 지역';
comment on column drone_project.shooting_data is '촬영 일시';
comment on column drone_project.shooting_start_latitude is '촬영 시작 위도';
comment on column drone_project.shooting_start_longitude is '촬영 시작 경도';
comment on column drone_project.shooting_end_latitude is '촬영 종료 위도';
comment on column drone_project.shooting_end_longitude is '촬영 종료 경도';
comment on column drone_project.status is '상태. 0:준비중, 1:점검/테스트, 2:개별영상, 3:후처리영상 , 4:프로젝트 종료, 5:에러';
comment on column drone_project.update_date is '수정일';
comment on column drone_project.insert_date is '등록일';
