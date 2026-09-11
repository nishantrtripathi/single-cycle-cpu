# single-cycle-cpu
Single-Cycle RISC-V CPU

A two-person educational SystemVerilog project implementing a 32-bit single-cycle RISC-V processor. The project is organized so the RTL, verification, documentation, and FPGA flow can evolve together without turning the repo into a pile of disconnected modules.

Project Goals

Build a readable single-cycle CPU from first principles.

Start with a deliberate RV32I subset, then expand only after the baseline core is stable.

Keep every major RTL block independently testable.

Use self-checking verification instead of relying only on waveform inspection.

Finish with a reproducible Vivado synthesis flow and a small FPGA demo.

Team Roles

Temporary names are used until the real owners are assigned.

Developer A: primary owner for datapath integration, ALU/register-file work, and FPGA synthesis.

Developer B: primary owner for decode/control, verification infrastructure, and program-level tests.

Both: review each other's pull requests and avoid merging unreviewed architectural changes.

Planned v1 Instruction Subset

Class

Instructions

Register ALU

ADD, SUB, AND, OR, XOR, SLL, SRL, SLT

Immediate ALU

ADDI, ANDI, ORI, XORI

Memory

LW, SW

Branch

BEQ, BNE

Optional v1.1

LUI, AUIPC, JAL, JALR, SLTU/SLTI/SLTIU, SRA/SRAI, remaining branch variants

The exact decision and rationale live in docs/adr/ADR-001-rv32i-subset.md.

Repository Layout

.
├── rtl/
│   ├── cpu_top.sv
│   ├── alu.sv
│   ├── register_file.sv
│   ├── control_unit.sv
│   ├── instruction_decoder.sv
│   ├── immediate_generator.sv
│   ├── program_counter.sv
│   └── memory_if.sv
├── tb/
│   ├── unit/
│   ├── integration/
│   └── common/
├── programs/
│   ├── asm/
│   └── hex/
├── scripts/
├── docs/
│   ├── architecture.md
│   └── adr/
├── .github/
│   └── ISSUE_TEMPLATE/
└── README.md

Development Flow

Pick an issue from the backlog and assign an owner.

Create a short-lived branch.

Implement the smallest testable change.

Add or update self-checking tests in the same pull request.

Run the full regression before requesting review.

Have the other developer review architectural/control changes.

Merge only when the relevant milestone exit test still passes.

Verification Philosophy

Each block should have a unit test before top-level integration. Program-level tests should check architectural outcomes such as final register values, memory values, PC behavior, and writeback events.

Waveforms are still useful for debugging, but a test is not considered complete if the only pass criterion is “the waveform looked right.”

Suggested First Programs

Arithmetic dependency chain

Taken/not-taken branch loop

Store/load round trip

Array sum

Fibonacci-like iterative loop

Vivado

Vivado is needed for synthesis, implementation, timing/resource reports, and an FPGA demo. It is not required for every early RTL edit if you use another simulator for fast unit tests, but the project should keep a documented Vivado-compatible flow from the beginning.

Definition of v1.0

v1.0 is complete when:

Every supported instruction has a passing test.

At least two nontrivial assembly programs execute correctly.

The full regression runs from one documented command.

Vivado synthesis completes on the selected FPGA target.

README, architecture documentation, and ADRs match the implementation.

The repository is tagged v1.0.
