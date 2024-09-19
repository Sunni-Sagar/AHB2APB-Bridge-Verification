
# AHB2APB Bridge Verification using Universal Verification Methodolgy(UVM)

The AHB to APB bridge is a hardware component that connects two types of buses in a system-on-chip (SoC): the Advanced High-Performance Bus (AHB) and the Advanced Peripheral Bus (APB). These two buses serve different purposes in the system, and the bridge facilitates communication between them.

**AHB (Advanced High-Performance Bus):** This is a high-speed, pipelined bus designed to support burst transfers. It is typically used for high-performance tasks and connections between the processor and memory or other high-speed peripherals.

**APB (Advanced Peripheral Bus):** This is a simpler, lower-speed bus used to connect low-power peripherals like UARTs, timers, or GPIOs. The APB does not support pipelined operations, and data transfers are single-cycle operations.

**AHB2APB Bridge Function:** The bridge converts high-performance AHB transactions to simpler APB transactions. It ensures that the faster, burst-oriented AHB transactions are translated into the slower, single-operation APB transactions, allowing both buses to operate together within the SoC without loss of data integrity.

## Key Responsibilities of the AHB to APB Bridge:
**Clock and Reset Synchronization:** It manages clock domains between AHB and APB buses.
**Transaction Conversion:** It translates AHB's pipelined, burst-based communication into APB’s single-cycle operations.
Control Signal Handling: The bridge manages control signals like address, data, read/write signals, and the handshake between the AHB and APB.
**Data Flow Management:** The bridge handles data reads and writes between the two buses, ensuring that transactions are completed correctly and within timing requirements.

## Verifying the AHB to APB Bridge Using This Verification Plan
The verification of the AHB to APB bridge will ensure that it functions as intended, effectively translating signals between the two buses without introducing errors, deadlocks, or data corruption. The following approach will be used:

**Testbench Setup:**

- The verification environment described in this plan will be used to drive AHB transactions at the source side and observe APB transactions at the destination side.
- A master agent (AHB master) will initiate various types of transactions (read, write, burst, single transfer) on the AHB interface.
- A slave agent (APB slave) will receive the translated transactions and drive appropriate responses.
The verification plan will employ the Master Agent to simulate AHB transactions and the Slave Agent to simulate APB behavior.

**Key Features to Verify:**

- Correct Data Translation: The bridge must correctly convert AHB burst transactions into individual APB transactions and vice versa.
- Signal Timing and Integrity: Ensure the clock and reset synchronization across both buses work correctly, and there is no data loss during transactions.
- Busy and Valid Signals: Verification will check that the busy signals are correctly asserted when the bridge is occupied, and valid signals are correctly asserted when data is ready to be transferred on the APB side.
- FIFO Management: The internal FIFO mechanism should handle data buffering properly, especially during burst transfers.
- Error Handling: Ensure correct behavior under error conditions like parity mismatches or invalid addresses.

**Simulation Scenarios:**

- Single Transfer Test: A simple single-cycle transfer from AHB to APB to ensure that data is correctly routed through the bridge.
- Burst Transfer Test: A burst of transactions on the AHB side, translated into multiple single-cycle operations on the APB side.
- Clock Domain Crossing Test: Ensure that transactions between the different clock domains of AHB and APB are properly synchronized.
- Reset Handling Test: Verifying that the bridge correctly handles reset conditions, resetting all signals and FIFOs appropriately.
- Error Scenarios: Test cases where invalid addresses, data mismatches, or timing violations are introduced, ensuring the bridge responds correctly and logs appropriate error signals.

**Assertions:**

The assertions in the verification plan will be used to validate key conditions such as:
- Correct assertion of pkt_valid and vld_out signals.
- Correct timing between valid_out and read_enable assertions within specified clock cycles.
- Handling of busy states and ensuring that data remains stable when busy signals are asserted.

**Coverage Metrics:**

- Functional Coverage: Covering all different transaction types (read, write, burst) on both AHB and APB sides.
- Assertion Coverage: Checking all critical assertions are triggered and verified during simulation.
- Cross Coverage: Ensuring that various combinations of transactions, errors, and boundary conditions are thoroughly tested across the AHB and APB domains.

