create database pudu;
CREATE USER '${jdbc.username}'@'%' IDENTIFIED BY '${jdbc.password}';
GRANT ALL PRIVILEGES ON pudu.* TO '${jdbc.username}'@'%' WITH GRANT OPTION;
flush privileges;



--ALTER TABLE Product
--drop FOREIGN KEY fk_Product_SmallImage;
--drop table if EXISTS ImageFile;
--drop table if EXISTS Category_Product;
--drop table if EXISTS Product;
--drop table if EXISTS Category;
--drop table if EXISTS UserRole;
--drop table if EXISTS User;

create table User (
	userName varchar(15) not null primary key,
	password varchar(40) not null
) ENGINE=MyISAM;

create table UserRole (
	userName varchar(15) not null REFERENCES User(userName),
	roleName varchar(15) not null,
	primary key (userName, roleName)
) ENGINE=MyISAM;

insert into User(userName, password) values ('pudu-admin', '033638b1cf3c98291d5d6d94c692a927');
insert into User(userName, password) values ('administrador', '5e4a2b7007a18714ffb8ebe682373414');
insert into UserRole(userName, roleName) values ('pudu-admin', 'admin');
insert into UserRole(userName, roleName) values ('administrador', 'admin');


CREATE TABLE Category
(
   id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   name varchar(255) NOT NULL,
   name_es varchar(255),
   name_sv varchar(255)
) ENGINE=MyISAM;
CREATE UNIQUE INDEX name ON Category(name);


CREATE TABLE Product
(
   Id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   Name varchar(255) NOT NULL,
   Name_es varchar(255),
   Name_sv varchar(255),
   Code varchar(20),
   Description varchar(1024),
   Description_es varchar(1024),
   Description_sv varchar(1024),
   smallImageId int null
) ENGINE=MyISAM;


CREATE TABLE ImageFile
(
   id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   content longblob,
   fileName varchar(255),
   type varchar(20),
   orderNumber int,
   smallImage bit default 0,
   productId int not null references Product(Id)
) ENGINE=MyISAM;
CREATE INDEX FK43140D57542F4228 ON ImageFile(productId);


ALTER TABLE Product
ADD CONSTRAINT fk_Product_SmallImage
FOREIGN KEY (smallImageId)
REFERENCES ImageFile(id);


CREATE TABLE Category_Product
(
   id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   product_id int NOT NULL references Product(Id),
   category_id int NOT NULL references Category(Id)
) ENGINE=MyISAM;

CREATE INDEX FKE9872EAE14C260D ON Category_Product(category_id);
CREATE INDEX FKE9872EAE3A065DB4 ON Category_Product(product_id);

