FROM httpd:2.4.35
EXPOSE 80

RUN apt-get update \ 
    && apt-get install -y \
    cpanminus \
    build-essential \
    perlmagick 

RUN cpanm SVG
RUN apt-get update && \
    apt-get install clustalw

RUN cpanm DBI
RUN cpanm HTML::Template
RUN cpanm Data::Dumper
RUN cpanm Date::Simple

RUN apt-get update \
    && apt-get install -y \
    pkg-config \
    libgd-dev

RUN cpanm GD

# デフォルトでインストールされるようになったらしい
# https://jumpyoshim.hatenablog.com/entry/the-solution-that-libmysqlclient-dev-has-no-installation-candidate
RUN apt-get install -y default-libmysqlclient-dev 

RUN cpanm DBD::mysql

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf