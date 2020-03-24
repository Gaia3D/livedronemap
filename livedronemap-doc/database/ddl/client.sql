drop table if exists client_group cascade;
drop table if exists client cascade;
drop table if exists client_group_role cascade;

-- 서버 그룹
create table client_group(
	client_group_id				int,
	group_key					varchar(60)			unique			not null,
	group_name					varchar(100)						not null,
	parent						int									default 1,
	depth						int									default 1,
	view_order					int									default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint client_group_pk 	primary key (client_group_id)	
);

comment on table client_group is '서버 그룹';
comment on column client_group.client_group_id is '고유번호';
comment on column client_group.group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column client_group.group_name is '그룹명';
comment on column client_group.parent is '부모 고유번호';
comment on column client_group.depth is '깊이';
comment on column client_group.view_order is '나열 순서';
comment on column client_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column client_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column client_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column client_group.description is '설명';
comment on column client_group.insert_date is '등록일';

-- 서버 그룹별 Role

create table client_group_role (
	client_group_role_id			int,
	client_group_id					int 							not null,
	role_id							int	 							not null,
	role_key						varchar(50)						not null,
	insert_date						timestamp with time zone		default now(),
	constraint client_group_role_pk primary key (client_group_role_id)
);

comment on table client_group_role is '서버 그룹별 Role';
comment on column client_group_role.client_group_role_id is '고유번호';
comment on column client_group_role.client_group_id is '서버 그룹 고유키';
comment on column client_group_role.role_id is 'Role 고유키';
comment on column client_group_role.role_key is 'Role KEY(속도를 위한 중복)';
comment on column client_group_role.insert_date is '등록일';


-- 서버
create table client (
	client_id					int,							
	client_group_id				int,								
	client_name					varchar(100)					not null,
	client_ip 					varchar(45) 					not null,
	use_yn 						char(1) 						default 'N',
	api_key 					varchar(256),
	description 				varchar(256),
  	update_date 				timestamp with time zone,
	insert_date					timestamp with time zone		default now(),
	constraint client_pk primary key (client_id),
	constraint client_api_key_uk UNIQUE (api_key)
);



comment on table client is '서버';
comment on column client.client_id is '고유번호';
comment on column client.client_group_id is '고유번호';
comment on column client.client_name is '서버명';
comment on column client.client_ip is '서버 IP';
comment on column client.use_yn is '사용유무, Y : 사용, N : 사용안함(기본)';
comment on column client.api_key is 'API KEY';
comment on column client.description is '설명';
comment on column client.update_date is '수정일';
comment on column client.insert_date is '등록일';
