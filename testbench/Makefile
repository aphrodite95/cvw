BITWIDTH := 32

%.memfile: %
	@echo "Processing $< for Wally ROM"
	riscv64-unknown-elf-objcopy \
		-O binary \
		--adjust-vma=-0x80000000 \
		$< $@.bin
	@echo "@00000000" > $@
	od -An -v -t x4 -w4 $@.bin | tr -d ' ' >> $@
	rm -f $@.bin

%.objdump.addr: %.objdump
	extractFunctionRadix.sh $<

%.objdump: %
	riscv64-unknown-elf-objdump -S -D $< > $@

