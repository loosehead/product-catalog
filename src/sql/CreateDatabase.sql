drop table if EXISTS Product;
drop table if EXISTS ProductType;
drop table if EXISTS UserRole;
drop table if EXISTS User;

create table User (
	userName varchar(15) not null primary key,
	password varchar(40) not null
) ENGINE=MyISAM;

create table UserRole (
	userName varchar(15) not null REFERENCES User(userName),
	roleName varchar(15) not null,
	primary key (userName, roleName)
) ENGINE=MyISAM;

insert into User(userName, password) values ('pudu-admin', '04363da49f0de9b52cd066de920f04e8');
insert into UserRole(userName, roleName) values ('pudu-admin', 'admin');


create table ProductType (
	Id int primary key not null AUTO_INCREMENT,
	Name varchar(255) not null,
	Name_es varchar(255),
	Name_sv varchar(255)
) ENGINE=MyISAM;


create table Product (
	Id int primary key not null AUTO_INCREMENT,
	Name varchar(255) not null,
	Name_es varchar(255),
	Name_sv varchar(255),
	Code varchar(20),
	Description varchar(1024),
	Description_es varchar(1024),
	Description_sv varchar(1024),
	Image LONGBLOB,
	SmallImage Blob,
	ProductTypeId int REFERENCES ProductType(Id)
	
) ENGINE=MyISAM;