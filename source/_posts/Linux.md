---
title: linux 基本认识
tags: 笔记
categories:Linux
abbrlink: 127135607
description: 初步了解 linux，学习常用操作命令和网络传输过程
date: 2019-11-22 00:00:00
updated: 2019-11-22 00:00:00
---

# Linux

redhat 发行版，收费版的Linux

SUSE Linux 德国版，常用于移动电信支付领域



### 桥接网路模式

### NAT 网络模式

就是在你宿主机的ip网络中，通过网络地址  转换你你你技术（NAT），

解决问题：

1. ip 地址不够用
2. 解决ip可能冲突的问题

为什么使用nat地址转换：

获取ip地址



上述没有进行配置

```shell
# 默认没有启动网卡，启动网卡
ifup   ens33
ifdown # 关闭网卡
管理员
systemctl 
```

管理网络服务的一个脚本文件

```shell
/etc/init.d/network   start/stop/restart  对网络进行启停/重启
```

Linux基本命令

文本是白色得， 文件夹市蓝色的

用 Tab 建补全命令，补全文件

对文件夹得增删改查：

增

```shell
mkdir     hello  #  建文件夹 
touch  文件名  # 创建文件
```

删

```shell
rm test.txt  # 删除文本
rm -i text.txt  # 删除文件要提醒
rm -i  sss* # 以sss开头的文件
rmdir  # 删除目录，只能删除空文件夹
rm -r hello14 # 
rm -rf /* # 删除所有文件（文件夹）,记得快照
```

改

```shell
passwd root(用户名) 
mv  旧文件名 新文件名 # 该文件名
mv  test  hello3/   # 移动文件
cp ss.txt  ss.txt.back    # 复制命令
cp -r test test2 # 拷贝文件夹，递归复制
```

查

查看当前位置：

```shell
pwd 
```

当前目录得内容

```shell
ls 
ls  操作对象
ls /root
ls -l  /root  # 显示 root 文件夹下得详细信息
ls      -la  # 显示所有文件（包括隐藏得）
ls      -la  /root  # 显示 root 文件夹下的
cd 切换目录 只能进入文件夹
cd  . 代表当前目录
cd  .. 切换上一级目录
man rm # 命令操作手册,查看命令详细用法

cat 文件 小
cat first.py -n 显示行号
cat >> kun.txt <<EOF
# 写入文件
more  查看大文件
```

vi 编辑器使用：

```shell
vi first.py  # 打开文件
i 是 insert 插入的意思
o 是在光标所在行的下一行写入信息
输入 i 之后进入编辑模式
按 esc ，退出编辑模式，回到命令
输入 ：wq！ 退出且写入文本信息
:  是进入底线命令模式的参数
w  是写入的意思
q  是退出的含义
！  强制性的含义

vim 中
set nu # 显示行号
yy # 光标所在的复制这一行
dd # 光标所在删除这一行
5yy 复制5行
5dd 删除5行
```

### 远程登录命令

```shell
ssh root@ip
w # 查看连接本机器的用户
```

修改网络配置文件

```shell
cd /etc/sysconfig/network-scripts
```

更改主机名字

```shell
hostnamectl set-hostname  linux学习
退出会话
logout
```

xshell 快捷命令

```python
clear   # ctrl + l 清屏
ctrl + d # 等同于logout
ctrl + shift + r # 快速登录

```

linux 的绝对路径

Linux的PATH路径

```shell
echo $PATH # 查看linux Path 变量
只能添加目录，不饿能定位到文件
软连接和path添加二选一即可
```

Linux的文件系统

```shell
[root@linux ~]# 
[用户名@主机名 当前工作目录]
$PS1="[\u@\h \w \t]\$"
PS1="[\u@\h \w \t]\$"

useradd ggy2 # 新建用户
passwd ggy2 # 密码

userdel 删除用户
userdel -rf 强制删除 f删除目录

sudo 以 root 的方式执行命令
设置 vi etc/sudoers 可以执行的用户
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
可以执行 sudo 命令的用户，
visudo 提供文件检测



su -  xiaobai 切换小白用户

echo "ss"  > # 重定向写入
echo "ss"  >> # 重定向追加写入

在liunx 中的文件第一行输入#coding：utf8

tar压缩解压命令
-c 压缩参数
-x 解压参数
-v 显示过程
-f 指定文件 这个写到最后
tar -cf 文件名

gzip 压缩当前目录所有文件

两个压缩格式，就要解压到两次
tar -xf  allrepo.tar  -C  /opt/  指定解压得目录

关闭 iptables
sysyemctl         stop      firewalld
系统服务管理命令   停止指令   服务名
```

### Linux 查找命令

```shell
find / -name 
find / -type -name
f 是文件
d 是目录
```

linux 查看进程

```shell
ps -ef # 查看所有
ps -ef | grep ss # 查看 ss 程序 过滤
管道命令 再次处理 grep
cat setting.py | grep  "STA*" 
grep -v # 反向选择
grep "STA*" settings.py -n # 显示行号

tail -f # 实时监控的命令
tail -f /tmp/文件名称  可以查看
```

### alias 别名命令

```shell
alias rm="rm -i" # 设置rm命令
unalias rm # 取消命令

which rm 查看rm命令在哪
whois python2 查看python2 在哪
who 查看当前登录用户
woami 当前用户是谁
```

scp远程传输命令

```shell
传输自己的文件
scp 自己的文件  root@ip:/opt/
传输远程服务器的文件，到自己本地
scp root@ip:/文件  /opt/文件
```

查看文件大小

```shell
du -f
du -h # 统计每个文件运行大小
du -sh 
```

top 

```shell
top # 查看当前进程，服务器具体信息
```

chattr 

```shell
chattr +a 文件名  # 枷锁
chattr -a 文件名  # 减锁
```

linux 查看时间

```shell
date # 查看当前时间
ntpdate -u ntp.aliyun.com

```

