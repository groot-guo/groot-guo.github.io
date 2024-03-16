---
title: Python 认识与实践
tags: 笔记
categories:
- IT技术
- 后端
- Python
abbrlink: 95688174
description: 利用 Python 做web 开发，爬虫，认识ptyhon 的不同。
date: 2019-07-18 00:00:00
---

# Python

## Python第一天

### 	初识编码

-  Python2默认英文编码    	Ascii  	英文，8位表示一个信息，2^8

```python
# -*- coding:utf-8 -*-
//输入编码格式python2中需要输入
```

-  Unicode   万国码，32位表示一个东西，2^32
- Python3默认UTF-8    UTF-8  给Unicode压缩

####     文件编码

- 编写文件时，保存文件要用UTF-8格式，
- 以什么格式保存就用什么格式读取
- win10 中可以更改 cmd 编码 `chcp 65001`

####        解释器

```python
#!/usr/bin/env python
# -*- conding:utf-8 -*-

print('你好')
```

运行：解释器 文件路径

在linux上右一种特殊的执行方法

- 给文件赋予一个可执行的权限
- ./a.py 自动去找文件的第一行 = /usr/bin/env/python a.py

####         输入

```python
print(你想要输出的东西)
raw_input('sadfas') #py2
input('asdad') #py3
```

特殊：

- py2：print "你好"
- py3：print("你好")

#### 		数据类型

```python
'alex' /"理解"/'''asds '''/""" ddsdd"""" ，一般称为字符创
666,一般称为数字/整型
Ture / False , 一般称为布尔类型
```

1.  字符串
   - 单引号
   - 双引号
   - 三引号
2. 整型
3. 布尔类型

## Python第二天

if ——else中有个`pass`直接跳过否定

#### 循环

```python
while True://可以加条件
	print('ssss')

   	break//终止循环
count = 1 
while True:
    print(count)
    continue //满足走上走
    
else：#不满足触发条件

    
```

for 和 while 的应用场景， 无穷使用 while



### 字符串格式化

%s 	字符串

%d 	数字

%%  	%

### 编码

- AsCII
- Unicode
  - ecs2
  - ecs4
- utf-8   中文用3字节
- utf-16
- gbk, 中文用2字节
- gbk-2312 中文用2字节

### Git

- 右键 git bash here

- 初始化 git init（每一次都得做）

- git add .  将当前目录下的文件都收集起来

- git commit  -m "第二天作业"   做记录 第几次收集

- 第一次执行的时候输入
   1. git config --global user.name "sssss"
   2. git config --global user.email " www@qq,com"
   3. git config --global user.password ""
   4. git remote add origin 地址

- 代码提交并收集

  1. git status
  2. git add .
  3. git commit -m "记录"
  4. git push origin master 将本地目录同步到

- 修改代码或删除文件等对本地任何文件操作

  - git  statue
- git add .
  - git commit -m "记录"
- git push origin master 将本地文件同步到码云仓库

下载 git 上的文件

```shell
npm clone 地址
```

- and  取大  且
- or   取小  或 ，都为真，输出前，第二项有错输出错，第二项有真输出真
- not  非
-    not>and>or

### 整型

- ​	py2
  - int超出范围自动转化为long (int)
- py3
  - int

### 布尔类型(bool/boolen)

### 字符串(str/string)

字符变大小

```python
# value = "alex sb"
# new_value = value.upper()变大
# new_value = value.lower()变小
# print(value)
```

确定字符串是否是数字

```python
num = input('请选择服务：')
flag = num.isdigit()
print(flag)         # "1" -> True ,"sad" -> False
```

去除空格（ rstrip / lstrip / strip(全去除)）

```python
user = input("请输入用户名：")
# new_user = user.rstrip()
# new_user = user.lstrip()
new_user = user.strip()
print("--->",new_user,'<----')
```

替换（replace）

```python
message = input("请说话：")
print(message)
# data = message.replace('大爷',"**") # 全替换
data = message.replace('大爷',"**",1) # 替换几个
print(data)
```

切割 （ split / rsplit ）

```python\
message = "下开放，阿斯顿福建克拉斯，阿斯顿发流口水."
# result = message.split(',')
# result = message.split('，',1) # 注意逗号中英文，默认从左向右
result = message.rsplit('，',1) #从有向左
print(result)
```

公共的：

- len()     计算长度

- 索引

  ```python\
  name = "sfdsa"
  print(name[0])
  print(name[-1]) #从右往左取值
  ```

- 切片

  ```python
  v = "sdfsadf"
  s = v[2:3] # f
  s = v[2:]  # fsadf
  s = v[:5]  # sdfsa  从左往右取到第五个
  s = v[:-1] # sdfsad 把 f 那掉了
  print(s)
  ```

  - .extend() 会在内部循环自动添加到列表

## 列表

 表示多个数据用列表

```python
user = ["sdsd","sdsdsd",99]
```

### 公共功能

- len

  ```python
  users = ["aaa","aaa",99]
  val = len(users)
  print(val)  #3
  ```

- 索引

  ```python
  users = ["aaa","aaa",99]
  val = users[0]
  print(val)  #
  ```

- 切片

  ```python
  users = ["aaa","aaa",99]
  val = users[0:2]
  val = users[::2] # 输出为偶数索引的值
  print(val)  #
  ```

