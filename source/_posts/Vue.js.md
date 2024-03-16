---
title: Vue 初识
tags: 笔记
categories:
- IT技术
- 前端
- Vue
abbrlink: 3095576720
description: vue 初识了解
date: 2019-06-23 00:00:00
---

# Vue.js

## 单页面应用程序

> Single Page Application
>
> 简称 SPA

### 网站交互方式

- 经典的多页面
  - 前后端糅合在一起，开发效率低
  - 用户体验一般，点击刷新跳转，等待时间过长
  - 每个页面都要重新加载
  - 有利于 SEO 搜索引擎搜索（蜘蛛会爬链接）
- 现代式的单页面
  - 开发方式好： 前后端分离
    - 服务端不关心页面，只关心数据
    - 客户端不关心数据库及操作，只关心通过接口拿数据和服务端交互，处理页面
  - 用户体验好，像客户端
  - 只需要加载渲染局部视图
  - 单页面应用开发技术复杂，所以有很多框架
    - AngularJS
    - ReactJs
    - VueJS
  - 单页面技术很成熟了，无法兼容低版本浏览器
  - 现在除了电商网站，其实已经很少需要兼容了
  - 大部分IE9以上
  - 单页面由于数据异步加载，所以不利于 SEO 搜索
  - 手机 Web 网页
  - 管理系统

### 多页面：以服务端为主导，前后端混合

- PHP案列，`.php`文件

### 单页面：前后端分离，各司其职

- 服务端只处理数据
- 前端只处理页面

### 模拟前后端分离模式



- 项目立项
- 需求分析
- 服务端的工作
  - 需求设计
  - 设计数据库
  - 接口设计（有时候也需要前端参与其中）
  - 接口（处理数据）开发
- 前端的工作
  - 需求分析
  - 写页面
  - 页面写好写功能
  - 通过接口和服务端进行交互

#### 前后端分离：多页



#### 前后端分离：单页

### 安装 http Server

```shell
npm install http-server -g 
//启动本地点击cmd
hs -c-1 -o   
//改端口号
http-server -p 8001
```

## 前端三大开发框架

> 单页开发其实比较复杂的，需要有一定的技术职称
>
> 所有有了我们现在需要学习的三大框架

- Angular
  - 09年诞生
  - Google
  - 目的：开发单页面更方便
  - 最主要是带来 MVVM 开发模式
  - MVVM 一句话：数据驱动视图，不操作DOM
- React
  - Facebook 公司自己也开发了一个 Web 框架
  - 组件化
- Vue
  - Vue 作者：尤雨溪
  - 早期有个人开发
  - Vue 借鉴了angular 和 react 之长，自己做了一个，后起之秀



## Vue.js介绍

vue.js只处理界面，跟服务端没关系

### Vue 特点

Vue核心特点：

— MVVM

—双向数据绑定

—组件化

—渐进式

### MVVM

### 创建实例

```javascript
<!-- 
		0. npm install vue
		1. 引包
		2. new Vue 得到 Vue 实例
			vue 这哪是可以理解为一个高级的模板引擎
	 -->
	 <script src="node_modules/vue/dist/vue.js"></script>
	 <script>
	 	//得到 Vue 实例
	 	const app = new Vue({
	 		el: '#app',// el 选项的作用就是管理模板的入口节点
	 		data: {// data 中数据叫做响应式数据，数据驱动视图
	 			message: 'hello Vue.js!'
	 		}.$mount('#app')//这种方式有明显的动作意图
	 	})
	 </script>
```



## TodoMVC项目

### browser-sync官网

https://www.browsersync.io/

### 安装browsersync

全局安装

```shell
npm install -g browser-sync
```

只在文件下安装

```shell
npm install --save-dev browser-sync
#或者
npm i -D browser-sync
```

### 配置browser-sync

```json
 "scripts":{
  	"dev":"browser-sync start --server --files \"*.html,css/*.css,js/*.js\"",
  	"start":"npm run dev"
  },
```

切记不能输错 server 和 files 否则不会启动服务本地文件，还有上面是监听 html 和 css js 文件

### 启动服务

```shell
npm run dev
#或者
npm start
```



## 组件化

将网页分成每个界面（组件）



下载 vue-cli工具

```shell
npm i -g vue-cli
npm install -g @vue/cli 安装使用

创建项目..到你的文件目录下创建文件
vue create hell-world
```

只会渲染第一个标签内容

v-bind:href == :href

v-on:click == @click

watch 与 computed

watch 监听一个变量

computed 监听的是一个实例



条件渲染

- v-if
- v-else,v-esle-if
- v-show



## Vue-cli工具

下载安装

```shell
npm install -g @vue/cli
```

创建项目（到项目目录的上一级）

```shell
vue create 项目名称（例如：hell-world）
```

Vue的全家桶 vue + vue-router + vuex

vue + vue-router 主要做SPA（）单页面应用

vue-router 是vue的核心插件

为什么使用单页面应用？

传统的路由跳转，如果后端资源过多，会导致页面出现白屏现象，让前端来做路由，在某个生命周期的钩子函数中发送ajax，数据驱动。

