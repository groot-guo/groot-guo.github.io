---
title: mysql 简单入门
tags: 笔记
categories:
- IT技术
- 数据库
- Mysql
abbrlink: 1397632726
description: 认识mysql，部署、安装、熟悉sql 语法
date: 2019-10-17 00:00:00
---

# MySql

## 第一章mysql 入门

MySQL是基于 c/s 架构的软件

#### 添加环境变量到path

```shell
cmd 初始化
mysqld --initialize-insecure
net start mysql  # 开启服务端
net stop mysql	# 移除服务端
mysql --install	# 安装服务  压缩包安装
mysql --remove	# 移除服务
```

#### 进程

```shell
tasklist |findstr msyql  # 查进程
taskkill /F /PID 进程号	#杀进程
```

#### 忘记密码

```shell
# 1.先关闭服务
# 2.跳过授权表开启服务
mysqld --skip-grant-tables   # 开启服务端的约束条件
mysql -uroot -p   #客户端连接
update mysql.user set authentication_string =password('') where User ='root';  #更改密码
flush privileges;  # 刷新权限
```

win10 中跳过授权表可以放在文件中更改 MySQL 中 my.ini 文件，无创建 

#### 统一字符编码

```ini
[mysqld]
# 设置 MySQL 的安装目录 **后面的路径一定是安装 sql 的目录（自己的）
basedir=C:\Program Files\MySQL\MySQL Server 5.7
# 设置 MySQL 数据库的数据的存放目录，必是data
datadir=C:\Program Files\MySQL\MySQL Server 5.7\data
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
# 忘记密码添加  skip-grant-tables 改完就删了
# mysql端口
port=3306
# 字符集
[mysqld]
character-set-server=utf8
collation-server=utf8_general_ci
[client]
default-character-set=utf8
[mysql]
default-character-set=utf8
```

修改字符集也可以使用

```mysql
# 查看所有字符集格式
SHOW VARIABLES LIKE 'char%';
# 修改某个为utf8
SET character_set_client = utf8 ;
```



#### 进入 MySQL

```mysql
mysql -uroot -p
\s; # 查看 MySQL 软件配置
show databases; # 查看所有的数据库
```

##### 创建 MySQL 用户

```mysql
use mysql
# 查看所有用户信息
select * from user
# 进入MySQL数据库下
create user 'mjj@'192.168.1.1' identified by '123'';
# 创建之后要进行刷新
flush privileges;
# 删除用户
drop user 'ggy'@'localhost';
# 修改用户
rename user 'ggy'@'localhoet' to 'ggy'@'localhost';
# 修改密码
set password for 'ggy'@'localhost'=Password('123');
```

可以修改为 192.168.1.% 表示本网用户

##### 授权 

@后面加的主机地址，需要设置

```mysql
# 查看权限
show grants for '用户'@'IP地址';
# 授权 mjj 用户对。。文件操作
grant select ,insert,update on db1.t1 to "mjj"@'%';
# 授权所有权限
# 对文件db1.t1有任意操作
grant all privileges on db1.t1 to "mjj"@'%';
# 对db1数据库中的文件任意操作
grant all privileges on db1.* to "mjj"@'%';
# 对数据库所有文件任意操作
grant all privileges on *.* to "mjj"@'%';

# 取消权限
revoke all privileges on *.* to "mjj"@'%';
```

登录

```shell
mysql -umjj - h 192.168.1.1 -P 3306 -p123
```

## 第二章MySQL命令

SQL命令

SQL语言主要用于存储数据、查询数据、更行数据和管理数据库系统、分为三种：

- DDL 语句 数据库定义语言：数据库、表、视图、索引、
- DML 语句 数据库操作语言：插入删除修改查看
- DCL 语句 数据库控制语言：

```mysql
select user();
# 查看所有数据库;
show databases;
# 创建数据库
create database db1;# 后面可加 charset="utf8" 或gbk
alter database db1 charset="gbk";
create table t1(id int, name char(10))engine=innodb;
# sql 语言是强类型 定义什么就必须加什么名称 
# engine=innodb 存储引擎
insert into t1(id,name) values(1,'alex'),(2,'ss');
```

#### 数据库操作

```mysql
# 查看数据库
show databases;
# 查看当前库
show create database db1;
# 查看所在的库
select database();
# 选择数据库
use 数据库名;
# 删除数据库
DROP DATABASE 数据库名;
# 修改数据库
alter database db1 charset utf8;
```

#### 表的操作

```mysql
			show create table t1;
# 查看所有的表
show tables; 
# 查看表的详细结构
desc t1; 
# 增加表
create table t1(id int,name char(10));	
# 修改表的结构
alter table t1 modify name char(6);
# name变大写的
alter table t1 change name NAME char(7);
# 删除表
drop table t1;
```

#### 数据操作

```mysql
# 插入数据
insert into t1(id,name) values(1,'ss'),(2,'222');
insert into t1 value(3,'sss');
# 更新数据
update db1.t1 set name='ssss';
update db1.t1 set name='sel' where id=2;
# 删除数据
delete from t1;
delete from t1 where id=2;
# 查找数据
select id from t1;
select id,name from t1;
select * from t1;
select * from db1.t1 where id=2;
# 复制表 复制表结构和记录
create table b1 from select * from db1.t1;
# 只要结构
create table b1 from select * from db1.t1 where 1>2;
create table b2 like db2.t1;
```

#### 存储引擎

mysql 5.5版本之后默认为innodb存储引擎
另外还有mysiam、memory、blackhone
#memory，在重启mysql或者重启机器后，表内数据清空
#blackhole，往表内插入任何数据，都相当于丢入黑洞，表内永远不存记录