爬虫命令

```shell
wget 地址http://pythonav.cn/av/girltwo.jpg
```

linux 和 windows 传输文件

通过  lrzsz 工具包

```shell
yum install lrzsz -y
lrzsz 上传下载的小工具
```



### 开关机命令

```shell
reboot # 命令用于重启机器
poweroff # 用于关闭系统
```

权限

```shell
ll # 查看文件权限
rw-r--r--
rw- 文件所属主的权限
r-- 这文件所属组的权限
r-- 其他人权限

chmod 0+r quanxian/ 修改权限
chmod u+ file 或者可以
chmod 777 file

r  可读，用 cat 查看
w  可以编辑或者删除
x  可以执行
```

文件夹的可读可写

```shell
r  可读
w  可以创建文件
x  可以进入目录
rwx 对应 4+2+1 
```





软连接配置（快捷方式）

```shell
ln 命令
ln -s 目标文件绝对地址  快捷方式的绝对路径
ln -s /opt/cs.txt   /home/cs.txt
```

### 网络端口命令

```shell
ps -ef | grep 查看任务是否运行有进程
netstat -tunlp | grep 查看任务的端口是否启动
安装 yum install net-tools -y
yum install nginx -y
yum install redis-server

ps 命令查看
ps -ef 查看进程

kill 命令 后面加进程号
kill -9 （危险命令），强制杀死

selinux 内置的防火墙
iptables -F 清空规则
iptables -L 查看规则
停止防火墙服务
sysytemctl /start/ restart/stop  firewalld

防火墙地址
vi /etc/selinux/config

```



### Linux字符编码

```shell
# 查看字符编码
echo $LANG
# 检查 xshell crt 得字符集
# 命令修改字符集
export LANG=en_US.utf8
1.修改配置文件 /etc/locale.conf
LANG="zh_CN.UTF-8"
1.2 读取这个文件，使变量生效
source 读取命令
2.更改玩查看系统语言变量
locale
```

df 分配磁盘空间

```shell
df 查看分配磁盘空间
df -h 查看根目录总容量
```

tree以树的形式显示信息

```shell
yum install tree
# 没有安装
```

### DNS服务

先解析 hosts 

再解析 resolv.conf

bind 软件，域名解析

常见的DNS

```
8.8.8.8 谷歌的
114.114.114.114 114dns
223.5.5.5
223.6.6.6 阿里巴巴的dns服务器
119.29.29.29  腾讯的
可在 /etc/resolv.conf 配置
```

hosts 强制解析的域名文件

```shell
/etc/hosts

nslookup 查看域名解析
```

### 定时任务

```shell
crontab -l 查看定时任务
crontab -e 编辑任务
etc 目录下
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed

crontab的语法
分   时   日   月   周  命令要用绝对路径写
*    *    *    *    *   每一个分钟做这个事情
3,15 *    *    *    *   命令
30   21   *    *    *   命令
30   1    *    *   6，0 命令
0    1    *    *   1-5  命令
```

### 软件包管理

格式分为三种：

1. 源码包格式

   1. 下载 python3 的源码包
   2. 解压源码包，切换目录
   3. 编译且安装
   4. 配置环境变量
   5. 使用python

2. rpm二进制包格式 （这种安装方式需要手动解决依赖关系）

   1. 下载软件的 rmp 格式包
   2. rmp -ivh lrzsz.rmp
   3. 使用 lrzsz

3. yum安装格式

   自动下载，解决依赖关系，自动处理其他依赖关系

   yum源的仓库路劲再 /etc/yum.repos.d/

   然后这个目录底下，只有 以 .repo结尾的文件，才被识别成 yum 仓库

配置国内的 yum 源

1. 在 /etc/yum.repos.d/ 目录底下，定制我们自己的 repo 仓库文件
2. 阿里的 yumhttps://opsx.alibaba.com/mirror

```shell
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
下载这个 yum 源 并改名为 Base源
```

3. 清楚 yum 缓存

   ```shell
   yum clean all
   ```

4. 生成新的阿里云的yum软件缓存

   ```shell
   yum makecache
   ```

再配置 epel 额外的仓库源，这个仓库就存放很多的第三方仓库，如 nginx， redis ，mysql

```
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
```

最好在生成 yum 缓存

#### yum 使用示例

```shell
yum install nginx -y   -y一路默认yes
```

执行：`lsof -i:80` 查看此时哪个进程正在使用80端口 

yum 不可以多个人使用，会被进程锁定

### 安装python3

编译安装

1. 下载源码

   ```shell
   wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
   安装之前确保依赖工具包得安装
   yum install gcc patch libffi-devel python-devel  zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel -y
   ```

2. 解压源码

   ```shell
   tar -xvf Python-3.7.4.tgz
   ```

3. 安装源码

   ```shell
   congfigure 一般用来生成 Makefile，为下一步得编译做准备 
   ./configure  --prefix=/user
   设置该软件 安装路径 为 /user
   
   make # 执行 这个 前会指定需要得工具
   
   make install 进行安装，生成应用程序
   
   配置软连接（注意，这个和PATH配置，二选一）
   ln -s 目标文件 软连接文件
   ln -s /opt/python36/bin/python3.6  /usr/bin/python3
   此时没有 pip
   ln -s /opt/python36/bin/pip3  /usr/bin/pip3
   
   注意这里path的配置，需要将物理解释器的python，放在path最前面
   配置 PATH
   echo PATH
   /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
   pwd
   /opt/python37/bin
   赋值，这个只能临时生效，需要写入文件永久生效
   PATH=/opt/python37/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
   
   Linux 有一个全局个人配置文件
   vim /etc/profile 
   在最底下写入这个 PATH
   然后读取这个文件
   source /etc/profile
   
   ```

### 虚拟环境

virtualenv 就是一个虚拟解释器

