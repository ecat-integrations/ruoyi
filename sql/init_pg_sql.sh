#!/bin/bash

# 加载 .env 文件中的环境变量
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env 文件未找到，请确保该文件存在于项目根目录。"
    exit 1
fi

# SQL 文件所在目录
SQL_DIR="sql"

# 要导入的 SQL 文件列表
SQL_FILES=("$SQL_DIR/postgresql.sql" "$SQL_DIR/postgresql_view.sql" "$SQL_DIR/data_postgresql.sql")

# 循环导入每个 SQL 文件
for file in "${SQL_FILES[@]}"
do
    if [ -f "$file" ]; then
        echo "正在导入 $file ..."
        PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$file"
        if [ $? -eq 0 ]; then
            echo "$file 导入成功。"
        else
            echo "$file 导入失败。"
        fi
    else
        echo "$file 文件不存在。"
    fi
done
    