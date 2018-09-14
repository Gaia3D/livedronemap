drop table if exists common_code cascade;

-- ���� �ڵ�
create table common_code (
	code_key					varchar(50),	
	code_type					varchar(50)							not null,
	code_name					varchar(60)							not null,
	code_name_en				varchar(60),
	code_value					varchar(256)						not null,
	use_yn						char(1)								default 'Y',
	view_order					int				default 1,
	css_class					varchar(30),
	image						varchar(256),
	description					varchar(256),
	insert_date					timestamp with time zone default now(),
	constraint common_code_pk primary key (code_key)	
);

comment on table common_code is '���� �ڵ�';
comment on column common_code.code_key is '����Ű';
comment on column common_code.code_type is '�ڵ� �з�';
comment on column common_code.code_name is '�ڵ��';
comment on column common_code.code_name_en is '���� �ڵ��';
comment on column common_code.code_value is '�ڵ尪';
comment on column common_code.use_yn is '�������, Y : ���(�⺻), N : ������';
comment on column common_code.view_order is 'ǥ�ü���. �⺻�� 1';
comment on column common_code.css_class is 'css class';
comment on column common_code.image is '�̹��� ���';
comment on column common_code.description is '����';
comment on column common_code.insert_date is '�����';
