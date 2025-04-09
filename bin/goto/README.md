## 安装方法

### 0. 环境

```bash
pipx ensurepath
```

### 1. 开发模式安装（推荐）：

```bash
pipx install -e .
```

### 2. 直接安装：

```bash
pipx install .
```

### 3. 使用方法

```bash
goto
```

### 4. 配置文件

配置文件位于 `~/server_list/config.yml`，格式如下：

```yaml
# the config file should be a YAML file to describe the server
# configurations like this:
---
personal:
    - user@192.168.1.1:22      local-test-machine
    - user@172.16.26.1:22      company-test-machine
working:
    - user@192.168.1.1:22      local-test-machine
    - user@172.16.26.1:22      company-test-machine
```