- 删除

  ```python
  users = ["hhhh","sdfsfa",99]
  #方式一
  users.pop(1)
  print(users)
  
  #方式二
  del users[1]
  print(users)
  ```

  注意：

  - 字符串本身不支持修改删除【不可变的类型】
  - 列表是可变类型

- 修改

  ```python
  users = ["来来来","sdafssd","asdfsad"]
  users[2] = 66
  
  users[0] = 'sadfsa'
  users[0][1]//选取是‘来’
  ```

  

- 步长

  ```python
  users = ["aaa","aaa",99]
  val = users[0:2:2]
  print(val)  #
  ```

- for 循环

- range(数字,数字,-1/ 1)-1 反过来，1 正过来

### 独有功能

- append, 在列表的最后追加一个元素
- insert(index," ")，在索引位置加元素
- remove/pop，remove加元素删除，pop加索引删除，默认最后一个
- clear，清空了

- 列表嵌套

  ```python
  users = ["sadffsf",0,True,[asdfsa,asdfas,],[1sadf]]
  
  users[0]
  users[3] #[asdfsa,asfsa,]
  users[3][-1] #"sadfsa"
  users[]
  ```

元组转换列表

```python
va = list((111,22,33,44))
print(va)
```

```
enumerate(变量,序号)
```

## 元组

### 元组书写规范

```python
users = [11,22,33,44] #列表 （可变）

users = (11,222,11,11) #元组 （不可变）
```

### 公共功能

1. 索引 （排除：int/bool）
2. 切片（排除：int/bool）
3. 步长（排除：int/bool）
4. 删除（排除：tuple/int/bool）
5. 修改（排除：tuple/int/bool）
6. for循环（排除：int/bool）
7. len（排除：int/bool）

### 独有功能（无）

### 特殊：元组中的元素不可被修改/删除。

```python
v1 = (11,22,333)
v1[1] = 999 #错误
v1 = 99


#可以嵌套

```

## 字典

> 请表示：刘伟达的信息，年龄18

```python\
info = {"name":'sfd','age':'18','gender':'男' }
info['name']
```

基本格式

```python
data = [键：值，键：值]
```

1. ##### 独有功能

   - `.keys()`获取所有字典中的键
   - `.values()`获取所有的值
   - `.items`获取所有的键和值

2. 公共功能

   - 索引 
   - 切片【无】
   - 步长【无】
   - 删除
   - 修改
   - for循环
   - len

添加字典可以直接赋 键 和 值，也可以使用 setdefault(键，值) 方法

```python
dic.setdefault("k4","v4")
print(dic)
```

.get() 方法找不到不报错，返回none

## 集合set

```python
v = {1,2,3,4,5,6}
# 创建集合
v = set()
```

- 无序
- 无法索引删除
- 不重复的

### 集合的独有功能

- add 											  添加
- discard	 							        删除
- update										 更新往里面添加(批量添加)
- intersection								 交集
- union											并集
- difference									差集
- symmetric_difference				对称差集

```python
v = set() #空集
v = {1,2,'施钻','呵呵'}

result = v.add('添加')  					# {1,2,'施钻','呵呵','添加'} 已存在不会重复添加
result = v.discard('施钻')				# {1,2,'呵呵'}不能通过索引删除
result = v.update({11,22,33})    	 	 # {1,2,11,22,33,'施钻','呵呵'}批量添加
result = v.intersection({1,22,'呵呵'})	# {1,'呵呵'} 交集
result = v.union({1,2,'呵呵','是'})	  	# {1,2,'施钻','呵呵','是'} 并集
result = v.difference({1,'呵呵'})			# {2,'施钻'} 差集
result = v.symmetric_difference({1,'呵呵','小何'})	#很少使用互相取差集 {2,'施钻','小何'}
```

注意：

```python
v = {1,2,'施钻','呵呵'}
result = v.intersection([1,22,'呵呵'])
#可以是列表，但 v 不能是列表，因为没有这个方法
```

### 公共功能

- len
- for 循环
- 索引【无】
- 切片【无】
- 删除【无】
- 步长【无】
- 修改【无】

​	列表/字典/集合 -> 不能放在集合中 + 不能作为字典的 key（unhasable）

集合字典的查询速度 > 列表

## 深浅拷贝（面试）

深浅拷贝相等



## 文件操作

### 打开文件

```python
open('url',mode='方式',encoding='格式')
```

文件的方式有：

- 单一的：

  - r		只读不能写，文件必须存在
  - w       只写不能读，写之前会清空，文件不存在会建立
  - a        只追加不能读，不存在会新建，默认光标在最后      

- k可读可写：

  - r+		能读，写：根据光标位置操作写入（可能会覆盖）`seek`调整光标位置
  - w+       能读能写，写入清空文件，读取调整光标位置
  - a+        能读能写，因为追加，所以光标最后，读取一样调整

- 带b编码（二进制）：

  - rb			`.encode('utf-8')`转换编码
  - wb
  - ab

  

## 三元运算（三木运算）

```python
v = 前面 if 条件 else 后面 
```

```python
# 让用户输入值，如果值是整数，则转换成整数，否则赋值为None
data = input('>>>')
value = int(data) if data.isdecimal() else None
```

