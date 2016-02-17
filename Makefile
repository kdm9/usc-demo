
rootfs.tpxz: rootfs.tar
	pixz $<

rootfs.tar: Dockerfile
	docker build --tag usc-demo .
	./docker2rootfs -o $@ usc-demo

