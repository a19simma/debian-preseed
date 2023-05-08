# Commands to remaster and add preseeding to debian image

Much of the information is taken from the debian official wiki: https://wiki.debian.org/DebianInstaller/Preseed/EditIso

`7z x -oisofiles debian-11.7.0-amd64-netinst.iso`

`cp isolinux.cfg isofiles/isolinux/isolinux.cfg`

Remember to change to public keu at the the end of the preseed.cfg

```
chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
echo userkey.pub | cpio -H newc -o -A -F isofiles/install.amd/initrd
gzip isofiles/install.amd/initrd
chmod -w -R isofiles/install.amd/
```

```
cd isofiles
chmod +w md5sum.txt
find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt
chmod -w md5sum.txt
cd ..
```
```
genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o preseed-debian-11.7.0-amd64-netinst.iso isofiles
```
