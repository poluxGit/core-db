#!/bin/bash
# Auteur : polux@poluxfr.org
# License : GPL
# ******************************************************************************
#  Script de génération d'une version de script de la base de données
# ******************************************************************************
#

# Message Applicatif
echo ""
echo "***********************************"
echo "* SQL RELEASE SCRIPTS v0.1 @polux *"
echo "***********************************"
echo ""

# Verifcation du nombre d'argument
if [ $# -ne 3 ]
then
   echo "Usage : $0 <Schéma cible> <VersionMajeure> <VersionMineure>" >&2
   echo ""
   exit 1;
fi

# Variables
SCHEMA=$1
VMAJ=$(printf "%02d\n" $2)
VMIN=$(printf "%02d\n" $3)
DATEVAL=`date +%Y%m%d`
RELEASES_TMP_FILE=./releases/$SCHEMA.sql
RELEASES_DIR_ROOT=../releases
RELEASES_DIR=$RELEASES_DIR_ROOT/$SCHEMA-R-$VMAJ.$VMIN
SQL_OUTFILE=$RELEASES_DIR/DB-SCRIPTS_$SCHEMA.sql
SQL_FINAL=$RELEASES_DIR/DB-SCRIPTS_$SCHEMA-R-$VMAJ.$VMIN-final.${DATEVAL}.sql
SCRIPTS_DIR=./wip
GENDATE=`date +%Y-%m-%d_%H:%M:%S`

echo "* Releasing version $VMAJ.$VMIN of $SCHEMA database schema into '$RELEASES_DIR'."

if [ -e $RELEASES_DIR ]; then
    echo "- Output directory '$RELEASES_DIR' already exists! it will be erased."
    rm -Rf $RELEASES_DIR
fi

# Création du répertoire de génération
mkdir $RELEASES_DIR
if [ $? -ne 0 ]; then
  echo "**** ERROR during directory '$RELEASES_DIR' creation. ****"
  exit 1;
fi
echo "- Output directory '$RELEASES_DIR' created successfully."

# Génération du SQL
echo "- SQL Files concatenation process begin - '$SCRIPTS_DIR'."
# Par répertoire
for lfile in `find $SCRIPTS_DIR | grep sql`
do
   echo "-- Concat content of '$lfile' to  '$SQL_OUTFILE'."
   SOURCEFILENAME=`basename $lfile`;
   echo "" >> $SQL_OUTFILE
   echo "-- -------------------------------------------------------------------------- --" >> $SQL_OUTFILE
   echo "-- From Source file : $SOURCEFILENAME" >> $SQL_OUTFILE
   echo "-- -------------------------------------------------------------------------- --" >> $SQL_OUTFILE
   echo "" >> $SQL_OUTFILE
   cat $lfile >> $SQL_OUTFILE
done

echo "- Final Step - Inject Parameterized values into $SQL_FINAL"
# Remplacement des valeurs paramétrées
cat $SQL_OUTFILE | sed s/TARGET_SCHEMA/$SCHEMA/ | sed s/TARGET_VERSION/$VMAJ.$VMIN/ | sed s/GEN_DATE/$GENDATE/ >> $SQL_FINAL
rm -f $SQL_OUTFILE

cat $SQL_FINAL > $RELEASES_TMP_FILE

echo ""
exit 0
