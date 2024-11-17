alter table Favorites drop foreign key fk_favWebID;
alter table Favorites drop foreign key fk_favPostID;
alter table Login drop foreign key fk_LogWebID;
alter table UserPreferences drop foreign key fk_UserPrefWebID;
alter table UserPreferences drop foreign key fk_UserPrefPrefID;
alter table UserRoles drop foreign key fk_UserRoleWebID;
alter table UserRoles drop foreign key fk_UserRoleRoleID;

DROP TABLE IF EXISTS UserRoles, Postings, Preferences, Roles, Favorites, Login, UserPreferences, Users;

create table Users(
  WebID varchar(20),
  firstName varchar(50) not null,
  lastName varchar (50) not null,
  email varchar (100) not null,
  primary key (WebID)
)engine = innodb;

create table Postings(
  postID int auto_increment,
  decription text not null,
  type varchar(10) not null,
  emphasis varchar(50) not null,
  primary key (postID)
)engine = innodb;

create table Preferences(
  prefID INT auto_increment,
  prefName varchar(50) not null,
  primary key (prefID)
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

create table UserPreferences(
  webID varchar(20),
  prefID int,
  primary key (webID, prefID)
)engine = innodb;

create table UserRoles(
  webID varchar(20),
  roleID int,
  primary key (webID, roleID)
)engine = innodb;

alter table Favorites add constraint fk_favWebID foreign key (webID) references Users (webID);
alter table Favorites add constraint fk_favPostID foreign key (postID) references Postings (postID);
alter table Login add constraint fk_LogWebID foreign key (webID) references Users (webID);
alter table UserPreferences add constraint fk_UserPrefWebID foreign key (webID) references Users (webID);
alter table UserPreferences add constraint fk_UserPrefPrefID foreign key (prefID) references Preferences (prefID);
alter table UserRoles add constraint fk_UserRoleWebID foreign key (webID) references Users (webID);
alter table UserRoles add constraint fk_UserRoleRoleID foreign key (roleID) references Roles (roleID);