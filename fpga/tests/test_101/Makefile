#
# Makefile to build the "dhrystone" test
#

BUILD = ../../../build

ROM_SIZE_KB = 64

BIN = test_101.bin
DAT = test_101.dat

all:		$(DAT)

install:	$(DAT)

$(DAT):		$(BIN)
		$(BUILD)/bin/bin2dat $(BIN) $(DAT) $(ROM_SIZE_KB)

$(BIN):		copy/copy.bin dhry/dhry.bin
		cat copy/copy.bin dhry/dhry.bin >$(BIN)

copy/copy.bin:	size.s
		$(MAKE) -C copy all

size.s:		dhry/dhry.bin
		/bin/echo -e ";" >size.s
		/bin/echo -e "; set number of bytes to be copied" >>size.s
		/bin/echo -e ";" >>size.s
		/bin/echo -e -n "\t.set\tsize," >>size.s
		stat -c %s dhry/dhry.bin >>size.s
		/bin/echo -e "\t.export\tsize" >>size.s

dhry/dhry.bin:
		$(MAKE) -C dhry all

clean:
		rm -f *~ size.s $(BIN) $(DAT)
		$(MAKE) -C copy clean
		$(MAKE) -C dhry clean