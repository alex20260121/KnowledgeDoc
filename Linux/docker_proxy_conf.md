# 设置Docker网络代理

Docker Hub 在国内是被墙的，导致现在想拉取镜像都被拒绝或网络重置，如果你在墙外有一台国外的服务器并且己经搭建好了自己的翻墙网络代理，那么只需要设置Docker daemon网络代理就可以解决任何拉取镜像的问题。

## 1. 误区

我之前以为在Linux终端配置了代理就可以解决上述问题，但后面发现Docker pull 默认是“用不到”`export ALL_PROXY="socks5://127.0.0.1:10810"`

原因是 docker pull 的网络请求是 Docker daemon（后台服务）发起的，而不是当前 shell。

**Docker 的工作模式：**

```lua
docker pull  →  docker CLI（前端）
                 ↓
              dockerd（系统服务，systemd 管理）
                 ↓
            直接访问 registry-1.docker.io
```

> [!NOTE]
> 
> dockerd 是 systemd 启动的系统服务，不会继承你终端里的环境变量，所以它根本不知道 ALL_PROXY 的存在。

## 2. 正确的设置Docker代理

给 Docker daemon 设置代理，而不是 shell。

### 2.1. 创建 systemd 代理配置目录

```bash
mkdir /etc/systemd/system/docker.service.d
```

### 2.2. 创建代理配置文件

```bash
vim /etc/systemd/system/docker.service.d/proxy.conf
```

内容如下：

```ini
[Service]
Environment="HTTP_PROXY=socks5h://192.168.135.1:10810"
Environment="HTTPS_PROXY=socks5h://192.168.135.1:10810"
Environment="NO_PROXY=localhost,127.0.0.1,.local"
```

> [!TIP]
> 
> 将IP地址改成自己的代理地址。

### 2.3. 重新加载并重启 Docker

```bash
systemctl daemon-reexec
systemctl daemon-reload
systemctl restart docker
```

### 2.4. 验证代理是否生效

```bash
systemctl show docker.service --property='Environment'
```

[!img](/Linux/shotcut/b844d2c7-a4e7-4cbe-a9bd-685a2a62b363.png)
