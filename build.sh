rm -rf nxttools.app
rm -rf nxttools
make -ftoolsmac.mak nxttools
make ARCH=ppc FPC_TARGET=powerpc-darwin -ftoolsmac.mak nxttools
make -ftoolsmac.mak nxttools.u
mv nxttools.u nxttools
./create_app_mac.sh nxttools
#
rm -rf nxtcc.app
rm -rf nxtcc
make -ftoolsmac.mak nxtcc
make ARCH=ppc FPC_TARGET=powerpc-darwin -ftoolsmac.mak nxtcc
make -ftoolsmac.mak nxtcc.u
mv nxtcc.u nxtcc
./create_app_mac.sh nxtcc

