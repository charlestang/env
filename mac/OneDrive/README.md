# OneDrive 进程守护

macOS 登录后自动运行，每 5 分钟检查当前用户的 OneDrive 主进程。进程不存在时启动 `/Applications/OneDrive.app`，并记录执行启动的时间。进程存在时不做任何操作，也不写日志。

## 安装

在终端进入本文件所在目录，执行：

```bash
mkdir -p "$HOME/Library/Application Support/local.onedrive.watchdog" "$HOME/Library/LaunchAgents"
cp check_onedrive.sh "$HOME/Library/Application Support/local.onedrive.watchdog/"
cp local.onedrive.watchdog.plist "$HOME/Library/LaunchAgents/"
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/local.onedrive.watchdog.plist"
```

加载后立即检查一次，以后每 300 秒检查。无需管理员权限，也无需安装其他软件。如果此前安装了其他 OneDrive 守护任务，请先停用，避免重复运行。

## 查看日志

```bash
tail -n 20 "$HOME/Library/Logs/local.onedrive.watchdog/watchdog.log"
```

只有实际执行成功的启动命令才会记录一行；首次拉起前，日志文件可能不存在。记录代表已提交启动请求，不代表同步已经恢复。

## 查看任务

```bash
launchctl print "gui/$(id -u)/local.onedrive.watchdog"
```

## 卸载

```bash
launchctl bootout "gui/$(id -u)" "$HOME/Library/LaunchAgents/local.onedrive.watchdog.plist"
rm "$HOME/Library/LaunchAgents/local.onedrive.watchdog.plist"
rm "$HOME/Library/Application Support/local.onedrive.watchdog/check_onedrive.sh"
rmdir "$HOME/Library/Application Support/local.onedrive.watchdog"
```

日志保留在 `~/Library/Logs/local.onedrive.watchdog/watchdog.log`，可以自行删除。

## 范围

只检查进程是否存在，不检测假死或同步状态。手动退出 OneDrive 后也会自动拉起。LaunchAgent 在用户登录后运行；电脑睡眠期间不执行检查。
