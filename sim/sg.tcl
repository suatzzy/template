
# --- 抓取外部传入的环境变量 ---
set top_name $::env(TOP_NAME)
set filelist_path $::env(FILELIST_PATH)

# 1. 新建工程 (用 ${} 拼接字符串)
new_project ../spyglass_lints/${top_name}_lint -force

# 2. 读取 RTL 代码 (使用传入的路径)
read_file -type sourcelist $filelist_path
# 3. 设置顶层模块名 (使用传入的顶层名)
set_option top $top_name
set_option enableSV yes
# 或者 set_option enableSV09 yes

# 4. 运行检查
current_goal lint/lint_rtl
run_goal

# 5. 输出报告并强制退出
write_report moresimple > ../spyglass_lints/lint_$top_name.rpt
exit -force
