---
title: golang 基本了解
tags: 笔记
categories:
- IT技术
- 后端
- golang
abbrlink: 3389314846
description: 初步学习golang，了解基本语法。
date: 2020-04-06 00:00:00
---

## go学习

### 流程控制



### 函数

> 声明语法： func 函数名 (参数列表) [返回值列表] {}
>
> type fun func(int,int) int
>
> 函数可以赋值给变量
>
> defer 语句

#### 内置函数

+ close : 主要用来关闭 channel
+ len: 用来求长度，比如string、array、slice、map、channel
+ new：用来分配内存，主要用来分配值类型，比如 int、struct。返回的是指针
+ make：用来分配内存，主要用来分配引用类型，比如chan、map、slice
+ append：用来追加元素到数组、slice中
+ panic和recover：用来做错误处理

闭包

> 函数内部的值修改会被保存

数组和切片

> 数组：是同一种数据类型的固定长度的序列
>
> 数组定义：var a [len] int，比如： var a[5] int
>
> 长度是数组类型的一部分，因此，var a[5] int 和var a[10] in 是不同的类型

```go
var age0 [5]int
```

> 切片是数组的一个引用，因此切片是引用类型
>
> 切片的长度可以改变，因此，切片是一个可变的数组
>
> 切片遍历方式和数组一样，可以用len()求长度
>
> cap可以求出slice的长度
>
> 切片是一个引用地址，可以直接修改，切片传地址
>
> slice、map、chan

```go
// 初始化
var slcie []int = arr[start:end]
```

copy 拷贝切片

排序和查找操作

`sort` 包

#### Map 数据结构

> key-value 的数据结构，又叫字典或关联数组
>
> 声明不会分配内存，需要初始化make

delete 删除key

#### 线程同步

+ `import("sync")`
+ 互斥锁  var mu sync.Mutex
+ 读写锁  var mu sync.RMutex

struct

1. 用来自定义复杂数据结构
2. struct里面可以包含多个字段（属性）
3. struct类型可以自定义方法，注意和函数的区分
4. struct类型是值类型
5. struct类型可以嵌套
6. GO语言没有class类型，只有struct类型

```go
// 初始化
type Student struct {
  Name string
  Age int
  score float32
}
// 小写无法包外访问，大写可以
```

链表 

```go
type Student struct {
  Name string
  Next* Student
}
```

golang 中的struct 没有构造函数，一般可以使用工厂模式来解决这个问题

匿名字段, 结构体字段可以没有名字。体现继承

```go
type Car struct {
  Name string
}
type ass struct {
  Car
}
```

方法，golang中的方法是作用在特定类型的变量上，因此自定义类型，都可以有方法，而不仅仅是struct

```go
func (recevier type) methodName(参数列表)(返回值列表){}
```

一个结构体嵌套另一个结构体就是组合

接口

Interface 类型可以定义一组方法，但是这些不需要实现。并且interface不能包含任何变量。

反射

### Goroute 

设置golang运行的cpu核数

go build -race 查看线程竞争

channel 声明

管道通信的文件

```go
var 变量 chan 类型
```

对channel 进行 select 操作

定时器

```go
import "time"
t := time.NewTicker(time.Second)
t.Stop()
```

Socket 编程

Tcp编程



