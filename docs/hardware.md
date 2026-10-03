# Project setup and hardware use

## Requirements

- Digilent Basys 3 with Artix-7 `xc7a35tcpg236-1`.
- Vivado with 7-series device support; the located source project identifies version 2024.1.
- A suitable external electrical source and oscilloscope for input checks.
- USB/JTAG access to the board.

Board information is available in the [Digilent Basys 3 Reference Manual](https://digilent.com/reference/_media/reference/programmable-logic/basys-3/basys3_rm.pdf).

## Create the project

Clone or download this repository. Open Vivado and use its Tcl console to source the project-creation script, substituting your checkout path:

```tcl
source {C:/your-checkout/FPGA-Carry-Chain-Delay-Line-Capture/scripts/create_project.tcl}
```

Alternatively, from a terminal with Vivado on its path:

```text
vivado -mode batch -source scripts/create_project.tcl
```

The script resolves source paths relative to itself, creates the project under `build/fpga_tdl`, adds the preserved RTL and XDC, and selects `tdl_capture` as the top module. It does not launch synthesis, implementation, bitstream generation or board programming. It refuses to overwrite an existing generated project.

**Verification status:** the script is new repository setup material. A clean Vivado build and hardware run have not been performed for this packaged repository. The historical result must not be treated as validation of a new build.

## Included constraint configuration

| Signal / setting | Preserved value |
|---|---|
| Board clock | W5, LVCMOS33, nominal 10 ns clock |
| Asynchronous input | J1 / Pmod JA1, LVCMOS33 |
| ILA | `u_ila_0`, one 256-bit data/trigger probe |
| Acquisition depth | 1,024 samples |
| Probe input pipeline setting | 0 optional stages |
| ILA clock | `clk_IBUF_BUFG` |
| Debug-hub clock connection | `clk_IBUF_BUFG` |
| Debug-hub frequency property | 300 MHz in the preserved XDC |

The debug-hub frequency property differs from the nominal 100 MHz connected board clock. It is preserved to retain the source configuration and requires review against the generated design and Vivado guidance. This discrepancy has not been established as the cause of the irregular capture. See [UG908: ILA Core and Timing Considerations](https://docs.amd.com/r/2024.1-English/ug908-vivado-programming-debugging/ILA-Core-and-Timing-Considerations).

## Before capturing

1. Run synthesis and inspect the elaborated/synthesized chain and debug connections. Review tool messages rather than assuming all original debug-net names remain valid in every tool version.
2. Run implementation. Inspect the 64-cell carry cascade, the sampling registers, timing reports and design-rule checks. Record actual placement rather than relying on historical coordinates.
3. Generate and program the bitstream. Associate the `.ltx` debug-probe file from that same build with the programmed bitstream.
4. Check the source's actual voltage range, load setting, grounding and edge shape before connecting it to JA1. The documented demonstration used 0-3 V with a shared reference, verified on an oscilloscope; a generator's displayed amplitude depends on its load setting.
5. Capture `raw_taps` in Hardware Manager. Record the trigger, sample window, source settings and build identity.
6. Export the complete capture, including settled rows and original sample indices. Check vector width and bit order before assigning physical tap positions.

These are reproduction instructions, not a record of an additional experiment. Asynchronous delay-line behavior needs separate hardware interpretation; passing ordinary synchronous timing checks does not establish calibrated fine timing.

## What is versioned

The repository includes source, constraints, setup instructions and selected historical figures. Vivado caches, generated IP, run products, bitstreams and large acquisitions are excluded by `.gitignore`. Preserve full measurements separately with an identified build and run. No prebuilt bitstream is supplied.
