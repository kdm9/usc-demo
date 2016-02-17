===========================
Userspace Containers PoC[1]
===========================


This is a demonstration of using `proot <http://proot.me>`_ as a
fully-userspace containerisation platform. Using proot, it is possible to
execute workflows in isolated environments on e.g. HPC clusters:

    - as an unprivileged user
    - without any setuid binaries
    - fully within $HOME or any other writeable directory
    - without any admin help or installation

In this repo is a Dockerfile that creates an Debian image within which we can
install khmer.

.. [#] PoC here standing for Proot-of-concept ;)


Demo
^^^^

To run this demo you will need installed on your local computer:

    - ``docker``: get it from docker.io
    - ``python-docker``: ``pip install docker-py``
    - ``python-docopt``: ``pip install docopt``

I refer below to ``<YOUR_HPC>`` or your remote machine. This could be any
computer running a Linux kernel. Your laptop, your local dev box, your HPC
cluster, your router...

1. Run ``make`` to create a rootfs.tar
2. ``scp rootfs.tar <YOUR_HPC>:~/``
3. On your remote machine, do:

   .. code-block:: shell

       mkdir ~/usc-demo
       cd ~/usc-demo
       wget -nv -O proot http://portable.proot.me/proot-x86_64
       chmod +x ./proot
       mkdir -p rootfs
       tar xvf ~/rootfs.tar

   This will install ``proot`` and set up the rootfs you made locally in step
   1.
4. Prove to yourself that your HPC cluster is useless:

   .. code-block:: shell

      # Unless you're very lucky, the following will fail wherever you normally
      # do your computation
      apt-get update
      apt-get install khmer
5. Run proot to create an isolated environment:

   .. code-block:: shell

      env -i ./proot -S ./rootfs /bin/bash

      # You should now see a prompt ending in '#', indicating you are root

      # Now, we will try installing khmer again:
      apt-get update
      apt-get install khmer

      # Whoo! If this hasn't broken your brain, then it was already broken

      # Let's hash some reads and calculate and abundance histogram
      load-into-counting.py -M 1e8 -k 32 sequence.cg sequence.fasta
      abundance-dist.py sequence.cg sequence.fasta hist.csv

      cat hist.csv