注意：先做出来，再简化

## 函数

面向对象的思想：函数式编程，（进行封装方法）

```python
# 函数的定义必须有 def
def foo():
    # 函数内容
    print('ssss')
# 函数执行
foo()

# 函数不调用，内部代码永远不会执行
```

### 参数赋值

```python
def foo(aa):		#形参
    v = [11,22,33]
    print(v[aa])
foo(1)  # 第二个元素输出，实参
```

### 返回值（return 1,2,3 返回元组）

```python
def func(arg):
    #....
    return 9  # 返回值为9 默认 return None

val = func('adsasd') # val 等于 return 
```

```python
# 1.让用户输入一段字符串,计算字符串中有多少大写A，将有多少个就这文件中写多少个’A’
def get_char_count(data):
    sum_counter = 0 
    for i in data:
        if i == 'A':
            sum_counter += 1
         
    return sum_counter

def write_file(line):
    if len(line) == 0:
        return False		# 如果函数中有 return 则停止执行
    with open('a.txt',mode='w',encoding='utf-8') as f:
        f.write(line)
    return True

content = input('请输入：')
counter = get_char_count(content)
write_data = "宿舍" * counter 
status = write_file(write_data)
if status:
    print('写入成功')
```

### 总结

```python
# 情况1
def f1():
    pass
f1()
# 情况2
def f2(a):
    pass
f2(1)
# 情况3
def f3():
    return 1
f3()
# 情况4
def f4(a):
    return a 
f4(1)
```

## 参数

### 基本参数

- 任意类型

- 任意个数

  ```python
  def  fun(a1,a2,a3):
  	print(a1,a2,a3)
  fun(1,'sda',True)
  ```

### 位置传参

```python
def fun(a1,a2):
	print(a1,a2)
fun(1,2)
```

### 关键字传参（位置参数在前，关键在后）

```python
def fun(a1,a2):
	print(a1,a2)
fun(a1=99,a2=1)
# 位置参数只能从第一个开始，所以不能重复给一个赋值
```

### 默认参数

```python
def fun(a,b=9)
	print(a,b)
fun(a)
# b 可不传，传改变
```

### 万能参数（打散），也可以与上面混用

- `*args（tuple）`
  - 可以接受任意个数的位置参数，并将参数转换成元组
    - `有 *`
    - `无 *`

```python
def func(*args):	# 一般情况下写成 args
    print(args)
func(1)   	# (1,)
func(1,2) 	# (1,2)
func((1,2,3,4,5)) 		# 元组套元组
func(*(1,2,3,4,6))		# 加 * 循环添加进去，直接赋值
# 当你不确定用多少参数时使用
```

- `**args（dict）`
  - 可以接受任意个数的关键字参数，并将参数转换为字典
  - `有**`
  - `无**`
- 只能关键字传参

### 综合应用

```python
def func(*args,**kwargs):
    print(args,kwargs)
func(1,2,3,k1=4,k2=3,k3=4)
```

### 调用函数

位置参数 > 关键字参数

用的较多：

- 定义函数：
  - def func(a)
  - def func(a,b=None) 对于默认值，如果是可变类型，----->坑
  - def func(*args,**kwargs)

## 作用域

- 全局作用域

- 局部作用域

- 一个函数就是一个作用域
- 作用域中查找数据规则：优先在自己的作用域找数据，自己没有就去“父级”-> "父级"->直到全局，没有就报错。

```python
def func():
    x = 9
    print(x)
    def x1():
        print(x)
    x1()	# 找父级
    x = 999
    print(x)
func()
```

- 子作用域中只能使用父级中的值，无法重新为父级的赋值

global 找到全局变量，可以修改

```python
name = '呵呵'
def fun():
    name = 'sdfa'
    def funs():
        global name
        name = 999
    funs()
    print(name)
fun()
print(name)
# sdfa
# 999
```

nonlocal 找到上一级的修改 

```python
name = '呵呵'
def fun():
    name = 'sdfa'
    def funs():
        nonlocal name
        name = 999
    funs()
    print(name)
fun()
print(name)
# 999
# 呵呵
```

### 注意：

全局变量大写，局部变量小写

## 函数小高级

函数赋值

````python
def func():
    print(123)
v1 = func
func()
v1()
````

```python
def func():
    print(123)
func_list = [func,func,func]
func_list
```

函数可以当做变量来使用，加（）返回值为none

```python
def fun():
    print(123)
# func_list1 = [fun,fun,fun]
# func_list2 = [fun(),fun(),fun()]
#
# print(func_list2)
info = {
    'k1':fun,
    'k2':fun(),
}
print(info)
```

```python
def fun(arg):
    v1 = arg()
    print(v1)
def show():
    print(666)
result = fun(show)
print(result)
## 666
# None
# None
```

面试题

```python
# 有10个函数，
def func():
    print('话费查询')
def bar():
    print('语音沟通')
    ....
choice = input('要执行的功能：')

```



## lambda 表达式(匿名函数)

用于表达简单的函数

```python
def func1(a1,a2):
    return a1 + 100
func2 = lambda a1,a2: a1 + 100
print(func1(1,2))
v = func2(1,2)
print(v)
#类似三木运算
```

