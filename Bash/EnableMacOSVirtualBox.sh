#!/usr/bin/sh

VBoxManage modifyvm $1 --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata $1 "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata $1 "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata $1 "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata $1 "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata $1 "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