就是基于物理环境下的python解释器，虚拟/分身  出的 多个解释器， 独立的

安装

```shell
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple virtualenv
上述地址 安装快一些
多了一个命令
```

开始使用

```shell
virtualenv  --no-site-packages --python=python3  venv1/ 创建虚拟环境的名字
--not-site-packages  构建隔离干净的虚拟环境
--python=python3 指定虚拟环境以哪个python解释器运行

source activate 激活命令
修改 PATH 变量，path是又执行顺序的
which python3
查看虚拟环境是否正常
deactivate  关闭命令

```

### Vim

```shell
w(e) 移动光标到下一个单词
b    移动光标上一个单词

数字0  移动到本行开头
$  移动光标到本行结尾
H  移动光标到屏幕首行
M  移动光标到屏幕的中间一行
L  移动光标到屏幕的尾行
gg 移动光标到文档的首行
G  移动光标到文档尾行

ctrl + f 下一页
ctrl + b 上一页
`.  移动光标到上一次的修改行
```

查找

```shell
/chaoge  在整篇文档中搜索chaoge字符串，向下查找
?chaoge  在整篇文档中搜索chaoge字符串，向上查找

*  查找整个文档，匹配光标所在的所有单词，按下 n 查找下一处，N上一处
#  查找整个文档，匹配光标所在的所有单词，按下 n 查找下一处，N上一处

gd  查找光标所在单词匹配的单词，并停留在注释的第一个匹配上

%  找到括号的另一半!!!
```

底线命令

```shell
:q        强制退出
:wq       强制写入退出
:set nu   显示行号
:数字     调到数字那行
```





确保开发环境的一致性

```shell
保证本地环境和开发环境的一致性
pip3 freeze > requirements.txt
到出当前python环境的包，创建这个配置文件
pip3 list 查看当前已安装的包
pip3 install -r requirements.txt  创建 virtualenv，在venv中导入下项目所需的模块依赖
```

### 虚拟环境管理工具

virtualenvwrapper

安装这个命令，必须得在物理解释器得下，注意退虚拟环境

```shell
pip3 install virtualenvwrapper
```

设置一个环境变量，每次启动加载这个

```shell
vim ~/.bashrc   #vim编辑用户家目录下的.bashrc文件，这个文件是用户在登录的时候，就读取这个文件
	
#export 是读取shell命令的作用
#这些变量根据你自己的绝对路径环境修改
export WORKON_HOME=~/Envs   #设置virtualenv的统一管理目录
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'   #添加virtualenvwrapper的参数，生成干净隔绝的环境
export VIRTUALENVWRAPPER_PYTHON=/opt/python37/bin/python3     #指定python解释器
source /opt/python37/bin/virtualenvwrapper.sh #执行virtualenvwrapper安装脚本 
```

使用过程

```shell
重新登录
mkvirtualenv  虚拟环境名字  # 自动创建，且激活虚拟环境
可以继续创建
workon  可以停止你当前的环境，任意切换
workon  django22 切换到这个虚拟环境

deactivate 停止虚拟环境
rmvirtualenv django22 退出当前虚拟环境

lsvirtualenv  列举所有的环境
cdvirtualenv  导航到当前机会的虚拟环境
cdvirtualenv  直接进入到 site-packages 目录中
lssitepackages  显示 site-packages 目录中的内容
```

## mariadb

就是MySQL的分支

安装MariaDB

yum 安装可能会低，所以源码安装可控

编译安装的软件，支持第三方功能扩展 ./configure  这里可以加上很多参数，定制功能

yum仓库的区别

1. 阿里云的yum仓库
2. 假设msyql官网，也会提供rmp包

配置MariaDB 的官方yum源，用于自动下载MariaDB的下载

注意点：阿里云提供的 yum仓库 ，和 epel 源仓库，也有但是很低

尽量选择官网的

```shell
touch /etc/yum.repos.d/mariadb.repo 
然后写入如下内容
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1


下载安装
yum install MariaDB-server MariaDB-client

如果下载太慢，可以删除这个镜像源，
rm -rf /etc/yum.repos.d/Mariadb.repo
然后清空 yum 缓存
yum clean all

阿里云下载 (阿里云的Mariadb包名是小写的,官方是大写的)
yum install mariadb-server  mariadb -y

yum remove tomcat 卸载
```

启动操作

```shell
systemctl start/stop/restart/status  mariadb
开机启动
systemctl enable mariadb
```

mysql初始化

```shell
mysql_secure_installation  这条命令可以初始化mysql
```





设置mysql 的中文编码支持，修改 /etc/my.cnf

配置文件的格式

```shell
*.conf
*.cnf
*.ini
*.yml
vim  /etc.my.cnf 修改成如下
在[msyqld]中加入
[mysqld]
character-set-server=utf8
collation-server=utf8_general_ci
重启服务，读取配置

```



接下来就是MySQL常用命令操作

```shell
grant all privileges on *.* to root@'%' identified by 'password';
记得要刷新权限
flush privileges;

命令备份数据库数据
linux 命令
mysqldump -u root -p --all-databases > /data/Allmysql.dump
登录mysql 导入数据
source /data/Allmysql.dump
通过命令导入数据
mysql -uroot -p < /data/Allmysql.dump  # 
```

主从复制



主从复制是通过 binlog 日志复制到需要同步的从服务器上。

MySQL数据库支持单向，双向，链式级联等不同场景复制，一个充当Master服务器，

而一个或多个充当服务器 slave ，接受master文件的内容。

主从复制的逻辑有一下几种：

- 一主一从，单向主从同步模式，只能在Master端写入数据
- 一主多从

MySQL的主从复制架构

准备主库的配置文件

```shell
修改配置文件
vim /etc/my.cnf
修改内容
[mysqld]
server-id=1            标注 主库的id 
log-bin=mysql-bin      那个binlog的文件名

