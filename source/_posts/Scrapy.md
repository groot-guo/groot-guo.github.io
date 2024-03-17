---
title: scrapy 爬虫
tags: 笔记
categories:
- IT技术
- 爬虫
- scrapy
abbrlink: 2297471041
description: scrapy 爬虫认识、使用。
date: 2019-09-20 00:00:00
updated: 2019-09-20 00:00:00
---

# Scrapy

scrapy 框架，异步爬虫框架。

### 同步与异步

同步：下一个方法依赖上一个方法，上一个没执行完，则下一个不会执行。

异步：下一个方法不依赖上一个方法，上一个没执行完，下一个依旧会执行。



组成：Pipeline  、Scheduler、Downloader、Spiders。以及Scrapy Engine 引擎（队列）

中间件：Spider Middlewares、Downloader Middlewares

Pipeline 主要用于处理IO 存储，写入本地获取的西悉尼

Scheduler 调度器，将所有的 url 发送给Downloader，并且去重网址，整合队列

Downloader  处理请求 requests，将 responses 返回给 Spiders

Spiders 是我们的爬虫文件

Scrapy Engine 引擎控制整个运转

spider middlewares 一般不用，爬虫将请求交给调度器时，进行处理。

Downloader Middlewares  加入请求头，加入代理 ip

### 初次使用 scrapy

安装 scrapy

```shell
pip install scrapy
```

创建项目

```shell
# 创建项目
>> scrapy startproject  项目名字
>> cd   项目名字
# 创建爬虫文件
>> scrapy genspider  爬虫名字  "host 地址"
# 运行爬虫文件
>> scrapy crawl  爬虫名字
```

常用配置

```python
Settings中的常用配置： 
	USER_AGENT = "" # User-Agent 
	ROBOTSTXT_OBEY = True|False # 是否遵守机器人协议 
	DEFAULT_REQUEST_HEADERS = {} # 默认Headers 
	CONCURRENT_REQUESTS = 16 # 下载器最大处理的请求数 
	DOWNLOAD_DELAY = 3 # 下载延时 
	SPIDER_MIDDLEWARES # Spider中间件 
	DOWNLOADER_MIDDLEWARES # Downloader中间件 
	ITEM_PIPELINES # 管道文件
```

创建文件

```shell
>> scrapy genspider s1 "blog.csdn.net"
```

创建好的爬虫文件

```python
import scrapy


class S1Spider(scrapy.Spider):
    # 爬虫名字
    name = 's1'
    # 如果 url 地址的 host 不属于 allowed_domains, 则过滤掉给请求
    allowed_domains = ['blog.csdn.net']
    # 项目启动时，访问的 url 地址
    start_urls = ['http://blog.csdn.net/']
	
    # 访问start_urls, 得到响应后调用的方法
    def parse(self, response):  # reponse 为响应对象
        pass

  	
```

下面方法执行相当于 start_urls ,但是可以跳过限定的请求头

```python
def start_requests(self):
    yield scrapy.Request(				 # 向调度器发送一个 Request 对象
    	url = 'http://edu.csdn.net',      # 请求地址，默认 GET 方式
        callback = self.parse2  		  # 得到响应后， 调用的函数 
    	)
 
def parse2(self, respones):				 # 得到响应后， 调用的函数
    print(response.body)				# 得到字节类型的数据
```

爬取网页时，一般默认机器人设置为 False

加入请求头

```python
# 在这个中间件中添加

class Scrapy01DownloaderMiddleware(object):
    # Not all methods need to be defined. If a method is not defined,
    # scrapy acts as if the downloader middleware does not modify the
    # passed objects.

    def process_request(self, request, spider):
        request.headers = Headers(
            {
                'User-Agent': user_agent.get_user_agent_pc()
            }
        )

        # Called for each request that goes through the downloader
        # middleware.

        # Must either:
        # - return None: continue processing this request
        # - or return a Response object
        # - or return a Request object
        # - or raise IgnoreRequest: process_exception() methods of
        #   installed downloader middleware will be called
        return None
```

