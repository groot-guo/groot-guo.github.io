---
title: Django 框架了解
tags: 笔记
categories: Python
description: Django 框架初步使用，简单流程记录
date: 2019-11-16 00:00:00
updated: 2019-11-16 00:00:00
---

# Django

项目与应用的关系

```shell
django-admin startproject 项目名称
```

创建应用

python manage.py startapp 视图函数

启动项目

python manage.py runserver IP:PORT

(默认本机端口8080)

### url控制器（路由）

1. 简单分组
2. 有名分组
3. 分发
4. 反向解析

### 视图函数

request（请求对象）

response（响应对象）

redict

### 模板语法

渲染变量  `{{}}` locals（）能全部传进去

- 深度查询：句点符
- filter ： 过滤器

渲染标签  `{%%}`

- for

  `{% for i in book %} `

- if 

### csrf标签

需要在 form 表单中添加 `{% csrf_token %}`



### 模板继承

extand

## ORM

建立在pymysql之上，避免书写sql语句

更加高效的使用

在设置中修改引擎即可，无需重新写

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'bms',
        'USER': 'ggy',
        'PASSWORD': '123',
        'HOST': '127.0.0.1',
        'PORT': 3306,
    }
}
```

### 数据库迁移

python manage.py makemigrations 

python manage.py migrate

### 操作数据的方式

#### 单表操作

##### 单表查询

1. all（） 方法：返回QuerySet类型
2. filter（）方法：返回QuerySet类型，要输入创建的配配置
3. get（）方法：返回 model对象
4. first（）last（）方法：QuerySet调用 ，返回model对象
5. exclude（）方法：返回QuerySet类型
6. order_by（）方法：排序，QuerySet调用，返回QuerySet类型
7. count（）方法：数数，QuerySet调用
8. reverse（）方法：QuerySet调用，返回也是QuerySet类型
9. exists（）：QuerySet调用，返回也是布尔类型
10. values（）：由queryset对象调用,返回值是queryset
11. values_list：由queryset对象调用,返回值是queryset

##### 模糊查询

双下划线

```python
Book.objects.filter(price__in=[100,200,300])
#查价格等于100，200，300
Book.objects.filter(price__gt=100)
#查询价格大于100
Book.objects.filter(price__lt=100)
#查询价格小于100
Book.objects.filter(price__range=[100,200])
#查询价格在100-200
Book.objects.filter(title__contains="python")
# 查询是python的书籍
Book.objects.filter(title__icontains="python")
# 查询包含python的书籍
Book.objects.filter(title__startswith="py")
# 查询以 py 开头
Book.objects.filter(pub_date__year=2012)
# 查询以2012年开头

setting.py
USE_TZ = True #时间模块
```

##### 单表添加

```python
# 方式一
Book(titile)
boo.save
# 方式二
book.objects.create()
#注意create 方法返回当前生成表的记录对象
```

##### 单表删除

```python
book.objects.delete()
```

##### 单表修改

```python
book.objects.update
```

#### 多表操作

##### 添加

一对多

```python
 #pub_obj=Publish.objects.filter(name="橙子出版社").first()

    # book=Book.objects.create(
    #     title="python",
    #     price=120,
    #     pub_date="2012-12-12",
    #     publish_id=1,
    #     #publish=pub_obj
    #
    # )
```

多对多

```python
   # 方式1
    # alex=Author.objects.filter(name="alex").first()
    # egon=Author.objects.filter(name="egon").first()
    # book.authors.add(alex,egon)
    # 方式2：
    # book.authors.add(1,2)
    # 方式3：
    # book.authors.add(*[1,2])

```

一对一

如同

##### 修改

```python
 ###### 解除再绑定
    book = Book.objects.filter(nid=3).first()
    book.authors.clear()
    book.authors.add(1)

    book.authors.set(1)
```

##### 基于对象的跨表查询

一对多

```python
####### 一对多 ##########
    '''
    正向查询：关联属性所在的表查询关联表记录
    反向查询

        ----正向查询按字段：book.publish
    Book------------------------------------>Publish
         <-----------------------------------
          反向查询表名小写_set.all()：pub_obj.book_set.all()

    '''
```

多对多

```python
####### 多对多 ##########
    '''
                正向查询按字段 book.authors.all()
       Book  -------------------------------------->Author
             <--------------------------------------
                反向查询按表名小写_set.all()： alex.book_set.all()
    '''
