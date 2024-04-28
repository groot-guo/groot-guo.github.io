---
title: node js 基础
tags: 笔记
categories: Node Js
abbrlink: 4fc23aae
date: 2019-09-10 00:00:00
updated: 2019-09-10 00:00:00
---

## node.js	

- ### node.js
  
  - Node.js不是一门语言
  - Node.js不是库、不是框架
  - Node.js是一个JavaScript运行时的环境
  - Node.js可以解析和执行JavaScript代码
- 浏览器中的JavaScript
  - EcmaScript
    - 基本的语法
    - if
    - var
    - function
    - Object
    - Array
  - BOM
  - DOM
- Node.js中的JavaScript
  - **没有BOM、DOM**
  - EcmaScript
  - 在Node这个JavaScript执行环境中为JavaScript提供了一些服务器级别的API
    - 例如文件读写
    - 网络服务构建

<!-- more -->

### 读取文件

```javascript
//浏览器中的JavaScript是没有文件操作的能力
//但是Node中的JavaScript具有文件操作的能力

//fs是file-system的简写，就是文件系统的意思
//在Node中如果想要进行文件操作，就必须引入fs这个核心 模块
//在fs这个核心模块中，就提供了所有的文件操作相关的API
//例如：fs。readFile就是用来读取文件的
//

//1.使用核心模块require方法加载fs核心模块
var fs = require('fs')

//2.读取文件
//	第一个参数就是要读取的文件路径
//	第二个参数就是一个回调函数
//			
//			成功
//				data  数据
//				error null
//			失败
//			 	data null
//			 	error 错误对象
//
fs.readFile('data/hello.txt',function(error,data){
	//body...
	//<Buffer 68 65 6c 6c 6f>
	//文件读取的都是二进制数据
	//这里看不到 0 和 1 ？原因是二进制转为16进制
	//所以通过toString方法调用
	console.log(data.toString())
})
```

### 写入文件

```javascript
var fs = require('fs')
//	第一个参数：文件路径
//	第二个参数：文件内容
//	第三个参数：回调函数
//		
//		error
//		
//		成功：
//			文件写入成功
//			error 是 null
//		失败：
//			文件写入失败
//			error 就是错误对象
//
//
fs.writeFile('./data/你好.md','大家好，给大家介绍一下，我是node.js',function(error){
	console.log("ok");
})
```

### 简单http服务

```javascript
//构建web服务器
//在node中专门提供一个核心模块：http
//http这个模块职责编写服务器

//1.加载http核心模块
var http= require('http')

//2.使用http.createServer（）方法创建一个文本服务器
//返回一个Server实例
var server= http.createServer()

//3.服务器能干嘛
//	提供服务：对数据的服务
//	发请求
//	接受请求
//	处理请求
//	给个反馈（发送响应）
//	注册 request 请求事件
//	当客户端请求过来，就会自动触发服务器的 request 请求事件，然后执行第二个参数：回调处理 

//request 请求事件处理函数，需要接受两个参数：
//	request 请求对象
//		请求对象可以用来获取客户端的一些请求信息，例如请求路径
//	response 响应对象
//		响应对象可以用来给客户端发送响应信息
//
//

server.on('request',function(request,response){
	//http://127.0.0.1:3000/
	//http://127.0.0.1:3000/aa
	//http://127.0.0.1:3000/12
	//http://127.0.0.1:3000/
	//
	console.log('收到客户端的请求了,请求路径是：' + request.url)
	//response 对象有一个方法：write可以用来给客户端发送响应数据
	//write s可以使用很多次，但是最后一定要使用end结束响应，否则客户端一直等待
	//
	//var url =requset.url  这样比较方便
	if(request.url=='/'){
		response.write('hello')
		response.write(' node.js')
	}else if(request.url=='/login'){
		response.write("登录")
	}else {
		response.write('404')
	}
	//返回值只能是二进制或者字符串，不能是对象。。。
	//JSON,stringify()方法可以返回json数据字符串
	response.end()
})
//4.绑定端口号，启动服务器
server.listen(3000,function(){
	console.log('服务器启动成功了，可以通过http//127.0.0.1:3000/')
})

```

## Node中的JavaScript

- ​	EcmaScript
- 核心模块
- 第三方模块
- 用户自定义模块

### 核心模块

​	Node为了JavaScript提供了很多服务器级别的API，这些API绝大多数都被包装到了一个具体的核心模块。例如`fs`核心模块，http服务构建模块`require`，`path`路径 

```javascript
var fs = require('fs')
var http = require('http')
```

### 模块系统

```javascript
//require 方法有两个作用
//  1、加载文件并执行里面代码
//	2、拿到被加载文件模块导出的接口对象
//	
//	a.js中
var bExports = require('./b')
console.log(foo)
//b.js中
var foo = 'boo'//这不能被其他js调用，文件域变量
export.foo = 'hello'//只有这个方法才能调用
export.add = function(){
    return x+y
}
```

