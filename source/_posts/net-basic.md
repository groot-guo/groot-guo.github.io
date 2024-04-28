---
title: 爬虫
tags: 笔记
description: 爬虫的安装与流程
abbrlink: 7ade1d5c
date: 2020-03-15 00:00:00
updated: 2020-03-15 00:00:00
---

# 网络编程

### BS架构

浏览器   

​		browser ---> server

### CS架构

客户端

​		client   ----> server

### TCP（Transmission Control Protocol）

可靠的、面向连接的协议（eg:打电话）、传输效率低全双工通信（发送缓存&接收缓存）、面向字节流。使用TCP的应用：Web浏览器；电子邮件、文件传输程序。

### UDP（User Datagram Protocol）

不可靠的、无连接的服务，传输效率高（发送前时延小），一对一、一对多、多对一、多对多、面向报文，尽最大努力服务，无拥塞控制。使用UDP的应用：域名系统 (DNS)；视频流；IP语音(VoIP)。

### 初识socket（基于socket实现网络通信）

创建服务器

```python
import socket

# 创建socket对象
server = socket.socket()

# 绑定Ip和端口
server.bind(('127.0.0.1', 3000))

# 后边可以等5个人
server.listen(5)

# 等待客户端来连接
conn, addr = server.accept()
print(conn, addr)

# 通过对象去获取（通过伞给我发送信息）
# 1024表示：服务端通过（伞）获取数据时，一次性最多拿1024字节。
data = conn.recv(1024)
print(data)

# 服务端通过链接对象（伞）给客户端回复一个消息
conn.send(b'stop')

# 与客户端端口开链接（放开那把伞）
conn.close()

# 关闭服务端的服务
server.close()
```

创建客户端

```python
import socket

client = socket.socket()

# 客户向服务端发请求（递伞）
# 阻塞，去连接，直到连接成功
client.connect(('127.0.0.1', 3000))

# 连接上服务端后，向服务端发送消息
client.send(b'hello')

# 等待服务端给他发送消息
data = client.recv(1024)
print(data)

# 关闭自己
client.close()
```

注意：

​	py3，send / recv 都是字节，unicode，为了压缩数据

​	py2 , send /recv 都是字符串

windows中会话间关闭客户端，服务端会报错，而mac会返回空

### 黏包现象

客户端发送请求，服务端返回的数据超过固定读取的字节数，

黏包：两次 sand 连在一起发送

方式一：分为两次发送

### 模拟SSH

```python
import subprocess

# 可以输入终端指令，进行验证
res = subprocess.Popen('dir', shell=True,
                       stderr=subprocess.PIPE, stdout=subprocess.PIPE)
# 由于时在windows中 cmd 是 gbk，
print(res.stdout.read().decode('gbk'))
```

# 并发和并行

并发，伪，由于执行速度特别快，人感觉不到停顿

并行，真，创建10个人同时操作

python多线程情况下：

- 计算密集型操作：效率低。（GIL锁）
- IO操作：效率高

python多进程的情况下：

- 计算密集型操作：效率高（浪费资源）
- IO操作：效率高（浪费资源）

IO密集型多线程：文件/输入输出/socket网络通信

计算密集型用多进程：

## GIL锁

全局解释器锁。用于限制一个进程中同一时刻只有一个线程被cpu调度。

扩展：默认GIL锁在执行100个cpu指令.

主线程会默认等子线程



