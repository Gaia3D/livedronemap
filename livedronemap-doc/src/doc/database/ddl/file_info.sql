drop table if exists file_info cascade;

-- 파일 관리
create table file_info(
	file_info_id			bigint,
	user_id					varchar(32)	 					not null,
	job_type				varchar(50)						not null,
	file_name				varchar(100)					not null,
	file_real_name			varchar(100)					not null,
	file_path				varchar(256)					not null,
	file_size				varchar(12)						not null,
	file_ext				varchar(10)						not null,
	insert_date				timestamp with time zone		default now(),
	constraint file_info_pk primary key (file_info_id)	
);

comment on table file_info is '파일 관리';
comment on column file_info.file_info_id is '고유번호';
comment on column file_info.user_id is '사용자 아이디';
comment on column file_info.job_type is '업무 타입';
comment on column file_info.file_name is '파일 이름';
comment on column file_info.file_real_name is '파일 실제 이름';
comment on column file_info.file_path is '파일 경로';
comment on column file_info.file_size is '파일 사이즈';
comment on column file_info.file_ext is '파일 확장자';
comment on column file_info.insert_date is '등록일';


