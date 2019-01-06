drop table if exists board_notice cascade;
drop table if exists board_notice_detail cascade;
drop table if exists board_notice_comment cascade;
drop table if exists board_notice_file cascade;

-- ��������
create table board_notice(
	notice_id 			bigint,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	notice_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			int								default 0,
	insert_date			timestamp with time zone,
	constraint board_notice_pk 	primary key (notice_id)	
);

comment on table board_notice is '��������';
comment on column board_notice.notice_id is '������ȣ';
comment on column board_notice.title is '����';
comment on column board_notice.user_id is '����� ���̵�';
comment on column board_notice.notice_site is '�������� �Խ� ������';
comment on column board_notice.start_date is '�Խ� ���۽ð�';
comment on column board_notice.end_date is '�Խ� ����ð�';
comment on column board_notice.use_yn is '�������, Y : ���, N : ������';
comment on column board_notice.client_ip is '��û IP';
comment on column board_notice.view_count is '��ȸ��';
comment on column board_notice.insert_date is '�����';

-- �������� ��
create table board_notice_detail (
	notice_detail_id		bigint,
	notice_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_detail_pk 	primary key (notice_detail_id)	
);

comment on table board_notice_detail is '�������� ��';
comment on column board_notice_detail.notice_detail_id is '������ȣ';
comment on column board_notice_detail.notice_id is '�������� ������ȣ';
comment on column board_notice_detail.contents is '����';
comment on column board_notice_detail.insert_date is '�����';


-- �������� ���(Comment)
create table board_notice_comment (
	notice_comment_id		bigint,
	notice_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_comment_pk 	primary key (notice_comment_id)	
);

comment on table board_notice_comment is '�������� ���(Comment)';
comment on column board_notice_comment.notice_comment_id is '������ȣ';
comment on column board_notice_comment.notice_id is '�������� ������ȣ';
comment on column board_notice_comment.user_id is '����� ���̵�';
comment on column board_notice_comment.comment is '���(Comment)';
comment on column board_notice_comment.client_ip is '��û IP';
comment on column board_notice_comment.insert_date is '�����';


-- �������� ����
create table board_notice_file(
	notice_file_id			bigint,
	notice_id				bigint 						not null,
	file_name				varchar(256)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_notice_file_pk 	primary key (notice_file_id)	
);

comment on table board_notice_file is '�������� ���� ����';
comment on column board_notice_file.notice_file_id is '������ȣ';
comment on column board_notice_file.notice_id is '������ȣ';
comment on column board_notice_file.file_name is '���� �̸�';
comment on column board_notice_file.file_real_name is '���� ���� �̸�';
comment on column board_notice_file.file_path is '���� ���';
comment on column board_notice_file.file_size is '���� ������';
comment on column board_notice_file.file_ext is '���� Ȯ����';
comment on column board_notice_file.insert_date is '�����';



drop table if exists board_faq cascade;
drop table if exists board_faq_detail cascade;
drop table if exists board_faq_comment cascade;
drop table if exists board_faq_file cascade;

-- FAQ
create table board_faq(
	faq_id 				bigint,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	faq_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			bigint							default 0,
	insert_date			timestamp with time zone,
	constraint board_faq_pk 	primary key (faq_id)	
);

comment on table board_faq is 'FAQ';
comment on column board_faq.faq_id is '������ȣ';
comment on column board_faq.title is '����';
comment on column board_faq.user_id is '����� ���̵�';
comment on column board_faq.faq_site is 'FAQ �Խ� ������';
comment on column board_faq.start_date is '�Խ� ���۽ð�';
comment on column board_faq.end_date is '�Խ� ����ð�';
comment on column board_faq.use_yn is '�������, Y : ���, N : ������';
comment on column board_faq.client_ip is '��û IP';
comment on column board_faq.view_count is '��ȸ��';
comment on column board_faq.insert_date is '�����';

-- FAQ ��
create table board_faq_detail (
	faq_detail_id			bigint,
	faq_id					bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_detail_pk 		primary key (faq_detail_id)	
);

