-- FK, Index 는 별도 파일로 분리. 맨 마지막에 작업 예정
drop table if exists user_group cascade;
drop table if exists user_group_role cascade;
drop table if exists user_group_menu cascade;
drop table if exists user_info cascade;
drop table if exists user_device cascade;
drop table if exists user_policy cascade;

-- 사용자 그룹
create table user_group(
	user_group_id				int,
	group_key					varchar(60)							not null ,
	group_name					varchar(100)						not null,
	ancestor					int									default 0,
	parent						int									default 1,
	depth						int									default 1,
	view_order					int									default 1,
	child_yn					char(1)								default 'N',
	default_yn					char(1)								default 'N',
	use_yn						char(1)								default 'Y',
	description					varchar(256),
	insert_date					timestamp with time zone			default now(),
	constraint user_group_pk 	primary key (user_group_id)	
);

comment on table user_group is '사용자 그룹';
comment on column user_group.user_group_id is '고유번호';
comment on column user_group.group_key is '링크 활용 등을 위한 확장 컬럼';
comment on column user_group.group_name is '그룹명';
comment on column user_group.ancestor is '조상 고유번호';
comment on column user_group.parent is '부모 고유번호';
comment on column user_group.depth is '깊이';
comment on column user_group.view_order is '나열 순서';
comment on column user_group.child_yn is '자식 존재유무, Y : 존재, N : 존재안함(기본)';
comment on column user_group.default_yn is '삭제 불가, Y : 기본, N : 선택';
comment on column user_group.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column user_group.description is '설명';
comment on column user_group.insert_date is '등록일';

-- 사용자 그룹별 Role
create table user_group_role (
	user_group_role_id				int,
	user_group_id					int 								not null,
	role_id							int	 								not null,
	insert_date						timestamp with time zone			default now(),
	constraint user_group_role_pk 	primary key (user_group_role_id)
);

comment on table user_group_role is '사용자 그룹별 Role';
comment on column user_group_role.user_group_role_id is '고유번호';
comment on column user_group_role.user_group_id is '사용자 그룹 고유키';
comment on column user_group_role.role_id is 'Role 고유키';
comment on column user_group_role.insert_date is '등록일';

-- 사용자 그룹 권한
create table user_group_menu(
	user_group_menu_id				int,
	user_group_id					int 								not null,
	menu_id							int 								not null,
	all_yn							char(1)								default 'N',
	read_yn							char(1)								default 'N',
	write_yn						char(1)								default 'N',
	update_yn						char(1)								default 'N',
	delete_yn						char(1)								default 'N',
	insert_date						timestamp with time zone			default now(),
	constraint user_group_menu_pk 	primary key (user_group_menu_id)
);

comment on table user_group_menu is '사용자 그룹 메뉴';
comment on column user_group_menu.user_group_menu_id is '고유번호';
comment on column user_group_menu.user_group_id is '사용자 그룹 고유키';
comment on column user_group_menu.menu_id is '메뉴 고유키';
comment on column user_group_menu.all_yn is '메뉴 접근 모든 권한';
comment on column user_group_menu.read_yn is '읽기 권한';
comment on column user_group_menu.write_yn is '쓰기 권한';
comment on column user_group_menu.update_yn is '수정 권한';
comment on column user_group_menu.delete_yn is '삭제 권한';
comment on column user_group_menu.insert_date is '등록일';


-- 사용자 기본정보
create table user_info(
	user_id						varchar(32),
	user_group_id				int									not null,
	user_name					varchar(64)							not null,
	password					varchar(512)						not null,
	salt						varchar(256)						not null,
	telephone					varchar(256),
	mobile_phone				varchar(256),
	email						varchar(256),
	messanger					varchar(100),
	employee_id 				varchar(20),
  	postal_code					varchar(6),
	address						varchar(256),
	address_etc					varchar(1000),
	ci							varchar(256),
	di							varchar(256),
	status						char(1)								default '0',
	user_role_check_yn			char(1)								default 'Y',
	user_insert_type			varchar(30)							default 'USER_REGISTER_SELF',
	sso_use_yn					char(1)								default 'N',
	login_count					bigint								default 0,
	fail_login_count			int									default 0,
	last_login_date				timestamp with time zone,
	last_password_change_date	timestamp with time zone			default now(),
	update_date					timestamp with time zone,
	insert_date					timestamp with time zone			default now(),
	constraint user_info_pk primary key(user_id)
);

