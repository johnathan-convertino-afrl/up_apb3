﻿NDSummary.OnToolTipsLoaded("File2:tb_cocotb.v",{42:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Test bench wrapper for cocotb</div></div>",43:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Copyright 2025 Jay Convertino</div></div>",44:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype44\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/3/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/3/2\"><span class=\"SHKeyword\">module</span> tb_cocotb #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">16</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"3/3/4/4\" style=\"grid-area:2/4/3/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"2/5/3/6\" data-NarrowGridArea=\"3/4/4/5\" style=\"grid-area:2/5/3/6\"><span class=\"SHNumber\">4</span></div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"2/6/3/7\" data-NarrowGridArea=\"4/1/5/6\" style=\"grid-area:2/6/3/7\">) ( <span class=\"SHKeyword\">input</span> clk, <span class=\"SHKeyword\">input</span> rstn, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_apb_paddr, <span class=\"SHKeyword\">input</span> [<span class=\"SHNumber\">0</span>:<span class=\"SHNumber\">0</span>] s_apb_psel, <span class=\"SHKeyword\">input</span> s_apb_penable, <span class=\"SHKeyword\">output</span> s_apb_pready, <span class=\"SHKeyword\">input</span> s_apb_pwrite, <span class=\"SHKeyword\">input</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_apb_pwdata, <span class=\"SHKeyword\">output</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_apb_prdata, <span class=\"SHKeyword\">output</span> s_apb_pslverror, <span class=\"SHKeyword\">output</span> up_rreq, <span class=\"SHKeyword\">input</span> up_rack, <span class=\"SHKeyword\">output</span> [ADDRESS_WIDTH-(BUS_WIDTH/<span class=\"SHNumber\">2</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_raddr, <span class=\"SHKeyword\">input</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] up_rdata, <span class=\"SHKeyword\">output</span> up_wreq, <span class=\"SHKeyword\">input</span> up_wack, <span class=\"SHKeyword\">output</span> [ADDRESS_WIDTH-(BUS_WIDTH/<span class=\"SHNumber\">2</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_waddr, <span class=\"SHKeyword\">output</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] up_wdata )</div></div></div></div><div class=\"TTSummary\">APB3 slave to uP interface DUT</div></div>",46:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype46\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/3/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/3/2\">up_apb3 #(</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH(ADDRESS_WIDTH),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH(BUS_WIDTH)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"4/1/5/4\" style=\"grid-area:2/4/3/5\">) dut ( .clk(clk), .rstn(rstn), .s_apb_paddr(s_apb_paddr), .s_apb_psel(s_apb_psel), .s_apb_penable(s_apb_penable), .s_apb_pready(s_apb_pready), .s_apb_pwrite(s_apb_pwrite), .s_apb_pwdata(s_apb_pwdata), .s_apb_prdata(s_apb_prdata), .s_apb_pslverror(s_apb_pslverror), .up_rreq(up_rreq), .up_rack(up_rack), .up_raddr(up_raddr), .up_rdata(up_rdata), .up_wreq(up_wreq), .up_wack(up_wack), .up_waddr(up_waddr), .up_wdata(up_wdata) )</div></div></div></div><div class=\"TTSummary\">Device under test, up_apb3</div></div>"});