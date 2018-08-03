drop table if exists upload_log cascade;

-- 사용자 파일 upload 이력
create table upload_log(
	upload_log_id				bigint,
	user_id						varchar(32),
	file_name					varchar(100)				not null,
	file_real_name				varchar(100)				not null,
	file_path					varchar(256)				not null,
	file_size					varchar(12)					not null,
	file_ext					varchar(10)					not null,
	insert_date					timestamp with time zone			default now(),
	constraint upload_log_pk	primary key (upload_log_id)	
);

comment on table upload_log is '사용자 파일 upload 이력';
comment on column upload_log.upload_log_id is '고유번호';
comment on column upload_log.user_id is '사용자 아이디';
comment on column upload_log.file_name is '파일 이름';
comment on column upload_log.file_real_name is '파일 실제 이름';
comment on column upload_log.file_path is '파일 경로';
comment on column upload_log.file_size is '파일 사이즈';
comment on column upload_log.file_ext is '파일 확장자';
comment on column upload_log.insert_date is '등록일';


