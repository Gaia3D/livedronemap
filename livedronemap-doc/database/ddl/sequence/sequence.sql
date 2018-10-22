drop sequence if exists access_log_seq;
drop sequence if exists api_log_seq;
drop sequence if exists client_seq;
drop sequence if exists client_group_seq;
drop sequence if exists client_group_role_seq;
drop sequence if exists drone_seq;
drop sequence if exists drone_project_seq;
drop sequence if exists health_check_log_seq;
drop sequence if exists ortho_detected_object_seq;
drop sequence if exists ortho_image_seq;
drop sequence if exists postprocessing_image_seq;
drop sequence if exists simulation_log_seq;
drop sequence if exists transfer_data_seq;
drop sequence if exists token_log_seq;
drop sequence if exists widget_seq;


create sequence access_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence api_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence client_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence client_group_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence client_group_role_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence drone_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence drone_project_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence health_check_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence ortho_detected_object_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence ortho_image_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence postprocessing_image_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence simulation_log_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;
create sequence transfer_data_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence token_log_seq increment 1 minvalue 1 maxvalue 999999999999 start 1 cache 1;
create sequence widget_seq increment 1 minvalue 1 maxvalue 999999999 start 1 cache 1;

