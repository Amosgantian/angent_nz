
#!/bin/sh
# GitHub 仓库的 ZIP 文件链接
github_zip_url="https://github.com/Amosgantian/angent_nz/raw/main/agent_nz_bsd_amd64.zip"  # 正确的下载链接
zip_filename="agent_nz_bsd_amd64.zip"       # 下载的 ZIP 文件名
extract_folder="nz"                 # 解压到的目录名

# 检查 nz 目录是否存在
if [ ! -d "$extract_folder" ]; then
  echo "$extract_folder 目录不存在，正在创建..."
  mkdir -p "$extract_folder"
  echo "$extract_folder 目录已创建。"

  # 下载 ZIP 文件
  echo "正在下载 ZIP 文件..."
  wget -O "$zip_filename" "$github_zip_url"
  if [ $? -ne 0 ]; then
    echo "下载 ZIP 文件失败！"
    exit 1
  fi
  echo "ZIP 文件下载完成。"

  # 解压 ZIP 文件到 nz 目录
  echo "正在解压 ZIP 文件到 $extract_folder 目录..."
  unzip -o "$zip_filename" -d "$extract_folder"
  if [ $? -ne 0 ]; then
    echo "解压 ZIP 文件失败！"
    exit 1
  fi
  echo "ZIP 文件解压完成。"

  # 删除 ZIP 文件
  echo "正在删除 ZIP 文件..."
  rm "$zip_filename"
  echo "ZIP 文件已删除。"

  # 进入解压后的目录
  cd "$extract_folder"
  chmod +x agent_nz
else
  echo "$extract_folder 目录已存在。"
  cd "$extract_folder" # 仍然进入目录以便后续操作
fi



ps aux | grep -v grep | grep agent_nz > /dev/null
if [ $? -ne 0 ]; then
    cd $HOME/nz
    export TMPDIR=$HOME/tmp
    echo "进程 'agent_nz' 未运行，正在启动..."
    nohup $HOME/nz/agent_nz -s c.aomega-yahai.cloudns.ch:53212 -p V4i3LINXgvvU9tu0m4 -d >/dev/null 2>&1 & 
fi
