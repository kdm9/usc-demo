
rootfs.tar: Dockerfile
	docker build --tag usc-demo .
	./docker2rootfs -o $@ usc-demo

README.html: README.rst
	rst2html $< $@

rootfs.tpxz: rootfs.tar
	pixz $<
