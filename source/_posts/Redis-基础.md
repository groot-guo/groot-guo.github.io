---
title: Redis-基础
abbrlink: bf7639ff
tags: 笔记
categories:
  - IT技术
  - Redis
description: Redis 数据结构基础认识和使用，redis 本身的特点了解
date: 2020-02-12 15:40:45
updated: 2021-04-16 11:20:11
---

# Redis 基础

## redis 基本认识



## 数据结构

### 字符串

#### 性质和特点

>字符串是一个由字节组成的序列。最大容量<font color=red>512MB</font>。
>
>字符串可以存储3种类型的值：
>
>- 字符串
>- 整数
>- 浮点数
>
>

#### SDS （简单动态字符串）

>简单动态字符串（simple dynamic string， SDS）
>
>特点：
>
>- 获取长度复杂度 O(1)，通过 len 字段
>- 拼接字符串，会先扩容，再拼接，并且容量会有剩余

```c
struct sdshdr {
    // 记录 buf 数组种已使用字节的数量
    // 等于 SDS 所保存字符串的长度
    int len;
    
    // 记录 buf 数组中未使用字节的数量
    int free;
    
    // 字符数组，用于保存字符串
    char buf[];
}
```

#### 操作

| 命令        | 用例描述                                                     |
| ----------- | ------------------------------------------------------------ |
| incr        | incr key-name  ——将键存储的值加1                             |
| decr        | decr key-name ——将键存储的值减1                              |
| incrby      | incrby key-name amount ——将键存储的值加上整数 amount         |
| decrby      | decrby key-name amount ——将键存储的值减去整数 amount         |
| incrbyfloat | incrbyfloat key-name amount ——将键存储的值加上浮点数 (redis 2.6 以上) |
| append      | append key-name value ——将值 value 追加到给定键 key-name 当前存储的值的末尾 |
| getrange    | getrange key-name start end ——获取一个由偏移量start 到 偏移量 end 范围所有字符组成的子串，包括 start、 end |
| setrange    | setrange key-name offset  value ——将从 start 偏移量开始的子串设置为给定值 |
| getbit      | getbit key-name offset ——将字符串看作二进制位串（bit string），并返回串中偏移量位 offset 的二进制位的值 |
| setbit      | setbit key-name offset value ——将字节串看作二进制位串，并将位串中偏移量 offset 的二进制位的值设置位 value |
| bitcount    | bitcount key-name [start end] ——统计二进制位串里面值为1的二进制的数量，如果 |
| bitop       | bitop operation dest-key key-name [key-name ...] ——对一个或者多个二进制位串执行包括并（AND）、或（OR）、异或（XOR）、非（NOT）在内任意一种按位运算操作，并将计算结果保存到 dest-key 中 |

### 列表

#### 原理



#### 操作



### 哈希

#### 原理



#### 操作



### 集合

#### 原理



#### 操作



### 有序集合

#### 原理



#### 操作



### 地理空间

#### 原理



#### 操作



### 流

#### 原理



#### 操作



## 参考

>
>
>
