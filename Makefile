image := debian-12.4.0-amd64-netinst.iso
build:
	rm -r isofiles
	7z x -oisofiles ${image}
	mkdir -p isofiles/isolinux
	cp isolinux.cfg isofiles/isolinux/isolinux.cfg
	chmod +w -R isofiles/install.amd/
	gunzip isofiles/install.amd/initrd.gz
	echo preseed.cfg | cpio -H newc -o -A -F isofiles/install.amd/initrd
	gzip isofiles/install.amd/initrd
	chmod -w -R isofiles/install.amd/
	chmod +w isofiles/md5sum.txt
	find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > isofiles/md5sum.txt
	chmod -w isofiles/md5sum.txt
	genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o preseed-${image} isofiles
