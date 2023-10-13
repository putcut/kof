#!/bin/bash
# https://github.com/ToQoz/isucon12q/blob/main/server/deploy.sh

set -e

WORKDIR=

# git最新化
echo "Git pull"
cd $WORKDIR
git pull

# 各種設定ファイルを配置
echo "Copy conf files"
# sudo cp conf/mysqld.conf /etc/mysql/mysql.conf.d/mysqld.cnf
# sudo cp conf/nginx.conf /etc/nginx/nginx.conf
# sudo cp conf/nginx-isuports.conf /etc/nginx/sites-available/isuports.conf
# sudo nginx -t

# ログローテーション
echo "Rotate Logs"
# sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.`date +%Y%m%d-%H%M%S` || true
# sudo mv /var/log/mysql/slow.log /var/log/mysql/slow.log.`date +%Y%m%d-%H%M%S` || true

# ミドルウェアリスタート
echo "Restart middlewares"
# sudo systemctl restart nginx
# sudo systemctl restart mysql

# アプリリスタート
echo "Restart app"
# (cd go && go build -o isuports .)
# sudo systemctl restart isuports

# アプリの起動ログを見る
journalctl -u isuports -e | tail -n 15

echo "deploy.sh Done"