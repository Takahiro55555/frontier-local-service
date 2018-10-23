FROM httpd:2.4.35
EXPOSE 80

RUN apt-get update \ 
    && apt-get install -y \
    cpanminus \
    build-essential \
    perlmagick 

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf