# env

Linux基础环境配置

用法：

```shell
cd ~
git clone git@github.com:charlestang/env.git
cd env
git submodule init
git submodule update
ln -s ~/env/.zshrc .zshrc
```

然后切换系统默认shell
```shell
chsh -s /bin/zsh
```

配置Vim
```shell
cd ~
ln -s ~/env/.vimrc .vimr
```

这份配置里面，有Vim的相关配置，主要是通过Vundle维护的一些插件，

打开Vim，执行：
```shell
:PluginInstall
```


