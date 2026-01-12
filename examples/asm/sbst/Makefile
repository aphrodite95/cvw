sbst.objdump: sbst.elf
	/opt/cvw_toolchain/bin/riscv64-unknown-elf-objdump -D sbst.elf > sbst.objdump

sbst.elf: sbst.S vectors.S Makefile
	/opt/cvw_toolchain/bin/riscv64-unknown-elf-gcc -o sbst.elf \
	-march=rv32i_zicsr -mabi=ilp32 -mcmodel=medany \
	-nostartfiles -T../../link/link_sbst.ld \
	sbst.S vectors.S


clean:
	rm -f sbst.elf sbst.objdump

