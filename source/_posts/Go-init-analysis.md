---
title: Golang init函数分析
tags:
  - 博客
  - 菜鸟的理解
categories: Golang
abbrlink: 38d3f8f
date: 2024-04-28 02:28:52
updated: 2024-04-28 02:28:52
---

>本人作为一个菜鸟级别的程序员，浅浅分析一下，如有不对，欢迎讨论。
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

<!-- more -->

## init 函数介绍

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

## 多个 init 函数如何执行

> 现在，我们已经了解了init 函数的作用，执行过程。那么在多个包中，它该如何执行。

在进行分析前，针对前面提出的问题，我们提问一些更深入的问题：

- 一个包中多个init 函数如何执行？
- 多个包中一个init 函数是如何执行的？

### 一个包中多个init 函数

> 一个包中多个 init 函数，是指在同一个package 中，不同的 go 文件里面，都有 init 函数做初始化。
>
> 下面先看示例代码目录结构

```shell
---- 层级结构 ----
存在某些导包省略，自己执行时，进行补充
go-init-example
|-- example
	|-- example-a.go
	|-- example-b.go
|-- main.go
```

{% tabs only-init-example %}

<!-- tab package main-->

```go
package main

import (
    "fmt"
    
    "go-init-example/example"
)

func main() {
	fmt.Println("a = ", example.A)
    fmt.Println("b = ", example.B)
}
```

<!-- endtab -->

<!-- tab 运行结果 -->

{% code %}

// 代码运行结果如下
package example set A = 1
package example set B = 1
a = 1
b = 1
{% endcode %}

<!-- endtab -->

<!-- tab example example_a.go -->

```go
var A int

func init() {
    A = 1
	fmt.Println("package example set A = ", A)
}
```

<!-- endtab -->

<!-- tab example example_b.go -->

```go
var B int

func init() {
    B = 1
	fmt.Println("package example set B = ", B)
}
```

<!-- endtab -->

{% endtabs %}

根据上述代码运行结果，可以发现程序最终打印的结果 从 A 到 B，依次进行了打印，但是程序是如何确定从 A 到 B的呢？依照上述代码，我们发现有两个排序：

- 文件名的排序
- main 函数中，调用变量的顺序

修改上述条件（这里不做演示代码），最终确定依靠文件顺序来进行 init 函数执行确定。

> <font color=red>注意</font>：当对同一个包中，不同 go文件使用 init 函数时，应当确定执行顺序是否会有影响。

----

### 多个包中一个init 函数

>对于不同包中的 init 函数，请看示例代码

```shell
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

{% tabs many-init-package %}

<!-- tab package main -->

{% code %}

package main

import (
	"fmt"

​	"go-init-example/example_a"
​	"go-init-example/example_b"
​	"go-init-example/example_c"
​	"go-init-example/example_c/example_d"
)

func main() {
	fmt.Println("a = ", example_a.A)
	fmt.Println("b = ", example_b.B)
	fmt.Println("c = ", example_c.C)
	fmt.Println("d = ", example_d.D)
}

{% endcode %}

<!-- endtab -->

<!-- tab 运行结果1 -->

{% code %}

// 代码运行结果如下

package a set A = 1
package b set B = 1
package c set C = 1
package d set D = 1
a = 1
b = 1
c = 1
d = 1

{% endcode %}

<!-- endtab -->

<!-- tab package example_a -->

```go
// package example_a
var A int

func init() {
    A = 1
	fmt.Println("package a set A = ", A)
}
```

<!-- endtab -->

<!-- tab package example_b -->

```go
// package example_b
var B int

func init() {
	B = 1
	fmt.Println("package b set B = ", B)
}
```

<!-- endtab -->



<!-- tab package example_c -->

```go
// package example_c
var C int

func init() {
	C = 1
	fmt.Println("package c set C = ", C)
}
```

<!-- endtab -->



<!-- tab package example_d -->

```go
// package example_d
var D int

func init() {
	D = 1
	fmt.Println("package d set D = ", D)
}

