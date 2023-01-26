# GitLab Runner runs out of disk space

This is an [SOP](https://en.wikipedia.org/wiki/Standard_operating_procedure) to remediate GitLab Runner runs out of disk space issue. Since the runner is configured with [docker executor](https://docs.gitlab.com/runner/executors/docker.html) it may cache a lot of container images in it's file system. Let's quickly check this: 

```bash

# ssh to the node

df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            196M     0  196M   0% /dev
tmpfs            42M  436K   41M   2% /run
/dev/sdb1        30G   12G   17G  41% /
tmpfs           206M     0  206M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sdb15      124M   11M  114M   9% /boot/efi
/dev/sda1       3.9G   24K  3.7G   1% /mnt
tmpfs            42M     0   42M   0% /run/user/1000

# as root (or with sudo) change to / and

du * -sh

0	bin
73M	boot
0	dev
3.9M	etc
5.3M	home
0	lib
0	lib32
0	lib64
0	libx32
16K	lost+found
4.0K	media
20K	mnt
16K	opt
0	proc
427M	root
436K	run
0	sbin
4.0K	srv
4.1G	swapfile
0	sys
40K	tmp
1.7G	usr
5.0G	var <== most likely this is the biggest directory

```

Docker keeps its images in `/var/lib/docker`. We can prune the images like this:

```bash

docker system prune -af 

# or like this:

docker rmi $(docker images -qa)

```

Consider cronjob on daily / weekly basis (depends on runner usage).

That's it!