重启mariadb ，修改前先确保服务停掉
systemctl start mariadb
或者
systemctl restart mariadb

创建用于主从数据同步的账户
create user 'ggy'@'%' identified by '123';

授予主从同步账号的，复制数据的权限
grant replication slave on *.* to 'ggy'@'%';

进行数据库的锁表，不能写入数据
flush table with read lock;

数据导出，
mysqldump -u root -p --all-databases > /opt/zhucong.dump

然后将主库的数据，发送给从库
scp /opt/zhucong.dump  root@从库:/opt

此时去从库的MySQL上，登录，导入主库的数据，保持数据一致性
mysql -uroot -p
source /opt/zhucong.dump 

配置从库


解锁表
unlock tables;
```

配置从库

```shell
slave从库配置
my.cnf写入
[mysqld]
server-id=3 主要区分开

重启数据库
systemctl restart mariadb

检查一下主库和从库的信息
show variables like 'server_id';
show variables like 'log_bin';

通过一条命令，开启主从同步
change master to master_host='192.168.147.11',
master_user='ggy',
master_password='123',
master_log_file='mysql-bin.000001',
master_log_pos=316;

启动从库开关
start slave;

查看复制状态
show slave status\G;
```





## Redis



redis 最多可以提供 10 万次/秒的读写

单线程数据

安装redis

```shell
源码安装
wget http://download.redis.io/releases/redis-4.0.10.tar.gz
解压
tar -zxf redis-4.0.10.tar.gz
进入redis 目录
make && make install 直接进行编译且安装
可以指定配置文件启动redis
在解压的文件中找redis.conf中设置如下图
redis-server redis.conf
指名文件启动
下图中 no 改为 yes 后台运行

yum install redis -y
redis 的配置文件
vim /etc/redis.conf

启动服务
systemctl start redis

进入redis
redis-cli


过滤出文件的空白行和注释行
grep -v "^#"  redis.conf |   grep  -v "^$"

```



安全模式



设置远程访问

````shell
配置文件中
bin 0.0.0.0 既可以本地访问，也可以远程访问

更改redis的默认端口
port 6380

使用redis的密码进行登录
requirepass 登录redis的密码

指定配置文件启动
redis-server redis.conf

同新的端口和密码登录redis
redis-cli -p 6380

登录后
 auth 密码
 
redis 还支持交互式的参数
redis-cli -p 6380 -a 123
````

redis持久化和发布订阅

发布订阅

```shell
发布者
publish    频道    消息   给频道发消息
订阅者
SUBSCRIBE   频道     订阅频道
PSUBSCRIBE  频道*    支持模糊匹配的订阅
频道
channel   频道名 自定义


```

RDB（持久化）

跟快照相似，服务器进程退出，数控就会丢失。将数据保存到磁盘中叫RDB，类似快照，手动执行，和定期执行。

```shell
创建配置文件
在 redis-4.0.10 文件夹 中
touch ss1-redis.conf
vim ss1-redis.conf

在 redis.conf 写入
port 6379                          # 端口
daemonize yes					 # 后台运行
logfile /data/6379/redis.log	  # log日志
dir /data/6379					# 数据存放文件路径
dbfilename my.rdbc				# 生成的数据文件

通过save触发持久化
save  900   1                     # rdb 机制 每900秒  有 1 个修改记录
save  300   10                    # 每 300 秒         10个修改记录
save  60    10000                   # 每 60 秒内       10000 修改记录


```

AOF持久化

记录所有服务器执行的变更操作命令，并在服务器启动时，通过重新执行这些命令来还原数据集

把命令追加到文件末尾，全部以 redis 协议的格式保存

优点： 最大程序保证数据不丢失

缺点： 日志记录非常大

```shell
redis-client  写入数据  >  redis-server  同步命令  >  AOF文件

在 redis.conf 写入
port 6379                          # 端口
daemonize yes					 # 后台运行
logfile /data/6379/redis.log	  # log日志
dir /data/6379					# 数据存放文件路径
appendonly yes					
appendfsync     everysec  每秒做一次持久化
			   always    总时修改类的操作
			   no        依赖于系统自带的缓存大小机制
			   

```

RDB切换到AOF备份

```shell
准备rdb的redis服务吨
redis-server  my-redis.conf  （注明着是rdb持久化）

redis-cli  登录 redis，通过命令激活持久化
# 到RDB模式下，备份文件，防止意外
redis 命令模式下输入：
CONFIG  set appendonly yes   # 用命令激活持久化（临时生效，注意写入到配置文件）
CONFIG SET save ""    # 关闭 rdb 持久化

将 AOF 操作，写入到配置文件，永久生效，下次重启后生效
appendonly yes					
appendfsync     everysec  
再通过 redis-server  my-redis.conf   启动AOF持久化

3.测试aof数据持久化 ,杀掉redis，重新启动
kill 
redis-server s15-redis.conf 

4.写入数据，检查aof文件

```

主从同步

一主两从

```shell
环境：
准备两个或两个以上 redis 实列

mkdir -p /data/{6380,6381}
mkdir  /data/638{0..2}    # 创建6380，6381，6382文件夹

配置文件实列：
port 6379
daemonize yes
pidfile /data/6379/redis.pid
loglevel notice
logfile "/data/6379/redis.log"
dbfilename dump.rdb
dir /data/6379
protected-mode no


sed "s/6379/6380/g" redis-6379.conf   # 前面被替换的内容，中间更换的内容，g全局
# 这个只能看替换结果
sed "s/6379/6380/g" redis-6379.conf  > redis-6380.conf

FLUSHDB   #  清空数据

pkill redis-server   # 清空所有的 redis-server，根据服务名杀死所有有关的服务

