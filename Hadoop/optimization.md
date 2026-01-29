# Hadoop集群的优化

Hadoop 集群的优化是一个系统工程，通常需要从硬件层、HDFS 存储层、YARN 资源调度层以及 MapReduce 计算层四个维度进行全方位调优。

## 1. HDFS

HDFS 的主要压力通常来自 NameNode 的内存压力和 DataNode 的读写效率。


