# 声明

> [!IMPORTANT]
> 本文中所有 **$** 符号后面连接的字符串均为变量。如：
> `$hostname` 代表主机名是一个变量。

## 1. 克隆虚拟机
>
> [!NOTE]
> 克隆之前需要提前关闭被克隆的虚拟机

```bash
virt-clone -o TEMPLATE-VM -n new-vm -f /vm-storage/vm-disk/new-vm.qcow2
```

## 2. 创建虚拟机

创建一台使用console控制台完成安装的虚拟机。

```bash
sudo virt-install --name k8s_master_template  \
--memory 4096 --vcpus 2 \
--metadata description="kubernetes master template" \
--location /res/ubuntu-20.04.6-live-server-amd64.iso,kernel=casper/hwe-vmlinuz,initrd=casper/hwe-initrd \
--disk /virtd/disk-img/k8s_master_template.qcow2,size=100 \
--network bridge=br0 --graphics none \
--console pty,target_type=serial \
--noautoconsole \
--extra-args "console=ttyS0,115200n8 serial"
```

![install](/KVM/img/1.png)
> [!TIP]
> 在`--location`参数中指定内核按照当前发行版实际文件名，有的kernel可能是`vmlinuz`，而initrd可能是`initrd`

## 3. 进入虚拟机控制台

登陆KVM虚拟机控制台 **(console)**。

```bash
virsh console $hostname
```

## 4. 列出当前所有虚拟机

列出当前所有虚拟机，包括 **开机，关机** 所有状态。

```bash
virsh list --all
```

![list](/KVM/img/2.png)

## 5. 为虚拟机增加一块磁盘

首先得创建一块磁盘，推荐使用`qcow2`格式的磁盘，它支持动态分配空间和快照。

```bash
# 语法: qemu-img create -f 格式 路径 大小
qemu-img create -f qcow2 /var/lib/libvirt/images/new-disk.qcow2 20G
```

将该磁盘挂载到目标虚拟机。

```bash
# 语法: virsh attach-disk <虚拟机名称> <源磁盘路径> <目标设备名> [参数]

virsh attach-disk my-vm /var/lib/libvirt/images/new-disk.qcow2 vdb \
--targetbus virtio \
--subdriver qcow2 \
--config --live
```

> [!NOTE]
> 参数：
> --targetbus virtio: 使用 VirtIO 总线（性能最好）。
> --subdriver qcow2: 指定驱动类型。
> --config: 将配置写入 XML 文件，重启后依然有效（持久化）。
> --live: 立即生效，无需关闭虚拟机（热添加）。
**注意：** 建议同时使用 --config 和 --live 以确保即时生效且永久保存。