create database course_center
create table student(stid int primary key ,fn varchar , sn varchar , age int , street varchar , city varchar)
create table stud_phone (phone int ,id int foreign key references student (stid))
create table courses (c_name varchar primary key , salary int , hall varchar )
create table staff(stfid int primary key, stf_fn varchar , stf_sn varchar)
create table staff_phone(stf_phone int , stf_id int foreign key references staff (stfid))
create table takes (stid int foreign key references student (stid), c_name varchar foreign key references courses(c_name),number_of_courses int, hours int )
create table give (stfid int foreign key  references staff (stfid ), c_name varchar foreign key  references courses (c_name), number_of_courses int , hours int )