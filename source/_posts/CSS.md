---
title: CSS 了解
tags: 笔记
categories:
- IT技术
- 前端
- css
abbrlink: 3744767357
description: css 样式了解，初步认识
date: 2019-07-02 00:00:00
---



# CSS

## 引入CSS样式表

### 内部样式表

内嵌式式在HTML内部书写放在<head>中

```html
<head>
    <style type="text/css">
        .div{
            
        }
    </style>
</head>
```

### 行内式（内联样式）

内样式，行间样式，内嵌样式。

```html
<标签名 style="属性：属性值">内容</标签名>
```

### 外部样式表（外链式）

```html
<head>
    <link href="css文件路径" rel="stylesheet" />
</head>
```

href：定义所链接外部样式表文件的URL，可以是相对路径，也可以是绝对路径。
type：定义所链接文档的类型，在这里需要指定为“text/CSS”，表示链接的外部文件为CSS样式表。
rel：定义当前文档与被链接文档之间的关系，在这里需要指定为“stylesheet”，表示被链接的文档是一个样式表文件。

## 三种样式表总结（位置）

| 样式表     | 优点                     | 缺点                     | 使用情况       | 控制范围           |
| ---------- | ------------------------ | ------------------------ | -------------- | ------------------ |
| 行内样式表 | 书写方便，权重高         | 没有实现样式和结构相分离 | 较少           | 控制一个标签（少） |
| 内部样式表 | 部分结构和样式相分离     | 没有彻底分离             | 较多           | 控制一个页面（中） |
| 外部样式表 | 完全实现结构和样式相分离 | 需要引入                 | 最多，强烈推荐 | 控制整个站点（多） |

# CSS样式规则

使用HTML时，需要遵从一定的规范。CSS亦如此，要想熟练地使用CSS对网页进行修饰，首先需要了解CSS样式规则，具体格式如下：                                          

```
在上面的样式规则中:

1.选择器用于指定CSS样式作用的HTML对象，花括号内是对该对象设置的具体样式。
2.属性和属性值以“键值对”的形式出现。
3.属性是对指定的对象设置的样式属性，例如字体大小、文本颜色等。
4.属性和属性值之间用英文“:”连接。
5.多个“键值对”之间用英文“;”进行区分。
可以用段落 和 表格的对齐的演示。
```

# 选择器

## css基础选择器

### 标签选择器（元素选择器）

```css
div{color:red;}
p{font-size:10px;}
```

### 类选择器

```html
.it{color:red;}
<p class="it"></p>
```

### 多类名选择器

```html
<div class="pink fontWeight font20">亚瑟</div>
<div class="font20">刘备</div>
<div class="font14 pink">安其拉</div>
<div class="font14">貂蝉</div>
```

### id 选择器

```html
#id{color:red;}
```

### id 选择器和类名选择器区别

id 是唯一的，类名可以重复

### 通配符选择器

```css
*{}
```

# CSS字体样式

### font-size：字号大小



### font-family：字体

### CSS Unicode字体

在 CSS 中设置字体名称，直接写中文是可以的。但是在文件编码（GB2312、UTF-8 等）不匹配时会产生乱码的错误。xp 系统不支持 类似微软雅黑的中文。

方案一： 你可以使用英文来替代。 比如 font-family:"Microsoft Yahei"。

方案二： 在 CSS 直接使用 Unicode 编码来写字体名称可以避免这些错误。使用 Unicode 写中文字体名称，浏览器是可以正确的解析的。
font-family: "\5FAE\8F6F\96C5\9ED1"，表示设置字体为“微软雅黑”。



可以通过escape()  来测试属于什么字体。

| 字体名称    | 英文名称        | Unicode 编码         |
| ----------- | --------------- | -------------------- |
| 宋体        | SimSun          | \5B8B\4F53           |
| 新宋体      | NSimSun         | \65B0\5B8B\4F53      |
| 黑体        | SimHei          | \9ED1\4F53           |
| 微软雅黑    | Microsoft YaHei | \5FAE\8F6F\96C5\9ED1 |
| 楷体_GB2312 | KaiTi_GB2312    | \6977\4F53_GB2312    |
| 隶书        | LiSu            | \96B6\4E66           |
| 幼园        | YouYuan         | \5E7C\5706           |
| 华文细黑    | STXihei         | \534E\6587\7EC6\9ED1 |
| 细明体      | MingLiU         | \7EC6\660E\4F53      |
| 新细明体    | PMingLiU        | \65B0\7EC6\660E\4F53 |

为了照顾不同电脑的字体安装问题，我们尽量只使用宋体和微软雅黑中文字体

