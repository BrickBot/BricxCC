#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking NeXTTool
/usr/bin/ld -b elf32-i386 -m elf_i386  -dynamic-linker=/lib/ld-linux.so.2    -L. -o NeXTTool link.res
if [ $? != 0 ]; then DoExitLink NeXTTool; fi
