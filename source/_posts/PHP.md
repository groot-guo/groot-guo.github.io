---
title: PHP 的 认识
tags: 笔记
categories: PHP
abbrlink: 442c7832
date: 2019-07-03 00:00:00
updated: 2019-07-03 00:00:00
---

# PHP

## 初步认识

```php
<?php echo 'hell php!'; ?>
```

如果遇到字符串输出

```php
<?php echo "sdfa"; ?>
<?php echo 12*3;?> /*数字运算*/
```

注意：输出，一定以  `;` 间隔

安装 wamp 集合控软件

修改 wamp 路径

找到 wampmanager.ini 和 .tpl 文件

查找 menu.left

修改 www目录为项目目录路径

修改 ${w_wwwDirectory} 变为项目路径

<!-- more -->

## 变量

### 定义变量名的方法

- 必须以字母或者下划线 “_” 开头
- 只能由数字或者字母，以及 “_” 组成，换可以加汉字
- 不允许有空格，多个单词建议   驼峰

```php
$var = "字符串";
可用 var_dump($var)输出类型  echo $var输出值
```

```php
<?php
    $var = "大家来学PHP";
    echo $var;
	echo "<br />";
	$var = "学PHP上慕课网";
	echo $var;
?>
```

### 变量的数据类型

可以通过 `memory_get_usage`来判断不同数据消耗的内存

```php
<?php 
echo $m1 = memory_get_usage(); 
echo "<br />";
$var_string = "123";
echo $m2 = memory_get_usage()-$m1; 
echo "<br />";
$n = 123;
echo $m3 = memory_get_usage()-$m1-$m2; 
echo "<br />";
$f = 123.00; 
echo $m4 = memory_get_usage()-$m1-$m2-$m3; 
echo "<br />";
$var_array =array("123"); 
echo $m5 = memory_get_usage()-$m1-$m2-$m3-$m4; 
?>
```



- int    整型
  
  - php中会将其他进制的数自动转换成十进制值输出
  
- bool  布尔值

- string 字符串

  - 可以使用 `''`或者`""`包含

  - 单双引号可以互相嵌入

    ```php
    <?php 
    $love = "I love you!"; 
    $string1 = "慕课网,$love";
    $string2 = '慕课网,$love';
    echo $string1;
    echo "<br />";
    echo $string2;
    ?>
    # 不可以使用 $变量时 用单引号包含
    ```

  - 多行字符串时（$变量  =  <<<GOD   GOD;）

    ```php
    <?php 
    $string1 = <<<GOD
    我有一只小毛驴，我从来也不骑。
    有一天我心血来潮，骑着去赶集。
    我手里拿着小皮鞭，我心里正得意。
    不知怎么哗啦啦啦啦，我摔了一身泥.
    GOD;
    echo $string1;
    ?>
    ```

- float   浮点型

  - 可以使用 e 或者 E来表示小数的科学计数法

php 变量会自动转换类型无须定义

### 特殊类型（资源）

fopen("文件路径","方法") 

```php
<?php 
//首先采用“fopen”函数打开文件，得到返回值的就是资源类型。
$file_handle = fopen("data/webroot/resource/php/f.txt","r");
if ($file_handle){
    //接着采用while循环（后面语言结构语句中的循环结构会详细介绍）一行行地读取文件，然后输出每行的文字
    while (!feof($file_handle)) { //判断是否到最后一行
        $line = fgets($file_handle); //读取一行文本
        echo $line; //输出一行文本
        echo "<br />"; //换行
    }
}
fclose($file_handle);//关闭文件
?>
```

### 特殊类型（空类型）

```php
<?php 
 error_reporting(0); //禁止显示PHP警告提示
 $var;					#  NULL
 var_dump($var);
 $var1 = null;			#  NULL
 var_dump($var1);
 $var2 = NULL;			#  NULL
 var_dump( $var2);
 $var3 = "节日快乐！";
 unset($var3);			#  NULL
 var_dump($var3);
?>
```

## 常量

通常常量定义都是**大写**

### define（定义常量）

基本格式（第一个必选参数，第二个 value 必选参数，第三个是可选参数）

```php
bool define(string $constant_name, mixed $value[, $case_sensitive = true])
```

string表示参数类型为字符串类型，mixed表示参数类型可以接受为多种不同的类型，case_sensitive = true表示默认为布尔类型TRUE

```php
# 示例
<?php
$p = "PII";
define("PI",3.14);
define($p,3.14);
echo PI;			# 3.14
echo "<br />";
echo PII;			# 3.14
?>
```

### 系统常量

- `__FILE__`   php程序文件名，获取当前文件的物理位置
- `__LINE__`  php文件的行数 
- `PHP_VERSION`  当前php版本
- `PHP_OS`        执行php的操作系统

获取常量值

直接变量运算的

```php
<?php
define("PI",3.14);
$r=1;
$area = PI*$r*$r; //计算圆的面积
?>
```

constant函数

基本格式

```php
mixed constant(string constant_name)
```

第一个参数constant_name为要获取常量的名称，也可为存储常量名的变量。如果成功则返回常量的值，失败则提示错误信息常量没有被定义。（注：mixed表示函数返回值类型为多种不同的类型，string表示参数类型为字符串类型）

```php
# 示例
<?php 
	define("PI",3.14);
	$r=1;
	$area = constant("PI")*$r*$r;
?>
```

### 判断常量是否被定义

defined()函数

基本格式：

```php
bool defined(string constants_name)
```

它只有参数constant_name，指的是要获取常量的名称，若存在则返回布尔类型true，否则返回布尔类型false; （注：bool表示函数返回值类型为布尔类型）

```php
# 示例
<?php 
define("PI1",3.14);
$p = "PI1";
$is1 = defined($p);
$is2 = defined("PI2");
var_dump($is1);
var_dump($is2);
?>
```