### font-weight：字体粗细

字体加粗还有 b 和 strong 标签之外。

```css
font-weight属性用于定义字体的粗细，其可用属性值：normal(400)、bold(700)、bolder、lighter、100~900（100的整数倍）。
```

### font-style:字体风格

字体倾斜除了用 i  和 em 标签之外，可以使用CSS 来实现，但是CSS 是没有语义的。

font-style属性用于定义字体风格，如设置斜体、倾斜或正常字体，其可用属性值如下：

normal：默认值，浏览器会显示标准的字体样式。

italic：浏览器会显示斜体的字体样式。

oblique：浏览器会显示倾斜的字体样式。

### font：综合设置字体样式

```css
p{font:font-size font-weight font-size/line-height font-family;}
```

使用font属性时，必须按上面语法格式中的顺序书写，不能更换顺序，各个属性以空格隔开。
注意：其中不需要设置的属性可以省略（取默认值），但必须保留font-size和font-family属性，否则font属性将不起作用。

# CSS外观属性

### color:文本颜色

1.预定颜色值，例如 red blue

2.十六进制，例如 `#FF0000`，`#FF6600`

3.RGB代码，rgb(255,0,0)

### line-height：行间距

1. px
2. em
3. %

### text-align：水平对齐方式

```css
text-align:left(左对齐) right(右对齐) center(居中对齐)
```

### text-indent：首行缩进

1. 数值
2. em（建议，一个1 em 就是一个字的宽度）
3. `%`

### text-decoration:文本的装饰

text-decoration   通常我们用于给链接修改装饰效果

| 值           | 描述                                          |
| ------------ | --------------------------------------------- |
| none         | 默认。定义标准的文本。                        |
| underline    | 定义文本下的一条线。下划线 也是我们链接自带的 |
| overline     | 定义文本上的一条线。                          |
| line-through | 定义穿过文本下的一条线。                      |
|              |                                               |
|              |                                               |

# CSS符合选择器

### 交集选择器

```css
p .one{} 例如 类名 + .one 的段落标签
```

### 并集选择器

通过 ， 相连接

```css
p,a{}
```

### 后代选择器

又称包含选择器

```css
.class h3{}
```

### 子元素选择器

只能选择作为某元素子元素的元素。

```css
p > a{}  或者 .demo > p{}
```

### 伪类选择器

例如  :link   :hover 

#### 链接伪类选择器

- :link      ` 未访问的链接 `
- :visited   `已访问的链接 `
- :hover     ` 鼠标移动到链接上 `
- :active    ` 选定的链接 `

   注意写的时候，他们的顺序尽量不要颠倒  按照  lvha 的顺序。   love   hate  爱上了讨厌 记忆法    或者   lv 包包 非常 hao 

```css
a {   /* a是标签选择器  所有的链接 */
			font-weight: 700;
			font-size: 16px;
			color: gray;
		}
a:hover {   /* :hover 是链接伪类选择器 鼠标经过 */
			color: red; /*  鼠标经过的时候，由原来的 灰色 变成了红色 */
}
```

# CSS注释

通常使用 `/**/`

# 标签显示模式（display）

### 块级元素（block-level）

### 行内元素（inline-level）

块级元素和行内元素区别

块级元素的特点：
（1）总是从新行开始
（2）高度，行高、外边距以及内边距都可以控制。
（3）宽度默认是容器的100%
（4）可以容纳内联元素和其他块元素。

行内元素的特点：
（1）和相邻行内元素在一行上。
（2）高、宽无效，但水平方向的padding和margin可以设置，垂直方向的无效。
（3）默认宽度就是它本身内容的宽度。
（4）行内元素只能容纳文本或则其他行内元素。

### 行内块元素（inline-block）

行内块元素的特点：
（1）和相邻行内元素（行内块）在一行上,但是之间会有空白缝隙。
（2）默认宽度就是它本身内容的宽度。
（3）高度，行高、外边距以及内边距都可以控制。

## 标签显示模式转换 display

块转行内：display:inline;

行内转块：display:block;

块、行内元素转换为行内块： display: inline-block;



# 行高的测量



# CSS三大特性

## CSS层叠性

样式叠加

## css继承性

子承父业

## CSS优先级

优先权重较高的

### CSS特殊性（Specificity）

关于CSS权重，我们需要一套计算公式来去计算，这个就是 CSS Specificity，我们称为CSS 特性或称非凡性，它是一个衡量CSS值优先级的一个标准 具体规范入如下：

specificity用一个四位的数 字串(CSS2是三位)来表示，更像四个级别，值从左到右，左面的最大，一级大于一级，数位之间没有进制，级别之间不可超越。 