多种样子

```python
func1 = lambda : 100
func2 = lambda x1: x1 * 100
func3 = lambda *args,**kwargs: len(args)+len(kwargs)
# 注意加 ： 后面是返回值

func5 = lambda n1,n2: n1 if n1 > n2 else n2
v = func5(1,2)
print(v)
```

列表的所有方法基本上返回都是NONE；字符串返回是个新值

## 内置函数

以前的都是内置函数

强制转换类

- dict()
- str()
- list()
- tuple()
- int()
- bool()
- set()

输入输出

- input
- print

数学相关

- abs()	绝对值

- float()   转换成浮点型（小数值）

- max()   最大

- min()    最小

- sum()   求和

- pow()

  ```python
  v = pow(2,3)
  print(v)  # 2**3
  ```

- round

  ```python
  round(1.2344,2)  # 会四舍五入
  ```

- divmod  两个数相除得 商 和 余数（单个接收会放在元组，两个不会）

  ```python
  # 分页
  # -*-  encoding:utf-8 -*-
  USER_LIST = []
  for i in range(1,789):
      v = {'name':'哈哈-%s' %i,'email':'123-%s@qq.com' %i}
      USER_LIST.append(v)
  # for item in USER_LIST:
  #     print(item)
  
  # 数据总条数
  total_count = len(USER_LIST)
  
  # 每页显示10条
  per_page_count = 10
  
  # 总页码数
  max_page_num,a = divmod(total_count,per_page_count)
  if a > 0:
      max_page_num += 1
  
  pager = int(input("请输入查看第几页："))
  if pager < 1 or pager > max_page_num:
      print("页码不合法，必须是 1 - %s" %max_page_num)
  else:
      """
          USER_LIST[0:10]
          USER_LIST[10:20]
          ....
      """
      start = (pager - 1) * per_page_count
      end = pager * per_page_count
      data = USER_LIST[start:end]
      for item in data:
          print(item)
  ```

  二进制十进制等之间相互转换

  - bin,   	只能将十进制转换为二进制
  - oct ，    将十进制进制转换为八进制
  - int ,        将其他进制转换成十进制
  - hex        将其十进制进制转换成十六进制

  ```python
  v1 = '' # 输入要转换的几进制数
  v2 = int(v1,base=2) # 在2 的输入几进制数转换为十进制
  print(v2)
  # 其他进制转换为其他进制
  ```

  面试题

  ```python
  # 一字节等于8位
  # IP: 192.168.12.79   -> 四个字节  010001001.010001001.010001001.010001001
  字符串拼接
  '.'.join(字符串)
  ```

## 函数中高级（闭包/高阶函数）

函数内部执行不会混乱各自开辟了一个空间去执行

函数可以做返回值返回.



函数返回值问题注意：

```python
name = 'sd'
def base():
    print(name)
def func():
    name = 'sdsd'
    base()
v = func()
```

闭包：



高阶函数

- 把函数当做参数传递
- 吧函数当做返回值传递

总结：

- 闭包概念：为函数创建一块区域并为其维护自己数据，以后执行时方便调用。【应用场景：装饰器/ SQLAlchemy源码】

## 内置函数（包涵面试的）

- chr	将十进制数字转换为 Unicode 编码中的对应字符串

  ```python
  v = chr(97)
  print(v)
  ```

- ord     将字符串在 Unicode 编码中找到其对应的十进制

  ```python
  v = "中国"
  for item in v:
      print(ord(item))
  ```

- 应用：随机验证码

  ```python
  import random
  def get_random_code(length=6):
      data = []
      for i in range(length):
          v = random.randint(65,90)
          data.append(chr(v))
      return ''.join(data)
  
  code = get_random_code()
  print(code)
  ```

  ```python
  import random # 导入一个模块
  v = random.randint(起始,终止) # 生成随机数
  ```

- 高级函数

  - map，循环每个元素（第二个参数），然后让每个元素执行函数（第一个参数），将每个函数执行的结果保存到新列表中，并返回

    ```python
    v1 = [11,22,33,44]
    result = map(lambda x: x + 100,v1)
    print(result) # [11,22,33,44,55,66] py2
    print(list(result)) # 特殊 py3
    
    ```

  - filter

    ```python
    v1 = [11,22,33,44,'asds','asd']
    
    # def func(x):
    #     if type(x) == int:
    #         return True
    #     return False
    # result = filter(func,v1)
    # print(list(result))
    # result = filter(lambda x: True if type(x) == int else False,v1)
    result = filter(lambda x: type(x) == int,v1)
    print(list(result))
    
    ```

  - reduce

    ```python
    import functools
    v1 = [1,2,3,4,5,6]
    def func(x,y):
        return x+y
    # result = functools.reduce(func,v1)
    result = functools.reduce(lambda x,y: x+y,v1)
    print(result)
    ```

    

- 面试题

  - 常用内置函数有哪些？

  - filter / map / reduce

  - 什么是匿名函数？

    ```python
    def func():
        pass
    v = [lambda x: x+100]
    ```

    

## 内置模块（.py文件）

将指定的 "字符串" 进行加密

