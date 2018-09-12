drop table if exists dorne cascade;

-- Drone 정보
create table drone(
	drone_id					int,
	drone_name					varchar(100),					not null,
	insert_date					timestamp with time zone		default now(),
	constraint drone_id_pk 		primary key (drone_id)
);

comment on table drone is 'Drone 정보'
comment on column drone.drone_id is 'Drone 고유번호';
comment on column drone.drone_name is 'Drone 장비 명';
comment on column drone.insert_date is '등록일';
