guide: https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md#different-boot-options-u-boot-kpart

section:
'''
## different boot options: u-boot, kpart

there are two boot strategies used in the arm chromebook bootable images: chainloaded u-boot and native chromeos kpart kernels. actually there is the third options to install an self built low level libreboot or coreboot bootloader, but this options is quite complicated, risky and not supported for many arm chromebooks and thus not used and discussed here.

booting via chainloaded u-boot is used by images for the 32bit armv7l chromebooks. here the low level bootloader is loading u-boot (another very common bootloader for arm systems) instead of the linux kernel and u-boot then will load the actual kernel. the advantage of this setup is that it is possible to create boot menus for selecting different kernels etc.

the native chromeos kpart booting works by packaging the used mainline kernel in the same way the regular chromeos kernel is packaged (kpart - i.e. the format for the kernel partition) and putting it this way into the kernel partition, so that the chromebook will boot it just like a regular chromeos kernel. this approached is used for the 64bit aarch64 chromebooks as there is no mainline u-boot available for them, which could be chainloaded. the disadvantages of this approach are that the resulting kernel image can be at max 32mb in size (16mb for 32bit armv7l systems) which can be quite small for systems with initrd and that the kernel cmdline args are fixed built into this kernel image and thus it is not very flexible. the advantage of this approach is that such a kernel image can contain multiple dtb files for different hardware and the proper one will be selected automatically at boot. an important feature of chromeos kernel partitions is that there might be multiple of them and they can be given a priority and a counter for failed boots which to some degree gives the opportunity for relatively failsafe test booting of new kernels without the risk of completely bricking a system. the bootable images discussed here for this reason have two kernel partitions of which only the first is currently used right now - the second one os there for test booting other kernels if done with the proper settings.
'''
