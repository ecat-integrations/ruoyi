<hr>

# 批量构建前端脚本

## 概述

这是一套用于 PostgreSQL 数据库备份和恢复的 Windows 批处理脚本，支持多种备份模式和灵活的配置选项。

## 文件说明

- `build_vue_projects.py` - 批量构建Vue前端脚本

## 系统要求

- Python 3.x
- 
## 安装和配置

### 1. 确保 Python 环境已经安装配置可用

确保以下工具在命令行中可用：
```cmd
python --version
```
## 使用方法

### 基本语法

```cmd
python build_vue_projects.py
```

<hr>


# PostgreSQL 数据库备份和恢复脚本

## 概述

这是一套用于 PostgreSQL 数据库备份和恢复的 Windows 批处理脚本，支持多种备份模式和灵活的配置选项。

## 文件说明

- `postgres_backup_restore.bat` - 备份和恢复脚本

## 系统要求

- Windows 操作系统
- PostgreSQL 12.10 或更高版本
- PostgreSQL 客户端工具（pg_dump, pg_restore, psql）已添加到系统 PATH

## 安装和配置

### 1. 确保 PostgreSQL 工具可用

确保以下工具在命令行中可用：
```cmd
pg_dump --version
pg_restore --version
psql --version
```

如果工具不可用，请将 PostgreSQL 的 bin 目录添加到系统 PATH 环境变量中。

### 2. 配置数据库连接

脚本支持以下默认配置：
- 主机：localhost
- 端口：5432
- 用户：postgres
- 数据库：postgres

可以通过命令行参数覆盖这些默认值。

## 使用方法

### 基本语法

```cmd
postgres_backup_restore.bat [操作] [选项]
```

### 操作类型

- `backup` - 备份数据库
- `restore` - 恢复数据库
- `help` - 显示帮助信息

### 常用示例

#### 1. 备份整个数据库

```cmd
# 备份默认数据库
postgres_backup_restore.bat backup

# 备份指定数据库
postgres_backup_restore.bat backup -d mydatabase

# 备份到指定目录
postgres_backup_restore.bat backup -d mydatabase -o D:\backups

# 备份数据库（提示输入密码）
postgres_backup_restore.bat backup -d mydatabase -W

#### 2. 仅备份表结构

```cmd
postgres_backup_restore.bat backup -d mydatabase -m schema_only
```

#### 3. 仅备份数据

```cmd
postgres_backup_restore.bat backup -d mydatabase -m data_only
```

#### 4. 备份指定表

```cmd
postgres_backup_restore.bat backup -d mydatabase -t "users,orders,products"
```

#### 5. 排除指定表

```cmd
postgres_backup_restore.bat backup -d mydatabase -e "temp_table,log_table"
```

#### 6. 压缩备份

```cmd
postgres_backup_restore.bat backup -d mydatabase -c
```

#### 7. 恢复数据库

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup_file.dump
```

#### 7.1. 恢复数据库（提示输入密码）

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup_file.dump -W
```

#### 8. 恢复指定表

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup_file.dump -t "users,orders"
```

#### 9. 恢复前清理数据库

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup_file.dump --clean
```

#### 10. 仅恢复表结构

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup_file.dump -s
```

## 详细参数说明

### 备份选项

| 参数 | 长参数 | 说明 | 默认值 |
|------|--------|------|--------|
| `-h` | `--host` | 数据库主机 | localhost |
| `-p` | `--port` | 数据库端口 | 5432 |
| `-U` | `--user` | 数据库用户 | postgres |
| `-d` | `--dbname` | 数据库名称 | postgres |
| `-W` | `--password` | 提示输入密码 | - |
| `-P` | `--password-env` | 从环境变量 PGPASSWORD 读取密码 | - |
| `-o` | `--output` | 备份输出目录 | backups |
| `-m` | `--mode` | 备份模式 | full |
| `-f` | `--format` | 备份格式 | custom |
| `-t` | `--tables` | 指定表名 | - |
| `-e` | `--exclude` | 排除表名 | - |
| `-v` | `--verbose` | 详细输出 | - |
| `-c` | `--compress` | 压缩备份文件 | - |

### 恢复选项

| 参数 | 长参数 | 说明 | 默认值 |
|------|--------|------|--------|
| `-h` | `--host` | 数据库主机 | localhost |
| `-p` | `--port` | 数据库端口 | 5432 |
| `-U` | `--user` | 数据库用户 | postgres |
| `-d` | `--dbname` | 数据库名称 | postgres |
| `-W` | `--password` | 提示输入密码 | - |
| `-P` | `--password-env` | 从环境变量 PGPASSWORD 读取密码 | - |
| `-i` | `--input` | 备份文件路径 | - |
| `-t` | `--tables` | 指定要恢复的表名 | - |
| `-v` | `--verbose` | 详细输出 | - |
| `-c` | `--clean` | 恢复前清理数据库 | - |
| `-s` | `--schema-only` | 仅恢复表结构 | - |

