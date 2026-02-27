# Cloudflare配置SSH内网穿透

Cloudflare作为全球知名CDN服务商，也称为'互联网大善人'，利用其强大的全球网络连接到个人的私人网络，并提供加密的安全连接。

## 1. 创建隧道网络

首先得登陆到Cloudflare门户网站：**Zero Trust** --> **网络** --> **连接器** --> **创建隧道**。
![10.imge](/Win/Pictu/10.png)

- **选择隧道类型**
![11.png](/Win/Pictu/11.png)

- **命名隧道**
![12.png](/Win/Pictu/12.png)

- **安装并运行Cloudflared**
![13.png](/Win/Pictu/13.png)

> [!TIP]
> 选择自己的操作系统类型和版本，由于我是安装在OpenWrt上，所以直接在[github](https://github.com/cloudflare/cloudflared/releases/tag/2026.1.2)下载二进制文件。

### 1.1. 启动cloudflared

因为下载的是二进制可执行文件，可以`chmod +x cloudflared`给予执行权限。

```bash
cloudflared tunnel run --token eyJhIjoiMmZlOTJjNzBlMzM0YTFiZm......RNVl6TTBZakl5TkRBeCJ9
```

> [!TIP]
> `token`后面这一串字符需要保存起来，这个相当于鉴权的令牌。

成功连接如下所示：
![14.png](/Win/Pictu/14.png)

### 1.2. 为该隧道配置域名及路由

![15.png](/Win/Pictu/15.png)

> [!NOTE]
> 端口改为自己的SSH端口。

## 2. 配置终端SSH代理

本文展示的是在MacOS平台下进行终端的连接，当然还有其它连接方式，但这里只用终端来进行演示。

编辑`~/.ssh/config`如下内容：

```bash
Host your_ssh_domain
    User your_ssh_username
    ProxyCommand cloudflared access ssh --hostname %h
    IdentityFile "your_private_key_path"
    Port 22
```

保存退出后直接使用：

```bash
ssh your_domain
```

> [!IMPORTANT]
> 注意：本地也需要安装`cloudflared`哦，不然直接使用ssh会提示`command not found: cloudflared`
