#!/bin/sh
for i in test*; do
	cd $i
	ln -fs ../common.makefile makefile
	ln -fs ../common.figures figures
	cd ..
done
