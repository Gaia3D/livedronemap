drop table if exists schedule_log cascade;
drop table if exists schedule_detail_log cascade;
drop table if exists schedule cascade;

-- ������
create table schedule(
	schedule_id					bigint,
	schedule_name				varchar(100)		not null,
	schedule_code				varchar(30)			not null,
	expression					varchar(50),
	use_yn						char(1)				default 'Y',
	start_date					timestamp with time zone,
	end_date					timestamp with time zone,
	user_id						varchar(32),
	execute_type				char(1)				default '0',
	description					varchar(256),
	insert_date				timestamp with time zone default now(),
	constraint schedule_pk primary key (schedule_id)	
);

comment on table schedule is '������';
comment on column schedule.schedule_id is '������ȣ';
comment on column schedule.schedule_name is '�����ٸ�';
comment on column schedule.schedule_code is '������ KEY';
comment on column schedule.expression is '������ ���� Quartz ǥ����';
comment on column schedule.use_yn is '�������, Y : ���, N : ������';
comment on column schedule.start_date is '���� �ð�';
comment on column schedule.end_date is '���� �ð�';
comment on column schedule.user_id is '����� ���̵�';
comment on column schedule.execute_type is '���� ��ü, 0 : WEB';
comment on column schedule.description is '����';
comment on column schedule.insert_date is '�����';


-- ������ ���� �̷�
create table schedule_log(
	schedule_log_id				bigint,
	schedule_id					bigint 				not null,
	execute_result				char(1)				not null,
	execute_total_count			int									default 0,
	execute_message				varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_log_pk primary key (schedule_log_id)	
);

comment on table schedule_log is '������ ���� �̷�';
comment on column schedule_log.schedule_log_id is '������ ���� �̷� ������ȣ';
comment on column schedule_log.schedule_id is '������ ������ȣ';
comment on column schedule_log.execute_result is '������ ���� ��ü ���. 0 : ����, 1 : ����, 2 : �κм���';
comment on column schedule_log.execute_total_count is '������ ���� �� �Ǽ�';
comment on column schedule_log.execute_message is '������ ���� ��� �� ����';
comment on column schedule_log.insert_date is '�����';

-- ������ ���� �� �̷�
create table schedule_detail_log(
	schedule_detail_log_id		bigint,
	schedule_log_id				bigint 				not null,
	execute_detail_result		char(1)				not null,
	execute_detail_message		varchar(1000)		not null,
	insert_date				timestamp with time zone			default now(),
	constraint schedule_detail_log_pk primary key (schedule_detail_log_id)	
);

comment on table schedule_detail_log is '������ ���� �� �̷�';
comment on column schedule_detail_log.schedule_detail_log_id is '������ ���� �� �̷� ������ȣ';
comment on column schedule_detail_log.schedule_log_id is '������ ���� �̷� ������ȣ';
comment on column schedule_detail_log.execute_detail_result is '���� ���. 0 : ����, 1 : ����';
comment on column schedule_detail_log.execute_detail_message is '���� ��� �� ����';
comment on column schedule_detail_log.insert_date is '�����';