ip地址和端口号的概念



### path路径操作模块

```shell
> path.basename('c:/a/b/c/index.js')
'index.js'
> path.basename('c:/a/b/c/index.js','js')
'index.'
> path.basename('c:/a/b/c/index.js','.js')
'index'
> path.basename('c:/a/b/c/index.js','.html')
'index.js'
> path.dirname('c:/a/b/c/index/js')
'c:/a/b/c/index'
> path.dirname('c:/a/b/c/index.js')
'c:/a/b/c'
> path.extname('c:/a/b/c/index.js')
'.js'
> path.isAbsolute('c:/a/b/c/index.js')
true
> path.isAbsolute('./a/b/c/index.js')
false
> path.isAbsolute('/a/b/c/index.js')
true
> path.parse('/a/b/c/index.js')
{ root: '/',
  dir: '/a/b/c',
  base: 'index.js',
  ext: '.js',
  name: 'index' }
> path.parse('c:/a/b/c/index.js')
{ root: 'c:/',
  dir: 'c:/a/b/c',
  base: 'index.js',
  ext: '.js',
  name: 'index' }
> path.join('c:/a','b')
'c:\\a\\b'
> var str = 'c:a/' + '/b'
undefined
> var str = 'c:a/' + '/b'
undefined
> str
'c:a//b'
> var str = 'c:a' + 'b'
undefined
> str
'c:ab'
> path.join('c:/a','b','c','d')//拼接路径
'c:\\a\\b\\c\\d'
```

- path.dirname
  - 获取一个路径中的目录部分
- pathn.extname
  - 获取一个路径中的扩展名部分
- path.parse
  - 把一个路径转换为一个对象
    - root 根路径
    - dir目录
    - base 包涵后缀名的文件名
    - ext后缀名
    - name 不包含后缀名的文件名
- path.join
  - 当你需要进行路径拼接的时候，使用他
- path.isAbsolute
  - 判断一个路径的是否为绝对路径

### node中的其他成员

在每个模块中，除了`require`、`exports`等模块相关API职位，还有两个特殊的成员，

- `_dirname`**动态获取**可以用来获取当前文件模块所属目录的绝对路径
- `_filename`**动态获取**可以用来获取当前文件的绝对路径

```javascript
//./a.txt 相对于当前文件路径
//./a.txt 相对于执行 node 命令所处的终端路径
//这不是错误，就是这样设计
//文件操作路径中，相对路径就是执行 node 所处的终端路径
```

在文件操作中，使用相对路径是不可靠的，不是bug

相对路径变为绝对路径用`path.join()`拼接

模块中的路径标识和文件操作相对于当前文件模块，不受执行影响

### 服务器读取资源

```javascript
//加载fs模块读取文件，写入文件
var fs = require('fs')

var server = http.createServer()

server.on('request',function(req,res){

	var url = req.url
	if(url == '/'){
		fs.readFile('./index.html',function(err,data){
			if(err){
				res.setHeader('Content-Type','text/plain;charset=utf-8')

				res.end('文件读取失败')
			}else{
				res.setHeader('Content-Type','text/html;charset=utf-8')
				res.end(data)
			}
		})
	}
})
server.listen(3000,function(){
	console.log('Server on ........')
})
```

不同资源对应不用的Content-Type需要配置

### 代码风格

​	注意`；`无论采用是否有这种风格，都在前面加`;`

有些人也使用！~等符号

​	es6中支持一种字符串包裹方式，叫做：模板字符串

`var foo = 'bar' ` 支持换行与html5中`<pre>`相同

### 服务端渲染和客户端渲染

- 服务端渲染就服务就行渲染

  - 响应的是结果

- 客户端渲染

- 服务端与客户端区别

  - 客户端不利于SEO搜索引擎优化
  - 服务端渲染可以被爬虫抓取到的，客户端异步渲染

### web服务器开发

```javascript
var http = require('http')
var fs = require('fs')
//
var server = http.createServer()
//服务器启动
server.on('request',function(req,res){
	//创建路径对象
	var url = req.url
	if(url == '/'){
		fs.readFile('./index.html',function(err,data){
			if(err){
				res.setHeader('Content-Type','text/plain;charset=utf-8')
				res.end('文件读取失败')
			}else{
                //data默认是二进制数据，可以通过 .toString 转为字符串
                //res.end()支持两种数据类型，一种是二进制，一种是字符串
				res.setHeader('Content-Type','text/html;charset=utf-8')
				res.end(data)
			}
		})
	}
})

server.listen(3000,function(){
	console.log('Server on ........')
})
```



### apache目录渲染

