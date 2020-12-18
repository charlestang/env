# 鼠须管配置文件说明

刚安装好的鼠须管配置目录，在没有使用`东风破`进行配置的情况下，只有如下的文件：
1. build/ - 里面存储的是编译过的配置文件
2. installation.yaml - 记录了安装的版本等信息
3. luna_pinyin.userdb/ - 一些二进制的文件
4. user.yaml - 记录了用户在使用过程中通过界面修改的配置

本配置文件增加了如下这些：
1. squirrel.custom.yaml - 设置了皮肤颜色
2. default.custom.ymal - 设置了可用的输入法列表和候选字数量为 9
3. double_pinyin_sogou.schema.yaml - 自己定制了一个符合搜狗布局的双拼方案
4. symbols.ymal - 导入了一个符号的集合，用于输入类似  的特殊符号
5. rime.lua - lua 插件的安装配置
6. lua/ - lua 插件代码