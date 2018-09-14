-- FK, Index�� ���� ���Ϸ� �и�.
drop table if exists transfer_data cascade;
drop table if exists individual_data cascade;
drop table if exists postprocessing_data cascade;


-- ���۵� ������ ����
create table transfer_data(
	transfer_data_id				bigint,
	drone_project_id				bigint						not null,
	data_name						varchar(100),
	data_type						char(1),
	attributes						jsonb,
	project_image_count				int							default 0;
	shooting_date					timestamp with time zone,
	transfer_sucessyn				char(1),
	constraint transfer_data_id_pk	primary key (transfer_data_id),
);

comment on table transfer_data is '���۵� ������ ����';
comment on column transfer_data.transfer_data_id is 'transfer data ������ȣ';
comment on column transfer_data.drone_proejct_id is 'drone project ������ȣ';
comment on column transfer_data.data_name is '������ �̸�';
comment on column transfer_date.data_type is '������ Ÿ��( 0 : ���� ���翵��, 1 : ��ó�� ����)';
comment on column transfer_data.attributes is '�Ӽ� ����';
comment on column transfer_data.transfer_time is '���� �Ͻ�';
comment on column transfer_data.transfer_sucessyn is '������ ���� ���� ���� ( Y : ���� ����, N : ���� ���� )';


-- ���� ���翵�� ������ ����
create table individual_data(
	individual_data_id				bigint,
	transfer_data_id				bigint						not null,
	individual_data_key				varchar(128)				not null,
	file_name						varchar(100)				not null,
	file_path						varchar(256)				not null,
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone	default now(),
	
	constraint individual_dataa_pk	primary key (individual_data_id),

);

comment on table individual_data is '�������翵�� ������ ����';
comment on column individual_data.individual_data_id is '�������翵�� ����Ƽ ����������ȣ';
comment on column individual_data.transfer_data_id is '���۵� ������ ���� ������ȣ';
comment on column individual_data.individual_data_key is '�������翵�� �ĺ�Ű';
comment on column individual_data.file_name is '�������翵�� ���ϸ�';
comment on column individual_data.file_path is '�������翵�� ���ϰ��';
comment on column individual_data.update_date is '������';
comment on column individual_data.insert_date is '�����';


-- ��ó�� ���� ������ ����
create table postprocessing_data(
	postprocessing_data_id			bigint,
	postprocessing_data_key			varchar(128)				not null,
	file_name						varchar(100)				not null,
	file_path						varchar(256)				not null,
	update_date						timestamp with time zone,
	insert_date						timestamp with time zone	default now(),
	constraint postprocessing_data_pk		primary key (postprocessing_data_id)
);

comment on table individual_data is '��ó������ ������ ����';
comment on column individual_data.individual_data_id is '��ó������ ����Ƽ ����������ȣ';
comment on column individual_data.transfer_data_id is '���۵� ������ ���� ������ȣ';
comment on column individual_data.individual_data_key is '��ó������ �ĺ�Ű';
comment on column individual_data.file_name is '��ó������ ���ϸ�';
comment on column individual_data.file_path is '��ó������ ���ϰ��';
comment on column individual_data.update_date is '������';
comment on column individual_data.insert_date is '�����';