```

<!-- entab -->

{% endtabs %}

​	从代码的运行结果来看，main 在执行前，按照 a、b、c、d 的顺序执行了init 函数初始化。那执行顺序有可能改变吗？

---

### 多个包init 函数执行顺序

> 在上面的执行结果中，我们可以看到导包的顺序为 a、b、c、d，main函数中打印的顺序为 a、b、c、d。
>
> 当我们看到不同包中 init 函数执行过程，经过深入思考后，可以提出以下几个问题：
>
> - 可以指定执行顺序吗？
> - 与包层级嵌套有关吗？
> - 如果存在依赖关系，又是如何执行的？
> - 如果在别的 init 函数执行初始化，最终会以哪个包执行结果为准？

#### 如果修改main 函数中打印：

{% tabs many-init-sort %}

<!-- tab package main -->

```go
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
    fmt.Println("c = ", example_c.C)
    fmt.Println("b = ", example_b.B)
    fmt.Println("a = ", example_a.A)
}
```

<!-- endtab -->

<!-- tab 运行结果2 -->

{% code %}

// 代码运行结果如下

package a set A = 1
package b set B = 1
package c set C = 1
package d set D = 1
d = 1
c = 1
b = 1
a = 1

{% endcode %}

<!-- endtab -->

{% endtabs %}

由上述代码可以看出，main 函数执行的顺序，并不能够改变其他包中init 函数加载执行的顺序。

#### 如果导包顺序修改呢

>将上面导包顺序修改为 d、c、b、a
>
>下面的代码导包顺序之所以这样，是由于go fmt 工具会对导包进行排序，为避免工具进行排序，人为调整顺序。**但在实际我们使用的过程中，应当遵守规范，如果存在需要空值 init 顺序，请看后序文章内容。**

{% tabs many-init-sort-desc %}

<!-- tab package main -->

```go
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
    fmt.Println("c = ", example_c.C)
    fmt.Println("b = ", example_b.B)
    fmt.Println("a = ", example_a.A)
}
```

<!-- endtab -->

<!-- tab 运行结果2 -->

{% code %}

// 代码运行结果如下

package d set D = 1
package c set C = 1
package b set B = 1
package a set A = 1
d = 1
c = 1
b = 1
a = 1

{% endcode %}

<!-- endtab -->

{% endtabs %}

从上面的代码结果可以看出，当导包的顺序发生变化时，程序在执行各个依赖包之间的init函数，遵循导包顺序的原则，依次加载执行。

<font color=red>**但如果存在包之间的依赖关系，是不是就会不一样呢？**</font>

><font color=red>注意</font>：如果在执行过程中有这明确的顺序要求，一定要注意在 main 函数中，包导入的顺序。

#### 包之间存在依赖关系时

> 如果包之间存在依赖，那么加载执行 init 函数的流程是什么顺序？
>
> 现在让我们来假设几种依赖关系：
>
> 1. 包 A 依赖 包 B
> 2. 包 C 依赖 包 D
> 3. 包 D 依赖 包 A， 包 C 依赖 包 D
>
> 在上述的关系中，我们分别假设了 平级目录依赖关系、嵌套层级目录依赖关系、嵌套层级与平级目录依赖关系（以上词语不知道有没有，均由本人进行词语拓展）。

##### 第一种情况

{% tabs package 1 %}

<!-- tab package main-->

```go
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
```

<!-- endtab -->

<!-- tab 运行结果 -->

{% code %}

// 代码运行结果如下

package a set A = 1
package b set B = 1
package b set A = 10
package c set C = 1
package d set D = 1
a = 10
b = 1
c = 1
d = 1

{% endcode %}

<!-- endtab -->

<!-- tab package example_a -->

```go
// package example_a
var A int

func init() {
    A = 1
	fmt.Println("package a set A = ", A)
}
```

<!-- endtab -->

<!-- tab package example_b -->

```go
// package example_b
var B int

func init() {
	B = 1
	fmt.Println("package b set B = ", B)
    
    exmaple_a.A = 10
    fmt.Println("package b set A = ", exmaple_a.A)
}
```

<!-- endtab -->

{% endtabs %}

##### 第二种情况

{% tabs package 1 %}

<!-- tab package main-->

```go
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
```

<!-- endtab -->

<!-- tab 运行结果 -->

{% code %}

// 代码运行结果如下

package a set A = 1
package b set B = 1
package d set D = 1
package c set C = 1
package c set D = 10
a = 1
b = 1
c = 1
d = 10

{% endcode %}

<!-- endtab -->

<!-- tab package example_c -->

```go
// package example_c
var C int

func init() {
	C = 1
	fmt.Println("package c set C = ", C)
    
    example_d.D = 10
    fmt.Println("package c set D = ", example_d.D)
}
```

<!-- endtab -->



<!-- tab package example_d -->

```go
// package example_d
var D int

func init() {
	D = 1
	fmt.Println("package d set D = ", D)
}