docker run -d -p 9999:9999\
 --link mymysql\
 --name flarum1\
 -e FORUM_URL='http://0.0.0.0:9999'\
 -e DB_PASS='root@123456'\
 -e FLARUM_ADMIN_USER='admin'\
 -e FLARUM_ADMIN_PASS='root@123456'\
 -e FLARUM_ADMIN_MAIL='admin@zzzmh.cn'\
 mondedie/docker-flarum:0.1.0-beta.10-stable

配置主从复制
在 redis-6380.conf 中以及  redis-6381.conf
slaveof  127.0.0.1  6379  # 指名主库的身份地址 ip 和端口
[root@linux redis-4.0.10]# echo  "slaveof 127.0.0.1 6379"  >> redis-6380.conf
[root@linux redis-4.0.10]# echo  "slaveof 127.0.0.1 6379"  >> redis-6381.conf
重启服务器一定要

查看一下配置信息
redis-cli -p 6379 info 数据库的信息
redis-cli -p 6380 info Replication  查看 6380
redis-cli -p 6381 info Replication  查看 6381主从信息
```







实现 Redis 主从复制



redis 主从复制，故障手动切换

1. 杀死 6379 的实列

   ```sehll
   kill 主库
   ```

2. 手动切换主从身份

   ```shell
   登录redis-6380，通过命令，去掉自己的主库身份，等待连接
   	slaveof no one
   登录 redis-6381 ，通过命令，生成新的主任
   	slaveof  127.0.0.1 6380
   ```

   



redis 哨兵

保护redis主从集群，正常运转，当主库挂掉之后，自动的在主库中挑选新的主库，进行同步



```shell
安装配置
准备三个redis 配置实列
如上述一样

准备三个哨兵的配置文件
touch redis-sentinel-26379.conf
touch redis-sentinel-26380.conf
touch redis-sentinel-26381.conf

写入配置文件
port 26379  
dir /var/redis/data/
logfile "26379.log"

sentinel monitor s15master 127.0.0.1 6379 2

sentinel down-after-milliseconds s15master 30000

sentinel parallel-syncs s15master 1

sentinel failover-timeout s15master 180000

daemonize yes

三个哨兵都那口不一样，所以可以使用上面的快速生成

[root@linux redis-4.0.10]# sed -i "s/26379/26381/g"  redis-sentinel-26381.conf

如果更改文件 master名
[root@linux redis-4.0.10]# sed -i "s/s15master/ggymaster/" redis-sentinel-26381.conf
加上 -i 是插入到文件中

创建文件
mkdir -p  /var/redis/data

启动哨兵
[root@linux redis-4.0.10]# redis-sentinel redis-sentinel-26379.conf
[root@linux redis-4.0.10]# redis-sentinel redis-sentinel-26380.conf
[root@linux redis-4.0.10]# redis-sentinel redis-sentinel-26381.conf
哨兵将自己发现的主从信息写入到文件中

```



查看哨兵信息是否正常

```shell
[root@linux redis-4.0.10]# redis-cli -p 26379 info sentinel
或者输入 info截至，查看最后一条
```







测试哨兵的作用

```shell
kill -9 主的端口
查看剩余的配置信息
```







##### 哨兵集群（redis0-cluster集群方案，官方）

并发的问题

可以达到10万次秒

那100 万怎么办

分布式

redis-cluster安装配置

准备6个redis 数据库实列，准备6个配置文件redis-{7000….7005}

```shell
touch redis-7000.conf {7000....7005}

配置文件详情
port 7000
daemonize yes
dir "/opt/redis/data"
logfile  "7000.log"
dbfilename "dump-7000.rdb"
cluster-enabled yes  # 开启集群模式
cluster-config-file  nodes-7000.conf  # 集群内部的配置文件
每个集群的 端口不同

启动6个配置文件
redis-server redis-7000.conf

```

配置 ruby 语言环境，脚本一键启动 redis-cluster

```shell
下载源码
 wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz
 
 安装ruby
 tar -xvf ruby-2.3.1.tar.gz
 ./configure --prefix=/opt/ruby/  告诉安装路径，还要执行下一步
 make && make install
 
 安装下载操作 redis 的模块包
 wget http://rubygems.org/downloads/redis-3.3.0.gem
 
 通过 ruby 的包管理工具 安装redis包
 可以不用配置
[root@linux opt]# /opt/ruby/bin/gem install -l redis-3.3.0.gem
会生成redis-trib.rb 这个命令

 
 准备一个ruby命令
 准备一个gem软件包管理命令
 # 拷贝 ruby 命令到 path下 /usr/local/ruby 配置环境变量
 cp /opt/ruby/bin/ruby     /usr/local       #  这些命令中间有空格
 cp bin/gem                /usr/local/bin
 
 
 gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
https://gems.ruby-china.org/ added to sources
https://rubygems.org/ removed from sources


```

```shell
配置环境变量
vim /etc/profile
写入最低行
PATH=$PATH:/opt/ruby/bin/
读取文件
source /etc/profile

一键创建集群
/opt/redis-4.0.10/src/redis-trib.rb
redis-trib.rb   create --replicas 1 127.0.0.1:7000  127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
# 自动分配主从关系  注意有个 1
分配主从关系， 以及 槽位分配 slot 槽位

检查节点的主从状态
redis-cli -p 7001 info replication

向redis写入数据  查看数据流向
redis-cli -p 7000 -c  集群模式




