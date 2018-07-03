
# 创建通道
CHANNEL_NAME=gitbookchannel
peer channel create -o orderer.gitbook.cn:7050 -c $CHANNEL_NAME -f ./config/gitbookchannel.tx
# 加入通道
peer channel join -b gitbookchannel.block
# 更新锚节点
peer channel update -o orderer.gitbook.cn:7050 -c ${CHANNEL_NAME} -f ./config/OrgBlogMSPanchors.tx

# 切换节点
CORE_PEER_ADDRESS=peer1.blog.gitbook.cn:7051
# 加入通道
peer channel join -b gitbookchannel.block


# 切换组织
CORE_PEER_ADDRESS=peer0.home.gitbook.cn:7051
# 切换msp
CORE_PEER_LOCALMSPID=OrgHomeMSP
# 切换msp文件地址
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/home.gitbook.cn/users/Admin@home.gitbook.cn/msp
# 加入通道
peer channel join -b gitbookchannel.block

# 更新锚节点
peer channel update -o orderer.gitbook.cn:7050 -c ${CHANNEL_NAME} -f ./config/OrgHomeMSPanchors.tx

# 切换到另一个节点
CORE_PEER_ADDRESS=peer1.home.gitbook.cn:7051
# 加入通道
peer channel join -b gitbookchannel.block


# 链码部分

# 安装链码
peer chaincode install -p github.com/hyperledger/fabric/peer/chaincode/hello -n hello -v 1.0

# 实例化链码
peer chaincode instantiate -o orderer.gitbook.cn:7050 -C gitbookchannel -c '{"Args":["init"]}' -P "OR ('OrgHomeMSP.member','OrgBlogMSP.member')" -v 1.0 -n hello

# 写入数据
peer chaincode invoke -o orderer.gitbook.cn:7050 -n hello -C gitbookchannel -c '{"Args":["setObj","1","gitbook"]}'

# 查询数据
peer chaincode query -n hello -C gitbookchannel -c '{"Args":["getWithId","1"]}'


