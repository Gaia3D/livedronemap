drop table if exists token_log cascade;


-- token 발행 이력
create table token_log (
	token_log_id 					bigint,
	client_id 						int							not null,
	user_id 						varchar(30), 
	token							varchar(256),
	token_status 					char(1) 					default '0',
	token_duration 					int 						default 240,
	year							char(4)						default to_char(now(), 'YYYY'),
	month							varchar(2)					default to_char(now(), 'MM'),
	day								varchar(2)					default to_char(now(), 'DD'),
	year_week						varchar(2)					default to_char(now(), 'WW'),
	week							varchar(2)					default to_char(now(), 'W'),
	hour							varchar(2)					default to_char(now(), 'HH24'),
	minute							varchar(2)					default to_char(now(), 'MI'),
	update_date 					timestamp with time zone,
	insert_date						timestamp with time zone	default now(),
  	constraint token_log_pk primary key (token_log_id)
);


comment on table token_log is 'token 로그';
comment on column token_log.token_log_id is '고유키';
comment on column token_log.client_id is 'client 고유키';
comment on column token_log.user_id is '사용자 아이디';
comment on column token_log.token is '토큰';
comment on column token_log.token_status is '토큰 상태. 0 : 사용중, 1 : 시간만료';
comment on column token_log.token_duration is '토큰 지속 시간. 240분 (기본값)';
comment on column token_log.year is '년';
comment on column token_log.month is '월';
comment on column token_log.day is '일';
comment on column token_log.year_week is '일년중 몇주';
comment on column token_log.week is '이번달 몇주';
comment on column token_log.hour is '시간';
comment on column token_log.minute is '분';
comment on column token_log.update_date is '수정일';
comment on column token_log.insert_date is '등록일';