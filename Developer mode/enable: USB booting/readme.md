guide: https://www.groovypost.com/howto/chromebook-recovery-flash-sd-card-drive/

# USB booting
sch: https://www.google.com/search?q=chromebook+force+recovery+usb

# steps:
1. Enter Development mode, and "browse as guest"
```
<esc> + <f5 (referesh)> + <power>
<ctrl> + <d>
<enter>
```

2. Wait for it to reboot and enter dev mode.
`<ctrl> + <d>`

3. now connect to a wifi network, and/or "Browse as guest"
```
<ctrl> + <alt> + <t>
shell
sudo bash
enable_dev_usb_boot
```
from: https://www.wikihow.com/Enable-USB-Booting-on-Chromebook
