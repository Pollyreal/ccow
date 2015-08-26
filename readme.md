# CCOW
## 目录
* [介绍](#介绍)
* [使用说明](#使用说明)
  * [全局配置](#全局配置)
  * [页面](#页面)
  * [业务处理](#业务处理)
  * [操作流程](#操作流程)
* [其他](#其他)
<a name="项目介绍"></a>
## 介绍
*ccow*是易叉公司官网后台，便于管理发布维护网站内容。<br>
包括新闻管理、留言管理、管理员权限。<br>
目前，后端的核心部分已经基本完成。但由于个人时间和能力所限，UI部分没有开发，没有测试完善，存在许多小问题。
<a name="使用说明"></a>
## 使用说明
<a name="全局配置"></a>
### 全局配置

1. web.config配置文件
“`
    <add key="Invite" value="xxxxxx"/><!--邀请码-->
    <add key="constr" value="server=.;Database=CCOW;Trusted_Connection=SSPI"/>
    <add key="newSecTable" value="NEWS_SECTION"/>
    <add key="newsTable" value="NEWS"/>
    <add key="adminTable" value="USER"/>
    <add key="commentsTable" value="COMMENTS"/>
    <add key="key" value="xxxx"/><!--密码编码密钥-->
    <add key="ValidationSettings:UnobtrusiveValidationMode" value="None" />
“`
    * **constr** 数据库登录映射。
    *  **newSecTable**~ **commentsTable**为表名。
    *  **Invite** 注册邀请码
    *  **key** 用户密码加密密钥<br><br>

<a name="页面"></a>
### 页面
1.注册登录login.aspx<br>
2.后台主页index.aspx：基本管理、跳转功能。缺少图片版块单独管理功能。<br>
3.查看版块view-sec.aspx<br>
4.修改版块edit-section.aspx<br>
5.查看新闻view-news.aspx<br>
6.修改新闻edit-news.aspx<br>
7.回复留言view-comments.aspx<br>
8.查看用户&增改权限view-admin.aspx<br>
9.修改个人密码add-admin.aspx<br>
10.母版页 mp.Master<br><br>
* *add-admin.aspx*设置初衷为添加管理员，当url传值id为空时，按钮事件是添加管理员。此后并未删除功能。
* *mp.Master*为母版页，包括导航条、header、footer，管理员当前信息绑定，判断登录状况，登出。
* **view-admin.aspx**由于form不可嵌套问题，**未使用**母版页，功能修改时或需注意。

<a name="业务处理"></a>
### 业务处理
* 添加功能都是直接传给后台事件。（回复留言除外）<br>
* 删除、修改可见状态、回复留言通过ajax方法发送数据并处理。处理页面为tools文件夹下**edit.aspx**<br>
 * 比较需要注意是图片上传、删除的地址问题。因为删除和添加的事件不在同一个文件夹下。图片放在网站根目录下UploadImage文件夹里。<br>
 * 版块 新建或修改版块时设定**无上级版块**的版块才可被选为上级版块，因此只能实现二级。若需实现更多级菜单，可删除该设定，或其他方法实现。
* 权限<br>
 * 使用二进制组合实现。用相与（&）计算判断用户是否具有该权限。<br>
 * 拥有**修改权限**权限的管理员不能修改自己的权限，拥有**删除管理员权限**的管理员不能删除比自己权限大的管理员。<br>
 *  权限的权重完整分布写在*view-admin.aspx*表单value中。修改时js文件夹index.js、几个edit-**.aspx或需改动。<br><br>

 <a name="操作流程"></a>
### 操作流程
用预给的用户名admin 密码登录系统。注册管理员默认权限为1。<br>
管理员栏目-查看所有 目录下可看到管理员权限，并修改。<br>
添加、删除、设置可见。

<a name="其他"></a>
## 其他
时间仓促，功能简陋，望您包涵。
任意的意见和建议，欢迎随意与我沟通,联系方式：
* Email: <pollyng@foxmail.com>
* QQ:373285694
项目的Bug和改进点，可直接提交给我。