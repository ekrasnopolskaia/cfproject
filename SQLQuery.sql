drop table ChangeTask;
drop table TypeChange;
drop table Task;
drop table Users2;
drop table Urgency;
drop table Importance;

create table Importance(
    id int NOT NULL PRIMARY KEY,
	importance varchar(50) NOT NULL,
	);

create table Urgency(
    id int NOT NULL PRIMARY KEY,
	urgency varchar(50) NOT NULL,
	);

create table Users2(
    uuid uniqueidentifier NOT NULL PRIMARY KEY,
	firstname varchar(50) NOT NULL,
	lastname varchar(50) NOT NULL,
	user_login varchar(50) NOT NULL,
	user_password varchar(50) NOT NULL,
	CONSTRAINT AK_user_login UNIQUE(user_login)
);

create table Task(
    uuid uniqueidentifier NOT NULL PRIMARY KEY,
    cur_date datetime NOT NULL,
	short_des varchar(50) NOT NULL,
	full_des varchar(50) NOT NULL,
	users uniqueidentifier NOT NULL FOREIGN KEY REFERENCES Users2(uuid),
	importance int NOT NULL FOREIGN KEY REFERENCES Importance(id),
	urgency int NOT NULL FOREIGN KEY REFERENCES Urgency(id),
	condition bit NOT NULL,
);

create table TypeChange(
    id int NOT NULL PRIMARY KEY,
	type_change varchar(50),
);

create table ChangeTask(
    id uniqueidentifier NOT NULL PRIMARY KEY,
	cur_date datetime NOT NULL,
	actions int NOT NULL FOREIGN KEY REFERENCES TypeChange(id),
	users uniqueidentifier NOT NULL FOREIGN KEY REFERENCES Users2(uuid),
	);

insert into Importance 
values(0,'no matter'),
(1,'important');

insert into Urgency 
values(0,'Do not rush'),
(1,'urgently');

insert into Users2
values('8616DD78-57B5-406C-A695-69CBAA7171BB','Ivan', 'Ivanov', 'login', 'password'),
('423E5BB6-4BD3-420C-B3AD-F0B8A5A598E2','Petr', 'Petrov', 'login1', 'password1');

insert into Task values(NEWID(), GETDATE(),'cook dishes','cook dishes for my sisters','8616DD78-57B5-406C-A695-69CBAA7171BB',0,0,'false'),
(NEWID(), GETDATE(),'clear room','clear room for my grandmom','423E5BB6-4BD3-420C-B3AD-F0B8A5A598E2',0,1,'false');

insert into TypeChange 
values(1, 'create'),(2, 'changes importance'),(3, 'changes urgency'),(4, 'complete');

insert into ChangeTask
values(NEWID(), GETDATE(), 2, '8616DD78-57B5-406C-A695-69CBAA7171BB');

