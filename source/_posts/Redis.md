---
title: Redis 了解与安装
tags: 笔记
categories: Redis
description: Redis 了解、安装、常见使用场景练习
abbrlink: '1738e583'
date: 2019-08-15 00:00:00
updated: 2019-08-15 00:00:00
---

## Redis

### Redis相关问题

+ Redis 和 memcached 区别？

对比 Memcache的共同点：

1. redis 是缓存到内存中，
2. 属于 key - value 

不同的;

1. redis 可以做持久化（将数据保存磁盘上）
2. 支持更丰富的数据类型，value 可以是字符串，链表，哈希，memcache只支持字符串

+ 如何高效的找到redis中所有以oldboy开头的key

```sql
key oldboy*
```

+ 什么是一致性哈希

> 首先一致性哈希满足以下几个方面：
> 平衡性
> 单调性
> 分散性
> 负载
> 平滑性
> https://juejin.im/post/5ae1476ef265da0b8d419ef2

将整个哈希空间虚拟成一个0 ~ 2^32无符号的圆形，然后把每个服务器进行哈希，然后将对应ip哈希到邻近服务器上。

+ redis是单进程单线程的吗？

首先redis是单线程单进程，如果需要，只能多开几个redis进程

1. 本身性能很高，每秒处理10万次的读写
2. 代码更清晰，逻辑更简单
3. 不用考虑各种锁的问题，不存在加锁释放锁操作，没有因为可能出现死锁而导致的性能消耗
4. 不存在多进程或多线程导致的切换而消耗CPU
5. 事件处理类型是IO多路复用
6. 将并行事件，串行化发生。

+ redis中数据库默认是多少个db及作用？

> 共16 db，存储key-value格式信息。相当于不同的库

+ 如果redis中的某个列表中的数据量非常大，如果实现循环显示每一个值？

> 利用xrange 方法实现生成器循环，然后yield生成器

+ redis 如何实现主从复制？以及数据同步机制？



redis 是一个非关系型数据库（No -SQL）

储存结构 字节 python读取时

### 数据结构

----

