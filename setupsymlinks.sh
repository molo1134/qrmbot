#!/bin/sh

BASEPATH=$(dirname $0)
EXECUTABLES=$(find $BASEPATH/lib -type f -perm /111 | grep -v '\.pl$' | sort)
for e in $EXECUTABLES ; do
#	echo $e
	echo ln -s -f $e
	ln -s -f $e
done
