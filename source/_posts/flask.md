---
title: flask 框架了解
tags: 笔记
categories: Python
description: flask 框架简单认识，初步使用
abbrlink: c2f9b069
date: 2019-12-07 00:00:00
updated: 2019-12-07 00:00:00
---



## Flask

初次认识

内置 session

三方组件全，

缺点：稳定性相对较差，核心要变，三方组件要更新

最简单的使用

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello World"

app.run()
```

Resopnse 三剑客：

HttpppResponse: return  “Hello World”

render:return render_template(“login.html”)

与django中的render 使用一致

redirect: return redirect (“/”)

跳转，重定向

Flask中小儿子：

1. from flask import jsonify

return jsonify()   返回 json 标准的字符串

content-type：application/json

2. return send_file()（打开并返回文件内容，自动识别文件格式）

#### flask中的request

```python
@app.route("/login", methods=["POST", "GET"])
def login():
    
    return render_template("login.html")

from flask import request
request.method # 请求方式
request.form  # 存放 FormData 中的数据
request.args  # 存放URL中的数据
request.path  # 路由地址
request.host  # 主机地址
request.host_url  # 加 http 的主机地址


先提交的是 POST，先序列化，然后GET，再序列化，
```

`.headers`  请求头信息

> Host: 127.0.0.1:5000
> Connection: keep-alive
> Cache-Control: max-age=0
> Upgrade-Insecure-Requests: 1
> User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36
> Sec-Fetch-Mode: navigate
> Sec-Fetch-User: ?1
> Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3
> Sec-Fetch-Site: none
> Accept-Encoding: gzip, deflate, br
> Accept-Language: zh-CN,zh;q=0.9
> Cookie: csrftoken=a4HVpqpS12F8eRZch58n2ToMJeCerukhbRuy20MKB3cLZTwok8gs8um9PoDkbFhI; sessionid=7ftfeserhzki55h74um33j51lo410lj0

`.`

>request.path------ /login
>request.data------ b''
>request.url------- http://127.0.0.1:5000/login
>request.values---- CombinedMultiDict([ImmutableMultiDict([]), ImmutableMultiDict([])])
>request.range----- None
>request.user_agent----- Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36
>request.args------ ImmutableMultiDict([])
>request.json------ None
>request.form------ ImmutableMultiDict([])
>request.authorization------ None
>request.access_route------- ImmutableList(['127.0.0.1'])
>request.cookies------ {'csrftoken': 'a4HVpqpS12F8eRZch58n2ToMJeCerukhbRuy20MKB3cLZTwok8gs8um9PoDkbFhI', 'sessionid': '7ftfeserhzki55h74um33j51lo410lj0'}
>request.accept_encodings------ gzip,deflate,br
>request.accept_languages------ zh-CN,zh;q=0.9
>request.accept_mimetypes------ text/html,image/webp,image/apng,application/xhtml+xml,application/signed-exchange;v=b3,application/xml;q=0.9,*/*;q=0.8
>request.content_length------ None
>request.accept_charsets----- 
>request.files----- ImmutableMultiDict([])
>request.blueprint---- None

#### Jinja2

`{{ }}` 引用变量

`{% % }` 逻辑函数