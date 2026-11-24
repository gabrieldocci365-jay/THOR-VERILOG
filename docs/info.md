<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project is a combinational 4-bit hexadecimal-to-7-segment decoder. It reads a 4-bit binary input from `ui_in[3:0]` (representing values `0` through `F`) and drives the corresponding active-high segment signals (`a` through `g`) on `uo_out[6:0]`.

## How to test

Set the desired 4-bit binary value using input switches `ui_in[0]` (LSB) through `ui_in[3]` (MSB). The matching hexadecimal character (`0`–`F`) will immediately light up on the 7-segment display. No clock or reset signal is required.

## External hardware

A common-cathode 7-segment display connected to `uo_out[6:0]` (such as the onboard 7-segment display on the Tiny Tapeout demo board).
