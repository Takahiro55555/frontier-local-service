FROM mysql:5.7
EXPOSE 3306

# 文字コード設定のためconf追加
ADD ./my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]