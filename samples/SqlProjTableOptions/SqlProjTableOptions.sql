create table dbo.t1
(
         id int not null identity primary key clustered,
         name nvarchar(100) not null
);
GO
ALTER TABLE dbo.t1 SET (LOCK_ESCALATION = TABLE);
GO
create table dbo.t2
(
         id int not null identity primary key clustered,
         name nvarchar(100) not null
);
GO
ALTER TABLE dbo.t2 SET (LOCK_ESCALATION = AUTO);
GO
create table dbo.t3
(
         id int not null identity primary key clustered,
         name nvarchar(100) not null
);
GO
ALTER TABLE dbo.t3 SET (LOCK_ESCALATION = DISABLE);
GO
