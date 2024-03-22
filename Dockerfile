# Dockerfile 示例

# 第一部分：基础镜像信息
FROM node:21
# 例如：FROM ubuntu:22.04 或 FROM python:3.10-slim-buster

# 第二部分：维护者信息（可选）
LABEL maintainer="genyuan.guo@qq.com"

# 第三部分：环境变量设置
ENV <环境变量名>=<值>
# 例如：ENV NODE_VERSION 14

# 第四部分：工作目录设置
WORKDIR /app
# 设定工作目录，后续的 RUN、CMD、COPY、ADD 指令将在此目录下执行

# 第五部分：依赖安装
# 对于基于 apt-get 的系统
RUN apt-get update && apt-get install -y \
    package1 \
    package2

# 对于基于 yum 的系统
RUN yum install -y \
    package3 \
    package4

# 对于基于 pip 的 Python 应用
RUN pip install --no-cache-dir \
    requirement1 \
    requirement2

# 第六部分：文件复制
COPY . /app           
# 将当前目录下所有文件复制到容器内的/app目录
COPY src /app/src      
# 将src目录下的文件复制到容器内的/app/src目录

# 第七部分：构建时的脚本执行
RUN ./configure && make && make install

# 第八部分：暴露端口
EXPOSE 80 433 4000
# <端口1> <端口2>
# 例如：EXPOSE 80 443

# 第九部分：设置容器启动时执行的命令
CMD ["<执行文件>", "<参数1>", "<参数2>"]
# 或者用 shell 形式
CMD <命令>

# 第十部分：使用ENTRYPOINT可以设置固定入口点
ENTRYPOINT ["executable", "param1", "param2"]

# 使用ARG传递构建参数
ARG <参数名>
# 使用构建参数
RUN echo ${参数名}

# 若需使用健康检查
HEALTHCHECK --interval=5m --timeout=3s CMD curl --fail http://localhost/ || exit 1

# 注意：Dockerfile 中的指令遵循一定的执行顺序，从上到下依次执行