drop table if exists transfer_data cascade;

-- 전송된 데이터 
create table transfer_data(
	transfer_data_id					bigint,
	proejct_id							bigint,
	
	constraint transfer_data_id_pk		primary key (transfer_data_id),
	constraint project_id_fk 			foreign key (proejct_id)
);

comment on table transfer_data is '전송된 데이터 관리';
comment on column transfer_data.transfer_data_id is 'transfer_data 고유번호';
comment on column transfer_data.proejct_id is 'project 고유번호';
