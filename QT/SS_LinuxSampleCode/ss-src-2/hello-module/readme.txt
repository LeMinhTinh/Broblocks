Adding a new module

1. Make a directory - drivers/hello
   Create or Copy file - Kconfig, Makefile, hello.c

   hello.c - A simple kernel module

   Kconfig - Add following statements
	#
	# hello module configuration
	#

	menu "Hello Module support"

	config HELLO
		tristate "Include Hello module?"
		---help---
		  Linux Kernel Module demonstration - Hello

	endmenu

   Makefile - Add foloowing statement
	obj-$(CONFIG_HELLO) += hello.o

3. Add the following statement before endmenu statement:

	source "drivers/hello/Kconfig"

   And add the following statement at the end of file in Makefile:

	obj-$(CONFIG_HELLO) += hello.o

3. Config, Build and Deploy the kernel.
