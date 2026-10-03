# ============================================================
# Basys 3 TDC constraints
# ============================================================

# Basys 3 onboard 100 MHz oscillator
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

create_clock -period 10.000 -name sys_clk -waveform {0.000 5.000} -add [get_ports clk]

# TDC asynchronous hit input - Pmod JA1
set_property PACKAGE_PIN J1 [get_ports hit]
set_property IOSTANDARD LVCMOS33 [get_ports hit]


# Architecture:
# clk = onboard 100 MHz clock
# hit = asynchronous pulse from JA1
#
# hit
#  |
#  v
# 64 x CARRY4
#  |
#  v
# 256 physical carry taps
#  |
#  v
# 256 sampling flip-flops
#  |
#  v
# raw_taps[255:0]
#  |
#  v
# ILA

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 256 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {raw_taps[0]} {raw_taps[1]} {raw_taps[2]} {raw_taps[3]} {raw_taps[4]} {raw_taps[5]} {raw_taps[6]} {raw_taps[7]} {raw_taps[8]} {raw_taps[9]} {raw_taps[10]} {raw_taps[11]} {raw_taps[12]} {raw_taps[13]} {raw_taps[14]} {raw_taps[15]} {raw_taps[16]} {raw_taps[17]} {raw_taps[18]} {raw_taps[19]} {raw_taps[20]} {raw_taps[21]} {raw_taps[22]} {raw_taps[23]} {raw_taps[24]} {raw_taps[25]} {raw_taps[26]} {raw_taps[27]} {raw_taps[28]} {raw_taps[29]} {raw_taps[30]} {raw_taps[31]} {raw_taps[32]} {raw_taps[33]} {raw_taps[34]} {raw_taps[35]} {raw_taps[36]} {raw_taps[37]} {raw_taps[38]} {raw_taps[39]} {raw_taps[40]} {raw_taps[41]} {raw_taps[42]} {raw_taps[43]} {raw_taps[44]} {raw_taps[45]} {raw_taps[46]} {raw_taps[47]} {raw_taps[48]} {raw_taps[49]} {raw_taps[50]} {raw_taps[51]} {raw_taps[52]} {raw_taps[53]} {raw_taps[54]} {raw_taps[55]} {raw_taps[56]} {raw_taps[57]} {raw_taps[58]} {raw_taps[59]} {raw_taps[60]} {raw_taps[61]} {raw_taps[62]} {raw_taps[63]} {raw_taps[64]} {raw_taps[65]} {raw_taps[66]} {raw_taps[67]} {raw_taps[68]} {raw_taps[69]} {raw_taps[70]} {raw_taps[71]} {raw_taps[72]} {raw_taps[73]} {raw_taps[74]} {raw_taps[75]} {raw_taps[76]} {raw_taps[77]} {raw_taps[78]} {raw_taps[79]} {raw_taps[80]} {raw_taps[81]} {raw_taps[82]} {raw_taps[83]} {raw_taps[84]} {raw_taps[85]} {raw_taps[86]} {raw_taps[87]} {raw_taps[88]} {raw_taps[89]} {raw_taps[90]} {raw_taps[91]} {raw_taps[92]} {raw_taps[93]} {raw_taps[94]} {raw_taps[95]} {raw_taps[96]} {raw_taps[97]} {raw_taps[98]} {raw_taps[99]} {raw_taps[100]} {raw_taps[101]} {raw_taps[102]} {raw_taps[103]} {raw_taps[104]} {raw_taps[105]} {raw_taps[106]} {raw_taps[107]} {raw_taps[108]} {raw_taps[109]} {raw_taps[110]} {raw_taps[111]} {raw_taps[112]} {raw_taps[113]} {raw_taps[114]} {raw_taps[115]} {raw_taps[116]} {raw_taps[117]} {raw_taps[118]} {raw_taps[119]} {raw_taps[120]} {raw_taps[121]} {raw_taps[122]} {raw_taps[123]} {raw_taps[124]} {raw_taps[125]} {raw_taps[126]} {raw_taps[127]} {raw_taps[128]} {raw_taps[129]} {raw_taps[130]} {raw_taps[131]} {raw_taps[132]} {raw_taps[133]} {raw_taps[134]} {raw_taps[135]} {raw_taps[136]} {raw_taps[137]} {raw_taps[138]} {raw_taps[139]} {raw_taps[140]} {raw_taps[141]} {raw_taps[142]} {raw_taps[143]} {raw_taps[144]} {raw_taps[145]} {raw_taps[146]} {raw_taps[147]} {raw_taps[148]} {raw_taps[149]} {raw_taps[150]} {raw_taps[151]} {raw_taps[152]} {raw_taps[153]} {raw_taps[154]} {raw_taps[155]} {raw_taps[156]} {raw_taps[157]} {raw_taps[158]} {raw_taps[159]} {raw_taps[160]} {raw_taps[161]} {raw_taps[162]} {raw_taps[163]} {raw_taps[164]} {raw_taps[165]} {raw_taps[166]} {raw_taps[167]} {raw_taps[168]} {raw_taps[169]} {raw_taps[170]} {raw_taps[171]} {raw_taps[172]} {raw_taps[173]} {raw_taps[174]} {raw_taps[175]} {raw_taps[176]} {raw_taps[177]} {raw_taps[178]} {raw_taps[179]} {raw_taps[180]} {raw_taps[181]} {raw_taps[182]} {raw_taps[183]} {raw_taps[184]} {raw_taps[185]} {raw_taps[186]} {raw_taps[187]} {raw_taps[188]} {raw_taps[189]} {raw_taps[190]} {raw_taps[191]} {raw_taps[192]} {raw_taps[193]} {raw_taps[194]} {raw_taps[195]} {raw_taps[196]} {raw_taps[197]} {raw_taps[198]} {raw_taps[199]} {raw_taps[200]} {raw_taps[201]} {raw_taps[202]} {raw_taps[203]} {raw_taps[204]} {raw_taps[205]} {raw_taps[206]} {raw_taps[207]} {raw_taps[208]} {raw_taps[209]} {raw_taps[210]} {raw_taps[211]} {raw_taps[212]} {raw_taps[213]} {raw_taps[214]} {raw_taps[215]} {raw_taps[216]} {raw_taps[217]} {raw_taps[218]} {raw_taps[219]} {raw_taps[220]} {raw_taps[221]} {raw_taps[222]} {raw_taps[223]} {raw_taps[224]} {raw_taps[225]} {raw_taps[226]} {raw_taps[227]} {raw_taps[228]} {raw_taps[229]} {raw_taps[230]} {raw_taps[231]} {raw_taps[232]} {raw_taps[233]} {raw_taps[234]} {raw_taps[235]} {raw_taps[236]} {raw_taps[237]} {raw_taps[238]} {raw_taps[239]} {raw_taps[240]} {raw_taps[241]} {raw_taps[242]} {raw_taps[243]} {raw_taps[244]} {raw_taps[245]} {raw_taps[246]} {raw_taps[247]} {raw_taps[248]} {raw_taps[249]} {raw_taps[250]} {raw_taps[251]} {raw_taps[252]} {raw_taps[253]} {raw_taps[254]} {raw_taps[255]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
