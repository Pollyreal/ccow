/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2015/8/12 10:37:10                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMMENTS') and o.name = 'FK_COMMENTS_REFERENCE_USER')
alter table COMMENTS
   drop constraint FK_COMMENTS_REFERENCE_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NEWS') and o.name = 'FK_NEWS_REFERENCE_NEWS_SEC')
alter table NEWS
   drop constraint FK_NEWS_REFERENCE_NEWS_SEC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NEWS') and o.name = 'FK_NEWS_REFERENCE_USER')
alter table NEWS
   drop constraint FK_NEWS_REFERENCE_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NEWS_SECTION') and o.name = 'FK_NEWS_SEC_REFERENCE_USER')
alter table NEWS_SECTION
   drop constraint FK_NEWS_SEC_REFERENCE_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMMENTS')
            and   type = 'U')
   drop table COMMENTS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NEWS')
            and   type = 'U')
   drop table NEWS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NEWS_SECTION')
            and   type = 'U')
   drop table NEWS_SECTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

/*==============================================================*/
/* Table: COMMENTS                                              */
/*==============================================================*/
create table COMMENTS (
   CommentId            int                  identity,
   AdminId              int                  null,
   NickName             varchar(50)          null,
   Comments             text                 null,
   CommentTime          datetime             null default getdate(),
   Reply                text                 null,
   ReplyTime            datetime             null default getdate(),
   ReplyStatus          int                  null default 0,
   constraint PK_COMMENTS primary key nonclustered (CommentId)
)
go

/*==============================================================*/
/* Table: NEWS                                                  */
/*==============================================================*/
create table NEWS (
   NewsId               int                  identity,
   SecId                int                  null,
   Title                varchar(255)         not null,
   PicPath              varchar(255)         null,
   Content              text                 null,
   Author               varchar(50)          null,
   AddTime              datetime             not null default getdate(),
   UpdateTime           datetime             not null default getdate(),
   VisibleStatus        bit                  not null,
   AdminId              int                  null,
   constraint PK_NEWS primary key nonclustered (NewsId)
)
go

/*==============================================================*/
/* Table: NEWS_SECTION                                          */
/*==============================================================*/
create table NEWS_SECTION (
   SecId                int                  identity,
   AdminId              int                  null,
   UpperId              int                  null,
   SecName              varchar(50)          null,
   SecOrder             int                  null,
   UpdateTime           datetime             null,
   AddTime              datetime             null,
   constraint PK_NEWS_SECTION primary key nonclustered (SecId)
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   AdminId              int                  identity,
   Admin                varchar(50)          not null,
   UserPwd              binary(20)           not null,
   RoleNo               int                  null,
   constraint PK_USER primary key nonclustered (AdminId)
)
go

alter table COMMENTS
   add constraint FK_COMMENTS_REFERENCE_USER foreign key (AdminId)
      references "USER" (AdminId)
go

alter table NEWS
   add constraint FK_NEWS_REFERENCE_NEWS_SEC foreign key (SecId)
      references NEWS_SECTION (SecId)
go

alter table NEWS
   add constraint FK_NEWS_REFERENCE_USER foreign key (AdminId)
      references "USER" (AdminId)
go

alter table NEWS_SECTION
   add constraint FK_NEWS_SEC_REFERENCE_USER foreign key (AdminId)
      references "USER" (AdminId)
go

