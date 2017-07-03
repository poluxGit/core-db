#!/bin/bash

SRC=/var/services/homes/polux/mydocs/_imports
TARGETSQLFILE=./myecm_insert_imports.sql

 echo "#**************************************#";
 echo "# MyECM - SQL Import Generation        #";
 echo "#**************************************#";

echo "-> Source Directory : $SRC";
echo "-> Target SQL Orders file : $TARGETSQLFILE";
echo "* Start generation !";

find $SRC -type f | sed 's/^\.\///' | while read -r line
do
  filename=$(basename "$line")
  filesize=$(wc -c <"$line")
  filepath=$(dirname "$line")
  echo "--> SQL Transformation about  '$filename'.";
  echo "INSERT INTO tobj_fichiers(filename,filepath,filesize,mime) VALUES ('$filename','$filepath',$filesize,'notdef');" >> $TARGETSQLFILE
done
