**Best guide**: https://github.com/hexdump0815/linux-mainline-on-arm-chromebooks/blob/main/readme.md#enabling-developer-mode

# enabling developer mode
section:
'''
in order to boot anything else than chromeos on a chromebook one needs to enable the developer mode for it. a few things related to enabling the developer mode are important to know: first - in the process all data saved locally on the chromebook will be deleted, so important data should be backed up first - and second - in developer mode some of the advanced security features of chromeos are not enabled anymore. some more information about the developer mode and how to enable it on different devices can be found here: https://chromium.googlesource.com/chromiumos/docs/+/master/developer_mode.md

on a normal chromebook with a built in keyboard the following procedure will initiate the switch to developer mode (see: https://chromium.googlesource.com/chromiumos/docs/+/master/debug_buttons.md#firmware-keyboard-interface):

esc + refresh (the round circle button) and press power button
ctrl d
enter (to accept)
it will take around 10 minutes to do the switch
for more tablet style chromebooks without a fixed keyboard (like the lenovo duet for instance) the following procedure will initiate the switch to developer mode (see: https://chromium.googlesource.com/chromiumos/docs/+/master/debug_buttons.md#firmware-menu-interface):

press the volume - and volume + buttons at the same time and then press the power button to turn on the device
a prompt saying something like "please insert a recovery usb disk" will appear
press the volume + button, now a menu should appear with options like "show debug info", "cancel", "power off", and "language"
press the volume - and volume + buttons at the same time again, now the option "show debug info" should change to "confirm disabling os verification"
select this option using the volume buttons and confirm it via the power button
it will take around 10 minutes to do the switch
afterwards preparing everything for booting from sd card or usb looks like this by going to the command prompt (see: https://chromium.googlesource.com/chromiumos/docs/+/master/developer_mode.md#shell):

ctl alt ->
login as user chronos (no password required)
sudo su (to become root)
crossystem dev_boot_usb=1 dev_boot_signed_only=0
reboot
ctrl u (to boot from sd card at the first initial screen after reboot)
'''
