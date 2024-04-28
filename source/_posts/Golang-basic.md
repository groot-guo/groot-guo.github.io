---
layout: _post
title: Golang 数据结构与关键字
date: 2020-10-21 10:04:25
updated: 2020-10-21 10:04:25
tags: 笔记
categories: Golang
abbrlink: ca04d71e1
---

## 数据结构

### 数组

>数组：相同元素，内存地址连续，利用索引可以快速访问到元素，容量确定（不可以扩容）的一种数据结构

#### 初始化方式

```golang
arr1 := [3]int{1, 2, 3}   // 确定容量大小
arr2 := [...]int{1, 2, 3} // 编译器会转换成上面这一种，推导确定容量
```

#### 访问和赋值

>利用下标进行索引查询每个元素，对应元素可以进行赋值操作，但不能超出数组长度的索引查询请求。
>
>

```golang
arr1 := [3]int{1, 2, 3}
for i := range arr1 {
    arr1[i] = 3 // 将对应索引的元素值，赋值 = 3
}
fmt.Println(arr1)
fmt.Println(arr1[3]) // 报错，因为索引的下标是从 0 开始 
```

<!-- more -->

### 切片

>动态数组：长度是动态的，可以在容量不足时扩容。
>
>切片其实内部引用的数组结构

#### 数据结构

```golang
type SliceHeader struct {
    Data uintptr // 数组
    Len int
    Cap int
}
```

#### 切片操作

```golang
// 字面量初始化
slice := []int{1, 2, 3}
// 关键字 make 
slice := make([]int, 3)
// 下标获得一部分
arr := [3]int{1, 2, 3}
slice := arr[:]

// 利用 for range 访问元素
for i := range slice {
    slice[i] = 1 // 利用索引访问时，获取到的是当前索引在数组中的地址
}

for _, v := range slice {
    v = 1 // 此方法访问时，切片元素没有修改，因为 v 变量是临时开辟的地址，每次读取会将对应的元素内容复制到 v 中
}

slice = append(slice, 1) // 追加一个元素到 slice 中, 扩容操作

// 复制切片
arr := []int{}
copy(arr, slice)

fmt.Println(len(slice)) // 查看长度
fmt.Println(cap(slice)) // 查看容量
```

#### 切片扩容

> 切片是一个动态数组，容量不固定，所以当需要进行扩容时，会进行数组的复制，重新选择一个地址来存储数组。
>
> 扩容的具体策略分为：
>
> - 当前期望容量大于当前容量两倍时，就会使用期望容量；
> - 当前切片长度小于 1024 时，就会将容量翻倍；
> - 当前切片长度大于 1024 时，就会每次按 25% 的容量扩容，直到新容量满足期望容量



### 哈希表

>map 就是go 中应用 哈希表方式进行数据存储的结构。
>
>map 采用 <font color=red>哈希桶</font> 进行存储数据的方式，哈希桶的地址是连续的，分为<font color=blue>正常桶</font> 和 <font color=blue>溢出桶 </font> ，每个桶中数据通过 <font color=blue>链表</font> 存储当前 key 利用哈希函数生成的哈希值对应的数据。
>
>一个正常桶存储 8个键值对，当 正常桶装满时，会存储到溢出桶。正常桶与溢出桶通过链表连接。

#### 数据结构

```golang
type hmap struct {
    count     	int				// 当前哈希表元素数量
    flags     	uint8			// 
    B         	uint8			// 当前哈希表持有 buckets （哈希桶）数量
    noverflow 	uint16			
    hash0     	uint32			// 哈希表的种子，值在创建时确定，引入随机性
    
    buckets		unsafe.Pointer
    oldbuckets	unsafe.POinter
    nevacuate 	uintptr
    
	extra		*mapextra
}

type mapextra struct {
    overflow		*[]*bmap
    oldverflow		*[]*bmap
    nextOverflow	*bmap
}

// 溢出桶
type bmap struct {
    tophash		[bucketCnt]uint8
    topbits		[8]uint8
    keys		[8]keytype
    values		[8]valuetype
    pad			uintptr
    overflow	uintptr
}

```

#### map 操作

```golang
// 初始化
hash := map[string]int{
    "easy": 1,
    "mid": 	2,
    "hard": 3,
}
hash := make(map[string]int) // 注意 make 的方式

// 访问
for key, value := range hash {
    fmt.Println(key, value) 	// 访问key 对应 value 
    hash[key] = 1 				// 赋值修改
}

// 隐藏的布尔类型字段，用于判断元素是否存在
if v, ok := hash["ww"]; ok {
    fmt.Println(v, ok)
} else {
    fmt.Println(v, ok)
}

delete(hash, "easy") // 删除操作
```

#### map 的扩容

>哈希扩容触发的两种情况：
>
>- 装载因子超过6.5；
>- 哈希表使用了太多溢出桶。



### 字符串

>字符串是go 中基础类型，可以当作一个由字符组成的数组，本身占用的内存空间是连续的。
>
>

#### 数据结构

```golang
type StringHeader struct {
    Data 	uintptr
    Len 	int
}
```

#### 字符操作

```golang
// 初始化
str1 := "hello wolrd"

// 拼接
str2 := "!"
str3 := str1 + str2

for i := range str1 {
    fmt.Println(str1[i]) // 每一个都是 byte 类型
}
```

#### Byte类型

>byte 是一个 <font color=red>8</font>  位无符号整数类型，底层是 **uint8**。值范围 0~ 255，可以表示 ASCII 字符集的单个字节。
>
>在文件操作中，常用于读取和写入字节数据。

```golang
// 声明
b := 'A'

// byte 转换为 int
i：= int(b)

// int 转换为 byte
b2 := byte(65)
```

#### rune 类型

>是 **int32** 类型的别名，表示一个 **Unicode** 字符。
>
><font color=red>可用于区分字符值和整数值。</font>
>
>每个 rune 占用 4 个字节。

```golang
// 声明
r := '呵呵'

// 判断是不是字母
isLetter := unicode.IsLetter(r)

// rune 转换为 int32
i := int32(r)
```



## 语言特性

### 函数

>

#### 特点

>- 值传递
>
>- 支持多返回值
>- 函数入参和出参的内存空间都在栈上进行分配

```golang
// 函数声明示例
func hello(a int) (int, int) {
    return 1 + a, 2
}
```



### 接口

>接口是一组方法的签名，
>
>

#### 数据结构



## 关键字

### for 和 range



### select



### defer



### panic 和 recover



### make 和 new



## 参考书籍

>- Go语言设计与实现
>- Go语言高级编程
>- Go语言底层原理剖析
>
>