```





如果没有出现重定向，就是没有进入集群，进入后直接清空keys，再创建

codis（集群方案）

redis哨兵博客地址：
https://www.cnblogs.com/pyyu/p/9718679.html
redis-cluster博客
https://www.cnblogs.com/pyyu/p/9844093.html
docker博客：
https://www.cnblogs.com/pyyu/p/9485268.html

## Nginx

web 服务器软件

win 
    IIS

linux
     nginx      
     apache   收费
     lighthttp  

公司技术栈

收费版

apache web服务器 + java +tomact 应用服务器 + oracle + memcached + redhat 企业办linux + svn（代码管理工具）

开源的技术栈

nginx + python  + uwsgi  （python的应用服务器，启动了10个进程处理django drf 请求） + mysql（rds）+ vue

```shell
curl -I pythonav.cn 对此域名发送请求只显示响应头
响应结果
HTTP/1.1 301 Moved Permanently
Server: nginx/1.12.2
Date: Sun, 25 Aug 2019 07:32:25 GMT
Content-Type: text/html
Content-Length: 185
Connection: keep-alive
Location: https://pythonav.cn/
这个可以修改
```

web服务器：接受HTTP请求并返回数据

web框架：开发web应用，处理接收到的数据

Nginx 开源支持高并发，高性能的www服务和代理服务软件

面试：

支持高并发，能支持几万并发连接

资源消耗少，3万并发连接开启10个nginx线程消耗的内存不到200M

可以做http反向代理和负载均衡

支持异步网络 I/O 事件模型 epoll

开始nginx

```shell
解决编译 nginx 所需的依赖包，不会报错
yum install gcc patch libffi-devel python-devel  zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel openssl openssl-devel -y

到 /opt 目录下，下载源码包
wget -c https://nginx.org/download/nginx-1.12.0.tar.gz

定义指定安装目录nginx112/
./configure --prefix=/opt/nginx112/

安装
make && make install

查看nginx 的工作目录
[root@linux nginx112]# ls
conf     配置文件目录 主要 nginx.conf
html  	网页根目录，通过域名访问 如 index.html\erro.html
logs    日志  如error.log、access.log
sbin    存放nginx课执行命令 sbin/nginx

开启前查看防火墙是否开启
getenforce

cat /proc/cpuinfo 查看cpu 信息
top 按1可以看到
```

nginx主配置文件学习

```shell
worker_processes  1; nginx 工作进程数，根据cpu核数定义
events {
    worker_connections  1024; # 事件连接数
}
# http区域块，定义nginx的核心web功能
http {
    include （关键字）      mime.types（可修改的值）;
    default_type  application/octet-stream;
    #定义日志格式
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';
    # 开启访问日志功能的参数
    #access_log  logs/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    #keepalive_timeout  0;
    # 保持长连接
    keepalive_timeout  65;
    # 支持图片 gif等等压缩。减少网络宽带
    #gzip  on;
    # 这个server标签，控制着nginx的虚拟主机
    server {
    	# 定义端口访问
        listen       80;
        # 域名
        server_name  localhost;
        # 定义编码
        #charset koi8-r;
        # 跟上类似
        #access_log  logs/host.access.log  main;
        # 定义网页的默认访问url
        location / {
        	# 加一个参数可以拒绝当前用户访问
        	deny 192.168.147.1;
            # root 参数定义网页根目录
            root   html;
            # 定义默认访问的网页首页文件
            index  index.html index.htm;
        }
        # 定义404 错误页面，也可以服务器的错误
        #error_page  404              /404.html;
        
        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}
        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}
        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }
    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;
    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}
    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;
    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;
    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;
    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;
    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}
}
```



无法访问nginx 时修改如下配置文件

```shell
直接编辑/etc/sysconfig/iptables文件
               1.编辑/etc/sysconfig/iptables文件：vi /etc/sysconfig/iptables
                   加入内容并保存：-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
               2.重启服务：/etc/init.d/iptables restart
               3.查看端口是否开放：/sbin/iptables -L -n
```

nginx 虚拟主机，多个服务器

```shell
创建多个server标签
#server {

    #    listen       443 ssl;
    #    server_name  localhost;
    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;
    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;
    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;
    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}
}

[root@linux conf]# vim nginx.conf
# 修改文件
[root@linux conf]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
# 进行语法测试
```

如果需要测试本机访问域名解析，再本机 hosts文件修改

```shell
192.168.147.1  www.ssss.com
```

nginx 的访问日志

```shell
将上面的日志注释去掉
杀死当前进程
重新启动服务

cd /opt/nginx112/logs/
查看日志文件所在位置
tail -f access.log
查看日志更新，实时监控，可以知道访问来源

拒绝用户访问，可以看上面
  location / {
        	# 加一个参数可以拒绝当前用户访问
        	deny 192.168.147.1;
        	# 这个换支持拒绝一整个网站， 点零，加上子网掩码地址
            # root 参数定义网页根目录
            root   html;
            # 定义默认访问的网页首页文件
            index  index.html index.htm;
        }
        
ab 网络压力测试工具

```

nginx反向代理

正向代理，一堆用户通过代理访问一个服务器

反向代理，一堆用户通过代理访问多个服务器

```shell
准备2 个服务器，2个nginx
192.168.147.11  web服务
192.168.147.12  反向代理

需要在反向代理添加配置
proxy_pass 192.168.13.79;
```



集群就是一堆服务器做一件事，一个节点就是一个服务器

为什么要有集群，因为大型的必须多个完成，单独完成不了。

价格有效性

可伸缩性

高可用性

透明性

##### 负载均衡

分担压力，分别可以向多个服务器发起请求



```shell
准备三台计算机
nginx1 作为nginx，负载均衡器
nginx2  web服务，提供一个页面
nginx3  web服务，提供一个页面

配置两台nginx的服务器内容
负载均衡器设置，在配置文件 nginx.conf中
upstream mywebserver {
# ip_hash;
	server 192.168.147.13:80  # weight=1;
	server 192.168.147.14:80;
}
mywebserver 是负载均衡池的名字


```



nginx负载均衡调度算法

```shell
调度算法               概述
轮询                   按照时间顺序追忆分配到不同的后端服务器（默认）
weight                 加权轮询， weight值越大，分配到的访问几率越高
ip_hash                每个请求按访问IP的hash结果分配，这样来自同一IP的固定访问一个后端服务器
url_hash               安装访问URL的hash结果来分配请求，是每个URL定向到同一个后端服务器
least_conn             最少链接数，那个机器链接数少就分发

