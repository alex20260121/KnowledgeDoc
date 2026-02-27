# Xray+Reality自建节点

**Xray + REALITY** 是目前最先进、安全性最高的网络代理技术组合之一。它主要解决了传统代理协议容易被深度数据包检测（DPI）识别和干扰的问题。

简单来说，**Xray** 是核心引擎（类似于 V2Ray 的升级加强版），而 **REALITY** 是它的一种传输层“黑科技”。

## 1. 准备工作

- **准备 VPS：** 一台位于海外的服务器（推荐 Debian 或 Ubuntu 系统）。

- **选择目标网页：** 找一个支持 TLS 1.3 且不在 CDN（如 Cloudflare）背后的网站作为伪装目标（如 `dl.google.com`）。 

### 1.1. 目标站点

在 **[FOFA](https://en.fofa.info/)** 扫描搜索选择一个目标站点，并且目标站点要满足如下条件：

1. 支持 TLS 1.3 协议

2. 使用 X25519 签名算法

3. 支持 HTTP/2 (H2) 协议

4. 不使用 CDN
   
   * 如果 Reality 目标网站使用 CDN, 数据将转发到 CDN 节点, 使你的 Reality 节点成为别人的反向代理加速节点

5. 国外网站, 在中国境内不依赖任何代理可以可直连访问

[FOFA](https://en.fofa.info) 搜索扫描语法：

```bash
asn=="396982" && country=="US" && port=="443" && cert!="Let's Encrypt" && cert.issuer!="ZeroSSL" && status_code="200"
```

检查该目标网站是否支持H2，在开发者工具的控制台输入:

```js
window.chrome.loadTimes()?.npnNegotiatedProtocol
```

检查该目标站点是否套了CDN，只需在域名后面加上`/cdn-cgi/trace`。

## 2. 布署节点

通过运行提供的安装脚本自动配置Systemd。

安装文件层次结构参考[Xray-install](用于在支持 systemd 的操作系统（如 CentOS / Debian / OpenSUSE）中安装 Xray 的 Bash 脚本。)

```bash
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
```

### 2.1. 配置服务端节点