```javascript
var http = require('http')
var fs = require('fs')
//
var wwwDir = 'D:/百里半'
//
var server = http.createServer()
//
server.on('request',function(req,res){
	var url = req.url
	fs.readFile('./template.html',function(err,data){
		if(err){
			return res.end('404 Not Found.')
		}
		//1. 如何得到wwwDri目录中的文件名
		//2.如何将得到的文件名和目录名替换到templat.html
		fs.readdir(wwwDir,function(err,files){
			if(err){
				return res.end('Can not find www dir.')
			}
			var content = ''
			files.forEach(function(item){
				//在ES6中的``字符串中，可以使用${}来引用变量
				content += `${item}`				
			})
			data = data.toString()
			data = data.replace('^_^',content)
			res.end(data)			
		})
	})
})
server.listen(3000,function(){
	console.log('Server on ......')
})
```

#### html渲染页面

```html
。。。。。。。
    <tbody id="tbody">
        <---!此处为模板引擎渲染方式---->
    {{ each files}}
    <tr>
      <td data-value = "apple"><a class="icon idr" href="D:/"></a>{{$value}}</td>
      <td class="detailsColum" data-value="0"></td>
      <td class="detailsColum" data-value="1509589967"><sss/td>
    </tr>
    {{/each}}
    </tbody>
 。。。。。。
```

### 处理表单get请求

```javascript
else if (pathname.indexOf('/public/') === 0) {
      // /public/css/main.css
      // /public/js/main.js
      // /public/lib/jquery.js
      // 统一处理：
      //    如果请求路径是以 /public/ 开头的，则我认为你要获取 public 中的某个资源
      //    所以我们就直接可以把请求路径当作文件路径来直接进行读取
      fs.readFile('.' + pathname, function (err, data) {
        if (err) {
          return res.end('404 Not Found.')
        }
        res.end(data)
      })
}else if (pathname === '/pinglun') {
      // 注意：这个时候无论 /pinglun?xxx 之后是什么，我都不用担心了，因为我的 pathname 是不包含 ? 之后的那个路径
      // 一次请求对应一次响应，响应结束这次请求也就结束了
      // res.end(JSON.stringify(parseObj.query))

      // 我们已经使用 url 模块的 parse 方法把请求路径中的查询字符串给解析成一个对象了
      // 所以接下来要做的就是：
      //    1. 获取表单提交的数据 parseObj.query
      //    2. 将当前时间日期添加到数据对象中，然后存储到数组中
      //    3. 让用户重定向跳转到首页 /
      //       当用户重新请求 / 的时候，我数组中的数据已经发生变化了，所以用户看到的页面也就变了
      var comment = parseObj.query
      comment.dateTime = '2017-11-2 17:11:22'
      comments.unshift(comment)
      // 服务端这个时候已经把数据存储好了，接下来就是让用户重新请求 / 首页，就可以看到最新的留言内容了

      // 如何通过服务器让客户端重定向？
      //    1. 状态码设置为 302 临时重定向
      //        statusCode
      //    2. 在响应头中通过 Location 告诉客户端往哪儿重定向
      //        setHeader
      // 如果客户端发现收到服务器的响应的状态码是 302 就会自动去响应头中找 Location ，然后对该地址发起新的请求
      // 所以你就能看到客户端自动跳转了
      res.statusCode = 302
      res.setHeader('Location', '/')
      res.end()
```



## require加载规则（模块作用域）

###  	加载node_modules

1. 先找到当前目录所在的 node_modules目录
2. node_modules/加载文件名的/package.json
3. 文件中main 对应的js文件
4. 如果没有package.json默认加载index.js

### CommonJS模块规范

模块系统

- 模块作用域
- 使用 require 方法加载模块
- 使用 exports 接口来导出模块中的成员

#### require 加载

两个作用：

- 执行被加载的代码
- 得到被加载模块中的`exports`导出接口对象

#### exports导出

对于可以被其他模块访问的成员，我们就需要公开都挂载到`exports`接口中

导出多个成员：

```javascript
exports.a = 123
exports.b = 'hello'
exports.c = function(){
    console.log('ccc')
}
exports.d = {
    foo:'bar'
}
```

导出单个成员

```javascript
module.exports = 'hello'
```

以后情况会覆盖：

```javascript

```



## package.json

我们建议一般每个项目都要有一个package.json文件。这个文件可以同过`nmp init`创建

##  npm

### npm官网

npmjs.com

### npm命令行工具

npm 的第二层含义就是命令行工具，只要安装node就安装了npm

升级npm

```shell
npm install --global npm
```

#### 常用命令

- npm init

  - npm init -y快速生成
  - 生成详细的package.json包括其他配置信息
- npm install
- npm install 包名

  - 只下载
