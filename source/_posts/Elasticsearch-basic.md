---
title: Elasticsearch-基础
tags: 笔记
categories: Elasticsearch
abbrlink: e74898e6
date: 2021-10-21 10:04:11
updated: 2021-10-21 10:04:11
---

# Elasticsearch-基础

## Elasticsearch



## Luncne

### 核心模块

analysis 模块

index 模块

store 模块

queryParser 模块

search 模块

similarity 模块

### 核心术语

Term：索引最小的存储单元和查询单元

词典（字典）：Term 集合

倒排表：多个词组成

正向信息：原始文档信息

段：索引中最小的独立存储单元。生成，只能读，不能写。

### 段合并