```

一对一

```python
####### 一对一 ##########
    '''
                     正常查询安字段：alex.ad
        Author -----------------------------------------> AuthorDetail
               <------------------------------------------
                     反向查询按表名小写  ad.author
    '''
```

##### 基于双下划线的跨表查询（基于join实现的）

```python
# KEY：正向查询按字段，反向查询按表明小写
# 手机号以110开头的作者出版过的所有书籍名称以及出版社名称
# 方式1:
#ret=Author.objects.filter(ad__tel__startswith=110).values_list("book__title","book__publish__name")
# print(ret)

# 方式2：
#ret=AuthorDetail.objects.filter(tel__startswith=110).values("author__book__title","author__book__publish__name")
#
# # 方式3：
#ret=Book.objects.filter(authors__ad__tel__startswith=110).values("title","publish__name")
```

##### 聚合分组

```python
   # 聚合
    # 查询所有书籍的平均价格
    from django.db.models import Avg,Max,Sum,Min,Count
    # ret=Book.objects.all().aggregate(priceAvg=Avg("price"))
    # print(ret) # {'priceAvg': 142.0}
    # # 查询所有书籍的个数
    # ret=Book.objects.all().aggregate(c=Count(1))
    # print(ret) # {'c': 4}

    # 跨表分组查询
    '''
    select app01_publish.name,COUNT(1) from app01_book INNER JOIN app01_publish ON app01_book.publish_id=app01_publish.nid
 
                             GROUP BY app01_publish.nid
    '''

    # 查询每一个出版社的名称以及对应的书籍平均价格
    # ret=Publish.objects.values("name","email").annotate(avg_price=Avg("book__price"))
    # print(ret) # <QuerySet [{'name': '苹果出版社', 'avg_price': 117.0}, {'name': '橙子出版社', 'avg_price': 112.0}, {'name': '西瓜出版社', 'avg_price': 222.0}]>

    # 查询每一个作者的名字以及出版的书籍的最高价格

    # ret=Author.objects.values("pk","name").annotate(max_price=Max("book__price"))
    # print(ret)

    # 查询每一个书籍的名称以及对应的作者的个数
    ret=Book.objects.values("title").annotate(c=Count("authors"))
    print(ret) # <QuerySet [{'title': 'python', 'authors__count': 2}, {'title': 'linux', 'authors__count': 1}, {'title': 'go', 'authors__count': 1}, {'title': 'java', 'authors__count': 0}]>

```

#### 聚合函数

```python
from django.db.models import Avg,Max,Sum,Min,Count
.aggregate(Count(1))
```

#### 分组查询

单表分组查询

```python
.annotate()前面values 哪一个字段就按哪一个字段分组
```

跨表分组查询

### F函数



### Q函数

### 新的数据类型

QuerySet

`[obj1，obj2]`





### 静态文件设置

配置setting

```python
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "static")
]
```

`###` 

如果url 只差一个/ django会加

append_SLASH = true 自动补 / 重定向301

### 中间件

middleware 

### forms组件

源码解析

钩子的应用

# CRM

### 表结构

modelForm

CBV 与 FBV

FBV ----- function based view

CBV ----- class based view

视图函数

自定义分页

dispatch分发

创建超级用户

```python
createsuperuser
```



# PEP8规范