```python
import  hashlib
def get_md5(data):
    # obj = hashlib.md5()
    obj = hashlib.md5()
    obj.update(data.encode('utf-8'))
    result = obj.hexdigest()
    return result
val = get_md5('123')
print(val)
```

加盐

```python
obj = hashlib.md5("asdfas".encode('utf-8'))
# 此处加盐
```

密码不显示（只能在终端运行）

```python
import getpass
pwd = getpass.getpass('请输入密码：')
if pwd == '123':
    print('登陆成功')
```



id   与 is  == 什么意思

函数的参数传递的是什么？【内存地址 = 引用 or 值】

总结

- 传参：位置参数 > 关键字参数
- 函数不调用，内部代码永远不执行
- 每次调用函数时，都会为此次调用开辟一块内存，内存可以保存自己以后想要用的值
- 韩式作用域，如果自己的作用域中没有，则往上级作用域找。



## 装饰器(6**)

```python
# 装饰器
def func(arg):
    def inner():
        print('before')
        v = arg()
        print('after')
        return v
    return inner
# 第一步：执行 func 函数并将下面的函数参数传递，相当于：func(index)
# 第二步：将 func 的返回值重新赋值给下面的函数名。index = func(index)
@func
def index():
    print(123)
    return 666
index()
print(index())
```

总结

- 目的：不改变原函数的基础上，再函数执行前后自定义功能

- 编写装饰器

  ```python
  # 装饰器的编写
  def x(func):
      def y():
          ret = func()
          return ret
      return y 
  # 装饰器的应用
  @x
  def index():
      pass
  
  @y
  def manage():
      pass
  ```

- 应用场景：想要维函数扩展功能时，可以选择用装饰器。

- 记住：

  - 装饰器编写格式

    ```python
    def 外层函数(参数):
        def 内层函数(*args,**kwargs):
            return 参数(*args,**kwargs)
        return 内层函数
    ```

  - 装饰器应用格式

    ```python
    @外层函数
    def index():
        pass
    index()
    ```

  - 为什么加 *args, **kwargs ，防止要传参



## 推导式

- 列表推导式 

  - 基本格式

    ```python
    # 变量 = [ for 循环变量 for 循环一个可迭代对象]
    vals = [ i for i in 'alex']  
    v1 = [ i+100 for i in range(10)]
    v2 = [ 99 if i>5 else 66 for i in range(10) ]
    
    def func():
        return 123
    v3 = [ func for i in range(10)]
    
    v5 = [ lambda : 100 for i in range(10)]
    result = v5[9]()
    
    v8 = [lambda x: x*i for i in range(10)]  # 新浪面试题
    # 1.请问 v8 是什么？
    # 2.请问 v8[0](2) 的结果是什么？
    
    # 面试题
    def num():
        return [lambda x:i*x for i in range(4)]
    # num -> [函数,函数，函数,函数]
    print([ m(2) for m in num() ])  #[6,6,6,6]
    
    #################################################
    v9 = [ i for i in range(10) if i>5]
    ```

- 集合推导式

  ```python
  v1 = { i for i in 'aelx'}
  ```

- 字典推导式

  ```python
  v1 = { 'k'+str(i):i for i in range(10)}
  ```

模块：

```python
import time
v = time.time() #获取当前时间
time.sleep(2)   # 睡 2 秒
```

## 带参数的装饰器

- 应用场景：flask框架  + Django缓存 + 面试题（写装饰器实现被装饰的函数要执行 N 次）
- 模块
  - os
  - sys
  - time （三种类型）
  - datetime
  - timezone 时区

面试题：

- def func(a,b=[]) 有什么陷阱？ 如果不传递参数，默认指向同一个地址，这个就是参数最好是不可变类型
- 看代码写结果

## 递归

```python
def func():
    print(1)
    func()
func()
```

默认递归次数限制  1000

## 带参数的装饰器

```python
def x(counter):
    def wrapper(func):
        def inner(*args,*kwargs):
            data = func(*args,**kwargs)  # 执行原函数并返回值
           	return data
        return inner
    return wrapper

@x(9)
def index():
    pass
```

欠

- 元数据：flask 框架
- 多个装饰器：Flask 框架

```python

@x1
@x2
def func():
    pass
```

总结：

- 基本装饰器
- 带参数的装饰器

## 模块

### sys模块

python 解释器相关的数据。

- sys.argv	

  ```python
  # -*-  encoding:utf-8 -*-
  """
  删除文件的脚本
  让用户执行脚本传入要删除的路径，在内部帮助将木目录删除
  """
  import sys
  # 获取用户执行脚本时，传入的参数
  path = sys.argv[1]
  # ['D:/ggy/Desktop/Python/课堂练习/day13/模块传参.py']  在目录后面加删除文件名
  
  # 删除
  import shutil
  shutil.rmtree(path)
  ```

- sys.path 当前项目的执行路径，可以添加才保住模块运行

### os模块

和操作系统相关的数据

- os.path.exists(path)	如果 path 存在，返回 True，如果 path 不存在，返回 False

- os.stat("文件名").st_size  获取文件大小

- os.path.abspath()   获取绝对路径

- os.path.join   路径拼接

- os.path.dirname()   获取上级目录

  ```python
  v1 = r"D:\ggy\Desktop\Python\课堂练习\day13\模块传参.py"
  os.path.dirname(v1)
  ```

  - 补充：
    - 转义：r  就是\

