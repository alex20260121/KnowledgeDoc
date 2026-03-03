# RockyLinux操作系统运维

RockyLinux跟RedHat和Centos是同宗同源。
在红帽公司（Red Hat）宣布停止维护稳定的 CentOS 8，并转向滚动更新的 CentOS Stream 后，社区失去了最受欢迎的免费企业级发行版。CentOS 的联合创始人 Gregory Kurtzer 随即发起了 Rocky Linux 项目，旨在提供一个百分之百兼容 RHEL 的社区版操作系统。

## 1. 设置静态网络IP地址

通过 `ip addr` 找出需要设置静态IP的网卡名称，按以下步骤执行。

- 设置IP地址和掩码

```bash
nmcli connection modify enp1s0 ipv4.addresses 192.168.2.14/32
```

- 设置网关

```bash
nmcli connection modify enp1s0 ipv4.gateway 192.168.2.1
```

- 设置DNS

```bash
nmcli connection modify enp1s0 ipv4.dns "192.168.2.1 223.5.5.5"
```

- 将DHCP模式改为Manual

```bash
nmcli connection modify enp1s0 ipv4.method manual
```

- 重新激活网卡

```bash
nmcli connection up enp1s0
```

> [!NOTE]
> 用该命令配置网络也支持持久化，会写入网络配置文件 `/etc/NetworkManager/system-connections/enp1s0.nmconnection`
