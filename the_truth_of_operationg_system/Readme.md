## 环境配置注意事项
- gcc4.6版本安装：

```
vim /etc/apt/sources.list

增加
deb http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse

sudo apt update
sudo apt install gcc-4.6
```