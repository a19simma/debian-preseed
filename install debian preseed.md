chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
gzip isofiles/install.amd/initrd
chmod -w -R isofiles/install.amd/

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o preseed-debian-11.7.0-amd64-netinst.iso isofiles

chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/xen/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/xen/initrd
gzip isofiles/install.amd/xen/initrd
chmod -w -R isofiles/install.amd/

chmod +w -R isofiles/install.amd/
gunzip isofiles/install.amd/gtk/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/gtk/initrd
gzip isofiles/install.amd/gtk/initrd
chmod -w -R isofiles/install.amd/

cd isofiles
chmod +w md5sum.txt
find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt
chmod -w md5sum.txt
cd ..