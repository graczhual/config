⚠️ **请注意：在公司已连接内网的同时，不要连接公司的 VPN**

vpn地址（外网）：vpn.graviti.cn:9090

**一、安装**
在[onedrive](https://graviti.sharepoint.cn/sites/devops/Shared%20Documents/Forms/AllItems.aspx?originalPath=aHR0cHM6Ly9ncmF2aXRpLnNoYXJlcG9pbnQuY24vOmY6L3MvZGV2b3BzL0VoM1NzcVJpcWloQmxVTUdkOHM4OXZRQlAtekdseVRlQk1mNkV4SXY5WWlCcWc%5FcnRpbWU9ekEyQjN1TlAyVWc&viewid=28fee6c6%2D252d%2D4336%2D8816%2D9d0d6cae0be3&id=%2Fsites%2Fdevops%2FShared%20Documents%2FVPN%20%E5%AE%89%E8%A3%85%2FAnyConnect%20VPN%20%E5%AE%89%E8%A3%85%E5%8C%85)中，选择对应系统的安装包。
- win是windows下的安装包
- macos是mac下的安装包
- linux则是Ubuntu等linux下的安装包

**1、windows安装：**
将anyconnect-win-4.7.04056-predeploy-k9.zip下载下来，解压：
{F20048}

点击"setup.exe"，只选择"Core & VPN"
{F20050}

点击安装，等待安装完毕即可。

**2、ubuntu安装：**

```
[root@localhost ~]# tar zxf anyconnect-linux64-4.7.04056-predeploy-k9.tar.gz
[root@localhost ~]# cd anyconnect-linux64-4.7.04056/vpn/
[root@localhost vpn]# ./vpn_install.sh
```
在输出的信息中，选择填y，回车：
{F20052}

安装完毕后，就能看到anyconnect的客户端了：
{F20054}


**3、Mac安装**
下载anyconnect-macos-4.8.00175-predeploy-k9.dmg
安装即可。

**4、android/ios**
android/ios可以在应用商店里搜索anyconnect，下载下来就可以了。

**二、使用**
根据不同的系统，下载好不同的客户端后，以windows为例：
{F20060}
填写vpn访问地址"vpn.graviti.cn:9090"，点击"connect"
接下来会进入到登录页面：
{F20064}
输入ldap账户，点击ok，进入到密码输入界面：
{F20066}
输入密码后并确定。
如果ocserv能正确通过freeradius认证的话，我们就能连接成功：
{F20070}
接下来就能愉快访问公司内网了
