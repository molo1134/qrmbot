#!/bin/sh
#
# 2-clause BSD license.
# Copyright (c) 2019,2026 molo1134@github. All rights reserved.

BASEPATH=$(dirname "$0")
EXECUTABLES=$(find "$BASEPATH/lib" -type f -perm /111 | grep -v '\.pl$' | sort)
for e in $EXECUTABLES ; do
#	echo $e
	echo ln -s -f "$e" .
	ln -s -f "$e" .
done