开启这个中间件

```python
# settings.py 在这个中间件取消注释

DOWNLOADER_MIDDLEWARES = {
   'scrapy01.middlewares.Scrapy01DownloaderMiddleware': 543, # 数字表示优先级，越小越高 
}
```

加入代理 Ip

```python
def process_request(self, request, spider):
        request.headers = Headers(
            {
                'User-Agent': user_agent.get_user_agent_pc()
            }
        )
        request.meta['proxy'] = 'http://IP:PORT' + ur.urlopen("代理 ip 接口").read().decode('utf-8').strip()
```

为了方便我们使用，可以增加一个 start.py

```python
from scrapy import cmdline

cmdline.execute('scrapy crawl s1'.split())
```

保存文件，修改文件如下

```python
  def parse2(self, response):
        # print("--" * 30)
        # print(response.body.decode('utf-8'))
        # print("--" * 30)
        data = response.body.decode('utf-8')
        item = {}
        item['data'] = data
        yield item
```

在 setting 中

```python
# 开启管道文件，settings.py 中
ITEM_PIPELINES = {
   'scrapy01.pipelines.Scrapy01Pipeline': 300, # 数字越小优先级越高， 
   'scrapy01.pipelines.Scrapy01Pipeline': 300, # 如果再加入一个，那么会将文件交给下一个管道文件处理
}
```



### 项目说明

| 关键字           | 说明                         |
| :--------------- | :--------------------------- |
| projectcode      | 项目编号                     |
| web              | 信息来源网站（例如：必联网） |
| keyword          | 关键字                       |
| detail_url       | 招标详细页网址               |
| title            | 第三方网站发布标题           |
| toptype          | 信息类型                     |
| province         | 归属省份                     |
| product          | 产品范畴                     |
| industry         | 归属行业                     |
| tendering_manner | 招标方式                     |
| publicity_date   | 招标公示日期                 |
| expiry_date      | 招标截止日期                 |

### log日志

```python
LOG_FILE = "日志文件地址"
LOG_LEVEL = "日志级别"

# 日志级别：
	CRITICAL  严重错误 (critical)
	ERROR     一般错误(regular errors)
    WARNING   警告信息(warning messages)
    INFO      一般信息(informational messages)
    DEBUG    调式信息 (debugging messages)
```

### pymysql

```python
import pymysql
mysql_conn = pymysql.Connection(
		host='localhost',  # 主机地址
    	port=3306,         # 端口号
    	user='root',       # 登录用户
    	password="",       # 登录密码
    	database='连接数据库名字',
    	charset='utf8',    # utf-8 得编码
	)
# 创建光标对象
cs = mysql_conn.cursor()
# 定义要执行得SQL 语句
cs.execute('SQL')
mysql_conn.commit()
```

Redis的数据库结构

Redis 中有16个数据库

select [ index ] 切换数据库

| 类型                                   | 表示   |
| -------------------------------------- | ------ |
| 字符串（数字属于特殊的字符串）         | String |
| 哈希（字典）                           | Hash   |
| 列表（有序，相当于 python 中的 list ） | List   |
| 无序集合                               | Set    |
| 有序集合                               | Zset   |

键的操作：

| 操作         | 命令             |
| ------------ | ---------------- |
| 查找         | keys [ pattern ] |
| 删除         | del [ key ]      |
| 检查是否存在 | exists [ key ]   |
| 查看键的类型 | type [ key ]     |

### scrapy-redis 原理



将调度器和

```python
# 启动Scrapy-Redis去重过滤器，取消Scrapy的去重功能 
DUPEFILTER_CLASS = "scrapy_redis.dupefilter.RFPDupeFilter" 
# 启用Scrapy-Redis的调度器，取消Scrapy的调度器 
SCHEDULER = "scrapy_redis.scheduler.Scheduler" 
# Scrapy-Redis断点续爬 
SCHEDULER_PERSIST = True 
# 配置Redis数据库的连接 
REDIS_URL = 'redis://127.0.0.1:6379'

```