comment on table board_faq_detail is 'FAQ ��';
comment on column board_faq_detail.faq_detail_id is '������ȣ';
comment on column board_faq_detail.faq_id is 'FAQ ������ȣ';
comment on column board_faq_detail.contents is '����';
comment on column board_faq_detail.insert_date is '�����';


-- FAQ ���(Comment)
create table board_faq_comment (
	faq_comment_id			bigint,
	faq_id					bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_comment_pk 	primary key (faq_comment_id)	
);

comment on table board_faq_comment is 'FAQ ���(Comment)';
comment on column board_faq_comment.faq_comment_id is '������ȣ';
comment on column board_faq_comment.faq_id is 'FAQ ������ȣ';
comment on column board_faq_comment.user_id is '����� ���̵�';
comment on column board_faq_comment.comment is '���(Comment)';
comment on column board_faq_comment.client_ip is '��û IP';
comment on column board_faq_comment.insert_date is '�����';


-- FAQ ����
create table board_faq_file(
	faq_file_id				bigint,
	faq_id					bigint 						not null,
	file_name				varchar(100)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_faq_file_pk	 primary key (faq_file_id)	
);

comment on table board_faq_file is 'FAQ ���� ����';
comment on column board_faq_file.faq_file_id is 'FAQ ���� ������ȣ';
comment on column board_faq_file.faq_id is '������ȣ';
comment on column board_faq_file.file_name is '���� �̸�';
comment on column board_faq_file.file_real_name is '���� ���� �̸�';
comment on column board_faq_file.file_path is '���� ���';
comment on column board_faq_file.file_size is '���� ������';
comment on column board_faq_file.file_ext is '���� Ȯ����';
comment on column board_faq_file.insert_date is '�����';



drop table if exists board_press cascade;
drop table if exists board_press_detail cascade;
drop table if exists board_press_comment cascade;
drop table if exists board_press_file cascade;

-- �����ڷ�
create table board_press(
	press_id 			bigint,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	press_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			bigint							default 0,
	insert_date			timestamp with time zone,
	constraint board_press_pk	 primary key (press_id)	
);

comment on table board_press is '�����ڷ�';
comment on column board_press.press_id is '������ȣ';
comment on column board_press.title is '����';
comment on column board_press.user_id is '����� ���̵�';
comment on column board_press.press_site is '�����ڷ� �Խ� ������';
comment on column board_press.start_date is '�Խ� ���۽ð�';
comment on column board_press.end_date is '�Խ� ����ð�';
comment on column board_press.use_yn is '�������, Y : ���, N : ������';
comment on column board_press.client_ip is '��û IP';
comment on column board_press.view_count is '��ȸ��';
comment on column board_press.insert_date is '�����';

-- �����ڷ� ��
create table board_press_detail (
	press_detail_id			bigint,
	press_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_detail_pk 	primary key (press_detail_id)	
);

comment on table board_press_detail is '�����ڷ� ��';
comment on column board_press_detail.press_detail_id is '������ȣ';
comment on column board_press_detail.press_id is '�����ڷ� ������ȣ';
comment on column board_press_detail.contents is '����';
comment on column board_press_detail.insert_date is '�����';


-- �����ڷ� ���(Comment)
create table board_press_comment (
	press_comment_id		bigint,
	press_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_comment_pk 	primary key (press_comment_id)	
);

comment on table board_press_comment is '�����ڷ� ���(Comment)';
comment on column board_press_comment.press_comment_id is '������ȣ';
comment on column board_press_comment.press_id is '�����ڷ� ������ȣ';
comment on column board_press_comment.user_id is '����� ���̵�';
comment on column board_press_comment.comment is '���(Comment)';
comment on column board_press_comment.client_ip is '��û IP';
comment on column board_press_comment.insert_date is '�����';


-- �����ڷ� ����
create table board_press_file(
	press_file_id			bigint,
	press_id				bigint 						not null,
	file_name				varchar(100)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_press_file_pk		primary key (press_file_id)		
);