| 继承或者* 的贡献值           | 0,0,0,0  |
| ---------------------------- | -------- |
| 每个元素（标签）贡献值为     | 0,0,0,1  |
| 每个类，伪类贡献值为         | 0,0,1,0  |
| 每个ID贡献值为               | 0,1,0,0  |
| 每个行内样式贡献值           | 1,0,0,0  |
| 每个!important贡献值  重要的 | ∞ 无穷大 |



权重是可以叠加的

 比如的例子：

```
div ul  li   ------>      0,0,0,3

.nav ul li   ------>      0,0,1,2

a:hover      -----—>      0,0,1,1

.nav a       ------>      0,0,1,1   

#nav p       ----->       0,1,0,1
```

   总结优先级：

1. 使用了 `!important`声明的规则。
2. 内嵌在 HTML 元素的 style属性里面的声明。
3. 使用了 ID 选择器的规则。
4. 使用了类选择器、属性选择器、伪元素和伪类选择器的规则。
5. 使用了元素选择器的规则。
6. 只包含一个通用选择器的规则。
7. 同一类选择器则遵循就近原则。

# css背景（background）

CSS 可以添加背景颜色和背景图片，以及来进行图片设置。

| background-color                                            | 背景颜色         |
| ----------------------------------------------------------- | ---------------- |
| background-image                                            | 背景图片地址     |
| background-repeat                                           | 是否平铺         |
| background-position                                         | 背景位置         |
| background-attachment                                       | 背景固定还是滚动 |
| 背景的合写（复合属性）                                      |                  |
| background:背景颜色 背景图片地址 背景平铺 背景滚动 背景位置 |                  |

## 背景图片(image)

语法： 

```css
background-image : none | url (url) 
```

参数： 

none : 　无背景图（默认的）
url : 　使用绝对或相对地址指定背景图像 

background-image 属性允许指定一个图片展示在背景中（只有CSS3才可以多背景）可以和 background-color 连用。 如果图片不重复地话，图片覆盖不到地地方都会被背景色填充。 如果有背景图片平铺，则会覆盖背景颜色。

小技巧：  我们提倡 背景图片后面的地址，url不要加引号。

## 背景平铺（repeat）

语法： 

```css
background-repeat : repeat | no-repeat | repeat-x | repeat-y 
```

参数： 

repeat : 　背景图像在纵向和横向上平铺（默认的）

no-repeat : 　背景图像不平铺

repeat-x : 　背景图像在横向上平铺

repeat-y : 　背景图像在纵向平铺 

设置背景图片时，默认把图片在水平和垂直方向平铺以铺满整个元素。

repeat-x : 　背景图像在横向上平铺  



repeat-y : 　背景图像在纵向平铺 



设置背景图片时，默认把图片在水平和垂直方向平铺以铺满整个元素。



## 背景位置(position)

语法： 

```css
background-position : length || length

background-position : position || position 
```

参数： 

length : 　百分数 | 由浮点数字和单位标识符组成的长度值。请参阅长度单位 
position : 　`top | center | bottom | left | center | right `

说明： 

设置或检索对象的背景图像位置。必须先指定background-image属性。默认值为：(0% 0%)。
如果只指定了一个值，该值将用于横坐标。纵坐标将默认为50%。第二个值将用于纵坐标。

注意：

1. position 后面是x坐标和y坐标。 可以使用方位名词或者 精确单位。
2. 如果和精确单位和方位名字混合使用，则必须是x坐标在前，y坐标后面。比如 background-position: 15px top;   则 15px 一定是  x坐标   top是 y坐标。

实际工作用的最多的，就是背景图片居中对齐了。

## 背景附着

语法： 

```css
background-attachment : scroll | fixed 
```

参数： 

scroll : 　背景图像是随对象内容滚动
fixed : 　背景图像固定 

说明： 

设置或检索背景图像是随对象内容滚动还是固定的。



## 背景简写

background属性的值的书写顺序官方并没有强制标准的。为了可读性，建议大家如下写：

background:背景颜色 背景图片地址 背景平铺 背景滚动 背景位置

```css
background: transparent url(image.jpg) repeat-y  scroll 50% 0 ;
```

## 背景透明(CSS3)

CSS3支持背景半透明的写法语法格式是:

```css
background: rgba(0,0,0,0.3);
```

 最后一个参数是alpha 透明度  取值范围 0~1之间

 注意：  背景半透明是指盒子背景半透明， 盒子里面的内容不收影响。

# 盒子模型

## 盒子边框（border）

