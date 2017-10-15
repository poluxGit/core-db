#!/bin/bash
# Auteur : polux@poluxfr.org
# License : GPL
# ******************************************************************************
# Message Applicatif
echo ""
echo "*******************************************"
echo "* SQL RELEASE SCRIPTS v0.1 @polux for ECM *"
echo "*******************************************"
echo ""
# Verifcation du nombre d'argument
if [ $# -ne 1 ]
then
   echo "Usage : $0 <Schéma cible>" >&2
   echo ""
   exit 1;
fi

# Variables
SCHEMA=$1
RELEASES_DIR_ROOT=./_tmp
ECM_DICO_CSVFILE=./business-models/ecm-pattern/ECM.csv
GENDATE=`date +%Y-%m-%d_%H%M%S`
OUTPUT_FILE=./releases/ECM/ECM-SQL-SCRIPT_${GENDATE}.sql

echo "* Generating SQL scripts for ECM Module into $SCHEMA database."
echo "- CSV definition file from '$ECM_DICO_CSVFILE'."

# Génération du SQL
echo "- Starting SQL script generation from a CSV Dictionnary file."
php ./sources/generate_sql-db_scripts.php $SCHEMA ECM $ECM_DICO_CSVFILE $RELEASES_DIR_ROOT/ECM.sql
echo "- Ending SQL script generation !"
echo ""
cat $RELEASES_DIR_ROOT/$SCHEMA.sql $RELEASES_DIR_ROOT/ECM.sql >> $OUTPUT_FILE
echo ""
exit 0
