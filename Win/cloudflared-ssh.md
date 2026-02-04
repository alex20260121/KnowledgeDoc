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