## 第三章数据类型

#### 整型

tinyint[数字] [**unsigned无符号]** 小整数  -128··127  布尔值可以用  tinyint(1)表示True 0表示False

int 后面的类型是显示宽度，不够补0，其他都是存储宽度，zerofill 用0 填充

#### 浮点型

FLOAT

DOUBLE ,精度比 float 高

decimal 更精准的小数

#### 日期

YEAR
	YYYY
DATE
	YYYY-MM-DD
TIME
	HH：MM：SS
DATETIME  用的最多

#### 字符

char  类型：定长，简单粗暴，浪费空间，存取快

varchar 类型：变长，存储速度慢，节省空间

#### 其他

enum 枚举 表示多选一

set 集合 表示多选一，或者多选多

#### 总结

小结：	
数据类型：
		整型：tinyint int bigint
		浮点型： float double decimal
		时间：year date time datetime
		字符：char 定长 > varchar 变长 > text 文本
		枚举：enum
		集合：set
		布尔：boolean  tinyint(1) 存1 表示true,存0 表示false
		函数： now() 根据字段的数据类型获取当前的时间格式
					char_length: 获取字符长度
					 length():获取字节数
		sql中默认是有符号的
		如果设置无符号unsigned
		用0填充 zefofill   
		对字段进行  约束

#### 约束

保证数据的完整性和一致性

表的设计
	1.not null 与 default

​				not null  不为空，default 默认值

create table tb1(id int not null default 2,name char(20) not null);
```mysql
create table tb1(id int not null default 2,name char(20) not null);
insert into tb1  values(1,'alex');
insert into tb1(name) values('武sir');
insert into tb1(id) values(3);
```
​	2.unique 		

​			单列唯一的，不重复的，重复的数据不能插入

```mysql
create table dep(id int not null,name varchar(20) unique);
insert into dep(id,name) values(1,'alex');
insert into dep(id,name) values(2,'alex');
```

​					多列唯一  表示每列都唯一	

```mysql
create table dep2(id int unique,name varchar(20) unique);
insert into dep2(id,name) values(1,'alex');
```

​					组合唯一  

```mysql
create table dep3(
	id int,
	name varchar(20),
	unique(id,name)		
);
insert into dep3(id,name) values(1,'alex');
insert into dep3(id,name) values(1,'alex2');
insert into dep3(id,name) values(2,'alex');
```

​	3.primary key （索引优化查询）

​			主键 = not null + unique

​			sql 版本中，一张表只允许有一个主键，通常是id，cid，nid，sid

```mysql
create table stu(
	id int primary key auto_increment,
	name varchar(10) unique
);
insert into stu(name) values ('alex');
	
化学反应： not null + unique
	create table stu2(
	id int not null unique auto_increment,
	name varchar(10) unique
);			
```
​			primary key  (索引优化)

​	4.auto_increment

truncate table t1; 数据量大，删除速度比上一条快，直接从零开始。

外键 foreign key 

被关联表   主表 先创建

关联表 从表 后创建，因为先创外键无法匹配

```mysql
constraint fk_dep forirgin key(dep_id) references dep(id)
# 设置外键dep_id 关联 dep（id）
on delete cascade # 同步删除
on update cascade # 同步更新
```

### 第三章表和表的关系

分析步骤：

先左表：
		1.先从左表的多条记录可以对应右表的一条记录，如果是，则证明左表的一个字段foreign key；右表一个字段（通常是 id）

​		2.再右表的多条记录可以对应左表的一条记录，如果是，则证明右表的一个字段foreign key；左表一个自字段（通常是id）

#### 3.1多对一

只有步骤 1 或者步骤 2 成立

的关系，凡是多的都是外键。

#### 3.2多对多

同时成立

#### 3.3一对一

步骤 1 和 2 都不成立

### 第四章表的查询

#### 4.1单表查询

​			一、单表查询的语法
​			SELECT 字段1,字段2... FROM 表名
​                  WHERE 条件
​                  GROUP BY field
​                  HAVING 筛选
​                  ORDER BY field
​                  LIMIT 限制条数
​			二、关键字的执行优先级（重点）

重点中的重点：关键字的执行优先级
	from
	where
	group by
	having 以前的版本不可以单独使用，现在可以
	select
	distinct
	order by（asc升序，desc降序）
	limit
		1.找到表:from
		2.拿着where指定的约束条件，去文件/表中取出一条条记录
		3.将取出的一条条记录进行分组group by，如果没有group by，则整体作为一组
		4.将分组的结果进行having过滤
		5.执行select
		6.去重
		7.将结果按条件排序：order by
		8.限制结果的显示条数

在my.ini 配置中设置ONLY_FULL_GROUP_BY 

分组之后 要想查询组内的信息，必须使用聚合函数，不能在 where 中使用必须分组

min()		求最小

max()		求最大

avg()		求平均

sum() 		求和	

count（）求总个数

#### 4.2多表查询

##### 4.2.1多表连接查询

外连接操作

```sql
SELECT 字段列表
	FROM 表1 INNER|LEFT|RIGHT JOIN 表2
	ON 表1.字段 = 表2.字段
```

​		内连接：符合条件查询

​		左连接：有限显示左表记录

​		右连接：优先显示右边记录

​		全外连接：显示左右两个表全部记录

##### 4.2.2符合条件连接查询



##### 4.2.3子查询

子查询是将一个查询语句嵌套在另一个查询语句中

一个查询语句查询的结果作为另一个查询语句的条件



 级联删方式

