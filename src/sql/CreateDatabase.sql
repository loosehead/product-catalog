drop table if EXISTS Product;
drop table if EXISTS ProductType;

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