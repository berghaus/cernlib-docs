#!/bin/sh
nawk '			{print}
/%!CERNPS_include/	{ file=$2
			  while (getline < file >0) { print }
       	                  close(file) } ' $1
