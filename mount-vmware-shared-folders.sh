#!/usr/bin/env bash

error_and_exit() {
	echo "[-] Unable to mount shared folders. Make sure vmware-tools are installed correctly" 
	exit
}


sudo mkdir /mnt/hgfs

if sudo touch /etc/rc.local;
then
	if $(sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other);
	then
		if $(sudo chown root /etc/rc.local); 
		then
			if $(sudo chmod 755 /etc/rc.local);
			then
				echo "[+] Successfully mounted VMWare shared folder to /mnt/hgfs!"
			else
				error_and_exit
			fi
		else
			error_and_exit
		fi
	else
		error_and_exit
	fi
else
	error_and_exit
fi
