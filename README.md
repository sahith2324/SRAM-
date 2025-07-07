# SRAM-
# 🧠 SRAM Interface Verification using SystemVerilog

## 📌 Overview

This project verifies the functionality of a **simple SRAM memory interface** using **SystemVerilog testbench**. It includes both **write and read operations** with self-checking mechanisms. The design is verified using waveform analysis and event-driven monitors and drivers.

## 🛠️ Features

- ✅ Write and Read operations to/from SRAM
- ✅ Functional verification using event-driven simulation
- ✅ Testbench includes drivers, monitors, scoreboards
- ✅ Signal-level waveform validation
- ✅ DUT and Testbench signals match for correctness

## 📁 Project Directory Structure

```
sram_verification/
├── src/               # RTL source files
│   └── sram.sv        # SRAM memory interface design
├── tb/                # Testbench files
│   ├── tb_top.sv      # Top module for testbench
│   ├── interface.sv   # Bus interface
│   ├── driver.sv      # Stimulus generator
│   ├── monitor.sv     # Output sampler
│   └── scoreboard.sv  # Checker
├── sim/               # Simulation scripts and logs
│   └── run.f          # File list for simulator
├── waveforms/         # Waveform images or .vcd/.fst files
│   └── sram_wave.png  # Screenshot of working waveform
└── README.md          # This file
```

## ⚙️ How it Works

1. **Write Phase**:
   - Sequential write to multiple addresses using driver.
   - Write data values like `0xC4`, `0xC8`, etc.

2. **Read Phase**:
   - Read back data from same addresses.
   - Monitor checks read data against expected.

3. **Waveform Validation**:
   - Observe `wr`, `addr`, `wdata`, `rdata` for timing and correctness.
   - Events like `cb_driver_event`, `cb_omon_event` help with synchronization.

## 🔍 Waveform Snapshot

Below is a snapshot from the simulation showing write followed by read operations.

![SRAM Waveform](waveforms/sram_wave.png)

## 🖥️ How to Run

1. **Simulator**: You can use any SystemVerilog simulator like:
   - Synopsys VCS
   - Mentor QuestaSim
   - Aldec Riviera-PRO
   - XSIM (Vivado)

2. **Steps**:

```bash
# Compile
vlog +acc -f sim/run.f

# Run simulation
vsim work.tb_top -do "run -all"

# View waveform
# If using VCD:
gtkwave dump.vcd
```

## 📌 Key Signals

| Signal Name | Description |
|-------------|-------------|
| `addr` | SRAM address |
| `wr` | Write enable (1 = Write, 0 = Read) |
| `wdata` | Data to be written |
| `rdata` | Data read from SRAM |
| `cb_driver_event` | Stimulus trigger |
| `cb_omon_event` | Read-check trigger |

## ✅ Verification Status

| Feature | Status |
|--------|--------|
| Write | ✅ Passed |
| Read | ✅ Passed |
| Event Synchronization | ✅ Verified |
| Waveform Validation | ✅ Done |

## 🧩 Future Improvements

- Add support for burst reads/writes  
- Inject errors to test negative scenarios  
- Extend testbench with coverage collection

## 📄 License

This project is open source under the [MIT License](LICENSE).
