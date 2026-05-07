# Web 项目硬化 Playbook

适用场景：
- Flask / FastAPI / Node / 静态前端混合项目
- “能跑但不稳定”的原型项目
- 启动链路、页面入口、API 验证、tunnel/公网暴露混乱

## 优先级顺序

### 1. 统一启动真相源
先回答三个问题：
1. 标准启动脚本是哪一个？
2. 标准 Python / Node 入口是哪一个？
3. 标准监听端口是哪一个？

产物：
- `start.sh`
- `AGENTS.md`
- `docs/architecture.md`

### 2. 收敛历史脚本
不要一上来删除旧脚本。先把旧脚本改成兼容转发：
- `old-start.sh -> exec ./start.sh`
- `old-public.sh -> exec ./start_public.sh`

原则：
- 先收敛，再清理
- 保留兼容性，但停止分叉逻辑

### 3. 建最小一致性检查
至少检查：
- 启动脚本引用的入口文件是否存在
- README 启动命令是否与真实入口一致
- 端口是否统一
- 兼容脚本是否已收敛

产物：
- `check-consistency.sh`

### 4. 建最小 smoke test
至少检查：
- 首页可访问
- 一个核心 API 返回 success
- 一个“扩展能力”API 返回 success

产物：
- `smoke_test.sh`

### 5. 最后再做 tunnel/公网标准化
前提：
- 本地服务必须先稳定
- tunnel 只允许代理到标准端口

产物：
- `start_tunnel.sh`
- `start_public.sh`

## 常见反模式

### 反模式 1：脚本能跑，但入口错了
症状：
- `start.sh` 指向不存在的文件
- 服务名换了，脚本没改

修复：
- 把入口显式收敛到 `main.py` / `app.py` / `server.js` 之一
- 用一致性脚本检查引用文件存在性

### 反模式 2：README 讲的是旧世界
症状：
- README 还写 `python app.py`
- 实际入口已经变成 `main.py`

修复：
- README、AGENTS、脚本同时更新
- 用 `check-consistency.sh` 检查 README 中的启动命令

### 反模式 3：本地入口和公网入口各玩各的
症状：
- 本地服务跑 8002
- tunnel 却代理 8000 / 5000

修复：
- tunnel 脚本固定代理 `127.0.0.1:<标准端口>`
- 用检查脚本验证端口一致性

## 最小交付标准
一个 Web 项目完成第一轮硬化后，至少应该有：
- 单一启动真相源
- `AGENTS.md`
- `docs/architecture.md`
- `check-consistency.sh`
- `smoke_test.sh`
- README 与真实入口一致
