// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Jan 17 10:56:26 2022
// Host        : Fahad-Dell running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/fahad/OneDrive/FPGA_SoC_Development/Working/btmems_zcu104/btmems_zcu104.srcs/sources_1/bd/zcu104/ip/zcu104_vio_0_0/zcu104_vio_0_0_stub.v
// Design      : zcu104_vio_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu7ev-ffvc1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2019.2" *)
module zcu104_vio_0_0(clk, probe_in0, probe_out0)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[31:0],probe_out0[31:0]" */;
  input clk;
  input [31:0]probe_in0;
  output [31:0]probe_out0;
endmodule
