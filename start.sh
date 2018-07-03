#设置遇到报错就不再往下执行
set -ev

#首先启动orderer节点
docker-compose -f docker-compose.yml up -d orderer.gitbook.cn

#启动状态数据库节点
docker-compose -f docker-compose.yml up -d peer0.blog.couchdb peer1.blog.couchdb peer0.home.couchdb peer1.home.couchdb

#启动ca节点
docker-compose -f docker-compose.yml up -d ca.blog.gitbook.cn ca.home.gitbook.cn

#启动peer
docker-compose -f docker-compose.yml up -d peer0.blog.gitbook.cn peer1.blog.gitbook.cn  peer0.home.gitbook.cn peer1.home.gitbook.cn

#最后启动cli
docker-compose -f docker-compose.yml up -d cli
