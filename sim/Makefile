
TOP_MODULE = softdrink
RTL_SRC    = ../rtl/softdrink.v




.PHONY: all clean elab run verdi lint



all:clean lint elab run

elab:
	vcs -full64 -debug_acc+all -sverilog -l compile.log		\
	-f ./files.f -timescale=1ns/1ps +vc +v2k

run:
	./simv -ucli -i wave_gen.tcl -l runsim.log

verdi:
	verdi -f files.f -ssf ./dump.fsdb &

lint:
	TOP_NAME=$(TOP_MODULE) RTL_PATH=$(RTL_SRC) sg_shell -tcl sg.tcl


clean:
	rm -rf AN.DB DVEfiles csrc simv.* *simv inter.vpd ucli.key *.log \
	       *_lint spyglass.out *.rpt	*.fsdb

