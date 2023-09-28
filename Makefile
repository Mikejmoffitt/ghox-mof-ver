AS=asl
P2BIN=p2bin
SRC=src/main.a68
BSPLIT=bsplit
MAME=mame

PKGNAME=ghox_mof_ver

ASFLAGS=-i . -n -U

.PHONY: all clean prg.bin prg.o

all: prg.bin

dataj: ghoxj.zip
	mkdir -p $@ && cp $< $@/ && cd $@ && unzip -o $< && rm ./$<

data: ghox.zip ghoxj.zip
	mkdir -p $@ && cp $< $@/ && cd $@ && unzip -o $< && rm ./$<

prg.orig: data
	$(BSPLIT) c data/tp021-01.u10 data/tp021-02.u11 $@

prga.orig: dataj
	$(BSPLIT) c dataj/tp021-01a.u10 dataj/tp021-02a.u11 $@

prg.o: prg.orig
	$(AS) $(SRC) $(ASFLAGS) -o prg.o

prg.bin: prg.o
	$(P2BIN) $< $@ -r \$$-0x3FFFF

ghox: prg.bin data
	mkdir -p $@
	cp data/* $@/
	$(BSPLIT) s $< $@/tp021-01.u10 $@/tp021-02.u11

ghoxj: prg.bin data
	mkdir -p $@
	cp data/* $@/
	rm $@/tp021-01.u10
	rm $@/tp021-02.u11
	$(BSPLIT) s $< $@/tp021-01a.u10 $@/tp021-02a.u11

test: ghox
	$(MAME) -rompath $(shell pwd) -debug $<

testj: ghoxj
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
	@-rm -rf dataj/
	@-rm -rf ghox/
	@-rm -rf ghoxj/
