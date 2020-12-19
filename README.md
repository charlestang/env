# env

## 目录

- [env](#env)
  - [目录](#目录)
  - [安装方法](#安装方法)
    - [1. 获取所有配置](#1-获取所有配置)
    - [2. 初始化`zsh`](#2-初始化zsh)
    - [3. 初始化`bash`](#3-初始化bash)
    - [4. 初始化`Vim`](#4-初始化vim)
  - [快捷命令介绍](#快捷命令介绍)
    - [1. `brew_upgrade`](#1-brewupgrade)
    - [2. `color_sheet`彩虹表](#2-colorsheet彩虹表)
    - [3. `goto`](#3-goto)
    - [4. `online`](#4-online)
    - [5. `md-to-toc`](#5-md-to-toc)

## 安装方法

### 1. 获取所有配置

使用`git`将代码克隆到本地，一般放在 `~` 文件夹中。因为`oh-my-zhs`和`bash-it`是引用`submodule`引用的功能，所以，需要初始化子模块。

```shell
cd ~
git clone git@github.com:charlestang/env.git
cd env
git submodule init
git submodule update
```

### 2. 初始化`zsh`

在`Mac`上，我喜欢使用`zsh`作为`shell`。切换系统默认`shell`为`zsh`。

```shell
chsh -s /bin/zsh
```

然后，挂载配置文件。

```shell
ln -s ~/env/.zshrc ~/.zshrc
```

如果需要自定义一些环境变量，或者自定义一些`alias`可以写入到`~/.zshrc.local`文件中，会被自动引用。挂载好配置文件，可以使用`source`命令，或者重新打开 Term 软件。

### 3. 初始化`bash`

在`Linux`上我喜欢使用`bash`作为`shell`，这个步骤和上面第 2 步不用都配置。挂载`bash`配置文件的方法有所不同。因为`bash-it`是个类似`shell`编写成的软件一样的存在，需要使用`install.sh`脚本来安装激活。执行下面的脚本，会在命令行启动一个交互式的安装过程，按照向导一步一步执行即可完成`bash`的配置挂载。

```shell
cd ~
env/bash-it/install.sh
```

安装完毕后，执行`bash-it show plugins`就可以看到`bash-it`提供的各种插件和功能。激活喜欢的插件即可。相比`oh-my-zsh`而言，我觉得`bash-it`的性能似乎更好一点，经常相应的速度更快一些。在性能低下的`Linux`上效果要好很多，而且一般是默认安装的，所以，在`Linux`上我更喜欢使用`bash-it`。

### 4. 初始化`Vim`

对于程序员来说，最重要的编辑器，莫过于是`Vim`了。使用下面的命令来挂载配置文件。

```shell
cd ~
ln -s ~/env/.vimrc .vimr
```

这份配置里面，有Vim的相关配置，主要是通过`vim-plug`维护的一些插件，

打开Vim，执行：
```shell
:PlugInstall
```

`vim-plug`可以并发地安装或者更新`vim`插件，而且使用的是`shallow copy`，所以速度很快，体验不错。

## 快捷命令介绍

在`env/bin`目录下，有几个我用`shell`脚本或者`python`脚本编写的命令，这里进行一些介绍。

### 1. `brew_upgrade`

如果在`Mac`上安装了`brew`这个命令的话，可以用这个命令来更新`Mac`上安装的软件。

### 2. `color_sheet`彩虹表

这个命令会在`Term`软件里打印一个颜色码表，主要是编写彩色的`shell`脚本时候的参考手册。

### 3. `goto`

这是`python`编写的远程服务器登录脚本。这个脚本，目前是`python 2.7`环境下编写和运行的，因为我的`Mac`默认的就是这个`python`版本。依赖`PyYAML`包，服务器的配置文件是用`yaml`格式来配置的。

配置文件需要放在`$HOME/server_list/config.yaml`文件中：

```yaml
# 服务器列表样例配置文件:
---
personal:
    - user@192.168.1.1:22      local-test-machine
    - user@172.16.26.1:22      company-test-machine
working:
    - user@192.168.1.1:22      local-test-machine
    - user@172.16.26.1:22      company-test-machine
```

按照上面的格式编写一个服务器列表，就可以在使用`goto`命令了。

### 4. `online`

这是一个`shell`脚本，作用是“上线”。主要是Web开发时候使用的，作用是把一个文件夹下面的文件和目录都变成`www-data`用户的。如果，目录中有`.git`或者`.svn`文件夹，则将这两个文件夹变成`root`用户的，所以，显然执行这个命令需要`root`权限。这是习惯不好的时候，维护服务器时候用的。可以用`sudo`来执行此命令。

### 5. `md-to-toc`

一个脚本，作用是给一个`Markdown`文件生成目录字符串，如果要编写一个很长的`README.md`的时候，用这个生成目录，可以提高阅读体验，主要是为了GitHub下的说明文件用的，因为 GitHub 不支持 `TOC` 这样的语法。代码是开源的可以参看[这里](https://github.com/amaiorano/md-to-toc)。
