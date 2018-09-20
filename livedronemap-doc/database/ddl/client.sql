drop table if exists client_group cascade;
drop table if exists client cascade;

-- ���� �׷�
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

comment on table client_group is '���� �׷�';
comment on column client_group.client_group_id is '������ȣ';
comment on column client_group.group_key is '��ũ Ȱ�� ���� ���� Ȯ�� �÷�';
comment on column client_group.group_name is '�׷��';
comment on column client_group.parent is '�θ� ������ȣ';
comment on column client_group.depth is '����';
comment on column client_group.view_order is '���� ����';
comment on column client_group.child_yn is '�ڽ� ��������, Y : ����, N : �������(�⺻)';
comment on column client_group.default_yn is '���� �Ұ�, Y : �⺻, N : ����';
comment on column client_group.use_yn is '�������, Y : ���, N : ������';
comment on column client_group.description is '����';
comment on column client_group.insert_date is '�����';


-- ���� �׷캰 Role
create table client_group_role (
	client_group_role_id			int,
	client_group_id					int 							not null,
	role_id							int	 							not null,
	role_key						varchar(50)						not null,
	insert_date						timestamp with time zone		default now(),
	constraint client_group_role_pk primary key (client_group_role_id)
);

comment on table client_group_role is '���� �׷캰 Role';
comment on column client_group_role.client_group_role_id is '������ȣ';
comment on column client_group_role.client_group_id is '���� �׷� ����Ű';
comment on column client_group_role.role_id is 'Role ����Ű';
comment on column client_group_role.role_key is 'Role KEY(�ӵ��� ���� �ߺ�)';
comment on column client_group_role.insert_date is '�����';


-- ����
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
	constraint client_pk primary key (client_id)	
);



comment on table client is '����';
comment on column client.client_id is '������ȣ';
comment on column client.client_group_id is '������ȣ';
comment on column client.client_name is '������';
comment on column client.client_ip is '���� IP';
comment on column client.use_yn is '�������, Y : ���, N : ������(�⺻)';
comment on column client.api_key is 'API KEY';
comment on column client.description is '����';
comment on column client.update_date is '������';
comment on column client.insert_date is '�����';
