# 使用 Hyperledger Fabric 自定义搭建属于自己的区块链

文：谦益


区块链 Hyperledge Fabric 项目是 IBM 开源的区块链项目，越来越多的技术人员进入到 Hyperledge Fabric 这个开源项目。但是新起来的技术，网上的资料都太少，大部分都是教你怎么跑first-network网络。

对于已经捣腾了一段时间的工程师来说，已经开始不满足跑first-network了，现在想改组织结构，增加peer等，不知道怎么改。

本次给大家分享下，怎么完全脱离官方的脚本，自己在本地一步一步搭建一条完全自定义的链。

此链的具体结构是：

- 1个 Order
- 2组织
- 4节点
- Solo 共识

后续，还会有更多的关于多节点， Kafka 节点共识的分享，敬请期待。


如果您想学习更加详细的搭建流程，可以到我在[gitbook](http://gitbook.cn/gitchat/activity/5b35de94deb86c016d7dc55a)上开的一场chat。

谢谢您的关注！


>注：如果你要运行这个项目，需要找到你开发环境的`configtxgen`,`cryptogen`这两个文件放到`bin`目录下。


