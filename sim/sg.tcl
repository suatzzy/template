# --- 抓取外部传入的环境变量 ---
set top_name $::env(TOP_NAME)
set rtl_path $::env(RTL_PATH)

# 1. 新建工程 (用 ${} 拼接字符串)
new_project ${top_name}_lint -force

# 2. 读取 RTL 代码 (使用传入的路径)
read_file -type verilog $rtl_path

# 3. 设置顶层模块名 (使用传入的顶层名)
set_option top $top_name

# 4. 运行检查
current_goal lint/lint_rtl
run_goal

# 5. 输出报告并强制退出
write_report moresimple > lint_$top_name.rpt
exit -force
