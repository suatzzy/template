debImport "-f" "files.f"
debLoadSimResult /home/jjt/target/frontend_homework/template/sim/dump.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "softdrink_tb.u0" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {u0}
wvAddSignal -win $_nWave2 "/softdrink_tb/u0/clk" "/softdrink_tb/u0/rstn" \
           "/softdrink_tb/u0/op_start" "/softdrink_tb/u0/cancel_flag" \
           "/softdrink_tb/u0/coin_val\[1:0\]" "/softdrink_tb/u0/hold_ind" \
           "/softdrink_tb/u0/charge_ind" "/softdrink_tb/u0/drink_ind" \
           "/softdrink_tb/u0/charge_val\[2:0\]"
wvSetPosition -win $_nWave2 {("u0" 0)}
wvSetPosition -win $_nWave2 {("u0" 9)}
wvSetPosition -win $_nWave2 {("u0" 9)}
wvZoomAll -win $_nWave2
verdiSetActWin -win $_nWave2
debExit
