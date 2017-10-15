<?php

/**
 * generate_sql-db_scripts
 *
 * Script de génération de script de base de données.
 * Génération depuis une définition métier des objets fonctionnels
 *
 * @author poluxGit
 *
 */

 require_once 'libs/CSVBusinessPatternSQLGenerator.class.php';

 $target_db = '';
 $dbobj_prefix = '';
 $input_csv_file = '';
 $output_filename = '';
 $cObjectsAttributes = [];
 $aComplexObjects = [];
 $aSimpleObjects = [];


// Nombre arguments OK ?
if($argc != 5 || is_null($argv))
{
  echo "Usage : php generate_sql-db_scripts.php <TARGET_SCHEMA> <DB_OBJ_PREFIX> <DICO_CSV_FILE> <OUTPUT_FILE> \n";
  exit;
}

// <------------------------- begin of the script -------------------------> //
$output_filename = '';
$output_filehandler = null;

// ARGV Parameters
$target_db = $argv[1];
$dbobj_prefix = strtoupper($argv[2]);
$input_csv_file = $argv[3];
$output_filename = $argv[4];

$lObjCSV = new CSVBusinessPatternSQLGenerator($input_csv_file,$target_db);

try{
  $lObjCSV->loadModel();
  $lObjCSV->generateSQLScript($dbobj_prefix,$output_filename,true);
}
catch(Exception $e)
{
  echo sprintf("Erreur => %s",$e->getMessage());
}


// <------------------------- end of the script -------------------------> //
exit;

 ?>
