
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

play_cycles = 250000
@cocotb.test()
async def test_tune(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 100, units="us")
    cocotb.fork(clock.start())
    
    dut._log.info("reset flygoat")
    dut.db_sel_in = 0
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    await ClockCycles(dut.clk, play_cycles)

    dut._log.info("reset gm3hso")
    dut.db_sel_in = 1
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    await ClockCycles(dut.clk, play_cycles)

    dut._log.info("reset bh5hso")
    dut.db_sel_in = 2
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    await ClockCycles(dut.clk, play_cycles)

    dut._log.info("reset planetes")
    dut.db_sel_in = 3
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0

    await ClockCycles(dut.clk, play_cycles)
