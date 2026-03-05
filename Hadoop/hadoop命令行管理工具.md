# hadoop命令行管理工具

hadoop集群交互主要是命令行(CLI)客户端工具：`hadoop`、`hdfs`、`yarn`、`mapred`，当然除了这些$HADOOP_HOME/sbin下如集群启动脚本命令：`start-dfs.sh`、`stop-dfs.sh`...，打开看一下可以发现全是bash脚本。

## hdfs

hdfs是hadoop分布式文件系统(HDFS)的管理脚本。

- **查看HDFS文件系统状态：**

```bash
hdfs dfsadmin -report 
```

> [!TIP]
> `hdfs dfsadmin -report` 还有其它一些子参数，如：`-live`、`slownodes`...
> 通过`hdfs dfsadmin -help`将会输出比较详细的说明。

- **列出HDFS文件目录**

```bash
hdfs dfs -ls /
```

- **复制目录或文件至HDFS**

```bash
hdfs dfs -copyFromLocal <localsrc> <dst>
```

- **复制目录到本地**

```bash
hdfs dfs -copyToLocal <src> <localdst>
```

> [!TIP]
> 拷贝至HDFS或从HDFS拷贝至本地等价于`hdfs dfs -put <localsrc> <dst>`、`hdfs dfs -get <src> <localdst>`
