#set page(
  width: 40cm,
  height: 60cm,
  flipped: true,
  footer: [
    #set align(right)
    #image("image/logo.svg", width: 2%),
  ],
  margin: (x: 3cm, y: 2cm),
)
#set text(font: "Source Han Serif SC")

#show raw.where(block: false): it => {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )[
    #set text(size: 10pt)
    #raw(it.text, lang: "bash", block: true)
  ]
}

#let commandBlock(body, title: "", command: "") = {
  box(
    width: 100%,
    stroke: (
      paint: gray,
      thickness: 0.5pt,
    ),
    inset: 12pt,
    outset: 0pt,
    radius: 5pt,
    clip: true,
  )[
    #text(
      size: 11pt,
      weight: "bold",
      font: "Source Han Serif SC",
    )[
      #title
    ]
    #raw(command, lang: "bash")

    #set text(
      size: 9pt,
      font: "Source Han Serif SC",
    )
    #body
  ]
}


#columns(5)[
  == 文件操作
  #commandBlock(title: "列目录与文件:", command: "ls [options] file")[
    - 包含隐藏文件在内的所有 (#strong[a]ll) 文件: `ls -a`
    - 列出详细 (#strong[l]ong) 信息: `ls -l`
    - 以人类 (#strong[h]uman) 格式显示文件大小: `ls -lh`
    - 递归 (#strong[R]ecursive) 列出所有子文件: `ls -R`
  ]


  #commandBlock(title: "列出目录树:", command: "tree [options] dir")[
    - 列出家目录的树: `tree ~`
    - 仅列出树中的文件夹 (#strong[d]irectory): `tree -d`
    - 列出含隐藏文件在内的所有 (#strong[a]ll) 文件的目录树: `tree -a`
  ]

  #commandBlock(title: "复制:", command: " cp [options] source dest")[
    - 复制 `~/A` 到 `/tmp/B`: `cp ~/A /tmp/B`
    - 递归 (#strong[r]ecursive) 复制目录: `cp -r ~/dirA /tmp/dirB`
    - 复制时显示详细 (#strong[v]erbose) 信息: `cp -v ~/A /tmp/B`
  ]

  #commandBlock(title: "重命名/移动:", command: "mv [options] source dest")[
    - 重命名 `A` 到 `B`: `mv A B`
    - 将 `A` 移动到家目录: `mv A ~/`
  ]

  #commandBlock(title: "删除:", command: "rm [options] file")[
    - 递归 (#strong[r]ecursive) 删除 A 目录: `rm -r A`
    - 递归删除且不作确认 (#strong[f]orce): `rm -rf A` #strong(text(fill: red)[(谨慎使用!)])
  ]

  #commandBlock(title: "读取文件开头:", command: "head [options] file")[
    - 读文件开头 100 行 (li#strong[n]e): `head -n 100 A`
    - 读文件开头 100 字符 (#strong[c]har): `head -c 100 A`
  ]

  #commandBlock(title: "读取文件结尾:", command: "tail [options] file")[
    - 读文件结尾 100 行 (li#strong[n]e): `tail -n 100 A`
    - 读结尾并实时跟随 (#strong[f]ollow) 更新: `tail -f A`
  ]

  #commandBlock(title: "链接:", command: "ln [options] file link")[
    - 作 `A` 指向 `/B` 的符号链接 (#strong[s]ymlink): `ln -s /B A`
    - 作 `A` 和 `/B` 的硬链接: `ln /B A`
  ]

  #commandBlock(title: "以行为单位选择内容:", command: "cut [options] file")[
    - 以空格为分隔符 (#strong[d]elimiter)，并选择第二项 (#strong[f]ield):

    ```
    curl --version | head -n 1 | cut -d' ' -f2
    ```

  ]

  #commandBlock(title: "修改文件权限位:", command: "chmod [options] mode file(s)")[
    - 递归 (#strong[R]ecursive) 修改权限: `chmod -R 755 A` #strong(text(fill: red)[(谨慎使用!)])
    - *权限的表示：符号*
      - 格式: `[ugoa][[+-=][perms]],...`
      - 例子: `u+x`,`o-wx`,`g-w`
      #table(
        columns: (auto),

        [u: #strong[u]ser/owner g: #strong[g]roup\
          o: #strong[o]thers a: #strong[a]ll],
        [+: 添加 -: 删除 =: 设置为],
        [r: #strong[r]ead w: #strong[w]rite\
          x: e#strong[x]ecute (可执行/列目录)],
      )
      - 特殊权限 (s, t, S, T) 参考 `man chmod`
    - *权限的表示：八进制数字*
      - 格式: 四位八进制数字，第一位可选
      - 例子: `755 (rwxr-xr-x)`
        - 第一位: 一般为 `0`，特殊权限参考 `man chmod`
        - 第二位: 所有者权限
        - 第三位: 用户组权限
        - 第四位：其他用户权限
      - 读: `4 (100)` 写: `2 (010)` 可执行: `1 (001)`
  ]

  #commandBlock(title: "搜索文件:", command: "find path [options] [搜索条件] [动作]")[
    - 搜索所有 MP4 视频文件: `find . -name '*.mp4'`
    - 搜索所有 `*.pyc` 文件并删除: `find . -name '*.pyc' -delete` #strong(text(fill: red)[(谨慎使用!)])
    - *搜索条件:*
      - `-name xyz*`: 名字匹配 `xyz*`
      - `-iname xyz*`: 名字匹配，不区分 (insensitive) 大小写
      - `-type d`: 只匹配目录 (directories)
      - `-type f`: 只匹配文件 (files)
      - `-mtime 0`: 1 天内修改的文件
      - `-mtime -x`: 在 x 天内修改
      - `-mtime +x`: 在 x 天外修改
      - `-mmin -x`: 在 x 分钟内修改
      - `-size +100M`: 大小大于 `100MiB`
      - `-size -100M`: 大小小于 `100MiB`
      - `(1 MiB = 1024 KiB = 1024 * 1024 B)`
      - `-perm /o+w`: 权限 (permission) 为可被他人写入
      - `! -perm /o+r`: 权限 (permission) 为不(!)可被他人读取
    - *动作:*
      - `-print`: 输出匹配项
      - `-delete`: 删除匹配文件
      - `-exec cmd '{}' ;`: 对每个匹配执行命令 (`cmd` 执行 n 次)
      - `-exec cmd '{}' +`: 聚集匹配后执行一次命令 (`cmd` 执行 1 次)
      - `-fprint /tmp/result`: 输出匹配项到 `/tmp/result`
  ]

  #commandBlock(title: "比较文件:", command: "diff [options] files")[
    - 比较 A 与 B 的差异: `diff A B`
    - 递归 (#strong[r]ecursive) 比较目录: `diff -r Adir Bdir`
    - 将被比较文件视为纯文本看待: `diff -a A B`
    - 存在差异时不 (#strong[q]uiet) 输出具体差异: `diff -q A B`
  ]

  #commandBlock(title: "搜索文件内容:", command: "grep [options] pattern files")[
    - 显示文件 A 中包含 hello 的行: `grep hello A`
    - 大小写不敏感 (#strong[i]gnore case) 搜索: `grep -i hello A`
    - 递归 (#strong[r]ecursive) 搜索当前目录下包含 hello 的文件，并忽略二进制 (-I): `grep -rI hello .`
    - 搜索文件中包含 hello 或者 world 的行: `grep -E 'hello|world' A`
    - 提示：可以试试更好用的搜索工具 `ripgrep`
  ]

  #commandBlock(title: "查看/连接文件:", command: "cat [options] file(s)")[
    - 查看文件 A: `cat A`
    - 连接 A, B, C 文件到 D: `cat A B C > D`
  ]

  #commandBlock(title: "排序:", command: "sort [options] file")[
    - 按照数字 (#strong[n]umeric) 倒序 (#strong[r]everse) 排序: `cat A | sort -nr`
  ]

  #commandBlock(title: "去重:", command: "uniq [options] input output")[
    - 使用 `uniq` 前需要先排序，因此一般和 `sort` 一起用
    - 去重并统计 (#strong[c]ount) 重复行出现次数，然后按照出现次数倒序排序: `cat A | sort | uniq -c | sort -nr`
  ]

  #commandBlock(title: "打包:", command: "tar [options] file")[
    - 将 A/ 打包 (#strong[c]reate) 并输出到 `A.tar` 文件 (#strong[f]ile): `tar cf A.tar A/`
    - 将 A/ 打包到 `A.tar.gz`，压缩程序由 tar 根据后缀自动(#strong[a]uto) 选择: `tar caf A.tar.gz A/`
    - 列出 (lis#strong[t]) `A.tar.gz` 的文件: `tar taf A.tar.gz`
    - 解压 (e#strong[x]tract) `A.tar.gz` 到当前目录: `tar xaf A.tar.gz`
  ]

  #commandBlock(title: "统计占用空间:", command: "du [options] file")[
    - 以人类 (#strong[h]uman) 可读的方式显示当前目录第一层 (#strong[d]epth)（每个文件夹）的总占用大小: `du -h -d 1 .`
  ]

  #commandBlock(title: "显示分区使用情况:", command: "df [options] file")[
    - 以人类 (#strong[h]uman) 可读的方式显示每个分区的使用情况: `df -h`
  ]

  == 进程操作

  #commandBlock(title: "列出进程信息:", command: "ps [options]")[
    - 列出所有进程（所有 (#strong[a]ll) 用户、显示用户信息 (#strong[u]ser) 并列出没有 tty (x) 的进程）: `ps aux`
    - 列出所有进程，并按 CPU 使用率降序排序: `ps aux --sort=-%cpu`
    - 列出所有进程的进程状态、进程 ID、父进程 ID 与进程名: `ps axo stat,pid,ppid,comm`
  ]

  #commandBlock(title: "交互式显示进程信息:", command: "top [options]")[
    - 每隔 1 秒 (#strong[d]elay) 刷新显示: `top -d 1`
    - 只显示 1 号和 2 号进程: `top -p 1,2`
    - *交互式界面快捷键:*
      - 空格: 立刻更新
      - n: 修改显示的进程数量
      - P: 按 CPU 降序排序
      - M: 按内存占用降序排序
      - q: 退出进程
    - 提示: 尝试更好用的 htop（包含颜色、鼠标支持等特性）
  ]

  #commandBlock(title: "进程操作:", command: "pgrep, kill, pkill, killall")[
    - 输出 `systemd` 进程的所有 PID: `pgrep systemd`
    - 强制杀死 `top` 进程:
      - `kill -9 $(pgrep top)`
      - `pkill -9 top`
      - `killall -9 top`
  ]

  == 网络与远程操作

  #commandBlock(title: "命令行远程连接:", command: "ssh [options] user@host [\"cmd1;cmd2\"]")[
    - 连接时输出调试信息: `ssh -vvv user@hostname`
    - 从跳板机连接服务器: `ssh -J user@jumpbox user@hostname`
    - 将服务器的 1234 端口转发到本地的 1234 端口: `ssh -L 1234:localhost:1234 user@hostname`
    - 在 1234 端口启动 SOCKS 代理，将流量转发到服务器: `ssh -D 1234 user@hostname`
    - 启用 X11 图形界面转发: `ssh -X user@hostname`
  ]

  #commandBlock(title: "HTTP 文件下载:", command: "wget [options] url")[
    - 下载文件到当前目录: `wget http://example.com/a.txt`
    - 下载文件到 `~/example.txt`: `wget -O \~/example.txt http://example.com/a.txt`
  ]

  #commandBlock(title: "HTTP 请求处理:", command: "curl [options] url")[
    - 显示请求详细 (#strong[v]erbose) 信息: `curl -v http://example.com/`
    - 下载文件到 `~/example.txt`: `curl -fLo ~/example.txt http://example.com/a.txt`
    - 发送 POST 请求: `curl -X POST http://example.com --data 'hello, world'`
  ]

  == 终端快捷键

  #commandBlock(title: "")[
    - (C- = Ctrl, M- = Alt)
    - C-c: 结束当前进程（发送 `SIGINT` 信号）
    - C-z: 暂停当前进程（发送 `SIGTSTP` 信号）
    - `jobs`: 显示后台进程
    - `bg %1`: 后台 (#strong[b]ack#strong[g]round) 恢复 1 号后台进程
    - `fg %1`: 前台 (#strong[f]ront#strong[g]round) 恢复 1 号后台进程
    - C-d: 结束输入 / `EOF`
    - C-r: 搜索历史记录
    - C-a: 跳转到输入开头
    - C-e: 跳转到输入结尾
    - C-k: 删除当前光标到输入结尾的内容
    - C-u: 删除当前行
    - C-w: 删除前一个单词
    - M-d: 删除后一个单词
    - C-y: 粘贴最后被快捷键删除的单词
  ]
]
