---
title: Redis-基础
tags: 笔记
categories: Redis
abbrlink: bf7639ff
date: 2020-02-12 15:40:45
updated: 2021-04-16 11:20:11
---

# Redis 基础

## redis 基本认识

### 使用场景



### 为什么快

>- 基于内存存储数据
>- Recator 模型（IO多路复用）
>- 单线程应用
>- 
>
>

## 数据结构

### SDS （简单动态字符串）

>简单动态字符串（simple dynamic string， SDS）
>
>特点：
>
>- 获取长度复杂度 O(1)，通过 len 字段
>- 拼接字符串，会先扩容，再拼接，并且容量会有剩余
>- 空间预分配
>- 惰性空间释放，通过 free 属性
>- 二进制安全，通过字节数组，而不是数组保存每一个字符，将字符拆分来保存
>
>与 C 字符串区别：
>
>- c字符串中，最后一个元素是空字符 `\0`，使用长度为 N+1. （SDS 也有）
>- 获取长度要遍历计数。
>- 容易造成缓冲区溢出，如果没有分配足够的空间，可能会使相邻数据的内容被意外修改

<!-- more -->

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

### 链表

>高效的节点重排能力，以及顺序性节点访问。通过增删节点灵活调整链表长度。
>
>redis 中，列表、发布订阅、慢查询、监视器等功能使用。
>
>特点：
>
>- 双端：带有前后节点
>- 无环：表头节点和表尾节点为空
>- 带表头指针和表尾指针：通过 list 结构 head 和 tail 获取复杂度 O(1)
>- 带链表长度计数器： 通过 len 获取
>- 多态： 使用 void 保存值，通过 dup 、 free、match 属性设置类型特定函数，保存不同值
>
>

```c
typedef struct listNode {
    // 前置节点
    struct listNode *prev;
    // 后置节点
    struct listNode *next;
    // 节点的值
    void *value;
}listNode;

typedef struct list {
    // 表头节点
    listNode *head;
    // 表尾节点
    listNode *tail;
    // 链表所包含的节点数量
    unsigned long len;
    // 节点值赋值函数
    void *(*dup) (void *ptr);
    // 节点值释放函数
    void (*free) (void *ptr);
    // 节点值比对函数
    int (*match) (void *ptr, void *key);
}list;
```



### 字典

>
>
>redis 数据库就是使用字典来作为底层实现的。
>
>哈希表使用 链地址法 来解决键冲突，相同的key 用 next 指针连接起来，构成一个单向链表。

#### 代码结构

```c
typedef struct dictht {
    // 哈希表数组 
    dictEntry **table; 
    // 哈希表大小
    unsigned long size;
    // 哈希表大小掩码，用于计算索引值
    // 总是等于 size-1
    unsigned long sizemask;
    // 该哈希表已有节点的数量
    unsigned long used;
}dictht;

typedef struct dictEntry {
    // 键
    void *key;
    // 值
    union{
        void *val;
        uint64_t u64;
        int64_t s64;
    } v;
    // 指向下个哈希表节点，形成链表
    struct dictEntry *next;
} dictEntry;

typedef struct dict {
	// 类型特定函数
    dictType *type;
    // 私有数据
    void *privdata;
    // 哈希表
    dictht ht[2];
    // rehash 索引
    // 当 rehash 不在进行时，值为-1
    int trehashidx; /*rehashing not in progress if rehashidx == -1 */
} dict;

typedef struct dictType {
    // 计算哈希值的函数
    unsigned int (*hashFunction) (const void *key);
    // 复制键的函数
    void *(*keyDup) (void *privdata, const void *key);
    // 复制值的函数
    void *(*valDup) (void *privdata, const void *obj);
    // 对比键的函数
    int (*keycompare) (void *privdata, const void *key1, const void *key2);
    // 销毁键的函数
    void (*keyDestructor) (void *privdata, void *key);
    // 销毁值得函数
    void (*valDestructor) (void *privdata, void *obj);
} dictType;
```

#### rehash



### 跳跃表

>
>
>使用场景：
>
>- 有序集合实现的底层之一
>- 集群节点中用作内部数据结构

