#!/usr/bin/env python3
# coding:utf-8

# dependency: PyYAML 3.13
# the config file should be a YAML file to describe the server
# configurations like this:
# ---
# personal:
#     - user@192.168.1.1:22      local-test-machine
#     - user@172.16.26.1:22      company-test-machine
# working:
#     - user@192.168.1.1:22      local-test-machine
#     - user@172.16.26.1:22      company-test-machine

import sys
import os
import re
from yaml import load
from yaml import FullLoader
from functools import reduce

def get_config_path():
    return os.path.expanduser("~/server_list/config.yml")

def load_config(config_path):
    return load(open(config_path, 'r'), Loader=FullLoader)

def render(servers, template):
    max_width = reduce(max, map(lambda x: len(x[1]), servers))
    for c in servers:
        print(template.replace('{width}',str(max_width)) % c)
    print('')

def section_parse(config, key, order, servers):
    items = []
    for svr in config[key]:
        order += 1
        user, host, port, name = re.split(r'[@:\s]\s*', svr)
        items += [(order, user, host, name)]
        servers += [(user, port, host)]
    return items, servers, order

def main():
    config_path = get_config_path()
    try:
        server_config = load_config(config_path)
    except FileNotFoundError:
        print(f"Error: Config file not found at {config_path}")
        sys.exit(1)

    # 使用 ANSI 转义序列来设置颜色
    # 这里使用了 ANSI 转义序列来设置颜色，格式为 \x1b[属性;前景色;背景色m。
    # 属性: 0 表示重置, 1 表示高亮, 4 表示下划线, 5 表示闪烁, 7 表示反显, 8 表示隐藏
    # 前景色: 30 表示黑色, 31 表示红色, 32 表示绿色, 33 表示黄色, 34 表示蓝色, 35 表示洋红色, 36 表示青色, 37 表示白色
    # 背景色: 40 表示黑色, 41 表示红色, 42 表示绿色, 43 表示黄色, 44 表示蓝色, 45 表示洋红色, 46 表示青色, 47 表示白色
    # 因为属性、背景色在不同的现代终端中支持情况不同，所以这里使用前景色来设置颜色。
    # \x1b[32m 表示绿色
    # \x1b[36m 表示青色
    # \x1b[33m 表示黄色
    # \x1b[35m 表示洋红色
    # \x1b[0m 表示重置颜色
    template = "\x1b[32m%2d) \x1b[36m%{width}s\x1b[0m@\x1b[33m%-18s \x1b[35m#%s\x1b[0m"
    servers = []
    line_num = 0

    working, servers, line_num = section_parse(server_config, 'working', line_num, servers)
    print("Please select the server you want to access:\n\nFor working:\n")
    render(working, template)

    personal, servers, line_num = section_parse(server_config, 'personal', line_num, servers)
    print("Personal:\n")
    render(personal, template)

    number = 0
    while number < 1 or number > len(servers):
        try:
            number = int(input("Type in the number:>"))
        except (EOFError, NameError, SyntaxError, KeyboardInterrupt, ValueError):
            break
        if number >= 1 and number <= len(servers):
            break

    if number > 0:
        svr = servers[number - 1]
        cmd = "ssh -l %s -p %s %s" % svr
        print("Now execute command:")
        print(cmd)
        os.system(cmd)

    sys.exit(0)

if __name__ == "__main__":
    main()
