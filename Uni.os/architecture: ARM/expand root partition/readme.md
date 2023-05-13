sch: https://www.google.com/search?q=arm+linux+expand+root

# from: imagebuilder `/scripts/extend-rootfs.sh`
https://github.com/hexdump0815/imagebuilder/issues/43

comment: "Writing the image this way should partition the drive and everything so you don't need to do so manually. Afterwards make sure to remove the USB before next boot and expand volume etc on first boot from emmc using `/scripts/extend-rootfs.sh`"

# from: PrawnOS
Expand the image to take up the entire device. 
https://github.com/SolidHal/PrawnOS#expand-prawnos

source: https://github.com/SolidHal/PrawnOS/blob/98581df1e671f35ac3ea629005edee568a8dfe86/scripts/InstallScripts/InstallPrawnOS.sh
