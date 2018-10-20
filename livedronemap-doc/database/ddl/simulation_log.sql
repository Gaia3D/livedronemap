DROP TABLE IF EXISTS simulation_log cascade;

CREATE TABLE simulation_log (
	simulation_log_id					bigint,
	simulation_type						char(1),
	client_id							int,
	client_name							varchar(30),
	status								char(1)				default '2',
	message								varchar(256),
	start_date							timestamp 			with time zone,
	complete_date						timestamp 			with time zone,
	insert_date							timestamp 			with time zone			default now(),
	constraint simulation_log_id_pk 	primary key (simulation_log_id)	
);	

comment on table simulation_log is '시뮬레이션 테스트 이력';
comment on column simulation_log.simulation_log_id is '고유키';
comment on column simulation_log.simulation_type is '시뮬레이션 종류, 0: 전체, 1: 클라이언트(시립대), 2: 가이아쓰리디';
comment on column simulation_log.client_id is 'client 고유키';
comment on column simulation_log.client_name is 'client명(중복)';
comment on column simulation_log.status is '시뮬레이션 상태. 0 : 성공, 1 : 실패, 2 : 진행중';
comment on column simulation_log.message is '상세 메세지';
comment on column simulation_log.start_date is '시뮬레이션 시작일';
comment on column simulation_log.complete_date is '시뮬레이션 완료일';
comment on column simulation_log.insert_date is '등록일';