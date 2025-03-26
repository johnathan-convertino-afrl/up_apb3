//******************************************************************************
// file:    tb_coctb.v
//
// author:  JAY CONVERTINO
//
// date:    2025/03/26
//
// about:   Brief
// Test bench wrapper for cocotb
//
// license: License MIT
// Copyright 2025 Jay Convertino
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.BUS_WIDTH
//
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: tb_cocotb
 *
 * APB3 slave to uP interface DUT
 *
 * Parameters:
 *
 *   ADDRESS_WIDTH   - Width of the APB3 address port in bits.
 *   BUS_WIDTH       - Width of the APB3 bus data port in bytes.
 *
 * Ports:
 *
 *   clk              - Clock
 *   rstn             - negative reset
 *   s_apb_paddr      - APB3 address bus, up to 32 bits wide.
 *   s_apb_psel       - APB3 select per slave (1 for this core).
 *   s_apb_penable    - APB3 enable device for multiple transfers after first.
 *   s_apb_pready     - APB3 ready is a output from the slave to indicate its able to process the request.
 *   s_apb_pwrite     - APB3 Direction signal, active high is a write access. Active low is a read access.
 *   s_apb_pwdata     - APB3 write data port.
 *   s_apb_prdata     - APB3 read data port.
 *   s_apb_pslverror  - APB3 error indicates transfer failure, not implimented.
 *   up_rreq          - uP bus read request
 *   up_rack          - uP bus read ack
 *   up_raddr         - uP bus read address
 *   up_rdata         - uP bus read data
 *   up_wreq          - uP bus write request
 *   up_wack          - uP bus write ack
 *   up_waddr         - uP bus write address
 *   up_wdata         - uP bus write data
 */
module tb_cocotb #(
    parameter ADDRESS_WIDTH = 16,
    parameter BUS_WIDTH     = 4
  )
  (
    input                                           clk,
    input                                           rstn,
    input  [ADDRESS_WIDTH-1:0]                      s_apb_paddr,
    input  [0:0]                                    s_apb_psel,
    input                                           s_apb_penable,
    output                                          s_apb_pready,
    input                                           s_apb_pwrite,
    input  [BUS_WIDTH*8-1:0]                        s_apb_pwdata,
    output [BUS_WIDTH*8-1:0]                        s_apb_prdata,
    output                                          s_apb_pslverror,
    output                                          up_rreq,
    input                                           up_rack,
    output  [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0]       up_raddr,
    input   [BUS_WIDTH*8-1:0]                       up_rdata,
    output                                          up_wreq,
    input                                           up_wack,
    output  [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0]       up_waddr,
    output  [BUS_WIDTH*8-1:0]                       up_wdata
  );
  // fst dump command
  initial begin
    $dumpfile ("tb_cocotb.fst");
    $dumpvars (0, tb_cocotb);
    #1;
  end
  
  //Group: Instantiated Modules

  /*
   * Module: dut
   *
   * Device under test, up_apb3
   */
  up_apb3 #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH)
  ) dut (
    .clk(clk),
    .rstn(rstn),
    .s_apb_paddr(s_apb_paddr),
    .s_apb_psel(s_apb_psel),
    .s_apb_penable(s_apb_penable),
    .s_apb_pready(s_apb_pready),
    .s_apb_pwrite(s_apb_pwrite),
    .s_apb_pwdata(s_apb_pwdata),
    .s_apb_prdata(s_apb_prdata),
    .s_apb_pslverror(s_apb_pslverror),
    .up_rreq(up_rreq),
    .up_rack(up_rack),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    .up_wreq(up_wreq),
    .up_wack(up_wack),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata)
  );
  
endmodule

