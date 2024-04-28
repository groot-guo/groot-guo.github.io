---
title: Golang init函数分析
date: 2024-04-28 02:28:52
updated: 2024-04-28 02:28:52
tags: [博客, 菜鸟的理解]
categories:Golang
 description: 分析 go 中init函数执行过程，变量初始化时，是否会存在其他情况，以及函数执行的流程。在实际的使用过程中，是否需要注意哪些操作。
---

# Golang init函数分析

>​	博主第一次文章编写，前面均为笔记记录，本人作为一个菜鸟级别的程序员，浅浅分析一下，如有不对，欢迎建议。
>
>本次代码用例环境：
>
>go version: 1.19.13

​	在进行分析init 函数过程之前，先提出几个问题来思考，这样可能更方便我们来进行理解。带着问题来思考，对整体的执行过程会更加清晰。

1. init 函数是什么
2. init 函数如何执行的
3. 多个包中 init函数的执行顺序如何确定的
4. 如果多个包中，执行init 函数，又存在修改时，如何保证不会修改
5. 使用 init 函数初始化数据时，需要注意哪些问题

### init 函数介绍

>​	init 函数，是 Golang 代码执行中，在 main 函数中的代码执行过程中，可以优先执行的一个函数，确保程序在执行main 函数中的代码时，避免其他包中使用的全局变量资源没有进行初始化。

````golang
// package example_a
var A int

func init() {
    A = 1
}

// package main
import (
    "fmt"
    
    "example_a"
)

func main() {
    fmt.Println("package a = ", example_a.A)
}

``` 
---terminal---
package a = 1
```
````

​	在上述代码执行过程中，main 包导入了 example_a 包，main 在执行的过程中，会打印 example_a包中变量 A，而 example_a 包就会执行 init 函数进行初始化变量，最终 main 函数执行，打印 变量 A ，其值 为1。

### 多个init 函数

> 现在，我们已经了解了init 函数的作用，执行过程。那么在多个包中，它该如何执行。

在进行分析前，针对前面提出的问题，我们再加深一些：

- 执行过程中，有什么顺序要求？
- 可以指定执行顺序吗？
- 与包层级嵌套有关吗？
- 如果存在引用，又是如何执行的？
- 如果在别的 init 函数执行初始化，最终会以哪个包执行结果为准？

#### 多个包中 init 函数执行流程

>先看一段基础版的代码演示，仅做为基本的 init 函数执行导包

````go
``` 
---- 层级结构 ----
存在某些导包省略，自己执行时，进行补充
go-init-example
|-- example_a
	|-- example-a.go
|-- example_b
	|-- example-b.go
|-- example_c
	|-- example-c.go
	|-- example_d
		|-- example-d.go
|-- main.go
```

// package example_a
var A int

func init() {
    A = 1
	fmt.Println("package a set A = ", A)
}

// package example_b
var B int

func init() {
	B = 1
	fmt.Println("package b set B = ", B)
}

// package example_c
var C int

func init() {
	C = 1
	fmt.Println("package c set C = ", C)
}

// package example_d
var D int

func init() {
	D = 1
	fmt.Println("package d set D = ", D)
}


package main

import (
    "fmt"
    
    "go-init-example/example_a"
	"go-init-example/example_b"
	"go-init-example/example_c"
	"go-init-example/example_c/example_d"
)

func main() {
	
    fmt.Println("a = ", example_a.A)
    fmt.Println("b = ", example_b.B)
    fmt.Println("c = ", example_c.C)
	fmt.Println("d = ", example_d.D)
}

// 代码运行结果如下
```
package a set A = 1
package b set B = 1
package c set C = 1
package d set D = 1
a = 1
b = 1
c = 1
d = 1
```
````

​	从代码的运行结果来看，main 在执行前，按照 a、b、c、d 的顺序执行了init 函数初始化。那执行顺序有可能改变吗？

#### 多个包init 函数执行顺序

> 在上面的执行结果中，我们可以看到导包的顺序为 a、b、c、d，main函数中打印的顺序为 a、b、c、d。
>
> 那么到底是哪一个顺序导致多个包中init 函数执行顺序的呢？

##### 如果修改main 函数中打印：

````go
package main

import (
    "fmt"
    
    "go-init-example/example_a"
	"go-init-example/example_b"
	"go-init-example/example_c"
	"go-init-example/example_c/example_d"
)

func main() {
	fmt.Println("d = ", example_d.D)
    fmt.Println("a = ", example_a.A)
    fmt.Println("b = ", example_b.B)
    fmt.Println("c = ", example_c.C)
}

// 代码运行结果如下
```
package a set A = 1
package b set B = 1
package c set C = 1
package d set D = 1
d = 1
c = 1
b = 1
a = 1
```
````

由上述代码可以看出，main 函数执行的顺序，并不能够改变其他包中init 函数加载执行的顺序。

##### 如果导包顺序修改呢？

>将上面导包顺序修改为 d、c、b、a
>
>下面的代码导包顺序之所以这样，是由于go fmt 工具会对导包进行排序，为避免工具进行排序，人为调整顺序。**但在实际我们使用的过程中，应当遵守规范，如果存在需要空值 init 顺序，请看后序文章内容。**

````go
package main

import (
    "fmt"
    
    "go-init-example/example_c/example_d"
    
    "go-init-example/example_c"
    
    "go-init-example/example_b"
    
    "go-init-example/example_a"
)

func main() {
	fmt.Println("d = ", example_d.D)
    fmt.Println("a = ", example_a.A)
    fmt.Println("b = ", example_b.B)
    fmt.Println("c = ", example_c.C)
}

// 代码运行结果如下
```
package d set D = 1
package c set C = 1
package b set B = 1
package a set A = 1
d = 1
c = 1
b = 1
a = 1
```
````

从上面的代码结果可以看出
