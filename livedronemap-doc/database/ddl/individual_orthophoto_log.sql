-- FK, Index�� ���� ���Ϸ� �и�.
drop table if exists individual_orthophoto_log cascade;

-- ���� ���翵�� ������ �̷� ����
create table individual_orthophoto_log(
	individual_orthophoto_log_id				bigint,
	drone_proejct_id					bigint				not null,
	file_name
	file_path
	attribute
	detect_ship_count
	detect_oil_count
	
	constraint individual_orthophoto_log_pk	primary key (individual_orthophoto_log_id),

);

comment on table individual_orthophoto_log is '���� ���翵�� ������ �̷� ����';
comment on column individual_orthophoto_log.individual_orthophoto_log_id is '���� ���翵�� ������ �̷� ���� ����Ű';