1. 轮询   默认
2. weight  权重优先级
3. ip_hash 根据客户端ip哈希分配，不能和weight一起使用

```

### 项目发布

python

uwsgi        wsgi  （web服务网关接口，就是一个实现了python  web的协议） 

wsgi  是基于python web服务的

wsgiref

​		python自带的web服务器

Guunicorn

​	linux 的python wsgi http服务器，常用于django ，flask结合部署

mode_wsgi

​	实现了apache 于wsgi应用程序的结合

uwsgi

​	c语言开发，快速，自我修复，开发人员友好的wsgi服务器，常用于python web部署







virtualenvwrapper

路飞的代码

vue 的代码

nginx   （一个是nginx对静态文件处理的优秀性能，一个是nginx的反向代理功能，以及nginx默认80都端口，访问80端口能反向代理到应用的8000端口）



mysql

redis

supervisor    进程管理工具

部署环境准备python3

wget

##### Docker容器

是对linux容器的一种封装，提供简单易用的容易使用接口。

将应用程序与程序的依赖打包，打包在一个文件里面，运行这个文件就会生成一个虚拟容器

容器与环境不一样。

应用场景，web应用的自动化打包，自动化测和持续集成、发布，在服务型环境中部署和调整数据库或其他应用

opnstack 云虚拟化技术

docker 启动秒级，使用一般为mb，性能接近原生，单机支持上千个容器

容器三大概念

镜像  image

容器  container

仓库  repository

docker生命周期三个概念

#### 安装Docker

编译安装



yum安装

```shell
yum install docker 官方源或者epel源
yum install docker* docker
```

rpm 安装

先卸载旧版本

```shell
sudo yum remove docker \
				docker-client \
				docker-client-latest \
				docker-common \
				docker-latest-logrotate \
				docker-logrotate \
				docker-selinux \
				docker-engine-selinux \
				docker-engine 

设置存储库
sudo yum install -y yum-utils \
		device-mapper-persistent-data \
		lvm2
sudo yum-config-manager \
	--add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo

安装 docker 社区版
sudo yum install docker-ce
ee 企业版

启动关闭docker
systemctl start docker
systemctl status docker
systemctl stop docker

```

docker 加速

网址https://www.daocloud.io/mirror

```shell
curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
```

```shell
exit # 退出当前容器
```



基本命令：

增

```shell
docker run centos
docker run -it centos
docker run -d centos /bin/sh -c "while true;do echo hello centos; sleep 1;done"
-d # 参数是 后台运行
/bin/sh 调用shell解释器
-c 指名一段shell语法
docker run -it --rm ubuntu  # 运行一个乌班图容器，并且退出时，删除记录

docker pull centos  # 下周centos镜像
```

删

```shell
docker rm 容器id  # 删除这条容器记录
docker rmi 镜像id  # 删除一个镜像记录
docker rm `docker ps -aq`  # 反引号取命令的运行结果
# 一次性删除所有容器id记录
docker rmi `docker images -aq`  # 一次性删除所有镜像记录
```

改

```shell
docker commit  # 提供容器记录，为新的镜像
docker stop 容器id   # 停止当前容器
docker start 容器id  # 启动已停止的容器

docker save centos > /opt/centos.tar.gz  # 到处 docker 镜像至本地

docker load  < /opt/centos.tar.gz  # 导入镜像

docker run --name s14heh -d centos /bin/sh -c "while true;do echo hello s14 docker ~~~; sleep 1; done"
# 通过 --name 参数给容器记录，加上别名

docker exec -it 容器id  /bin/bash # 进入正在运行的容器
-it  # 交互式的操作终端
/bin/bash # 使用 shell 解释器，只有 redhat，centos才能用 /bin/bash


# 按需要定制自己的镜像文件
# 1.先进入容器，然后安装 vim
# 2.提交新的镜像文件
docker commit 容器id  /opt/centos-vim

# 3. 查看新的镜像记录
docker images
# 4.通过新的镜像运行这个容器，
docker run -it /opt/centos-vim  /bin/bash

```

查

```shell
docker image ls # 查看镜像记录
docker images # 查看镜像记录

docker ps  # 查看容器记录，只能查看到正在后台运行的容器

docker ps -a # 查看容器记录，包括已运行过的
docker ps -aq
q # 显示容器id

dcoker logs -f 容器id # 查看容器日志

docker container ls -a # 等同于docker ps -a

docker search 镜像名  # docker 仓库，dockerhub
dcoker version # 查看版本
```

其他

```shell
# 1.下载镜像
docker pull traning/webapp
# 2.dockerrun -d -P 6fa python app.py
-d # 后台运行
-P # 将容器内的5000端口随机映射到宿主机的一个端口

docker port 容器id  
# 查看当前容器的访问端口（外部访问到容器内的端口）

docker run -d centos -P
-d # 后台运行
-P # 随机端口映射
-p # 9000（宿主机）:5000（容器内）
--name # 给创建的容器记录
```

利用docker 自己定制镜像。

脚本示例

```shell

#脚本的概念就是，将你想做的事，写入到一个文件中，然后执行这个文件，就是执行一个脚本



#假如我想定制一个自己的 docker镜像 
#首先得有一个基础操作系统镜像
#FROM centos  #基于这个centos的镜像，然后定制我自己的镜像
#底下通过docker提供的指令，添加，自定制自己的规则，然后创建自己的镜像文件
#FROM centos  #基于这个centos的镜像，然后定制我自己的镜像
#RUN yum install vim -y 
#RUN yum install nginx -y  


#仅仅只有这3句的dockerfile，就能定制一个拥有nginx和vim的centos镜像文件

#此时我构建出的这个centos-vim-nginx镜像文件，就可以传给14期的所有同学用


#咱们14期的同学，就可以 docker load 或者docker pull 这个镜像，docker run centos-vim-nginx

