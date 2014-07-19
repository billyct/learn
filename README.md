# LEARN

## 一个Meteor编写的[在线教育网站](http://learn-app.meteor.com)程序

Learn 是一个[Meteor](http://meteor.com)编写的[在线教育网站](http://learn-app.meteor.com)程序，实时WEB，重要的在于分享以及讨论使用Meteor这个有趣的东西在编写程序遇到的事情

DEMO地址:[http://learn-app.meteor.com](http://learn-app.meteor.com)



## 开始

确保你已经开始使用[Node](http://nodejs.org)和[Meteor](http://meteor.com)

### 步骤 1: 克隆源码

```bash
$ git clone https://github.com/billyct/learn.git
```

### 步骤 2: 设置
配置lib/setting.js文件里面的github开放平台和qiniu的存储秘钥等配置

可以在collections/schemas.coffee文件里，初始化课程类型等数据

### 步骤 3: 安装

```bash
$ cd learn
$ mrt
```
然后访问[http://localhost:3000](http://localhost:3000)

## 关于修改的一些东西
因为mrt了moment包，但是这个包并没有使用中文语言所以，所以如果有需要的话，可以自己修改
```bash
/packages/moment/package.js
```
并且加入
```javascript
api.add_files('lib/moment/lang/zh-cn.js', where)
```

vender里面的marked.js不是原生的marked.js为了配合prism的语法高亮所以修改了里面的case code时候的return
```javascript
return '<pre'
  +' class="'
  + this.options.langPrefix
  + this.token.lang
  + '"'
  + '><code'
  + (this.token.lang
  ? ' class="'
  + this.options.langPrefix
  + this.token.lang
  + '"'
  + 'data-language="'
  + this.token.lang
  + '"'
  : '')
  + '>'
  + this.token.text
  + '</code></pre>\n';
```

## 未完成的东西
* ~~subscribe和publish不够干净~~
* ~~管理员管理课程类别~~
* 个人页面和管理员页面
* ~~在线支付~~改成捐赠方便高效
* 本地的文件和(本地视频的转码,可能需要本地转码)，因为现在只是把文件上传到[七牛](http://qiniu.com)
