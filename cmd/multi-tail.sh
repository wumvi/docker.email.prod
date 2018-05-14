#!/bin/bash

for file in "$@"
do
	echo "tail $file"
	tail -f $file &
done
