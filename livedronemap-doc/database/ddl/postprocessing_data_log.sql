-- FK, Index�� ���� ���Ϸ� �и�.
drop table if exists postprocessing_data_log cascade;


-- ��ó�� ���� ������ �̷� ����
create table postprocessing_data_log(
	postprocessing_data_log_id					bigint,
	
	constraint postprocessing_data_log_pk	primary key (postprocessing_data_log_id)
);

comment on table postprocessing_data is '��ó�� ���� ������ ����';
comment on column postprocessing_data.postprocessing_data_id is '��ó�� ���� ������ ���� ���� ��ȣ';
