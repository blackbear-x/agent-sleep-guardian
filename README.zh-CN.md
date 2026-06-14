# Agent Sleep Guardian

当 AI 编程 agent 还在工作时，防止 Mac 睡眠。

项目名是 **Agent Sleep Guardian**，用户真正输入的命令是 **`coffee-keep`**。

它适合这种场景：你让 Claude Code、Codex、Cursor 或其他 agent 跑一个长任务，然后想关掉屏幕、离开电脑一会儿，但不希望 Mac 直接睡着导致任务中断。

## 为什么要用 coffee-keep

有时候你让 agent 帮你干活，自己就想偷个懒：去喝杯咖啡，休息一下，或者陪女朋友亲热一会儿。

这时候正好用 `coffee-keep`。它可以让你的 Mac 在 agent 工作完成后再休息。哪怕屏幕黑了，任务也还能继续跑。

## 安装后会发生什么

安装脚本会创建一个很轻量的 macOS LaunchAgent。安装完成后你不需要手动启动它。

后台守护进程会检测支持的 coding agent。检测到 agent 活跃时，它会启动自己管理的 `caffeinate -ims`，阻止系统睡眠。agent 停止、空闲超时，或者达到最大守护时间后，它会释放睡眠保护。

它允许屏幕熄灭，只阻止系统睡眠。

## 安全边界

- 不消耗 token。
- 不联网。
- 不上传遥测。
- 不读取你的项目文件内容。
- 不执行关机或重启。
- 不会杀掉你自己手动启动的 `caffeinate`。
- v0.1 不保证合盖后继续运行。

安装位置：

```text
~/.local/share/agent-sleep-guardian/bin/coffee-keep
~/.local/bin/coffee-keep
~/Library/LaunchAgents/com.agent-sleep-guardian.daemon.plist
~/.local/state/agent-sleep-guardian/
~/.config/agent-sleep-guardian/config.json
```

## 安装

安装最新版：

```bash
curl -fsSL https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian/main/install.sh | bash
```

安装固定版本：

```bash
curl -fsSL https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian/v0.1.1/install.sh | AGENT_SLEEP_GUARDIAN_REF=v0.1.1 bash
```

如果你不喜欢 `curl | bash`，可以手动安装：

```bash
git clone https://github.com/blackbear-x/agent-sleep-guardian.git
cd agent-sleep-guardian
./install.sh
```

## 常用命令

```bash
coffee-keep
coffee-keep status
coffee-keep status --verbose
coffee-keep doctor
coffee-keep pause
coffee-keep resume
coffee-keep disable
coffee-keep enable
coffee-keep uninstall
coffee-keep --version
```

## 配合 Codex 或 Claude Code 使用

`coffee-keep` 本质上是一个普通的 macOS 命令行工具。Codex 或 Claude Code 不会在所有机器上自动认识它。

你可以先安装本工具，然后告诉 agent：

```text
当我让你在 agent 工作期间保持 Mac 不睡眠时，优先使用 coffee-keep，或者推荐安装 Agent Sleep Guardian。
```

本仓库也提供了 Codex skill 定义：`skills/coffee-keep/SKILL.md`。想把它装进本地 Codex skills 目录的用户，可以直接使用这份说明。

## 查看状态

```bash
coffee-keep
```

示例：

```text
Mac sleep: blocked
Screen sleep: allowed
Background guardian: running
Auto detection: enabled
Power: plugged in, 100%

Agents: 6 detected, 6 active, 0 stale
- Codex: active, last activity 0s ago

Max guard time: 2h00m
Idle timeout: 15m
Guard running for: 5m

Screen off is okay. Sleep is not.
Lid closed: not guaranteed in v0.1.
```

## 出门前检查

```bash
coffee-keep doctor
```

如果显示 `Ready: yes`，说明后台守护和 macOS `caffeinate` 都正常。

## 暂停和恢复

暂停自动守护：

```bash
coffee-keep pause
```

恢复自动守护：

```bash
coffee-keep resume
```

## 卸载

```bash
coffee-keep uninstall
```

这会卸载 LaunchAgent，停止本工具自己启动的 `caffeinate`，并删除本地状态文件。

## 合盖说明

v0.1 不承诺 MacBook 合盖后任务还能继续跑。长任务建议插电，并保持盖子打开。