docker run -d -p 8888:8888\
 --link mysql\
 --name flarum\
 -e FORUM_URL='http://localhost:8888'\
 -e DB_PASS='root@1234'\
 -e FLARUM_ADMIN_USER='admin'\
 -e FLARUM_ADMIN_PASS='root@1234'\
 -e FLARUM_ADMIN_MAIL='admin@zzzmh.cn'\
 mondedie/docker-flarum:0.1.0-beta.10-stable


FROM scratch #制作base image 基础镜像，尽量使用官方的image作为base image


FROM centos #使用base image

FROM ubuntu:14.04 #带有tag的base image


#相当于代码注释，告诉别人，你的镜像文件的信息是什么
LABEL version=“1.0” #容器元信息，帮助信息，Metadata，类似于代码注释
#定义一个dockerfile的作者信息
LABEL maintainer="wupeiqidsb"


#开始定制自己的镜像需求
#对于复杂的RUN命令，避免无用的分层，多条命令用反斜线换行，合成一条命令！
RUN yum update && yum install -y vim \
    Python-dev #反斜线换行
#RUN指令，相当于在centos中执行了一堆命令
RUN hostnamectl set-hostname mydocker
RUN yum install redis -y 
	
#写上3条就会执行者3条


WORKDIR /root 					#相当于linux的cd命令，改变目录，尽量使用绝对路径！！！不要用RUN cd
WORKDIR /test						 #如果没有就自动创建
WORKDIR demo						 #再进入demo文件夹
WORKDIR s14
WORKDIR /opt 

RUN pwd      /opt 


#ADD和COPY
#宿主机linux有自己的磁盘，文件夹
#容器空间 也有自己的文件夹

#我们使用docker一定是想将宿主机的文件，添加到容器中

#ADD就是添加宿主机的文件，到容器当中
#ADD还有一个解压缩的功能

# /opt 
ADD and COPY 
#把宿主机的hello文件，放入到容器的 / 根目录下
# 这个hello文件的相对路径，是以Dockerfile文件所在目录为相对路径

ADD hello /  #把本地文件添加到镜像中，吧本地的hello可执行文件拷贝到镜像的/目录

#把与dockerfile同级的一个test.tar.gz压缩文件，拷贝添加到容器的 根 / 目录中，并且解压缩
#  远程传输 并且  tar -zxvf  
ADD test.tar.gz /  #添加到根目录并解压  
 

WORKDIR /root  #切换工作目录到 /root 

#把dockerfile同级的那个hello文件 拷贝到容器的/root/test/hello 

ADD hello test/ #进入/root/ 添加hello可执行命令到test目录下，也就是/root/test/hello 一个绝对路径

COPY hello test/  #等同于上述ADD效果



ADD与COPY
    -ADD除了COPY功能还有解压功能
	
添加远程文件/目录使用curl或wget



ENV #环境变量，尽可能使用ENV增加可维护性
ENV MYSQL_VERSION 5.6 #设置一个mysql常量
RUN yum install -y mysql-server=“${MYSQL_VERSION}” 


RUN ./cofigure  --prefix=/opt/
RUN  make&& make install 


```



dockerfile实验

```shell
#1.准备一个flask代码，准备python代码
	from flask import Flask
	app=Flask(__name__)
	@app.route('/')
	def hello():
		return "hello docker,i am  sbwueiqi, i am in s14 "
	if __name__=="__main__":
		app.run(host='0.0.0.0',port=8080)
		
#2.准备Dockerfile，准备好所有需要的文件
[root@node1 /data/mydocker 10:33:53]#ls
CentOS-Base.repo  Dockerfile  epel.repo  myflask.p

```

```dockerfile
cat Dockerfile
	FROM centos        
	LABEL maintainer="Chao Yu<yc_uuu@163.com>"
	ADD CentOS-Base.repo /etc/yum.repos.d/
	ADD epel.repo /etc/yum.repos.d/
	RUN yum clean all
	RUN yum install python-pip -y
	RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple flask
	COPY myflask.py /app/
	WORKDIR /app
	EXPOSE 8080
	CMD ["python","myflask.py"]
	1.引入一个centos镜像，为基础镜像
	2.作者注释信息
	3.添加本地的两个yum文件，到容器的/etc/yum.repos.d/底下
	4.清空yum缓存
	5.yum安装pip工具
	6.pip安装flask模块，指定清华源
	7.拷贝本地的flask代码，到容器的/app/目录下
	8.切换工作目录，到/app底下
	9.暴露容器的8080端口，然后在运行镜像时候，加上-p参数，指定端口映射
	10.执行命令，运行flask
```

#### 构建私有仓库

```shell
1.下载docker官方提供的私有仓库镜像
	docker pull  registry
	2.查看镜像
	docker images 
	3.启动一个私有仓库容器
		docker run -d \
			-p 5000:5000 \
			-v /opt/data/registry:/var/lib/registry \
			registry
	4.此时可以检查容器进程
	docker ps 
	5.此时私有仓库就打开了5000端口，通过端口映射，访问宿主机的5000端口，查看是否通信
	yum install telnet -y 
	
	telnet 127.0.0.1 5000   #检测5000端口是否通信
	
	6.修改本地镜像的tag标签，标注我要往哪push镜像
	docker tag docker.io/hello-world  192.168.12.96:5000/s14-hello
	
	7.修改docker配置，允许非安全的传输方式
	
		1.vim /etc/docker/daemon.json，写入信息，私有仓库地址，都得改成自己的
			{"registry-mirrors": ["http://95822026.m.daocloud.io"],
			"insecure-registries":["192.168.12.96:5000"]
			}
		2.修改docker.server 
			vim /lib/systemd/system/docker.service
			#写入如下信息，请在[service]中写入		
			[Service]
			EnvironmentFile=/etc/docker/daemon.json
		
		
		
```

