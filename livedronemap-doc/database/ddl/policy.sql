drop table if exists policy cascade;

-- 운영정책
create table policy (
	policy_id						int,
	user_upload_type				varchar(256)				default '3ds,obj,ifc,dae',
	user_upload_max_filesize		int							default 500,
	user_upload_max_count			int							default 50,
	insert_date						timestamp with time zone	default now(),
	constraint policy_pk primary key (policy_id)	
);

comment on table policy is '운영정책';
comment on column policy.policy_id is '고유번호';
comment on column policy.user_upload_type is '업로딩 가능 확장자. 3ds,obj,ifc,dae';
comment on column policy.user_upload_max_filesize is '최대 업로딩 사이즈(단위M). 500M';
comment on column policy.user_upload_max_count is '1회, 최대 업로딩 파일 수. 50개';
comment on column policy.insert_date is '등록일';