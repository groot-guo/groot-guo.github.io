---
title: Golang net包代码分析浅谈
tags:
  - 博客
  - 菜鸟的理解
categories: Golang
abbrlink: 91f8ab39
date: 2024-04-28 02:30:46
updated: 2024-04-28 02:30:46
---


>事先声明：所有参考内容，会在结尾留下。
>
>为什么会对Golang 中 `net` 包进行分析，最近看完书中`netpoll`的讲解，之前也阅读过，但始终对于`net`包 和`netpoll`两者关系没有理清。然后又看到了字节跳动在自己开源的`netpoll`对于Go `net`包的评价。两者结合，对于net包的性能为何快，那么`netpoll`又扮演什么功能。
>
>本文仅对`net`包中`rpc`服务和客户端的创建流程，对于其中`netpoll`是何时被调用，之间的联系。
>
>思考不是很全面，如有瑕疵，欢迎建议。
>
>go version: 1.19.13

<!-- more -->

## `rpc`服务和客户端

### 创建和使用

> 在Go中创建一个`rpc`服务和客户端，其中基本上实现了rpc 协议的解码和编码、rpc 服务和客户端服务的连接和请求处理。下面先看一段代码示例和基本流程。

![image-20240429170943578](./../images/image-20240429170943578.png)

{% tabs rpc %}

<!-- tab rpc client -->

```go
package main

import (
	"fmt"
	"log"
	"net/rpc"
)

func main() {

	client, err := rpc.Dial("tcp", "localhost:8080")
	if err != nil {
		log.Fatal("dialing:", err)
	}

	var reply string
	err = client.Call("HelloService.Hello", "world", &reply)
	if err != nil {
		log.Fatal(err)
	}

    fmt.Println(reply)
}
```

<!-- endtab -->

<!-- tab rpc server -->

```go
package main

import (
	"log"
	"net"
	"net/rpc"
)

type HelloService struct {
}

func (p *HelloService) Hello(request string, reply *string) error {
	*reply = "hello " + request
	return nil
}

func main() {
	srv := rpc.NewServer()
	srv.RegisterName("HelloService", new(HelloService))

	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatal("ListenTCP error:", err)
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Fatal("Accept error:", err)
		}

		go srv.ServeConn(conn)
	}
}
```

<!-- endtab -->

{% endtabs %}

上述代码流程里，我们实现了基本`rpc`服务创建，`rpc`客户端请求，在`hello server`处理请求数据，返回组合的数据，打印了`hello world`。 

---

### `rpc`服务流程详细分析

>针对上面的`rpc`服务创建流程，具体流程是怎么做的，`netpoll` 又充当了什么角色，为什么说`net`包实现的`rpc`是`BIO`模式的。
>
>下面对于其中`Listen`函数、`Accept`函数、`ServeConn`函数具体流程进行分析。

#### `Listen`函数

>先看一下`Listen`函数中，底层数据结构主要字段。
>
>从下图我们看到，`Listener` 结构体最终涉及调用了 `pollDesc`，而`pollDesc`是`netpoll`功能的主要数据结构，`pollDesc`封装了操作系统的文件描述符，从而监控了网络`IO`的请求。 而在`netpoll`中，在`linux`中主要通过`epoll`模型实现。

![image-20240429180552177](./../images/image-20240429180552177.png)

> 下面我们看一下整体函数调用链路。

![image-20240429182001877](./../images/image-20240429182001877.png)

> 接下来再对应实际代码分析一下。



#### `Accept`函数



#### `ServeConn`函数



---

### `rpc`客户端详细分析



## 总结



## 参考

> 《Go语言设计与实现》
