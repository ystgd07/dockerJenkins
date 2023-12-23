FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

WORKDIR /root

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get update && \
    apt-get install -y vim && \
    apt-get install -y software-properties-common && \
    apt-get install -y nginx
    
COPY index.html /root/index.html

CMD ["nginx", "-g", "daemon off;"]