PEP8规范时约束我们在书写 python 时的一种代码规范，在此罗列出一些常用的规范。详细可以区查看官网具体定义。[PEP8规范](https://www.python.org/dev/peps/pep-0008/)



### 导包的顺序

标准库  --> 第三方库   --> 自己的，一共三层，每层之间空开一行



### 注释

注释多行一般采用双引号注释，函数注释，写完双引号 在中间按 Enter  ，可以生成快速注释（在pycharm中），对于注释可以进行详细解释。



单行注释，一般用于局部注释信息，书写时要与 `# `空一格



### 命名规范

python 中命名规范有两种

- 驼峰式命名
- 下划线命名

驼峰式命名，一般要作用项目名称，或者类名书写





下划线命名一般用于变量或者函数命名，由于变量或者函数的命名表达不清楚时可以使用下划线命名。



特殊变量常量，由于 python 中无法定义常量，一般将常量的命名全部大写。

```python
CASE = 123
```

模块命名小写，表达不了用下划线隔开

```python
add_user
from add_user
```

### 书写方式

等号两边都有空格



函数或者类之间相隔两个空行



结束时空一行



## RBAC组件

rbac 组件一般我们用于权限的校验，帮助我们更好的管理用户认证信息，不同的用户权限不同，访问的界面展示也不相同

什么是权限： 一个含有正则表达式的 url

基于 RBAC 设计表关系：



```python

class User(models.Model):
    class Meta:
        # 此处设置 admin 中显示名称
        verbose_name = verbose_name_plural = '用户表'

    name = models.CharField(max_length=32)
    pwd = models.CharField(max_length=32)
    roles = models.ManyToManyField(to='Role')

    def __str__(self):
        return self.name


class Role(models.Model):
    class Meta:
        verbose_name = verbose_name_plural = '职位表'

    title = models.CharField(max_length=32)
    permissions = models.ManyToManyField(to='Permission')

    def __str__(self):
        return self.title


class Permission(models.Model):
    class Meta:
        verbose_name = verbose_name_plural = '权限表'

    title = models.CharField(max_length=32)
    url = models.CharField(max_length=32)
	menu=models.ForeignKey("Menu",on_delete=models.CASCADE,null=True)
    
    def __str__(self):
        return self.title
    
    
class Menu(models.Model):
    class Meta:
        verbose_name = verbose_name_plural = '菜单表'
        
    title = models.CharField(max_length=32, verbose_name='菜单')
    icon = models.CharField(max_length=32, verbose_name='图标', null=True, blank=True)


```

添加需要的权限信息

任何利用中间件和自定义的模块 传输和获取 当前用户的权限信息

```python
# 通过自定义 middleware 模块在 setting 中加入，引入中间件
from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import HttpResponse, redirect
import re


class PermissionMiddleWare(MiddlewareMixin):

    def process_request(self, request):

        current_path = request.path
        # 设置白名单
        for reg in ['/login/', '/admin/*']:
            ret = re.search(reg, current_path)
            if ret:
                return None

        # 校验是否登录
        user_id = request.session.get('user_id')
        if not user_id:
            return redirect('/login/')

        # 校验权限
        permission_list = request.session.get("permission_list")
        for reg in permission_list:
            reg = "^%s$" % reg
            ret = re.search(reg, current_path)
            if ret:
                return None

        return HttpResponse("无权访问！")
```

rbac 自定义模块

```python
from app1.models import *


def initial_sesson(user, request):
    """
    功能：将当前登录人的所有权限录入 session 中
    :param user:当前登录人
    :param request:
    :return:
    """
    # 查询当前登录人的所有权限列表
    permissions = Role.objects.filter(user=user).values('permissions__url')
    print('roles', permissions)

    permissions_list = []
    for item in permissions:
        permissions_list.append(item['permissions__url'])

    # 将当前登录人的权限列表注入 session 中
    request.session['permission_list'] = permissions_list

```



#### 动态显示菜单权限

动态获取显示菜单，注意本次显示是后台操作

需要获取当前用户的权限信息，获取 url 和 是否为菜单，以及所带的 icon 图标。因为设计到传值的问题，于是我们产生了自定过滤器。

首先自定过滤器

```python
# web.py 文件中
from django.utils.safestring import mark_safe
from django.template import Library
import re
register =Library()


@register.inclusion_tag("rbac/menu.html")
# 将当前函数的 permission_menu_dict 传给 rbac 的 menu.html
def get_menu_styles(request):
    """
    自定义过滤器
    :param request:传入当前用户菜单信息 
    :return: 
    """
    permission_menu_dict = request.session.get("permission_menu_dict")
    print("permission_menu_dict",permission_menu_dict)
    return {"permission_menu_dict":permission_menu_dict}

```

在 menu.html 中书写

```django
# menu.html
<div class="multi-menu">
    {% for item in permission_menu_dict.values %}
       <div class="item">
        <div class="title"><i class="{{ item.menu_icon }}"></i>{{ item.menu_title }}</div>
        <div class="body">
              {% for foo in item.children %}
                  <a href="{{ foo.url }}">{{ foo.title }}</a>
              {% endfor %}
        </div>
       </div>
    {% endfor %}
</div>
```

使用自定义的组件

```html
 <div class="left-menu">
      <div class="menu-body">
           {% load web %}
           {% get_menu_styles request %}
      </div>
</div>
```

整体样图



## Queryset

特点：

- 可切片
- 可迭代
- 惰性查询
- 缓存机制

## DRF（django rest framework）

简述DRF（Django restframework）就是一个Django中使用 rest 接口规范的模块。什么rest接口规范？就是对于我们书写前后端分离时，定义接口的一种规范，列举如下规范：

| 请求方式 |       url 设计（接口）       |      请求内容      |            响应内容            |
| :------: | :--------------------------: | :----------------: | :----------------------------: |
|   GET    |    127.0.0.1:8000/books/     | 获取所有书本的信息 | [ {书的id,name,…} , {}, {} …]  |
|   GET    | 127.0.0.1:8000/books/{ id }  |   获取单条数据据   |  单条数据{ 书的 id，name…. }   |
|   POST   |    127.0.0.1:8000/books/     |    增加单条数据    | 添加成功的数据{ ‘mesage’:‘ok’} |
|  DELETE  | 127.0.0.1：8000/books/{ id } |    删除单条数据    |           返回空“  ”           |
|   PUT    | 127.0.0.1:8000/books/{ id }  |      修改数据      |      更新后完整的数据{ }       |

从结构上看，比我们一般设计的 url 地址更加简洁明了，方便程序员维护还有错误处理

错误处理：{ “error” : “message” }

如何在 Django 中实现 rest接口规范？

安装 DRF

```shell
pip install django
pip install djangorestframework
```

完成之后可以进行学习了以下内容：

- APIView
- 解析器组件
- 序列化组件
- 视图组件
- 认证组件
- 权限组件
- 频率控制组件
- 分页组件
- 响应器组件
- url 控制器

Django 中View视图函数使用有些不是很方便，所以封装了APIView

```python
class LoginView(View):
    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        print(request.POST)
        # 此时Ajax发送的请求无法被识别
        return HttpResponse("ok")
```

APIView的使用

```python
class LoginView(APIview):
    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        print(request.data)
        # APIView中的解析器就帮我们做到了解析的功能
        return HttpResponse("ok")
```



View源码分析CBV（django  classbasedview）

1. from  django.views  import  View

2. 在视图类种继承 View 类 class StudentView(View):pass

3. urls.py 中定义路由关系

   1.  from django.urls  import  re_path
      from classbasedview  import views

      urlpatterns = [

      ​	re_path(“login/”, views.LoginView.as_view()),

      ]

4. Django启动时加载路由系统，会读取urlpatterns中的对应关系
5. 执行as_view(),或得器返回值，该函数返回一个view视图函数
6. 此时绑定关系建立好了，当用户请求过来时，就会执行url对应得view视图函数
7. 该视图函数得返回值是self.dispatch()
8. self.dispatch()会找到http_method_names变量里面得函数，并执行，并最终返回

APIView源码分析

封装自己的东西，用到view得方法

1. 安装djangorestframework 
   pip install djangorestframework

2. 在views.py中
   from rest_framework.view  import  APIView

3. 在视图类继承APIView

   ```python
   class StudentView(APIView):
       def get(self, request):
           pass
       def post(self, request):
           pass
       
   ```

4. urls.py 中保持不变

5. Django启动时加载路由系统，会读取 urlpatterns 中的对应关系

   ```python
   from django.urls import path
   from api.view import views
   urlpatterns = [
       path("login/", views.LoginView.as_view()),
   ]
   ```

6. 此时绑定关系已经建立好了，当用户请求过来时，就会执行 url 对应的 View 视图函数

7. 请求到来，执行View视图函数

8. 最后执行 dispatch()，获取返回值，返回给用户

9. Django RestFramework 自定制的内容就在重写的 as_view 函数里面以及 dispatch() 方法

## 解析器组件

Django 原生解析器

1. from django.core.handlers.wsgi  import WSGIRequest
2. POST = property(_get_post, _set_post), 找 def  _load_post_and_files(self)函数，判断类型，然后进行解析封装。只支持  content_type == ‘multipart/from-data’ 。也可以进行自定义封装，但是遵循开放封闭原则，不要更改源代码。

```python
class LoginView(View):

    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        print(request.POST)
        origin_data = request.body
        parsed_data = origin_data.decode('utf-8')
        print(parsed_data)
        return HttpResponse("ok")
```

DRF的解析器

```python
from rest_framework.views import APIView
from rest_framework.parsers import FormParser


class LoginView(APIView):
    parser_classes = [FormParser]
    # 此时加了固定的解析器，就只能解析formdata了

    def get(self, request):
        return render(request, 'login.html')

    def post(self, request):
        # print(request.POST)
        # origin_data = request.body
        # parsed_data = origin_data.decode('utf-8')
        # print(parsed_data)
        print(request.data)
        # request.data 是一个函数，一个 porperty 装饰的方法
        return HttpResponse("ok")
```

1. views.LoginView.as_view()

2. LoginView 里面没有 as_view 方法，到父类 APIView 去找

3. 执行 View 里面得 as_view() 方法，返回函数

   ```python
   def view(request, *args, **kwargs):
       self = cls(**initkwargs)
       if hasattr(self, 'get') and not hasattr(self, 'head'):
           self.head = self.get
       self.request = request
       self.args = args
       self.kwargs = kwargs
       return self.dispatch()
   ```

4. url 和视图函数之间得绑定关系建立完毕 `{"login": view},` 等待用户请求

5. 接受到用户请i去：login，到建立好的绑定关系里面执行对应得视图函数：view(request)

6. 视图函数的执行结构是什么就返回给用户什么：self.dispatch()，self.diaptch() 的执行结果是什么，就返回给用户是什么

7. 此时的 self 代表的就是 LoginView 对象

8. 开始找 dispatch 方法，self里面没有，LoginView里面没有，在APIView里面有

9. 开始执行 APIView 里面的 dispatch

10. 最后找到 http 方法（GET，POST，PUT，DELETE）

11. 开始执行找到的方法（GET），self.get(), self此时代表LoginView的实例化对象

    ```python
    11.1 假设接收到的是POST请求, 执行request.data
    11.2 根据分析，所有的解析工作都在request.data里面实现，且data是一个方法（被装饰后的）
    11.2 开始执行request.data
    	@property
    	def data(self):
    		if not _hasattr(self, '_full_data'):
    			self._load_data_and_files()
    		return self._full_data
    11.3 执行self._load_data_and_files
    11.4 执行self._data, self._files = self._parse()
    11.5 parser = self.negotiator.select_parser(self, self.parsers)
    	11.5.1 开始找self.parsers
    	11.5.2 self.get_parses()
    			[ parse() for parse in self.parser_classes ]
    		11.5.3 parser_classes = api_settings.DEFAULT_PARSER_CLASSES
    		11.5.4 from rest_framework import api_settings
    		11.5.5 api_settings = APISettings(None, DEFAULTS, IMPORT_STRINGS)
    	11.5.6 class APISettings():pass
    	11.5.7 找不到DEFAULT_PARSER_CLASSES，__getattr__
    		'DEFAULT_PARSER_CLASSES': (
    		'rest_framework.parsers.JSONParser',
    		'rest_framework.parsers.FormParser',
    		'rest_framework.parsers.MultiPartParser'
    	),
    	11.5.8 首先找程序的settings
    	11.5.9 然后找rest_framework的settings
    
    11.6 self._data就是我们想要的数据
    11.7 DRF将self._data = data
    11.8 request.data
    ```

    

DRF的所有功能都是在as_view() 和 dispatch里面重写的

而解析器组件在 dispatch 方法里面重写了，具体是在重新封装的Request对象里面

```python
#  源码
class LoginView(APIView):
	def get(self, request):
	    pass
		
	def post(self, request):
		request.data  # 新的request对象 @property
		return


class APIView(View):
	@classmethod
	def as_view(cls, **initkwargs):
	    pass
		super(APIView, cls).as_view(**initkwargs)
		
	def initialize_request(self, request, *args, **kwargs):
	
		from rest_framework.request import Request

		return Request(
			request,  # 原生request对象
			parsers=self.get_parsers(), #
			authenticators=self.get_authenticators(),
			negotiator=self.get_content_negotiator(),
			parser_context=parser_context
		)
			
	def dispatch(self):
	    pass
		request = self.initialize_request(request, *args, **kwargs)
        self.request = request
		
	def get_parsers(self):
	
		return [parser() for parser in self.parser_classes]
```

Django 的原生序列化

```python
from django.core.serializers import serialize
from django.shortcuts import render, HttpResponse


class CourseView(APIView):
    # def get(self, request):
    #     course_list = list()
    #     for course in Course.objects.all():
    #         course = {
    #             "course_name": course.course_name,
    #             "description": course.description,
    #         }
    #         course_list.append(course)
    #     print(course_list)
    #     return HttpResponse(json.dumps(course_list, ensure_ascii=False))

    def get(self, request):
        origin_data = Course.objects.all()
        # 开始序列化
        serialized_data = serialize("json", origin_data)
        return HttpResponse(serialized_data)
```

### DRF序列化

```python
from rest_framework import serializers


class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book
        fields = "__all__"

    publish_name = serializers.CharField(max_length=32, read_only=True, source="publish.name")
    publish_city = serializers.CharField(max_length=32, read_only=True, source="publish.city")
    # write_only_fields = ("authors", "publish")

    author_list = serializers.SerializerMethodField()

    def get_author_list(self, book_obj):
        # 拿到 queryset 开始循环 [{},{},{}]
        authors = list()

        for author in book_obj.authors.all():
            authors.append(author.name)

        return authors
```



### Mixins 进行接口优化

```python
from rest_framework.generics import GenericAPIView
from rest_framework.mixins import (ListModelMixin,
                                   CreateModelMixin,
                                   DestroyModelMixin,
                                   UpdateModelMixin,
                                   RetrieveModelMixin)

from .app_serializer import *


class BookView(ListModelMixin, CreateModelMixin, GenericAPIView):
    queryset = Book.objects.all() 
    # 告诉需要使用的数据库查询
    serializer_class = BookSerializer
	# 告诉使用的序列化组件
    
    def get(self, request):
        return self.list(request)

    def post(self, request):
        return self.create(request)
  

class BookFilterView(DestroyModelMixin, UpdateModelMixin, RetrieveModelMixin, GenericAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)
```

- Django程序启动，开始初始化，读取 urls.py， 读取 settings， 读取视图类
- 执行 as_view()，BookView没有，需要到父类中找
- 几个ModelMixin也没有，GenericAPIView中没有，继续到GenericAPIView（APIView）中找
- 在APIView中找到，与前面的逻辑一样，在 GenericAPIview 中定义了查找 queryset 和serializer——class 类的方法
- as_view() 方法返回重新封装的视图函数，开始建立 url 和视图函数之间的映射关系
- 等待用户请求
- 执行视图函数的 dispatch 方法（因为视图函数的返回值是：return self.dispatch()
- dispatch 分发请求，查找到视图类的五个方法中的某个
- 开始执行，例如 post 请求，返回 self.create()， 自己没有，去父类找。
- 最后在 CreateModelMixin 中查找
- 执行 create()  方法，获取 queryset 和 serializer_class
- 返回数据

断言进行判断

```python
assert  a in b 
# assert 就是断言
```



### 使用 generics 进行接口逻辑优化

```python
from rest_framework import generics


class BookView(generics.ListCreateAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer


class BookFilterView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

```

### 使用viewset进行接口逻辑优化

对比上面，再次封装（不是我），利用 mixins 进行分发请求，找到对应的函数。

```python
from rest_framework.viewsets import ModelViewSet


class BookView(ModelViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
```

- 与上面一样加载后，进行 as_view() 函数中，因为路由中配置了参数，携带 actions参数 到函数中执行

- Django程序启动，开始与上述一样的操作
- 遵循自己没有，找父类，找到了ModelViewSet 中找
- ModelViewSet 继承了 mixins 的几个 ModelMixin 和 GenericViewSet，最终只有GenericViewSet ，它继承了 ViewSetMixin 和 generic.GenericAPIView （这个我们已经认识了）
- 先去 ViewSetMixin 中查找，找到了 as_view() 类方法，在重新封装 view 函数的过程中，有一个 self.action_map = actions
- 这个 actions 就是我们给 as_view() 传递的参数
- 绑定 url 和视图函数（actions）之间的映射关系
- 等待用户请求
- 接收到用户请求，根据 url 找到视图函数
- 执行视图函数的 dispatch 方法（因为视图函数的返回值是： return self.dispatch()）
- dispatch 分发请求，查找到视图类的五个方法的某个
- 开始执行，例如 post 请求，返回：self.creat(), 自己没有，去父类
- 最后找到 CreateModelMixin 中，执行create方法，获取queryset和serializer_class ，返回数据

## Django下的表contentype表：

这张表主要记录



## 公钥私钥

私钥  ———— 公钥                      RSA

## 支付宝沙箱环境

getattr  （）

## Django admin源码

callable() ke'diao 

## Cookie和session区别

Cookies 是服务器在本地机器的一个小文本，每一次都随着本地服务器发送至同一个服务器。 IETE RFC 2956 HTTP State Management Mechanism 是通用 cookie 规范。网络服务器用 HTTP头向客户端发送 Cookie，在客户端，浏览器通过解析这些 cookie 并将它们保存为一个本地文件，它会自动将同一服务器的任何请求带上这写 cookies。

Cookie 机制采用的是在客户端保持状态的方案。它是在用户端的会话状态的存贮机制，他需要用户打开客户端的 cookie 支持。cookie 的作用就是为了解决 HTTP 协议无状态的缺陷所作的努力。

## session

session 是一种服务端的机制，服务端使用类似于散列表的结构来保存信息。

当程序需要为某个客户端的请求创建一个session时，服务器首先检查这个客户端的请求里是否已包含一个session 标识（session Id），如果已经为此客户端创建过 session ，服务器就按照这个 session Id 把session 减锁出来使用（无，则创建）。这个session Id 的值应该是一个既不会重复，又不容易被找到规律以仿造的字符串，这个 session ID 将被在被刺响应中返回给客户端保存。

保存这个session Id的方式可以采用 cookie， 这样在交互过程中浏览器可以自动的按照规则把这个 标识发挥给服务器。一般这个 cookie的名字类似于 session Id。但是 cookie可以被认为禁用。

有一个技术叫做 URL 重写， 就是 session Id 直接附加在 URL路径的后面， 还有一种技术叫做 表单隐藏字段。就是服务器会自动修改表单，添加一个隐藏字段，以便在表单提交时能够把session Id 传递会服务器。

cookie 和seseion 都能够进行会话跟踪，但是完成原理不太一样，普通状况下二者均能满足需求，但是 有时不能够运用cookie ，有时不能够运用 session。

Cookie 和session的不同点：

1.存取方式不同
Cookie 只能保管 ASCII 字符串，假如需求存取 Unicode 字符或则二进制数据，要先编码。若要存储略微复杂的信息，比较难。

session 中能够存储任何类型的数据，包括而不限于 string ，，，等。session 中能够直接保管 java Bean乃至任何Java类。

2.隐藏策略的不同

cookie 存储在客户端阅读器中，对客户端是可见的，客户端的一些程序可能会窥探、复制以至修正cookie中的内容。

而session 存储 在服务器上，对客户端是透明的，不存在敏感信息泄露的风险。

假如选用 cookie，比较好的方法是，敏感的信息如账号等尽量不要写到 cookie 中。最好将 cookie 信息加密，然后提交服务器解密。

3.有效期的不同

cookie 可以设置的时间很长很长，以持久的记载该用户的登录信息。要到达这种效果，用cookie是好的选择。

session 依赖于 名为 jseeion Id 的cookie，而 cookie 就sessionId的国企时间默许为 -1，值需关闭阅读器session就会失效，所以session 不能够达到持久的记录。运用 URL重写也不行。而 设置session的超时时间越长， 服务器累计的session就会越多，越容易招致内存泄漏。

4.服务器压力的不同

session 是保管在服务端的，每个用户都会产生一个session。假如并发访问的用户十分多，会产生十分多的 session， 耗费大量的内存。所以并发极高的情况，不会选择用session追踪客户会话。

而cookie保存在客户端，不占用服务器资源。并发阅读的用户十分多，cookie是很好的选择。

5.浏览器支持的不同

cookie 是需要客户端浏览器支持的。计入客户端仅用了 cookie，那么会话跟踪就会失效。关于 WAP 应用，常规的Cookie 就派不上用场了。

运用 session以及 URL地址重写。需要注意的是一切的用到 session 程序的 URL 都要进行 URL地址重写。否则 session会话跟踪还会失效。关于 WAP应用来说， session+URL地址重写或许是他唯一的选择。

假如支持 cookie，则 cookie既能够设为本浏览器窗口以及子窗口内有效，也能设为一切阅读器窗口内有效。但 session 只能在本阅读器窗口以及其子窗口内有效。但session只能在本阅读器内有效。（IE8下不同窗口session相干）

6.跨域支持上的不同

cookie 支持跨域名访问。例如将 domain 属性设置为 “.bao.com”，则以 “.bao.com”为后缀的一切域名能够访问 cookie。跨域名 cookie 如今被普遍用在网络中。而session不会支持跨域名访问，session仅在他所在的域名内有效。

所以大部分场景都是cookie和session搭配。



