drop table if exists menu cascade;

-- 메뉴
create table menu(
	menu_id				int,
	menu_type			char(1),
	name				varchar(100)							not null,
	name_en				varchar(30)								not null,
	lang				varchar(10)								default 'ko',
	parent				int										default '1',
	depth				int										default '1',
	view_order			int										default '1',
	url					varchar(256)							not null,
	url_alias			varchar(256),
	image				varchar(256),
	image_alt			varchar(100),
	css_class			varchar(30),
	default_yn			char(1)									default 'N',
	use_yn				char(1)									default 'Y',
	display_yn			char(1)									default 'Y',
	description			varchar(256),
	insert_date			timestamp with time zone				default now(),
	constraint menu_pk 	primary key (menu_id)	
);


comment on table menu is '메뉴';
comment on column menu.menu_id is '고유번호';
comment on column menu.menu_type is '메뉴 타입, 0 : 관리자 사이트, 1 : 사용자 사이트';
comment on column menu.name is '메뉴명';
comment on column menu.name_en is '영어 메뉴명';
comment on column menu.lang is '언어';
comment on column menu.parent is '부모 고유번호';
comment on column menu.depth is '깊이';
comment on column menu.view_order is '나열 순서';
comment on column menu.url is 'URL';
comment on column menu.url_alias is 'URL Alias';
comment on column menu.image is '이미지';
comment on column menu.image_alt is '이미지 Alt';
comment on column menu.css_class is 'css class명';
comment on column menu.default_yn is '기본 표시 메뉴, Y : 기본, N : 선택';
comment on column menu.use_yn is '사용유무, Y : 사용, N : 사용안함';
comment on column menu.display_yn is '화면표시 여부, Y : 표시, N : 비표시';
comment on column menu.description is '설명';
comment on column menu.insert_date is '등록일';
