//******************************************************************************
// file:    up_apb3.v
//
// author:  JAY CONVERTINO
//
// date:    2024/03/19
//
// about:   Brief
// APB3 slave to uP interface
//
// license: License MIT
// Copyright 2024 Jay Convertino
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
// IN THE SOFTWARE.
//
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: up_apb3
 *
 * APB3 slave to uP interface
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
module up_apb3 #(
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

  localparam shift = BUS_WIDTH/2;

  wire  valid;

  reg   r_cycle;

  // var: valid
  // This will add an extra clock cycle. since enable happens after select. both are needed to use the device.
  assign valid = s_apb_psel & s_apb_penable & rstn;

  // var: s_apb_pslverror
  // APB3 error is always 0, no error.
  assign s_apb_pslverror = 1'b0;

  // var: up_waddr
  // up_waddr and s_apb_addr are a direct mapping.
  assign up_waddr = s_apb_paddr[ADDRESS_WIDTH-1:shift];

  // var: up_waddr
  // up_raddr and s_apb_addr are a direct mapping.
  assign up_raddr = s_apb_paddr[ADDRESS_WIDTH-1:shift];

  // var: up_wdata
  // up_wdata and s_apb_pwdata are a direct mapping.
  assign up_wdata = s_apb_pwdata;

  // var: s_apb_prdata
  // s_apb_prdata and up_rdata are a direct mapping.
  assign s_apb_prdata = up_rdata;

  // var: up_wreq
  // uP write request is a combination of the APB3 valid and APB3 write select (active high is write).
  assign up_wreq = valid & s_apb_pwrite & r_cycle;

  // var: up_rreq
  // uP read request is a combination of the APB3 valid and APB3 write select (active low is read).
  assign up_rreq = valid & ~s_apb_pwrite & r_cycle;

  // var: s_apb_pready
  // Ready is being treated like a awk
  assign s_apb_pready = (up_wack | up_rack) & rstn;

  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_cycle <= 1'b1;
    end else begin
      r_cycle <= 1'b1;

      if(valid == 1'b1)
      begin
        r_cycle <= 1'b0;
      end
    end
  end
endmodule
