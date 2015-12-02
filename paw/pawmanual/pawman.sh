#!/bin/sh
nawk '/<INCLUDE FILE=paw/ {split($2,arr,"=")
			    file=arr[2] ".sgml"
			    while (getline < file >0) { print }
                          	close(file); next }
			  {print}' pawmast.sgml

