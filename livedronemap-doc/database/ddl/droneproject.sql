-- FK, Index는 별도 파일로 분리.
drop table if exists drone_project cascade;

-- 프로젝트 관리
create table drone_project(
	project_id					bigint,
	drone_id					bigint,							
	project_name				varchar(300)					not null.
	start_latitude				numeric(13,10),
	start_longitude				numeric(13,10),
	end_latitude				numeric(13,10),
	end_longitude				numeric(13,10),
	status						char(1),						default	'0',			
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	capture_task_date			timestamp with time zone,		default now(),
	constraint project_id_pk	primary key (project_id),
);

comment on table project is '프로젝트 관리';
comment on column project.project_id is 'project 고유번호';
comment on column project.project_name is 'project 이름';
comment on column project.start_Lat is '드론이 처음 촬영한 영상 위치의 위도';
comment on column projcet.start_Lon is '드론이 처음 촬영한 영상 위치의 경도';
comment on column project.end_Lat is '드론이 마지막으로 촬영한 영상 위치의 위도';
comment on column projcet.end_Lon is '드론이 마지막으로 촬영한 영상 위치의 경도';
comment on column project.status is 'project의 상태. 0:준비중, 1:점검/테스트, 2:개별영상, 3:후처리영상 4:프로젝트 종료 5:error';
comment on column projcet.update_date is '수정일';
comment on column project.insert_date is '등록일';
