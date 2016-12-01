# 这是 Ruby on Rails Tutorial 教程

[应用的在线地址](https://getsukamiy.herokuapp.com/)

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Getting started

得到应用: 

```
$ git clone https://github.com/GetsuKami/my-first-app.git
```
修改database.yml,适合自己的：

```
$ vim config/database.yml
```

执行bundle: 如果没有gem，请安装：

```
$ bundle install --without production
```

创建数据库、执行迁移：

```
$ rails db:create
$ rails db:migrate
```

执行seed：

```
$ rails db:seed
```

最后运行测试:

```
$ rails test
```

上述都成功之后运行服务器:

```
$ rails server
```

更多的信息，请看：
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book)