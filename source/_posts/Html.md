---
title: html 基本了解
tags: 笔记
categories:
- IT技术
- 前端
- HTML
abbrlink: 1490421584
description: 初步了解 html 语法，编写静态页面
date: 2019-06-10 00:00:00
updated: 2019-06-10 00:00:00
---

# HTML

## HTML初识

### HTML骨架格式

```html
<html>
    <head>#头部
        <title>眼睛</title>
    </head>
    <body>
    主题内容
    </body>
</html>
```

### HTML标签分类

双标签：例如 `<html></html>`

```html
<标签名>内容</标签名>
```

单标签：例如 `<br/>`

```html
<标签/>
```

### HTML标签关系

嵌套关系

并列关系

## 文档类型<!DOCTYPE>

<!DOCTYPE>声名文档类型：例如 xhtml 或者 html ，不过现在统一使用 html。

## 字符集

<meta charset="UTF-8" />
utf-8是目前最常用的字符编码格式

gb23121 简单中文 包括6763个汉字

BIG5 繁体中文 港澳台等用

GBK 包涵全部中文字符，是GB2312的扩展

## 标签语义化

主要是方便代码阅读、便于维护。

遵循原则：先确定语义的HTML，在选合适的css。

## HTML常用标签

### 排版标签

#### 标题标签

<head>  <title> </title>
    <h1></h1>等等

#### 段落标签

p

#### 水平线标签

hr

#### 换行标签

br

#### div、span 标签

div  span

### 标签的属性

```html
<hr width="223" />
```

### 图像标签

```html
<img src="url" />
```

### 连接标签

#### 锚点定位

```html
使用“a href=“#id名”
<a href="#teo"></a>
<h3 id="teo"></h3>
```

#### base标签

base 可以设置整体连接的打开状态

base 写到 <head>  </head> 之间

把所有的连接都默认添加 target="_blank"

### 特殊字符



### 注释标签

```html
<!---- 注释语句 ---->
```

### 路径

#### 相对路径

#### 绝对路径

## 列表标签

### 无序标签 ul 

```html
<ul>
	<li></li>
</ul>
```

就是没有数字排序

### 有序标签 ol

```html
<ol>
    <li></li>
</ol>
```

数字排序 1.2.3.

### 自定义标签

```html
<dl>
    <dt></dt>
</dl>
```

## 表格 table 

### 创建表格

```html
<table>
    <tr>
    	<td>单元格的文字</td>
    ....
    </tr>
    ...
</table>
```

注意：

tr 中只能套用 td

### 表格的属性



### 表头标签

```html
<th>
	<td></td>
</th>
```

### 表格结构

```html
<thead></thead>表头
<tbody></tbody>表格主体
```

### 表格标题

caption

```html
<table>
    <caption>表格标题</caption>
</table>
```

### 合并单元格

跨行合并：rowspan  跨列合并：colspan

## 表单标签

### input 控件



### label标签

label 标签为 input 元素定义标注（标签）

作用：用于绑定一个表单元素，当点击label标签的时候，会自动定位到当前表单

```html
<label for="male">Male</label>
<input type="radio" name="sex" id="male" value="male"/>
```

### textarea 控件

```html
<textarea cols="每行中的字符数" row="显示行数"></textarea>
```

### 下拉菜单

使用 select 控件定义下拉菜单的基本语法：

```html
<select>
    <option>选项1</option>
    <option>选项2</option>
</select>
```

注意：

1. &lt;select&gt;</select&gt;中至少应包含一对&lt;option></option&gt;。
2. 在option 中定义selected =" selected "时，当前项即为默认选中项。

### 表单域（from）

from标签

```html
<from action="url地址" method="提交方式" name="表单名称"></from>
```

常用属性：

1. Action
   在表单收集到信息后，需要将信息传递给服务器进行处理，action属性用于指定接收并处理表单数据的服务器程序的url地址。
2. method
   用于设置表单数据的提交方式，其取值为get或post。
3. name
   用于指定表单的名称，以区分同一个页面中的多个表单。

注意：  每个表单都应该有自己表单域。

## 位运算

```javascript
var num1 = 10;
var num2 = 20;
num1 = num1 ^ num2;
num2 = num1 ^ num2;
num2 = num1 ^ num2;
```

