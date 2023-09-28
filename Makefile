AS=asl
P2BIN=p2bin
SRC=src/main.a68
BSPLIT=bsplit
MAME=mame

PKGNAME=ghox3

ASFLAGS=-i . -n -U

.PHONY: all clean prg.bin prg.o

all: prg.bin

data: ghox.zip ghoxj.zip
	mkdir -p $@ && cp $< $@/ && cd $@ && unzip -o $< && rm ./$<
	cp ghoxj.zip $@/ && cd $@ && unzip -o ghoxj.zip && rm ./ghoxj.zip

prg.orig: data
	$(BSPLIT) c data/tp021-01.u10 data/tp021-02.u11 $@

prga.orig: data
	$(BSPLIT) c data/tp021-01a.u10 data/tp021-02a.u11 $@

prg.o: prg.orig
	$(AS) $(SRC) $(ASFLAGS) -o prg.o

prg.bin: prg.o
	$(P2BIN) $< $@ -r \$$-0x3FFFF

ghox: prg.bin data
	mkdir -p $@
	cp data/* $@/
	rm $@/tp021-01a.u10
	rm $@/tp021-02a.u11
	$(BSPLIT) s $< $@/tp021-01.u10 $@/tp021-02.u11

test: ghox
	$(MAME) -rompath $(shell pwd) -debug $<

$(PKGNAME).zip: ghox
	cd $< && zip $@ * && mv $@ ../

clean:
	@-rm -f $(PKGNAME).zip
	@-rm -f prg.bin
	@-rm -f prg.o
	@-rm -f prg.orig
	@-rm -f prga.orig
	@-rm -rf data/
	@-rm -rf ghox/
