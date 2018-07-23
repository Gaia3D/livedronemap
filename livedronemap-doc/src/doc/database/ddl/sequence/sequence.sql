
drop sequence if exists file_info_seq;

create sequence file_info_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