comment on table user_info is '사용자 기본정보';
comment on column user_info.user_id is '고유번호';
comment on column user_info.user_group_id is '사용자 그룹 고유번호';
comment on column user_info.user_name is '이름';
comment on column user_info.password is '비밀번호';
comment on column user_info.salt is 'SALT';
comment on column user_info.telephone is '전화번호';
comment on column user_info.mobile_phone is '핸드폰 번호';
comment on column user_info.email is '이메일';
comment on column user_info.messanger is '메신저 아이디';
comment on column user_info.employee_id is '사번';
comment on column user_info.postal_code is '우편번호';
comment on column user_info.address is '주소';
comment on column user_info.address_etc is '상세주소';
comment on column user_info.ci is '실명 인증 CI 고유값';
comment on column user_info.di is '실명 인증 DI 도메인 고유값';
comment on column user_info.user_role_check_yn is '최초 로그인시 사용자 Role 권한 체크 패스 기능. 기본값 Y : 체크';
comment on column user_info.status is '사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_type=0), 6:임시비밀번호';
comment on column user_info.user_insert_type is '사용자 등록 방법. 기본 : SELF';
comment on column user_info.sso_use_yn is 'Single Sign-On 사용유무. 기본값 N : 사용안함';
comment on column user_info.login_count is '로그인 횟수';
comment on column user_info.fail_login_count is '로그인 실패 횟수';
comment on column user_info.last_login_date is '마지막 로그인 날짜';
comment on column user_info.last_password_change_date is '마지막 로그인 비밀번호 변경 날짜';
comment on column user_info.update_date is '개인정보 수정 날짜';
comment on column user_info.insert_date is '등록일';


-- 사용자 사용 디바이스
create table user_device (
	user_device_id				bigint,
	user_id						varchar(32)	 						not null,
	device_name1				varchar(60)							not null,
	device_type1				char(1)								default '0',
	device_ip1					varchar(45),
	device_priority1			int									default 1,
	use_yn1						char(1)								default 'Y',
	description1				varchar(256),
	device_name2				varchar(60)							not null,
	device_type2				char(1)								default '0',
	device_ip2					varchar(45),
	device_priority2			int									default 2,
	use_yn2						char(1)								default 'Y',
	description2				varchar(256),
	device_name3				varchar(60)							not null,
	device_type3				char(1)								default '0',
	device_ip3					varchar(45),
	device_priority3			int									default 3,
	use_yn3						char(1)								default 'Y',
	description3				varchar(256),
	device_name4				varchar(60)							not null,
	device_type4				char(1)								default '0',
	device_ip4					varchar(45),
	device_priority4			int									default 4,
	use_yn4						char(1)								default 'Y',
	description4				varchar(256),
	device_name5				varchar(60)							not null,
	device_type5				char(1)								default '0',
	device_ip5					varchar(45),
	device_priority5			int									default 5,
	use_yn5						char(1)								default 'Y',
	description5				varchar(256),
	insert_date				timestamp with time zone				default now(),
	constraint user_device_pk primary key (user_device_id)
);


comment on table user_device is '사용자 사용 디바이스';
comment on column user_device.user_device_id is '고유번호';
comment on column user_device.user_id is '사용자 아이디';
comment on column user_device.device_name1 is '사용 기기명1';
comment on column user_device.device_type1 is '사용 기기 타입1. 0 : PC, 1 : 핸드폰';
comment on column user_device.device_ip1 is 'IP1';
comment on column user_device.device_priority1 is '우선순위1';
comment on column user_device.use_yn1 is '사용유무1. Y : 사용, N : 미사용';
comment on column user_device.description1 is '설명1';
comment on column user_device.device_name2 is '사용 기기명2';
comment on column user_device.device_type2 is '사용 기기 타입2. 0 : PC, 1 : 핸드폰';
comment on column user_device.device_ip2 is 'IP2';
comment on column user_device.device_priority2 is '우선순위2';
comment on column user_device.use_yn2 is '사용유무2. Y : 사용, N : 미사용';
comment on column user_device.description2 is '설명2';
comment on column user_device.device_name3 is '사용 기기명3';
comment on column user_device.device_type3 is '사용 기기 타입3. 0 : PC, 1 : 핸드폰';
comment on column user_device.device_ip3 is 'IP3';
comment on column user_device.device_priority3 is '우선순위3';
comment on column user_device.use_yn3 is '사용유무3. Y : 사용, N : 미사용';
comment on column user_device.description3 is '설명3';
comment on column user_device.device_name4 is '사용 기기명4';
comment on column user_device.device_type4 is '사용 기기 타입4. 0 : PC, 1 : 핸드폰';
comment on column user_device.device_ip4 is 'IP4';
comment on column user_device.device_priority4 is '우선순위4';
comment on column user_device.use_yn4 is '사용유무4. Y : 사용, N : 미사용';
comment on column user_device.description4 is '설명4';
comment on column user_device.device_name5 is '사용 기기명5';
comment on column user_device.device_type5 is '사용 기기 타입5. 0 : PC, 1 : 핸드폰';
comment on column user_device.device_ip5 is 'IP5';
comment on column user_device.device_priority5 is '우선순위5';
comment on column user_device.use_yn5 is '사용유무5. Y : 사용, N : 미사용';
comment on column user_device.description5 is '설명5';
comment on column user_device.insert_date is '등록일';



-- 사용자 운영정책
create table user_policy(
	user_policy_id							bigint,
	user_id									varchar(32)	 						not null,	
	update_date								timestamp with time zone			default now(),
	insert_date								timestamp with time zone			default now(),
	constraint user_policy_pk primary key (user_id)	
);

comment on table user_policy is '사용자 운영정책';
comment on column user_policy.user_policy_id is '고유키';
comment on column user_policy.user_id is '사용자 아이디';
comment on column user_policy.update_date is '수정일';
comment on column user_policy.insert_date is '등록일';