# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

   # Tabla esperada (0gfedcba) según las compuertas exactas de tu esquemático
    expected = [
        0x3F, # 0
        0x06, # 1
        0x5B, # 2
        0x4F, # 3
        0x66, # 4
        0x6D, # 5
        0x7C, # 6 (sin segmento superior)
        0x07, # 7
        0x7F, # 8
        0x67, # 9 (sin segmento inferior)
        0x77, # A
        0x7C, # b
        0x39, # C
        0x5E, # d
        0x79, # E
        0x71, # F
    ]

    for val, exp in enumerate(expected):
        dut.ui_in.value = val
        await ClockCycles(dut.clk, 1)
        assert dut.uo_out.value == exp, f"Entrada {val:X}: esperado {exp:#04x}, recibido {int(dut.uo_out.value):#04x}"