```c
typedef struct zskiplist {
  	// 表头节点和表尾节点
    struct skiplistNode *header, *tail;
    // 表中节点的数量
    unsigned long length;
    // 表中层数最大的节点的层数
    int level;
} zskiplist;

typedef struct zskiplistNode {
    // 后退指针
    struct zskiplistNode *backward;
    // 分值
    double score;
    // 成员对象
    robj *obj;
    // 层
    struct zskiplistLevel {
        // 前进指针
        struct zskiplistNode *forward;
        // 跨度
        unsigned int span;
    } level[];
} zskiplistNode;
```



### 整数集合

>
>
>
>
>使用场景：
>
>- 集合键

```c
typedef struct intset {
    // 编码方式
    uint32_t encoding;
    // 集合包含的元素数量
    uint32_t length;
    // 保存元素的数组
    int8_t contents[];
} intset;
```

#### 升级和降级



### 压缩列表

>压缩列表是为了节约内存而开发的，是由一系列特殊编码的连续内存块组成的顺序型数据结构。
>
>使用场景：
>
>- 列表键
>- 哈希键

| 属性    | 类型     | 长度  | 用途                                                         |
| ------- | -------- | ----- | ------------------------------------------------------------ |
| zlbytes | uint32_t | 4字节 | 记录整个压缩列表占用的内存字节数；在对压缩列表进行内存重分配，或计算zlend的位置时使用 |
| zltail  | uint32_t | 4字节 | 记录压缩列表表尾节点举例压缩列表的起始地址有多少字节；通过这个偏移量，程序无须遍历整个压缩列表就可以确定表尾节点的地址 |
| zllen   | uint16_t | 2字节 | 记录了压缩列表包含的节点数量：当这个属性的值小于uint16_MAX(65535) 时，这个值就是包含节点的数量；当等于时，真实数量需要遍历整个压缩列表 |
| entryX  | 列表节点 | 不定  | 压缩列表包含的各个节点，节点的长度由节点保存的内容决定的     |
| zlend   | uint8_t  | 1字节 | 特殊值 0xFF（十进制255），用于标记压缩列表的末端             |
|         |          |       |                                                              |



### 对象

>基于对象系统来使用上述数据结构
>
>主要分为：
>
>- 字符串对象
>- 列表对象
>- 哈希对象
>- 集合对象
>- 有序集合对象
>
>基于 引用计数 技术的内存回收机制。
>
>对象共享机制，适当条件下，让多个数据库键共享同一个对象节约内存。
>
>带有访问时间记录信息，用于计算数据库键的空转时长，时长较大会优先删除。
>
>

```c
typedef struct redisObject {
    // 类型
    unsigned type:4;
    // 编码
    unsigned encoding:4;
    // 指向底层实现数据结构的指针
    void *ptr;
    
    // 引用计数，在内存回收中
    int refcount; 
        
    // ...
} robj;
```

#### 内存回收



#### 对象共享



## 常用命令

### 字符串

>字符串是一个由字节组成的序列。最大容量<font color=red>512MB</font>。
>
>字符串可以存储3种类型的值：
>
>- 字符串
>- 整数
>- 浮点数
>
>字符串对象编码可以是 int、raw、或 embstr。
>
>保存的类型区分：
>
>- long 类型整数时，编码采用 int 
>- 字符串时
>  - 且长度大于 39 字节，使用 sds 保存，编码设置为 raw
>  - 小于39时，使用 embstr 保存
>
>long double 类型浮点数使用 embstr 或 raw。
>
>其余长度不满足时，均采用 embstr 或 raw。
>
>

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

>列表对象的编码可以是  压缩列表 或 链表。  
>
>使用 压缩列表 编码条件：
>
>- 保存的所有字符串元素长度都小于 64 字节；
>- 保存的元素数量小于 512 个；
>
>不满足上面条件的使用 链表。（上限值可以修改，配置中 list-max-ziplist-value 和 list-max-ziplist-entries）
>
>