边框就是那层皮。  橘子皮。。柚子皮。。橙子皮。。。

语法： 

```css
border : border-width || border-style || border-color 
```

边框属性—设置边框样式（border-style）

边框样式用于定义页面中边框的风格，常用属性值如下：

```
none：没有边框即忽略所有边框的宽度（默认值）

solid：边框为单实线(最为常用的)

dashed：边框为虚线  

dotted：边框为点线

double：边框为双实线
```



### 盒子边框写法总结表

|              |                                                              |                                                              |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 设置内容     | 样式属性                                                     | 常用属性值                                                   |
| 上边框       | border-top-style:样式; border-top-width:宽度;border-top-color:颜色;border-top:宽度 样式 颜色; |                                                              |
| 下边框       | border-bottom-style:样式;border- bottom-width:宽度;border- bottom-color:颜色;border-bottom:宽度 样式 颜色; |                                                              |
| 左边框       | border-left-style:样式; border-left-width:宽度;border-left-color:颜色;border-left:宽度 样式 颜色; |                                                              |
| 右边框       | border-right-style:样式;border-right-width:宽度;border-right-color:颜色;border-right:宽度 样式 颜色; |                                                              |
| 样式综合设置 | border-style:上边 [右边 下边 左边];                          | none无（默认）、solid单实线、dashed虚线、dotted点线、double双实线 |
| 宽度综合设置 | border-width:上边 [右边 下边 左边];                          | 像素值                                                       |
| 颜色综合设置 | border-color:上边 [右边 下边 左边];                          | 颜色值、`#十六进制`、rgb(r,g,b)、rgb(r%,g%,b%)               |
| 边框综合设置 | border:四边宽度 四边样式 四边颜色;                           |                                                              |

```
	border-top: 1px solid red; /*上边框*/
	border-bottom: 2px solid green; /*下边框*/
	border-left: 1px solid blue;
	border-right: 5px solid pink;
	
	border: 1px solid red;
```

### 表格的细线边框

以前学过的html表格边框很粗，这里只需要CSS一句话就可以美观起来。 让我们真的相信，CSS就是我们的白马王子（白雪公主）。

table{ border-collapse:collapse; }  collapse 单词是合并的意思

border-collapse:collapse; 表示相邻边框合并在一起。

### 圆角边框(CSS3)

从此以后，我们的世界不只有矩形。radius 半径（距离）

语法格式：

```css
border-radius: 50%;
```



## 内边距（padding）

padding属性用于设置内边距。  是指 边框与内容之间的距离。

padding-top:上内边距

padding-right:右内边距

padding-bottom:下内边距

padding-left:左内边距

注意：  后面跟几个数值表示的意思是不一样的。

| 值的个数 | 表达意思                                                     |
| -------- | ------------------------------------------------------------ |
| 1个值    | padding：上下左右边距 比如padding: 3px; 表示上下左右都是3像素 |
| 2个值    | padding: 上下边距 左右边距 比如 padding: 3px 5px; 表示 上下3像素 左右 5像素 |
| 3个值    | padding：上边距 左右边距 下边距 比如 padding: 3px 5px 10px; 表示 上是3像素 左右是5像素 下是10像素 |
| 4个值    | padding:上内边距 右内边距 下内边距 左内边距 比如: padding: 3px 5px 10px 15px; 表示 上3px 右是5px 下 10px 左15px 顺时针 |

## 边距（margin）

margin属性用于设置外边距。  设置外边距会在元素之间创建“空白”， 这段空白通常不能放置其他内容。

margin-top:上外边距

margin-right:右外边距

margin-bottom:下外边距

margin-left:上外边距

margin:上外边距 右外边距  下外边距  左外边

取值顺序跟内边距相同。

### 外边距实现盒子居中

可以让一个盒子实现水平居中，需要满足一下两个条件：

1. 必须是块级元素。     
2. 盒子必须指定了宽度（width）

然后就给**左右的外边距都设置为auto**，就可使块级元素水平居中。

实际工作中常用这种方式进行网页布局，示例代码如下：

```css
.header{ width:960px; margin:0 auto;}
```

### 文字盒子居中图片和背景区别

1. 文字水平居中是  text-align: center
2. 盒子水平居中  左右margin 改为 auto 

```css
text-align: center; /*  文字居中水平 */
margin: 10px auto;  /* 盒子水平居中  左右margin 改为 auto 就阔以了 */
```

3. 插入图片 我们用的最多 比如产品展示类
4. 背景图片我们一般用于小图标背景 或者 超大背景图片

