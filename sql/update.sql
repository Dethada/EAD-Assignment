update users
set lastloginip = "127.0.0.1", lastlogintime = "2018/04/27 11:06:00"
where username = "admin";

alter table users modify lastloginip varchar(15) not null,
modify lastlogintime datetime not null;