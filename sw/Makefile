%.elf: %.S
	riscv64-zephyr-elf-gcc -nostartfiles -march=rv32i -mabi=ilp32 -Tlink.ld -o$@ $<
%.bin: %.elf
	riscv64-zephyr-elf-objcopy -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< 4096 > $@

clean:
	rm -f *.elf *.bin *.hex