```css
section img {  
		width: 200px;/* 插入图片更改大小 width 和 height */
		height: 210px;
		margin-top: 30px;  /* 插入图片更改位置 可以用margin 或padding  盒模型 */
		margin-left: 50px; /* 插入当图片也是一个盒子 */
	}

aside {
		width: 400px;
		height: 400px;
		border: 1px solid purple;
		background: #fff url(images/sun.jpg) no-repeat;
	
		background-size: 200px 210px; /*  背景图片更改大小只能用 background-size */
		background-position: 30px 50px; /* 背景图片更该位置 我用 background-position */
	}
```



### 清除元素的默认内外边距

为了更方便地控制网页中的元素，制作网页时，可使用如下代码清除元素的默认内外边距： 

```css
* {
   padding:0;         /* 清除内边距 */
   margin:0;          /* 清除外边距 */
}
```

注意：  行内元素是只有左右外边距的，是没有上下外边距的。 内边距，在ie6等低版本浏览器也会有问题。

我们尽量不要给行内元素指定上下的内外边距就好了。

## 外边距合并

使用margin定义块元素的垂直外边距时，可能会出现外边距的合并。

### 相邻块元素垂直外边距的合并

当上下相邻的两个块元素相遇时，如果上面的元素有下外边距margin-bottom，下面的元素有上外边距margin-top，则他们之间的垂直间距不是margin-bottom与margin-top之和，而是两者中的较大者。这种现象被称为相邻块元素垂直外边距的合并（也称外边距塌陷）。



解决方案：  避免就好了。

### 嵌套块元素垂直外边距的合并

对于两个嵌套关系的块元素，如果父元素没有上内边距及边框，则父元素的上外边距会与子元素的上外边距发生合并，合并后的外边距为两者中的较大者，即使父元素的上外边距为0，也会发生合并。



解决方案：

1. 可以为父元素定义1像素的上边框或上内边距。
2. 可以为父元素添加overflow:hidden。

待续。。。。

## content宽度和高度

使用宽度属性width和高度属性height可以对盒子的大小进行控制。

width和height的属性值可以为不同单位的数值或相对于父元素的百分比%，实际工作中最常用的是像素值。

大多数浏览器，如Firefox、IE6及以上版本都采用了W3C规范，符合CSS规范的盒子模型的总宽度和总高度的计算原则是：

```
  /*外盒尺寸计算（元素空间尺寸）*/
  Element空间高度 = content height + padding + border + margin
  Element 空间宽度 = content width + padding + border + margin
  /*内盒尺寸计算（元素实际大小）*/
  Element Height = content height + padding + border （Height为内容高度）
  Element Width = content width + padding + border （Width为内容宽度）
```

注意：

1、宽度属性width和高度属性height仅适用于块级元素，对行内元素无效（ img 标签和 input除外）。

2、计算盒子模型的总高度时，还应考虑上下两个盒子垂直外边距合并的情况。

3、**如果一个盒子没有给定宽度/高度或者继承父亲的宽度/高度，则padding 不会影响本盒子大小**。

## 盒子模型布局稳定性

开始学习盒子模型，同学们最大的困惑就是， 分不清内外边距的使用，什么情况下使用内边距，什么情况下使用外边距？

答案是：  其实他们大部分情况下是可以混用的。  就是说，你用内边距也可以，用外边距也可以。 你觉得哪个方便，就用哪个。

但是，总有一个最好用的吧，我们根据稳定性来分，建议如下：

按照 优先使用  宽度 （width）  其次 使用内边距（padding）    再次  外边距（margin）。   

```
  width >  padding  >   margin   
```

原因：

1. margin 会有外边距合并 还有 ie6下面margin 加倍的bug（讨厌）所以最后使用。

2. padding  会影响盒子大小， 需要进行加减计算（麻烦） 其次使用。

3. width   没有问题（嗨皮）我们经常使用宽度剩余法 高度剩余法来做。

   

## 盒子阴影

语法格式：

```css
box-shadow:水平阴影 垂直阴影 模糊距离 阴影尺寸 阴影颜色  内/外阴影；
```



1. 前两个属性是必须写的。其余的可以省略。
2. 外阴影 (outset) 但是不能写    默认      想要内阴影  inset 

```css
div {
			width: 200px;
			height: 200px;
			border: 10px solid red;
			/* box-shadow: 5px 5px 3px 4px rgba(0, 0, 0, .4);  */
			/* box-shadow:水平位置 垂直位置 模糊距离 阴影尺寸（影子大小） 阴影颜色  内/外阴影； */
			box-shadow: 0 15px 30px  rgba(0, 0, 0, .4);
			
}
```

