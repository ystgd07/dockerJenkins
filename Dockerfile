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
COPY nginx.conf /etc/nginx/nginx.conf
COPY test.conf /etc/nginx/sites-available/test.conf
RUN rm -rf /etc/nginx/sites-enabled/default
RUN rm -rf /etc/nginx/sites-available/default
RUN chmod +x /root && \
    chmod +x /root/index.html
RUN ln -s /etc/nginx/sites-available/test.conf /etc/nginx/sites-enabled
RUN chmod +x /etc/nginx/sites-enabled
CMD ["/usr/sbin/init"]
ENTRYPOINT service nginx start && bash
