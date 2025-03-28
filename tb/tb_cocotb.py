#******************************************************************************
# file:    tb_cocotb.py
#
# author:  JAY CONVERTINO
#
# date:    2025/03/04
#
# about:   Brief
# Cocotb test bench
#
# license: License MIT
# Copyright 2025 Jay Convertino
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
#******************************************************************************

import random
import itertools

import cocotb
from cocotb.clock import Clock
from cocotb.utils import get_sim_time
from cocotb.triggers import FallingEdge, RisingEdge, Timer, Event
from cocotb.binary import BinaryValue
from cocotbext.apb.three import apb3Master
from cocotbext.up.ad import upEchoSlave

# Function: random_bool
# Return a infinte cycle of random bools
#
# Returns: List
def random_bool():
  temp = []

  for x in range(0, 256):
    temp.append(bool(random.getrandbits(1)))

  return itertools.cycle(temp)

# Function: start_clock
# Start the simulation clock generator.
#
# Parameters:
#   dut - Device under test passed from cocotb test function
def start_clock(dut):
  cocotb.start_soon(Clock(dut.clk, 2, units="ns").start())

# Function: reset_dut
# Cocotb coroutine for resets, used with await to make sure system is reset.
async def reset_dut(dut):
  dut.rstn.value = 0
  await Timer(5, units="ns")
  dut.rstn.value = 1

# Function: increment test
# Coroutine that is identified as a test routine. Write data, on one clock edge, read
# on the next.
#
# Parameters:
#   dut - Device under test passed from cocotb.
@cocotb.test()
async def increment_test(dut):

    start_clock(dut)

    apb_master = apb3Master(dut, "s_apb", dut.clk, dut.rstn)

    up_echo_slave = upEchoSlave(dut, "up", dut.clk, dut.rstn)

    await reset_dut(dut)

    for x in range(0, 2**8):

        await apb_master.write(x, x)

        await RisingEdge(dut.clk)

        rx_data = await apb_master.read(x)

        assert rx_data == x, "WRITTEN DATA DOES NOT EQUAL READ."

    await RisingEdge(dut.clk)

# Function: increment test stream
# Coroutine that is identified as a test routine. Write data, in a stream to registers,
# then read back stream.
#
# Parameters:
#   dut - Device under test passed from cocotb.
@cocotb.test()
async def increment_test_stream(dut):

    start_clock(dut)

    apb_master = apb3Master(dut, "s_apb", dut.clk, dut.rstn)

    up_echo_slave = upEchoSlave(dut, "up", dut.clk, dut.rstn)

    await reset_dut(dut)

    for x in range(0, 2**8, dut.BUS_WIDTH.value):

        await apb_master.write(x, x)

    for x in range(0, 2**8, dut.BUS_WIDTH.value):
        rx_data = await apb_master.read(x)

        assert rx_data == x, "WRITTEN DATA DOES NOT EQUAL READ."

    await RisingEdge(dut.clk)


# Function: in_reset
# Coroutine that is identified as a test routine. This routine tests if device stays
# in unready state when in reset.
#
# Parameters:
#   dut - Device under test passed from cocotb.
@cocotb.test()
async def in_reset(dut):

    start_clock(dut)

    dut.rstn.value = 0

    await Timer(10, units="ns")

    assert dut.up_wack.value.integer == 0, "uP WACK is 1!"
    assert dut.up_rack.value.integer == 0, "uP RACK is 1!"
    assert dut.s_apb_pready.value.integer == 0, "APB PREADY is 1!"

# Function: no_clock
# Coroutine that is identified as a test routine. This routine tests if no ready when clock is lost
# and device is left in reset.
#
# Parameters:
#   dut - Device under test passed from cocotb.
@cocotb.test()
async def no_clock(dut):

    dut.rstn.value = 0

    await Timer(5, units="ns")

    assert dut.up_wack.value.integer == 0, "uP WACK is 1!"
    assert dut.up_rack.value.integer == 0, "uP RACK is 1!"
    assert dut.s_apb_pready.value.integer == 0, "APB PREADY is 1!"
