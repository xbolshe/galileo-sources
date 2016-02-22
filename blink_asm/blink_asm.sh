nasm -f elf32 blink_asm.asm
ld -o blink_asm blink_asm.o
rm -f ./blink_asm.o