- npm install --save 包名

  - 下载并且保存依赖项（package.json文件中的dependencies选项）
  
  - npm i -S包名
  
  - 在npm5.0.0以上均支持自动保存配置信息
  
  - 加--save是为了区分是否必须的依赖
  
  - npm install --production
  
    ```json
     "scripts":{
      	"start":"node main.js",
      	"dev":""
     },
    ```
  
    直接执行npm start或者 npm run start 或者npm run`其他命令`
- npm uninstall 包名

  - 只删除，如果有依赖项会依然保存
- npm uninstall --save 包名

  - 删除的同时也会把依赖信息也去除
  - npm un -S包名
- npm help

  - 查看使用帮助
- npm 命令 --help

  - 查看指定命令的使用帮助
  - 例如我忘记了uninstall命令的简写了，这个我可以输入这个

### npm被墙问题

安装淘宝的cnpm：

```shell
npm install --global cnpm
```

接下来你安装的会替换npm为cnpm

```shell
cnpm install jquery
```

mkdir cnpm-demo创建羡慕

rmdir cnpm-demo删除项目

```shell
 npm install jquery --registry=https://淘宝地址
```

只要写了下面的命令每次都是通过淘宝的服务器下载

```shell
npm config set registry https://registry.npm.taobao.org
#查看 npm配置信息 
npm config list
```

##  Express

### 起步

```shell
npm init --yse
npm i -S express
```

安装nodemon自动重启

```shell
npm install --global nodemon
```

### 基本路由

get

```javascript
//
app.get('/',function(){})
```

post 

```javascript
//
app.post('/',function(){})
```

在Express中配置`art-tempalte`模板

```shell
npm install --save art-tempalte
npm install --save express-art-tempalte
```

配置

```=
app.engine('art',require('express-art-template'))
```

如果更改渲染路径

```javascript
//不能写错views
app.set('views',目录路径)
```

 在express获取表单post请求数据

`body-parser`

```shell
npm isntall --save body-parser
```

配置

```javascript

```

在输入JSON数据中配置db.json时注意

```json
{
	"students":[
		{"id":1,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":2,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":3,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":4,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":5,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":6,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"},
		{"id":7,"name":"张三","gender":0,"age":18,"hobbies":"吃饭、睡觉、"}`,`//不能加逗号
	]
}
```

#### 路由设计

| 请求方法 | 请求路径         | get参数 | post参数                       | 备注             |
| -------- | ---------------- | ------- | ------------------------------ | ---------------- |
| GET      | /studens         |         |                                | 渲染首页         |
| GET      | /students/new    |         |                                | 渲染添加学生页面 |
| POST     | /studens/new     |         | name、age、gender、hobbies     | 处理添加学生页面 |
| GET      | /students/edit   | id      |                                | 渲染编辑页面     |
| POST     | /studens/edit    |         | id、name、age、gender、hobbies | 处理编辑请求     |
| GET      | /students/delete | id      |                                | 处理删除请求     |

## MongoDB

### 关系型数据库和非关系型数据库

表就是关系

- 所有的关系型数据库都需要`sql`语句操作

- 所有的关系型数据库都需要设计表结构

- 而且数据表还支持约束

  - 唯一的
  - 主键
  - 默认值
  - 非空

- 非关系型数据库非常灵活

- 有的非关系型数据库就是key-value对儿

- 在MongoDB是长的最像关系型数据库的非关系型数据库

  - 数据库->数据库
  - 数据表->集合（数组）
  - 表记录->（文档对象）

- MongoDB不需要设计表结构

- 也就是你可以任意的往里面存数据

  第三方包：`mongoose`基于MongoDB官方的`mongodb`包再一次做了封装

## express—session

安装

```shell
npm install express-session
```

配置

```javascript
// 在 Express 这个框架中，默认不支持 Session 和 Cookie
// 但是我们可以使用第三方中间件：express-session 来解决
// 1. npm install express-session
// 2. 配置 (一定要在 app.use(router) 之前)
// 3. 使用
//    当把这个插件配置好之后，我们就可以通过 req.session 来发访问和设置 Session 成员了
//    添加 Session 数据：req.session.foo = 'bar'
//    访问 Session 数据：req.session.foo

app.use(session({
  // 配置加密字符串，它会在原有加密基础之上和这个字符串拼起来去加密
  // 目的是为了增加安全性，防止客户端恶意伪造
  secret: 'itcast',
  resave: false,
  saveUninitialized: false // 无论你是否使用 Session ，我都默认直接给你分配一把钥匙
}))
```

使用:

```JavaScript
//添加 Session 数据
req.session.foo = 'bar'
//获取 Session 数据
req.session.foo
```

提示：默认Session 数据时内存存储的，服务器一旦重启就会丢失，真正的生产环境会把 Session 数据持久化。

## NVM管理node版本

下载地址

https://github.com/coreybutler/nvm-windows/releases

查看版本

```shell
nvm -v
```

查看node版本

```shell
nvm ls
```