- os.listdir()

  ```python
  import os
  
  result = os.listdir(r'D:\ggy\Desktop\Python\课堂练习\day13')
  print(result)
  # 只有当前目录下的所有文件
  ```

- os.walk()

  ```python
  import os 
  result = os.walk(r'D:\ggy\Desktop\Python\课堂练习\day13')
  for a,b,c in reult:
     print(a,b,c)
  """
      for item in c:
          path = os.path.join(a,item)
          print(path)
      break
  """
  ```

- shutil

  ```python
  # 删除
  import shutil
  shutil.rmtree(path)
  ```

  sys.exit()

py2:

- xrange ,不会在内存中立即创建，而是在循环时。边循环边创建
- range ，在内存立即把所有的值都创建

py3:

- range, 不会在内存中立即创建，而是在循环时。边循环边创建
- list(range) ,

- 内置模块，python内部提供的功能

- 第三方模块，下载 / 安装 / 使用。

  ```shell
  python3 -m pip install xlrd
  ```

  同时存在两个python版本就用这个方法，记得添加环境变量

- 自定义模块

  ```python
  # 创建 xxx.py 文件
  def f1():
      pass
  def f2():
      pass
  
  # x1.py
  import xxx
  xxx.f1()
  xxx.f2()
  ```

### 内置模块

- os.makedir , 创建目录
- os.makedirs , 创建目录和子目录
- sys.path , 默认python 去导入模块时，会按照 sys.path 的路径找模块

## json模块

json 是一个特殊的字符串。【长的像列表 / 字典 / 字符串 / 数字 / 真假】set 不支持和 tuple转换为 list

转换成 json 叫序列化，反过来叫 反序列化

```python
import json
# 序列化，将python的值转化为json格式的字符串。
v1 = json.dumps(v)
print(v1)

# 反序列化，将json格式的字符串转换成python的数据类型
v2 = '["alex",123]'
print(type(v2))
v3 = json.loads(v2)
print(v3,type(v3))
```



- 模块基础知识
- time / datetime
- json / picle
- shutil
- logging
- 其他

模块（类库）

- 内置模块

- 第三方
  - json / time       /os/sys

- 自定义

模块可以是 py 文件也可以是文件夹

py2中必须写 `_ _int_ _.py` 文件就是包，py3可以没有，最好加上

定义模块可以把文件或者一个文件夹（包）当做一个文件夹，方便以后其他使用

导入模块先加载模块并执行

```python
# 第一种加载
import yous
yous.func()
# 第二种
from ss import func,show
#第三种
from sjj import func as f
f()
#第四种
from li import *
```

导入包

```python
# 第一种
import ll.js
ll.jd.f1()
# 第二种
from li import jd
jd.f1()
from li.jd import f1
f1()

```

总结

模块和要执行的同一文件 且 需要 模块中的很多功能时，，推荐同：import 模块

其他推荐： from 模块 import 模块   模块。函数（0

其他推荐： from 模块。模块 import 函数 函数（）



json

- 字典或者列表中有中文，序列化时想要保留中文显示
- dumps(,ensure_ascii=False) 
- dump（写入文件，文件操作）
- loads   读到文件
- 优点：所有语言统一缺点：只能序列化基本数据类型
- 不加s 文件操作

pickle  序列化

- 优点：python中所有东西都能被她序列化（socket对象）：
- 缺点：序列化内容只有python认识

shutil 模块

- 删除

- 重命名

time 模块

- time.time()

datetime模块

异常处理

```python
try:
    val = input('请输入数字：')
    print(int(val))
except Exception as e:
    print("输入错误！")
```

## 迭代器

自己不会写只会用。

迭代器，帮助你对某种对象中的元素进行逐一获取

迭代器内部都有一个 next 方法 ，用以一个个获取数据。

## 生成器

```python
def func(arg):
    arg = arg+1
    yield 1
    yield from base()
    yield 2
    yield 100
    
# 函数内部不会执行，返回一个  生成器对象
v1 = func(2000)

# 生成器可以被循环，，一旦开始循环，函数内部开始执行
for item in v1:
    print(item)
```

生成器推导式

```python
v2 = (i for i in range(10))  # 生成器推导式，创建了一个生成器，内部循环执行。

# 面试题：请比较 [i for i in range(10)] 和 (i for in range(10))区别？
# 一个生成器，一个推导式
```



## 装饰器

相对导入,层级越深，丶越多

```python
from .. import utils
from . import utils
```

主文件

```python
__name__
```

## 面向对象

```python
class Bug:
    def func(self):
        pass
# 定义一个类
class Fss:
    # 方法
    def cun(self):
        pass
# 创建对象调用类的方法
x = Bug()
x.func()
```

初始化方法，构造方法



## 继承

```python
# 父类(基类)
class Base:
    def f1(self):
        pass
# 子类(派生类)    
class Foo(Base):
    def f2(self):
        pass
    
# 创建了一个子类的对象    
obj = Foo()
# 执行对象 . 方法时，优先在自己的类中找，如果没有就是父类中找。
obj.f2()
obj.f1()

# 创建了一个父类的对象
obj = Base()
obj.f1()

```

