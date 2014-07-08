# LEARN

## 一个Meteor编写的在线教育网站程序

Learn 是一个[Meteor](http://meteor.com)编写的在线教育网站程序，实时WEB，重要的在于分享以及讨论使用Meteor这个有趣的东西在编写程序遇到的事情


## 开始

确保你已经开始使用[Node](http://nodejs.org)和[Meteor](http://meteor.com)

### 步骤 1: 克隆源码

```bash
$ git clone https://github.com/billyct/learn.git
```

### 步骤 2: 安装

```bash
$ cd learn
$ mrt
```
然后访问[http://localhost:3000](http://localhost:3000)

## 一些东西
因为mrt了moment包，但是这个包并没有使用中文语言所以，所以如果有需要的话，可以自己修改
```bash
/packages/moment/package.js
```
并且加入
```javascript
api.add_files('lib/moment/lang/zh-cn.js', where)
```

## 希望能够在未来的版本里面出现的功能
1.在线支付
2.本地的文件和(本地视频的转码,可能需要本地转码)，因为现在只是把文件上传到[七牛](http://qiniu.com)
