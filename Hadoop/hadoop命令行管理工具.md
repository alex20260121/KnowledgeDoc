# hadoop命令行管理工具

hadoop集群交互主要是命令行(CLI)客户端工具：`hadoop`、`hdfs`、`yarn`、`mapred`，当然除了这些$HADOOP_HOME/sbin下如集群启动脚本命令：`start-dfs.sh`、`stop-dfs.sh`...，打开看一下可以发现全是bash脚本。

## HDFS

hdfs是hadoop分布式文件系统(HDFS)的管理脚本。

### 查看HDFS文件系统状态

```bash
hdfs dfsadmin -report 
```

> [!TIP]
> `hdfs dfsadmin -report` 还有其它一些子参数，如：`-live`、`slownodes`...
> 通过`hdfs dfsadmin -help`将会输出比较详细的说明。

### 列出HDFS文件目录

```bash
hdfs dfs -ls /
```

### 复制目录或文件至HDFS

```bash
hdfs dfs -copyFromLocal <localsrc> <dst>
```

### 复制目录到本地

```bash
hdfs dfs -copyToLocal <src> <localdst>
```

> [!TIP]
> 拷贝至HDFS或从HDFS拷贝至本地等价于`hdfs dfs -put <localsrc> <dst>`、`hdfs dfs -get <src> <localdst>`

### 删除文件或目录

```bash
hdfs dfs -rm -r /path/to/dir
```

### 查看文件内容

```bash
hdfs dfs -cat /path/to/file
```

### 创建目录

```bash
hdfs dfs -mkdir /path/to/dir
```

### 查看目录或文件的使用情况

```bash
hdfs dfs -du -h /path/to/dir
```

### 查看HDFS的容量使用情况

```bash
hdfs dfs -df -h
```

## YARN

YARN（Yet Another Resource Negotiator）是Hadoop的资源管理器，以下是一些常见的YARN命令：

### 查看集群资源状态

```bash
yarn node -list
```

### 查看集群作业状态

```bash
yarn application -list
```

### 查看某个作业的详情

```bash
yarn application -status <application_id>
```

### 强制终止某个作业

```bash
yarn application -kill <application_id>
```

### 提交mapreduce作业

```bash
yarn jar <jar_file> <main_class> <args>
```

