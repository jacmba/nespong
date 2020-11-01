.PHONY: all clean

all: nespong.nes

nespong.nes: *.asm **/*.asm res/*.*
	nesasm nespong.asm

clean:
	rm *.fns
	rm *.deb
	rm *.nes