| 命令       | 用例和描述                                                   |
| ---------- | ------------------------------------------------------------ |
| rpush      | rpush key-name value [value ...] ——将一个或多个值推入列表的右端 |
| lpush      | lpush key-name value [value ...] ——将一个或多个值推入列表的左端 |
| rpop       | rpop key-name ——移除并返回列表最右端的元素                   |
| lpop       | lpop key-name ——移除并返回列表最左端的元素                   |
| lindex     | lindex key-name offset ——返回列表中偏移量为 offset 的元素    |
| lrange     | lrange key-name start end ——返回列表从 start 偏移量到 end 偏移量范围内所有元素，包括 start 和 end 元素 |
| ltrim      | ltrim key-name start end ——对列表进行修剪，只保留从 start 偏移量到 end 偏移量范围内，包括 start 和 end 元素 |
| blpop      | blpop key-name [key-name ...] timeout ——从第一个非空列表中弹出位于最左端的元素，或者在 timeout 秒之内阻塞并等待可以弹出的元素出现 |
| brpop      | brpop key-name [key-name ...] timeout ——从第一个非空列表中弹出位于最右端的元素，或者在 timeout 秒之内阻塞并等待可以弹出的元素出现 |
| rpoplpush  | rpoplush source-key dest-key ——从 source-key 列表中弹出位于最右端的元素，然后将元素推入 dest-key 列表的最左端，并返回这个元素 |
| brpoplpush | brpoplpush source-key dest-key timeout ——从source-key 列表中弹出位于最右端的元素，推入dest-key 列表最左端，并返回元素；如果 source-key为空，那么在 timeout 秒之内阻塞并等待可弹出的元素的出现 |
|            |                                                              |



### 哈希（散列）

>哈希对象编码可以是 压缩列表 或 字典。
>
>使用压缩列表时，先添加到哈希对象中键值对被放在列表表头方向，后添加的在表尾方向，键和值分别存储，但键在前，值在后，紧挨在一起。
>
>使用 压缩列表 编码条件：
>
>- 保存所有键值对的字符串长度小于64字节
>- 键值对数量小于512个
>
>不满足上述条件，使用字典编码。（上限可以修改，hash-max-ziplist-value 和 hash-max-ziplist-entries）
>
>

| 命令         | 用例和描述                                                   |
| ------------ | ------------------------------------------------------------ |
| hmget        | hmget key-name key [key ...] ——从散列里面获取一个或多个键的值 |
| hmset        | hmset key-name key value [key value ...] ——为散列里面的一个或多个键设置值 |
| hdel         | hdel key-name key [key ...] ——删除散列里面的一个或多个键值对，返回成功找到并删除的键值对数量 |
| hlen         | hlen key-name ——返回散列包含的键值对数量                     |
| hexists      | hexists key-name key ——检查给定键是否存在于散列中            |
| hkeys        | hkeys key-name ——获取散列包含的所有键                        |
| hvals        | hvals key-name ——获取散列包含的所有值                        |
| hgetall      | hgetall key-name ——获取散列包含的所有键值对                  |
| hincrby      | hincrby key-name key increment ——将键key 存储的值加上整数 increment |
| hincrbyfloat | hincrbyfloat key-name key increment ——将键key 存储的值加上浮点数 increment |
|              |                                                              |
|              |                                                              |

### 集合

>集合对象编码可以是 整数集合 和 字典。
>
>当使用 字典 作为编码时，每一个键存储的都是 字符串对象，但值为 空。
>
>使用 整数集合编码条件：
>
>- 保存所有元素是整数
>- 数量不超过512个
>
>不满足条件使用字典。（上限通过 set-max-intset-entries 配置）
>
>