comment on table board_press_file is '�����ڷ� ���� ����';
comment on column board_press_file.press_file_id is '������ȣ';
comment on column board_press_file.press_id is '�����ڷ� ������ȣ';
comment on column board_press_file.file_name is '���� �̸�';
comment on column board_press_file.file_real_name is '���� ���� �̸�';
comment on column board_press_file.file_path is '���� ���';
comment on column board_press_file.file_size is '���� ������';
comment on column board_press_file.file_ext is '���� Ȯ����';
comment on column board_press_file.insert_date is '�����';



drop table if exists board_forum cascade;
drop table if exists board_forum_detail cascade;
drop table if exists board_forum_comment cascade;
drop table if exists board_forum_file cascade;

-- ����
create table board_forum(
	forum_id 			bigint,
	title				varchar(4000)					not null,
	user_id				varchar(32)						not null,
	forum_site			varchar(30),
	start_date			timestamp with time zone,
	end_date			timestamp with time zone,
	use_yn				char(1) 						default 'Y',
	client_ip 			varchar(45)						not null,
	view_count			int								default 0,
	insert_date			timestamp with time zone,
	constraint board_forum_pk 	primary key (forum_id)	
);

comment on table board_forum is '����';
comment on column board_forum.forum_id is '������ȣ';
comment on column board_forum.title is '����';
comment on column board_forum.user_id is '����� ���̵�';
comment on column board_forum.forum_site is '���� �Խ� ������';
comment on column board_forum.use_yn is '�������, Y : ���, N : ������';
comment on column board_forum.client_ip is '��û IP';
comment on column board_forum.view_count is '��ȸ��';
comment on column board_forum.insert_date is '�����';

-- ���� ��
create table board_forum_detail (
	forum_detail_id			bigint,
	forum_id				bigint 						not null,
	contents				text,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_detail_pk 	primary key (forum_detail_id)	
);

comment on table board_forum_detail is '���� ��';
comment on column board_forum_detail.forum_detail_id is '������ȣ';
comment on column board_forum_detail.forum_id is '���� ������ȣ';
comment on column board_forum_detail.contents is '����';
comment on column board_forum_detail.insert_date is '�����';


-- ���� ���(Comment)
create table board_forum_comment (
	forum_comment_id		bigint,
	forum_id				bigint						not null,
	user_id					varchar(32)	 				not null,
	comment					varchar(4000)				not null,
	client_ip				varchar(45)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_comment_pk 	primary key (forum_comment_id)	
);

comment on table board_forum_comment is '�������� ���(Comment)';
comment on column board_forum_comment.forum_comment_id is '������ȣ';
comment on column board_forum_comment.forum_id is '�������� ������ȣ';
comment on column board_forum_comment.user_id is '����� ���̵�';
comment on column board_forum_comment.comment is '���(Comment)';
comment on column board_forum_comment.client_ip is '��û IP';
comment on column board_forum_comment.insert_date is '�����';


-- ���� ����
create table board_forum_file(
	forum_file_id			bigint,
	forum_id				bigint 						not null,
	file_name				varchar(256)				not null,
	file_real_name			varchar(100)				not null,
	file_path				varchar(256)				not null,
	file_size				varchar(12)					not null,
	file_ext				varchar(10)					not null,
	insert_date				timestamp with time zone	default now(),
	constraint board_forum_file_pk 		primary key (forum_file_id)	
);

comment on table board_forum_file is '���� ���� ����';
comment on column board_forum_file.forum_file_id is '������ȣ';
comment on column board_forum_file.forum_id is '���� ������ȣ';
comment on column board_forum_file.file_name is '���� �̸�';
comment on column board_forum_file.file_real_name is '���� ���� �̸�';
comment on column board_forum_file.file_path is '���� ���';
comment on column board_forum_file.file_size is '���� ������';
comment on column board_forum_file.file_ext is '���� Ȯ����';
comment on column board_forum_file.insert_date is '�����';