```

<!-- entab -->

{% endtabs %}

##### 第三种情况

{% tabs package 1 %}

<!-- tab package main-->

```go
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
```

<!-- endtab -->

<!-- tab 运行结果 -->

{% code %}

// 代码运行结果如下

package a set A = 1
package b set B = 1
package d set D = 1
package d set A = 10
package c set C = 1
package c set D = 10
a = 10
b = 1
c = 1
d = 10

{% endcode %}

<!-- endtab -->

<!-- tab package example_c -->

```go
// package example_c
var C int

func init() {
	C = 1
	fmt.Println("package c set C = ", C)
    
    example_d.D = 10
    fmt.Println("package c set D = ", example_d.D)
}
```

<!-- endtab -->

<!-- tab package example_d -->

```go
// package example_d
var D int

func init() {
	D = 1
	fmt.Println("package d set D = ", D)
    
    example_a.A = 10
    fmt.Println("package d set A = ", example_a.A)
}

```

<!-- entab -->

{% endtabs %}

根据上述代码用例的执行结果，其实我们总结出以下几条执行规则：

1. 先按照main 函数 import 顺序加载
2. 读取依赖中是否有引用关系，如果有，先执行依赖关系
3. 否则，按照main 函数 import 顺序执行，当执行到对应有依赖关系的，先按照依赖顺序执行。

{% note %}

其实从代码执行结果来看，我们可以得出，当有依赖顺序时，会先按照依赖顺序执行。

那如果 package example_c 中有多个包引用，会影响执行吗？

答案是不会，这个顺序主要以 package main 中的import 确定，其他包中的顺序无法影响。 

{% endnote %}

---

## `sync.Once` 与 `init` 函数

<font color=red>注意</font>：查看下文时，希望你对 `sync.Once` 有所了解。

>查看了很多博客，有的博客说 `init` 函数实现了 `sync.Once` 功能。
>
>首先要了解 `sync.Once` 是什么，其次它干了什么。
>
>而`init` 函数，可以理解在 main 执行时，import 各包之前所执行的初始化操作。
>
>`sync.Once` 指是确保不同协程执行到同一行代码时，确保<font color=red>至少</font>和<font color=red>仅</font>执行**一次**。
>
>可以看出，从用途来说不同，从用法来说不同。

从用途来说：

- `init` 函数确保当前包被使用时，全局资源可以得到初始化。这一代码运行发生在`main`函数之前。
- `sync.Once`确保多协程执行同一段代码时，确保某一函数在此代码中，已经被执行。

从用法来说：

- `init`函数是确保当前包资源，一般用作全局资源初始化。
- `sync.Once`，准确来说是确保某个函数仅需要执行一次，可以作为资源初始化，但不一定是全局。

下面仅作`sync.Once`代码示例：

{% tabs sync %}

<!-- tab sync.Once -->

{% code %}
package main

import (
	"fmt"
    "sync"
)

var A int

func setA1() {
	A++
	fmt.Println("set A++, A =  ", A)
}

func setA2() {
	A++
	fmt.Println("set A++, A =  ", A)
}

func main() {
    wg := sync.WaitGroup{}
	s := sync.Once{}
	for i := 0; i < 3; i++ {
		go func() {
			s.Do(setA1)
			fmt.Println("A = ", A)
			wg.Done()
		}()
		wg.Add(1)
	}
	wg.Wait()
	s.Do(setA2)
    setA()
}
{% endcode %}

<!-- endtab -->

<!-- tab 运行结果 -->

{% code %}
set A++, A = 1
A = 1
A = 1
A = 1
set A++, A = 2
{% endcode %}

<!-- endtab -->

{% endtabs %}

由此我们可以总结出不同，`sync.Once`只是确保在`once`这个实例对象，创建后，只会执行一次 do 函数，而具体 do 函数里面第一次执行的是哪个函数，并不关心。最终只会确保do 只会执行一次。在实际的应用场景中，我们可以查看到 go 源码中 netpoll 做初始化时，就使用到了 `sync.Once`。 

---

## 总结

根据上述多个示例分析，由此我们得出以下几点：

在同一个包中，多个`init`函数：

- 执行顺序仅依赖文件排序

多个包中`init`函数：

- 先按照`import`顺序执行
- 判断各包是否存在依赖关系
  - 先执行没有依赖的包
  - 再执行依赖顺序
- `main`函数执行

> 假设有包 A、B、C，然后包 B 依赖包 C，那么main 中 import 顺序为 A、B、C。
>
> 最终加载执行为 A、C、B。
