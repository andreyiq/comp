riscv32-unknown-linux-gnu-as riscvtest.S -o riscvtest.o
riscv32-unknown-linux-gnu-objcopy -O binary riscvtest.o riscvtest.bin
hexdump -e '"%08x\n"' riscvtest.bin > riscvtest.hex
