drop sequence if exists policy_seq;
drop sequence if exists file_info_seq;
drop sequence if exists upload_log_seq;

create sequence policy_seq increment 1 minvalue 1 maxvalue 999999999999 start 2 cache 1;
create sequence file_info_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence upload_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;