### 备份模式

- `full` - 备份表结构和数据（默认）
- `schema_only` - 仅备份表结构
- `data_only` - 仅备份数据

### 备份格式

- `custom` - 自定义格式，压缩且支持选择性恢复（推荐）
- `plain` - 纯文本格式，可读性好但文件较大
- `directory` - 目录格式，便于并行处理大数据库

## 高级功能

### 1. 详细输出模式

使用 `-v` 或 `--verbose` 参数可以查看详细的执行过程：

```cmd
postgres_backup_restore.bat backup -d mydatabase -v
```

### 2. 自动压缩

使用 `-c` 或 `--compress` 参数可以自动压缩备份文件：

```cmd
postgres_backup_restore.bat backup -d mydatabase -c
```

### 3. 选择性恢复

可以从备份文件中选择性恢复特定的表：

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup.dump -t "users,orders"
```

### 4. 清理恢复

使用 `--clean` 参数可以在恢复前删除已存在的对象：

```cmd
postgres_backup_restore.bat restore -d mydatabase -i backup.dump --clean
```

### 5. 密码处理

脚本支持多种密码处理方式：

#### 5.1. 交互式密码输入

使用 `-W` 或 `--password` 参数提示用户输入密码：

```cmd
postgres_backup_restore.bat backup -d mydatabase -W
```

#### 5.2. 环境变量密码

使用 `-P` 或 `--password-env` 参数从环境变量 `PGPASSWORD` 读取密码：

```cmd
# 设置环境变量
set PGPASSWORD=mypassword

# 使用环境变量中的密码
postgres_backup_restore.bat backup -d mydatabase -P
```

#### 5.3. 自动检测环境变量

如果没有指定密码参数，脚本会自动检查环境变量 `PGPASSWORD`：

```cmd
# 设置环境变量
set PGPASSWORD=mypassword

# 脚本会自动使用环境变量中的密码
postgres_backup_restore.bat backup -d mydatabase
```

**安全提示：**
- 使用环境变量时，密码可能会在进程列表中可见
- 建议在脚本执行完成后清除环境变量：`set PGPASSWORD=`
- 对于生产环境，建议使用 PostgreSQL 的 `.pgpass` 文件或 SSL 证书认证

## 故障排除

### 常见问题

#### 1. 找不到 PostgreSQL 工具

**错误信息：**
```
错误: 找不到 pg_dump 工具，请确保 PostgreSQL 已安装并添加到 PATH
```

**解决方案：**
- 确保 PostgreSQL 已正确安装
- 将 PostgreSQL 的 bin 目录添加到系统 PATH 环境变量
- 重启命令提示符或 PowerShell

#### 2. 连接数据库失败

**错误信息：**
```
错误: 备份失败
```

**解决方案：**
- 检查数据库连接参数（主机、端口、用户名、密码）
- 确保数据库服务正在运行
- 检查防火墙设置
- 验证用户权限

#### 3. 权限不足

**错误信息：**
```
错误: 恢复失败
```

**解决方案：**
- 确保用户具有足够的权限
- 检查数据库是否存在
- 验证备份文件格式是否正确

### 调试技巧

1. **使用详细模式**：添加 `-v` 参数查看详细输出
2. **检查工具版本**：确保 PostgreSQL 工具版本兼容
3. **测试连接**：使用 `psql` 手动测试数据库连接
4. **查看日志**：检查 PostgreSQL 服务器日志

## 最佳实践

### 1. 备份策略

- 定期进行完整备份
- 使用自定义格式（custom）以获得最佳性能和灵活性
- 启用压缩以节省存储空间
- 保留多个备份版本

### 2. 恢复策略

- 在恢复前测试备份文件的完整性
- 使用 `--clean` 参数确保干净的恢复
- 在恢复生产数据库前先在测试环境中验证

### 3. 安全考虑

- 保护备份文件的安全
- 使用强密码
- 限制备份文件的访问权限
- 考虑加密备份文件

## 版本历史

- **v1.0.1** - 修复脚本执行流程问题
- **v1.0.0** - 初始版本

## 技术支持

如果遇到问题，请：

1. 检查本文档的故障排除部分
2. 使用详细模式（-v）获取更多信息
3. 验证 PostgreSQL 工具是否正确安装
4. 检查数据库连接参数

## 许可证

本脚本采用 MIT 许可证，可自由使用和修改。 