什么时候用到继承？

多个类中有公共方法时，可以继承

```python
class Base
	def f1(self):
        pass

class Foo(Base):
    def f2(self):
        pass

class Bar(Base):
    def f3(self):
        pass
    
obj1 = Foo()

obj2 = Bar()
```

继承关系中的查找顺序：
注意

- self 是谁？self 参数时python帮助我们自动传递
- self  是哪个类创建的，就从此类开始找，自己没有找父类

多继承

## 多态（多种类型/多种形态）鸭子模型

```python

```

什么是鸭子模型，传参时无须指定模型

```python
对于一个函数而言
```

## 成员

变量（字段）变量修饰符

```python
# -*-  encoding:utf-8 -*-
"""
    1.类的成员
"""
class Foo:
    # 类变量/（静态字段）
    country = "中国"

    # 方法
    def __init__(self,name):
        self.name = name    # 实例变量/字段

    # 方法
    def func(self0):
        pass
# 类的实例  类的对象
obj = Foo()
obj.func()
# 通过类来修改静态字段，其他不能修改
Foo.country = "美国"
# 访问时，最好用类方法，不行则用对象
print(obj.country)
print(Foo.country)
# 什么时候用类变量
# 当所有对象有共同字段时，且更改都要删除时，可以 实例变量（字段）提取到 类变量（静态字段）

# -*-  encoding:utf-8 -*-
#
# class Foo:
#     def __int__(self,name):
#         self.__name = name
#         self.age = 123
#
#     def func(self):
#         print(self.__name)
#
# obj = Foo()
# print(obj.age)
# obj.func()

class Base:
    def __init__(self,name):
        self.name = name

    def cunc(self):
        print(self.name)
obj = Base('sss')
obj.cunc()
```

方法	方法修饰符

```python
# -*-  encoding:utf-8 -*-
#
# class Foo(object):
#     def __int__(self,name):
#         self.name = name
#
#     # 实例方法
#     def func(self):
#         print(self.name)
#
#     #静态方法 , 方法无须使用对象封装的值，则为静态方法
#     @staticmethod
#     def display():
#         print('6566')

# 类方法

class Foo(object):
    def __init__(self,name):
        self.name = name

    # 实例方法
    def func(self):
        print(self.name)

    #静态方法 , 方法无须使用对象封装的值，则为静态方法
    @staticmethod
    def display():
        print('6566')

    # 类方法当前类
    @classmethod
    def show(cls,x1,x2):
        print('999')

    def __dss(self):
        print('sd')

    @property #属性 ,调用时无须加括号
    def end(self):
        return 0

Foo.show(1,2)
print(Foo.show(1,23))
obj = Foo('sd')
```

面试题：静态方法/类方法和实例方法的区别？

从创建方式：

静态方法需要加@staticmethod，类方法则添加@classmethod，实例方法无须

从调用角度：

实例方法需要创建对象来调用，静态方法和类方法则需要类来调用

从应用场景来说;

如果在方法内部不会用到对象数据时，则可以设置称为静态方法或者类方法

如果你在方法中用到当前类，则设置成为的类方法

## 嵌套 / 组合（建模）

```python
"""
创建三个学校且三个学校的设施内容等都是一致.
"""
class School(object):
    def __init__(self, name, address):
        self.name = name
        self.address = address

    def speech(self):
        print('讲课')
        
obj1 = School('老男孩北京校区', '美丽富饶的沙河')
obj2 = School('老男孩上海校区', '浦东新区')
obj3 = School('老男孩深圳校区', '南山区')
class Teacher(object):
    def __init__(self, name, age, salary):
        self.name = name
        self.age = age
        self.__salary = salary
        self.school = None

t1 = Teacher('李杰', 19, 188888)
t2 = Teacher('艳涛', 18, 60)
t3 = Teacher('女神',16, 900000)
# ############## 老师分配校区
t1.school = obj1
t2.school = obj1
t3.school = obj2
# ####################################
# 查看t1老师,所在的校区名称/地址
print(t1.school.name)
print(t1.school.address)
print(t1.name)
print(t1.age)
t1.school.speech()
```

组合补充

## 主动调用其他类的成员

```python
# 方式一

# 方式二 按照类的顺序，找下一个
class Base(object):
    
    def f1(self):
        print('5各功能')

 class Foo(Base):
    def f1(seld):
        print('sss')
        super().f1() # 按照当前类的继承顺序，来执行顺序，
       
```



## 特殊成员（这是语法）

- `__init__`初始化的，不是构造方法
- 对象（）自动执行 `__call__`
- 对象【】自动执行 `__getitem__`
- 对象【‘ss’】= 11 自动执行 `__setitme__`  无返回值
- del  对象【xx】  自动执行  `__delitem`   无返回值
- 对象 + 对象  自动执行 `__add__`  
- with 对象  自动执行 进来 `__enter__` 返回值   出去 `__exit__`  
- 真正的构造方法  `__new__`  在 init 之前先执行，创建一个空的对象，为对象初始化
- 把封装的值以字典形式显示   `__dict__`
- 迭代器



## isinstance / issubclass / type



## 区分方法和函数

内：方法

外：函数

## 反射

handler（）判断对象是否存在于模块中

