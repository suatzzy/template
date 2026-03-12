#!/bin/bash
if [ ! -d "/home/jjt/target/frontend_homework/template" ]; then
    echo "错误：找不到模板目录！"
    exit 1
fi
# 检查是否输入了项目名称
if [ -z "$1" ]; then
    echo "用法: mk_ic_proj.sh <项目名称>"
    exit 1
fi

PROJ_NAME=$1

# 创建顶层项目目录
mkdir -p "$PROJ_NAME"
cd "$PROJ_NAME"

# 创建子目录结构
mkdir rtl sim tb

# 在 sim 目录下创建空文件
cp /home/jjt/target/frontend_homework/template/sim/Makefile sim/Makefile
cp /home/jjt/target/frontend_homework/template/sim/novas.rc sim/novas.rc
cp /home/jjt/target/frontend_homework/template/sim/wave_gen.tcl sim/wave_gen.tcl
cp /home/jjt/target/frontend_homework/template/sim/sg.tcl sim/sg.tcl
cp /home/jjt/target/frontend_homework/template/sim/rtl.f sim/rtl.f
cp /home/jjt/target/frontend_homework/template/sim/files.f sim/files.f



echo "项目 "$PROJ_NAME" 结构创建完成！"
ls ..