| 命令        | 用例和描述                                                   |
| ----------- | ------------------------------------------------------------ |
| sadd        | sadd key-name item [item ...] ——将一个或多个元素添加到集合里面，并返回被添加元素当中原本并不存在于集合里面的元素数量 |
| srem        | srem key-name item [item ...] ——从集合里面移除一个或多个元素，并返回被移除元素的数量 |
| sismember   | sismember key-name item ——检查元素item 是否存在于集合 key-name 里 |
| scard       | scard key-name ——返回集合包含的元素的数量                    |
| smembers    | smembers key-name ——返回集合包含的所有元素                   |
| srandmember | srandmember key-name [count] ——从集合里面随机地返回一个或者多个元素。当 count 为正数，随机元素不重复；负数，可能会重复 |
| spop        | spop key-name ——随机地移除集合中的一个元素，并返回被移除的元素 |
| smove       | smove source-key dest-key item ——如果source-key 包含元素item，那么集合source-key 里面移除元素 item，并将元素 item 添加到集合 dest-key 中；如果item 移除成功，返回1，否则 0 |
| sdiff       | sdiff key-name [key-name ...] ——返回那些存在于第一个集合、但不存在于其他集合中的元素（差集运算） |
| sdiffstore  | sdiffstore dest-key key-name [key-name ...] ——将那些存在于第一个集合但并不存在于其他集合中的元素（差集运算）存储到 dest-key 键里面 |
| sinter      | sinter key-name [key-name ...] ——返回那些同时存在于所有集合中的元素（交集运算） |
| sinterstore | sinterstore dest-key key-name [key-name ...] ——将那些同时存在于所有集合的元素（交集）存储到 dest-key 键里面 |
| sunion      | sunion key-name [key-name ...] ——返回那些至少存在于一个集合中的元素（并集运算） |
| sunionstore | sunionstore dest-key key-name [key-name ...]——将那些至少存在于一个集合中的元素（并集运算）存储到dest-key键里面 |
|             |                                                              |



### 有序集合

>有序集合对象编码可以是 压缩列表 或 跳跃表。
>
>使用压缩列表是，每个集合元素中包含一个元素成员和一个元素分值，两个元素紧挨在压缩列表节点中，集合元素按照元素分值从小到大排列。
>
>
>
>当时用 zset 作为底层实现，一个 zset 中包括一个 字典 和 一个 跳跃表。
>
>字典创建一个从成员到分值的映射，键—成员，值—分值。通过字典可以查成员的分值。
>
>跳跃表按 分值从小到大保存了所有集合元素。而 节点中 score 保存了元素的分值，可以用来进行范围操作。
>
>而跳跃表和字典通过指针 共享相同元素，节省空间。
>
>
>
>如果仅利用其中一个实现：
>
>- 字典无序，范围查询，会需要额外空间
>- 跳跃表查询成员分值，无法做到 O(1)
>
>
>
>使用压缩列表条件：
>
>- 元素数量小于128个
>- 成员长度小于 64字节
>
>不满足使用 跳跃表编码。（通过zset-max-ziplist-entries 和 zset-max-ziplist-value 配置）
>
>



| 命令             | 用例和描述                                                   |
| ---------------- | ------------------------------------------------------------ |
| zadd             | zadd key-name score member [score member ...] ——将带有给定分值得成员添加到有序集合里面 |
| zrem             | zrem key-name member [member ...] ——从有序集合里面移除给定得成员，并返回被移除成员得数量 |
| zcard            | zcard key-name ——返回有序集合包含的成员数量                  |
| zincrby          | zincrby key-name increment member ——将member 成员的分值加上 increment |
| zcount           | zcount key-name min max ——返回分值介于 min 和max 之间的成员数量 |
| zrank            | zrank key-name member ——返回成员 member 在有序集合中的排名   |
| zscore           | zscore key-name member ——返回成员member 的分值               |
| zrange           | zrange key-name member ——返回成员member 的分值               |
| zrevrank         | zrevrank key-name member ——返回有序集合里成员 member 的排名，成员按照分值从大到小排列 |
| zrevrange        | zrevrange key-name start stop [withscores] ——返回有序集合给定排名范围内的成员，成员按照分值从大到小排列 |
| zrangebyscore    | zrangebyscore key min max [withscores] [limit offset count] ——返回有序集合中，分值介于 min 和max 之间的所有成员 |
| zrevrangebyscore | zrevrangebyscore key min max [withscores] [limit offset count] ——获取有序集合中分值介于min 和max 之间的所有成员，并按照分值从大到小的顺序来返回它们 |
| zremrangebyrank  | zremrangebyrank key-name start stop ——移除有序集合中排名介于start 和 stop之间的所有成员 |
| zremrangebyscore | zremrangebyscore key-name min max ——移除有序集合中分值介于 min 和 max之间的所有成员 |
| zinterstore      | zinterstore dest-key key-count key [key ...] [weights weight [weight...]] [aggregate sum\|min\|max]  ——对给定的有序集合执行类似于集合的交集运算 |
| zunionstore      | zunionstore dest-key key-count key [key ...] [weights weight [weight...]] [aggregate sum\|min\|max]——对给定的有序集合执行类似于集合的并集运算 |
|                  |                                                              |



