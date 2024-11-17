alter table Users drop foreign key fk_UserRoleID;
alter table Favorites drop foreign key fk_favWebID;
alter table Favorites drop foreign key fk_favPostID;
alter table Login drop foreign key fk_LogWebID;
alter table Postings drop foreign key fk_PostWebID;
alter table ApprovePostings drop foreign key fk_ApprPostWebID;
alter table Ratings drop foreign key fk_RateWebPostID;
alter table Ratings drop foreign key fk_RatePostWebID;

DROP TABLE IF EXISTS UserRoles, Postings, Preferences, Roles, Favorites, Login, UserPreferences, Users;

create table Users(
  webID varchar(20),
  firstName varchar(50) not null,
  lastName varchar (50) not null,
  email varchar (100) not null,
  roleID int not null,
  vcode varchar(10) not null,
  primary key (webID)
)engine = innodb;

alter table Users add constraint fk_UserRoleID foreign key (roleID) references Roles(roleID) on delete cascade;

create table Postings(
  postID int auto_increment,
  title varchar(50) not null,
  description text not null,
  type varchar(50) not null,
  emphasis varchar(50) not null,
  url varchar(255),
  startDate date not null,
  webID varchar(20) not null,
  primary key (postID)
)engine = innodb;

alter table Postings add constraint fk_PostWebID foreign key (webID) references Users(webID) on delete cascade;

create table ApprovePostings(
  postID int auto_increment,
  title varchar(50) not null,
  description text not null,
  type varchar(50) not null,
  emphasis varchar(50) not null,
  url varchar(255),
  startDate date not null,
  webID varchar(20) not null,
  primary key (postID)
)engine = innodb;

alter table ApprovePostings add constraint fk_ApprPostWebID foreign key (webID) references Users(webID) on delete cascade;

create table Preferences(
  prefID int auto_increment,
  prefName varchar(50) not null,
  primary key (prefID)
)engine = innodb;

create table Types(
  typeID int auto_increment,
  typeName varchar(50) not null,
  primary key (typeID)
)engine = innodb;

create table Roles(
  roleID int,
  roleType varchar(7) not null,
  primary key (roleID)
)engine = innodb;

create table Favorites(
  webID varchar(20),
  postID int,
  primary key (webID,postID)
)engine = innodb;

create table Login(
  webID varchar(20),
  password varchar (255) not null,
  primary key (webID)
)engine = innodb;

create table Ratings(
  webID varchar(20) not null,
  postID int not null,
  rating decimal(2, 1) not null,
  primary key (webID, postID)
) engine = innodb;

alter table Favorites add constraint fk_favWebID foreign key (webID) references Users (webID) on delete cascade;
alter table Favorites add constraint fk_favPostID foreign key (postID) references Postings (postID) on delete cascade;
alter table Login add constraint fk_LogWebID foreign key (webID) references Users (webID) on delete cascade;
alter table Ratings add constraint fk_RateWebPostID foreign key (webID) references Users (webID) on delete cascade;
alter table Ratings add constraint fk_RatePostWebID foreign key (postID) references Postings (postID) on delete cascade;

insert into Preferences (prefName) values ("Data Science");
insert into Preferences (prefName) values ("Computer Security");

insert into Roles (roleID, roleType) values (1, "Student");
insert into Roles (roleID, roleType) values (2, "Alumni");
insert into Roles (roleID, roleType) values (3, "Faculty");
insert into Roles (roleID, roleType) values (4, "Admin");