+ [redisObject](#redisobject)
+ [string](#junmp)
  + [int](#jump)（存放整数类型）
  + [SDS](#jump)（存放浮点、字符串、字节类型）
+ [list](#jump)
  + [链表](#jump)（linkedlist）双向链表
  + [压缩列表](#jump)（ziplist）压缩列表
+ [hash](#jump)
  + [压缩列表](#jump) （以上述相同）
  + [字典](#jump)（使用散列表解决，解决冲突的方法是链表法）
+ [set](#jump)
+ [zset](#jump)
+ [跳表](#jump) skiplist

#### <span id="redisobject">redisObject</span>

---

Redis的key是顶层模型，value是扁平化的。Redis中，所有value都是一个object，它的结构如下：

```c
typedef struct redisObject{
  unsigned [type] 4;
  unsigned [encoding] 4;
  unsigned [lru] REDIS_LRU_BITS;
  int refcount;
  void *prt;
} robj;
```

相关字段说明：

- type：数据类型，例如string、hash、list等。
- encoding：内部编码，就是数据结构。指的是当前这个value底层是用的什么数据结构。因为同一个数据类型底层也有多种数据结构的实现。
- REDIS_LRU_BITS：当前对象可以保留的时长。在键的过期策略中用到。
- refcount：对象引用计数，用于GC。
- ptr：指针，指向以encoding的方式实现这个对象的实际地址。



#### <span id="string">string</span>

---

string类型有两种底层存储结构。Redis会根据存储的数据及用户的操作指令自动选择合适的结构：

+ int：存放整型类型
+ SDS：存放浮点、字符串、字节类型

> SDS：简单动态字符串（simple dynamic string）

##### <span id="SDS">SDS</span>

SDS的内部数据结构：

```c
typedef struct sdshdr {
  // buf 中已占用的字符长度
  unsigned int len;
  // buf 中剩余可用的字符长度
  unsigned int free;
  // 数据空间
  char buf[];
}
```

其底层就是char数组。buf最大容量就是512M，可以放字符串、浮点数、字节。但为什么没用数组？

因为buf 会有动态扩容和缩容的需求。如果直接使用数组，那每次对字符串的修改都会导致重新分配内存，效率很低。

buf扩容过程如下：

+ 如果修改后len长度将小于1M，这时分配给 free 的大小 == len。
  例如修改后10 字节，那么free 为10，buf 实际长度变成了10 + 10 + 1 = 21 byte
+ 如果修改后len长度 >= 1M，这时分配给 free 的大小 == 1M。
  例如修改后 30M，那么给 free是 1M，buf实际长度变成了30M + 1M + 1byte



惰性空间释放指的是当字符串缩短时，并没有真正的缩容，而是移动 free 的指针。这样一来字符串长度增加时，就不用重新分配内存了。但这样会造成内存的浪费，redis 提供了api来真正释放内存。

#### <span id="list">list</span>

----

list 底层有两种数据结构：链表linklist和压缩列表ziplist。当list元素个数少且元素内容长度不大时，使用ziplist实现，否则linklist。

##### 链表

Redis使用的是双向列表。为了方便操作，使用list结构来维持链表。如图：



```c
typedef struct list {
  // 表头节点
  listNode *head;
  // 表尾节点
  listNode *tail;
  // 链表所包含的节点数量
  unsigned long len;
  // 节点值复制函数
  void *(*dup)(void *ptr);
  // 节点值释放函数
  void *(*free)(void *ptr);
  // 节点值对比函数
  int (*match)(void *ptr, void *key);
}list;
```

data存的其实就是一个指针。链表里面的元素是上面介绍的string。因为是双向链表，所以可以方便地把它当成一个栈或者队列使用。

##### 压缩列表

与上面链表对应，有点类似数组，通过一片连续的内存空间来存储数据。与数组唯一不同点：允许存储的结构大小不同。每个节点上增加一个length属性记录这个节点的长度，这样方便地得到下一个节点的位置。



上图字段的含义：

+ zlbytes：列表的长度
+ zltail：指向最末元素
+ zllen：元素的个数
+ entry：元素的内容，里面记录了前一个Entry的长度，用于方便双向遍历
+ zlend：恒为0xFF，作为ziplist的定界符

压缩列表不只是list的底层，也是hash的底层实现之一。当hash的元素个数少且内容长度不大时，使用压缩列表来实现。

#### <span id="hash">hash</span>

----

Hash 底层有两种实现：压缩列表和字典（dict）。

##### 字典

字典类似java中map，python中dict。与java中hashmap类似，redis底层也是使用的散列表作为字典的实现，解决hash冲突使用的是链表法。Redis同样使用了一个数据结构来维持散列表：



在键增加或者减少时，会扩容或者缩容，并且进行rehash，根据hash值重新计算索引值。如果字典太大怎么办？

为了解决一次性扩容耗时过多的情况，可以将扩容操作穿插在插入操作的过程中，分批完成。当负载因子触达阈值之后，只能申请新空间，但并不将老的数据搬移到新散列表中。当有新数据要插入时，将新数据插入新散列表中，并且从老的散列表中拿出一个数据放入到新散列表。每次插入一个数据到散列表，都重复上面的过程。经过多次插入操作之后，老的散列表中的数据就一点一点全部搬移到新散列表中了。这样没有了集中的一次一次性数据搬移，插入操作就都变得很快乐。这个被称为渐进式rehash。

#### <span id="set">set</span>

---

set里面没有重复的集合。set的实现比较简单。如果是整数类型，就直接使用整数集合intset。使用二分查找来辅助，速度还是挺快的。不过在插入的时候由于要移动元素，时间复杂度是 O(N)。

如果不是整数类型，就是用上面在hash那一节介绍的字典。key 为 set 的值，value 为空。

#### <span id="zset">zset</span>

---

zset是可排序的set。与hash的实现方式类似，如果元素个数不大，就使用压缩列表ziplist来存储。不过由于zset包含了score的排序信息，所以在ziplist内部，是按照score排序递增来存储的。意味着每次插入数据都要移动之后的数据。

#### <span id="">跳表</span>（skiplist）

跳表（skiplist）是另一种实现dict的数据结构。跳表是对链表的一个增强。我们在使用链表的时候，即使元素有序排列的，但如果要查找一个元素，也从头查找下去，复杂度是O（N）。而跳表顾名思义，就是跳跃了一些元素，可以抽象多层。

如图所示，比如我们要查找8，先在最上层L2查找，发现在1 和9 之间；然后去L1层查找，发现在5和9之间；然后去L0查找，发现在7和9之间，然后找到8。

当元素较多时，跳跃表可以显著减少查找次数。



同list类似，Redis内部也不是直接使用的跳跃表，而是使用了一个自定义的数据结构来持有跳跃表。下图左边蓝色部分是skiplist，右边是4个zskiplistNode。zskiplistNode内部有很多层L1、L2等，指针指向这一层的下一个结点。BW是回退指针，用于查找的时候回退。然后下面是score和对象本身object。





