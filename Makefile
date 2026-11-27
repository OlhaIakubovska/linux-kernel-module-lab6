# Usage:
#   export KDIR=$HOME/repos/linux-stable
#   make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
ccflags-y += -g
obj-m := hello.o

KDIR ?= $(HOME)/repos/linux-stable

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
	cp hello.ko hello.ko.unstripped
	$(CROSS_COMPILE)strip -g hello.ko

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
	rm -f hello.ko.unstripped

check:
	$(KDIR)/scripts/checkpatch.pl --no-tree -f hello.c