getattr（模块，函数）根据字符串为参数，去模块 / 类 / 对象（一切皆对象） 中寻找与之同名的成员

## 其他

## 约束

类的约束

```python
def func(arg):
    """
   	报警通知的功能
   	"""
    arg.send()
```

抽象类和抽象方法

```python
form abc import ABCMeta,abstractmethod
class Base(metaclass=ABCMeta)

@abstractmethod
抽象方法
```

什么是接口以及作用？

接口是一种数据类型，主要约束派生类中必须实现指定的方法

python 中不存在，Java和c#中有

约束方法

- 抽象类和抽象方法，编写上麻烦
- 人为主动抛出异常

约束时，抛出异常是否可以用其他的

不专业：

raise  Exception()

专业：

raise NotImplementedErrod()

应用场景：

多个类，内部必须有某些方法，需要使用基类 + 异常进行处理

## 自定义异常

## logging

## osi 7层模型

网络之间的数据传输，

7层模型

- 应用层   使用软件
- 表示层    看到数据，如视频。图片
- 会话层    保持登陆或者链接状态
- 传输层   TCP/UDP
- 网络层  IP
- 数据链路层    MAC
- 物理层  将数据转换成电信号

5层模型

- 应用层    
  - 应用层
  - 表示层
  - 会话层
- 传输层
- 网路层
- 数据链路层
- 物理层

4层模型

- 应用层
  - 应用层
  - 表示层
  - 会话层
- 传输层
- 网络层
- 物理层
  - 数据链路层
  - 物理层

#### TCP 三次握手四次挥手

 socket 客户端向入伍端发送请求时：三次握手

客户端和服务端断开连接：四次挥手



## 并发和并行

并发，伪  由于执行速度特别快，人感觉不到停顿

并行，真    创建10个人同时擦欧总

## 线程。进程

单进程，单线程的应用程序

python调用系统的多线程和多继承

python中只能创建单进程和单线程

多线程在一个进程执行时会分时执行

### GIL锁

```python
import time
import threading

lock = threading.RLock()

n = 10

def func(i):
    print('这段代码不加锁',i)

    lock.acquire()
    global n
    print('当前线程',i,'读取到的 n 值：',n)
    n = i
    time.sleep(1)
    print('当前线程',i,'修改 n 值为：',n)
    lock.release()

for i in range(10):
    t = threading.Thread(target=func,args=(i,))
    t.start()
```



### python 线程编写

主线程默认等子线程

为什么创建线程

​	由于线程时 cpu 工作的最小单元，创建线程可以利用多核优势实现并行操作

为什么创建进程？

​	进程与进程之间做数据隔离（Java/c#）

io 请求不占用 cpu

#### 线程池（py3 独有）

### 线程安全

​	线程安全，多线程操作时，内部会让所有线程拍碎处理

​	线程不安全 + 人 =>  排队处理

## 进程

数据共享

锁

进程池

爬虫实例（模块）

	- requests
	- bs4（beautifulsoup）

进程锁

当用到同一个数据时，要加锁，数据共享

与线程锁一样操作

进程池  py3 中

### 初识爬虫

pip install requests

pip install beautifulsoup4

优先使用线程好

## IO多路复用

基于IO复用 + socket 实现并发请求

作用：检测多个 socket 是否已经发生变化（是否已经连接成功 / 是否已经获取数据）（可读 / 可写）

基于 IO 多路复用 + socket 实现并发请求（一个线程100个请求）

​	IO  多路复用

socket 非阻塞 

基于事件循环实现的异步非阻塞框架

已经实现的模块：Twisted   爬虫时

##### 作用

​	检测多个 socket 是否发生变化

​		系统中有 select（1024个socket ，循环去检测）   、 poll（不限制个数、循环检测（水平触发）） 、epoll（不限制，回调方式（边缘触发））、三种模式

python 模块：

​	select.select 

​	select.epoll   

#### 提高并发方案

- 多线程
- 多进程
- 异步非阻塞模块（Twisted） scrapy 框架 （单线程完成并发）

## 协程

协程，操作系统中不存在的东西，由程序员创造出来的

可以认为：微线程，对一个线程进行分片，使得线程在代码块之间进行来回切换执行，而不是在原来逐行执行。

安装一个模块:

```shell
pip instanll greenlet
```

单纯的协程无用

#### 协程的存在

协程 + IO操作

安装 gevent  内部依赖 greenlet 加 IO 切换

```shell
pip install gevent 
```

协程可以提高并发吗？

​	协程自己本身无法实现并发（甚至性能会降低）

​	协程 + IO切换性能提高

面试必备：

进程，线程，协程的区别？

列表生成式 也式一种生成器

### asyncio 模块

创建协程函数使用asyncio.coroutine 装饰器

- tensorflow机器学习

三种异步方式

多线程

多进程

协程

异步不一定就是多线程和多进程

python -m http.server

### 单例模式

生成单例模式

singleton  pattern 软件设计模式

一个类只有一个实例对象

实现单例模式的方式：

- 使用模块
- 使用 `__new__`
- 使用装饰器（decorator）
- 使用元类（metaclass）

```python
class Singleton(object):
    _instance = None
    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(Singleton, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    
class MyClass(Singleton):
    a = 1
    
```