### 发布与订阅

>订阅者负责订阅频道，发送者向频道发送二进制字符串消息。
>
>
>
>如何保证消息的可靠性
>
>消息积压会耗费过多内存
>
>

| 命令         | 用例和描述                                                   |
| ------------ | ------------------------------------------------------------ |
| subscribe    | subscribe channel [channel ...] ——订阅给定的一个或多个频道   |
| unsubscribe  | unsubscribe [channel [channel ...]] ——退定给定的一个或多个频道，如果执行时没有给定任何频道，那么退订所有频道 |
| publish      | publish channel message ——向给定频道发消息                   |
| psubscribe   | psubscribe pattern [pattern ...] ——订阅与给定模式相匹配的所有频道 |
| punsubscribe | punsubscribe [pattern [pattern ...]] ——退订给定的模式，如果执行时没有给定任何模式，那么退订所有模式 |
|              |                                                              |



### 其他命令

#### 排序

>能够对 列表、集合、有序集合进行排序。
>
>选项：
>
>- 降序、升序
>- 元素看作数字排序
>- 看作 二进制字符串排序
>- 使用被排序元素之外的 其他值 作为权重值排序
>- 可以从输入的列表、集合、有序集合以外的其他地方进行取值
>
>

| 命令 | 用例和描述                                                   |
| ---- | ------------------------------------------------------------ |
| sort | sort source-key [BY pattern] [limit offset count] [get pattern [get pattern ...]] [asc\|desc] [alpha] [store dest-key] ——跟据给定的选项，对输入列表、集合或者有序集合进行排序，然后返回或者存储排序的结果 |



#### 事务

>使用事务，保证元素修改发生冲突，不会出现数据问题。、
>
>事务会将命令打包，然后一次性、有序地执行的机制。命令加入事务队列，按照 FIFO 原则执行。
>
>事务执行不会中断，要么全部执行完，才会结束。
>
>
>
>multi 用于事务开始
>
>exec 代表事务执行
>
>watch 命令 是一个乐观锁



#### 过期时间

>expire 设置 key 过期时间
>
>过期键的判定：
>
>1. 检查给定键是否存在于过期字典：如果存在，那么取得键的过期时间
>2. 检查当前 unix 时间戳 是否大于键的过期时间：是，则过期，否，未过期
>
>一般过期策略：
>
>- 定时删除：内存友好，通过定时器删除，释放内存
>- 惰性删除：对cpu 时间来说最友好，取键的时候进行检查，删除操作仅在当前键操作，不会在其他键上
>- 定期删除：隔一段时间进行删除，限制删除时长和频率，难点在 时长和频率
>
>采用 惰性删除 和 定期删除
>
>

| 命令      | 用例和描述                                                   |
| --------- | ------------------------------------------------------------ |
| persist   | persist key-name ——移除键的过期时间                          |
| ttl       | ttl key-name ——查看给定键距离过期还有多少秒                  |
| expire    | expire key-name seconds ——让给定键在指定的秒数之后过期       |
| expireat  | expireat key-name timestamp ——将给定键的过期时间设置为给定的unix 时间戳 |
| pttl      | pttl key-name ——查看给定键距离过期时间还有多少毫秒，这个命令在 redis 2.6 或以上可用 |
| pexpire   | pexpire key-name milliseconds ——让给定键在指定的毫秒数之后过期，这个命令在redis 2.6 或以上可用 |
| pexpireat | pexpireat key-name timestamp-milliseconds ——将一个毫秒级精度的 unix 时间戳设置为给定间的过期时间， redis 2.6 或以上可用 |



## 参考

>- 《redis 设计与实现》
>- 《redis 实战》
>
>
