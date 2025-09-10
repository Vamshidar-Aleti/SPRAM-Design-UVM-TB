# UVM Testbench for a Single-Port RAM

## Project Overview

This repository contains a comprehensive UVM (Universal Verification Methodology) testbench developed to verify a simple synchronous Single-Port RAM (SP-RAM). This project serves as a practical example of building a modern, reusable verification environment from the ground up.

The development of this testbench followed an iterative process, starting with a basic structure and evolving to solve common verification challenges such as DUT latency, transaction monitoring, and robust test termination.

## DUT Features (Single-Port RAM)
* **Depth:** 16 locations
* **Data Width:** 8 bits
* **Address Width:** 4 bits
* **Operations:** Synchronous Read and Write
* **Latency:** Read operations have a one-cycle latency (data is available on the clock cycle after the address is presented).
## Testbench Architecture & Features

This is a standard agent-based UVM testbench with the following components:

* **`seq_item`**: Defines the transaction packet for read/write operations.
* **`sequencer`**: Manages the flow of transactions to the driver.
* **`driver`**: Drives the transactions onto the DUT's interface signals.
* **`monitor`**: A pipelined monitor that non-intrusively samples the DUT interface to capture transactions, correctly handling the one-cycle read latency.
* **`agent`**: Encapsulates the driver, monitor, and sequencer.
* **`scoreboard`**: Contains a reference model (a simple array) to predict expected read data and compares it against the data captured by the monitor.
* **`environment`**: Instantiates the agent and the scoreboard and connects them.
* **`base_test`**: The base test class that builds the environment and configures the `default_sequence`.
* **`base_seq`**: The sequence that generates a configurable number of randomized read and write transactions.

---

## Project Structure

```
.
├── design.sv             # RTL for the Single-Port RAM (DUT)
├── interface.sv          # SystemVerilog interface to connect TB and DUT
├── package.sv            # Central package file that includes all UVM component files
├── testbench.sv          # The top-level testbench module (tb_top)
│
├── seqeunce_item.sv      # Transaction class definition
├── spr_base_sequec.sv    # Base sequence for generating stimulus
├── spr_sequencer.sv      # Sequencer component
├── spr_driver.sv         # Driver component
├── monitor.sv            # The final, simplified Pipelined Monitor component
├── spr_agent.sv          # Agent component
├── spr_scbd.sv           # Scoreboard component
├── spr_env.sv            # Environment component
├── spr_test.sv           # Base Test class
└── dump.vcd              # Waveform dump file (generated after simulation)
