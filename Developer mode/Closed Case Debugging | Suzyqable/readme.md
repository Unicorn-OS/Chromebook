guide: https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md#setting-gbb-flags-enabling-ccd-and-the-magic-suzyqable

section:
'''
## setting gbb flags, enabling ccd and the magic suzyqable

it is possible to set parameters like the above to enable booting from usb also as default in the chromebook firmware via the so called gbb flags. this is definitely recommended as soon as one wants to install a regular linux onto the internal emmc storage of a chromebook (and wiping the chromeos on it). the reason for this is that at least some chromebooks tend to drain the battery if not used for a longer time and settings like the above for allowing usb booting and the enabled developer mode get lost if the battery gets completely empty in such cases. so one might end up in a situation where booting from usb/sd card is no longer possible as the corresponding flags were reset to their default to not allow booting from those devices. as there is no chromeos anymore on the emmc it is not possible to change the flags to enable booting from usb/sd again and the only way out is to restore cromeos via restore image onto the internal emmc storage wiping the regular linux installation there (and loosing all of its data) which is not really what one wants. due to this it is in the end highly recommended to set those flags to default to allow usb/sd booting and enabled developer mode, so that it will still work even if the battery gets completely drained. in case one gets into the above described situation that the usb booting flags get lost due to battery drain there might be some last option to get access to the installed linux on emmc back without having to restore chromeos to it by using a special hand crafted restore image as described here: https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/workaround-for-battery-discharge-in-dev-mode/ - i'm not sure if this procedure is still working for the latest chromeos and firmware versions, but it might be worth a try at least in such cases.

the problem with this is that it is not really that easy as chromebooks have by default some form of write protection enabled for the area of the firmware where those gbb flags are stored as part of the chromeos security setup. disabling this write protection requires opening the chromebook and removing a certain screw (in most cases) or metallic sticker (for instance in case of the snow chromebook), which is bridging some contacts to keep the write protection active. a search on the internet should bring up a lot of information about where to find this special screw for different chromebook types and how this screw usually looks like (for the ones without explicit documentation). this method to enable/disable the write protection was used on all older chromebooks, but all newer ones do it in a different way which does not longer require the device to be opened, but requires a special usb-c cable to disable the write protection - the suzyqable - instead. this cable has on top of that a few other nice use cases: it provides access to the serial console of the chromebook, to the ec firmware console and to the so called cr50 console. all this together is called 'ccd' for closed case debugging. if a certain chromebook supports ccd can be seen in the last column of this table: https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices - more information about how to disable the write protection via suzyqable on supported systems can be found here: https://wiki.mrchromebox.tech/Firmware_Write_Protect#Disabling_WP_on_CR50_Devices_via_CCD

after following the mrchromebox guide from above to open the ccd, the following commands given at the ccd prompt will ensure maximum openness and least risk of not being able to get out of a bricked situation (but please be aware that this will give quite a bit of power to everyone having physical access to the device):
- wp false
- wp false atboot
- ccd reset factory
- ccd testlab enable (requires pressing the power button a few times when requested to prove presence)

and finally some more detailed links around those topics:

- https://chromium.googlesource.com/chromiumos/platform/ec/+/cr50_stab/docs/case_closed_debugging_cr50.md
- https://chromium.googlesource.com/chromiumos/docs/+/master/write_protection.md
- https://github.com/jackrosenthal/ec-zephyr-build/blob/master/docs/case_closed_debugging_cr50.md
- https://wiki.mrchromebox.tech/Unbricking
- https://chromium.googlesource.com/chromiumos/platform/ec/+/cr50_stab/docs/case_closed_debugging_cr50.md#Option-2_OpenNoDevMode-and-OpenFromUSB-are-set-to-Always

back to the gbb flags ... lets assume the write protection has been disabled in one way or another. the following are the steps to set the gbb flags in the desired way:

- the usual disclaimer:
  - all the below steps are done at your own risk
  - only do the below steps if you have at least a rough idea what they are doing
  - if something goes wrong it might brick your chromebook in the worst case - the chance is very very low, but the risk is there if flashing the low level firmware
- make sure the chromebook is properly charged and the power suply is connected properly
- make sure the chromebook is in developer mode (otherwise see above)
- disable the flash write protection (see above - this disables the first part of the write protection - the hardware write protection)
- boot chromeos
- ctl alt ->
- login as user chronos (no password required)
- sudo su (to become root)
- go somewhere, where a "touch testfile" does not give an error, because the dir is read-only - 'cd /tmp' should work
- check the second part of the write protection - the software write protection - via the comman 'flashrom --wp-status'
- it will most probably show enabled
- disable it via 'flashrom --wp-disable'
- re-check it via 'flashrom --wp-status'
- it should be disabled now (this will only work if the hardware write protection has been disabled beforehand)
- read the firmware from the flash into a file 'bios.bin' via the command 'flashrom -r bios.bin'
- it is a good idea to copy this file to a safe place outside of the chromebook now (sd card, usb stick etc.) to have a copy of the original unmodified firmware around just in case ...
- note: in case the boot screen should be changed as well (see below) it might be a good idea to do this first to avoid resetting the changed gbb settings again then
- set the desired gbb flags via the command '/usr/share/vboot/bin/set_gbb_flags.sh 0x19'
- it looks like in newer chromeos versions (around 112+ or so) one should use 'futility gbb --set --flash --flags=0x19' instead (but the old command from above seems to still work as well)
- the current gbb flags can be checked via the command '/usr/share/vboot/bin/get_gbb_flags.sh' (newer version: 'futility gbb --get --flash --flags')
- the meaning of the flags is (their sum is 0x19):
  - GBB_FLAG_DEV_SCREEN_SHORT_DELAY 0x00000001 - initial boot screen only for 2 seconds instead of the default 30 seconds and no beep afterwards
  - GBB_FLAG_FORCE_DEV_SWITCH_ON 0x00000008 - keep developer mode enabled by default
  - GBB_FLAG_FORCE_DEV_BOOT_USB 0x00000010 - keep the possibility to boot from usb/sd card enabled by default
- re-enable the software write protection via 'flashrom --wp-enable'
- in case you get an error for that command speaking about --wp-range (which seems to happen on newer chromeos versions), then please do the following (see: https://chromium.googlesource.com/chromiumos/docs/+/master/write_protection.md#Enabling-write-protect)
  - run the command 'fmap_decode bios.bin'
  - note down the range for WP_RO - usually it is 0x00000000 to 0x00200000 (or 0x00400000), but better double check
  - then rerun the failed command as (with the range noted down above) - for example 'flashrom --wp-enable --wp-range 0x00000000 0x00200000'
- re-check the software write protect via 'flashrom --wp-status' - it should be enabled again now
- if everything looks good, you can shutdown your system now
- put the flash write protect screw/sticker back or enable it again via ccd if desired

on older chromebooks (at least the 32bit versions) it is also possible to replace the initial developer mode sceen with a simple black screen with the small text 'developer mode warning' in the middle of the screen by doing the following steps before re-enabling the write protection above (make sure you have saved a copy of your initial bios.bin file somewhere outside of your chromebook beforehand):
- create an empty boot bitmap file via 'touch nothing'
- write this empty boot bitmap into the flash file via 'gbb_utility -s --bmpfv=nothing bios.bin'
- write back the modified flash file via 'flashrom -w bios.bin'
- to be on the safe side maybe redo the gbb flag settings from above as it might have been undone in case the bios.bin file was read before the gbb flags were set
- now you can continue with the re-enabling of the write protection as described above

it seems to be possible to do a similar cleanup of the intial developer mode screen on newer devices as well according to https://www.reddit.com/r/chromeos/comments/hbajeg/bios_bitmaps_question/fv8uncy/ - i tried it on an elm chromebook and it worked using the following commands:

- cd /tmp
- flashrom -p host -r bios.bin
- cp bios.bin bios.bin.org
- cbfstool bios.bin extract -n vbgfx.bin -f vbgfx.bin.org
- cbfstool bios.bin remove -n vbgfx.bin
- flashrom -p host -w bios.bin

it is a good idea to put the bios.bin.org and vbgfx.bin.org to a safe place in case one wants to revert the changes one day (i did not really like the result and actually reverted it back to the original state by flashing back the bios.bin.org). maybe it is even possible to replace the default bitmaps with custom own ones similar to how it is described at https://jcs.org/2016/08/26/openbsd_chromebook for the old gbb bitmaps. after looking closer at this it looks like this is more complex than initially expected - see: https://github.com/hexdump0815/imagebuilder/blob/61a5297fde1431bf28ff390aeabe6b4eab52f223/todo.txt#L9-L14

'''
