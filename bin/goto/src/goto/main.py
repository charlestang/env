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

    template = "\x1b[0;32;40m%2d) \x1b[0;36;40m%{width}s\x1b[0m@\x1b[0;33;40m%-18s \x1b[1;35;40m#%s\x1b[0m"
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
