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


 $target_db = '';
 $dbobj_prefix = '';
 $input_csv_file = '';
 $output_filename = '';

// Nombre arguments OK ?
if($argc != 5 || is_null($argv))
{
  echo "Usage : php generate_sql-db_scripts.php <TARGET_SCHEMA> <DB_OBJ_PREFIX> <DICO_CSV_FILE> <OUTPUT_FILE> \n";
  exit;
}

/**
 *  Manage a CSV entry
 */
function manageLine($pArrData,$pIntRowCount){

  global $output_filename;

  if(count($pArrData)>=1 && !empty($pArrData[0]))
  {

    $lStrMsg = '';
    // According type of line (first information)...
    switch(strtoupper($pArrData[0]))
    {
      case 'OBJC':
          $lStrMsg="Complex Object Instanciation !";
          generateComplexObject($pArrData,$output_filename);
          break;
      case 'OBJS':
          $lStrMsg="Simple Object Instanciation !";
          generateSimpleObject($pArrData,$output_filename);
        break;
      case 'LNK':
          $lStrMsg="Link Instanciation !";
          generateLink($pArrData,$output_filename);
          break;
      case 'ATTROBJDEF':
          $lStrMsg="Attribute on Object definition creation !";
          generateAttributeDefinitionOnObject($pArrData,$output_filename);
          break;
      case 'ATTRLNKDEF':
          $lStrMsg="Attribute on Link definition creation !";
          generateAttributeDefinitionOnLink($pArrData,$output_filename);
          break;
      default:
        $lStrMsg="Type not identified ! - Line ignored.";
        break;
    }
  }
  else {
    $lStrMsg = sprintf("Empty Line => ignored !");
  }

  // Display Message !
  echo sprintf(" Line %d - ".$lStrMsg." \n",$pIntRowCount);
}//end manageLine()


/**
 * Simple Business Object generation
 *
 * @param   array(mixed)  $pArrData             Array of CSV Values
 * @param   object        $pObjOutfilehandler   Output fileHandler.
 *
 * @todo Generation de cartouche avec heure/date de génératio net source CSV
 *
 */
function generateSimpleObject($pArrData,$pStrOutputfile){

  global $target_db;
  global $dbobj_prefix;

  // get pattern file ...
  $patternfile = './patterns/OBJS.sql';
  $patternContent = file_get_contents($patternfile);

  // ****** Getting & validating CSV Data !
  // $lStr = $pArrData[];
  $lStrObjectName = $pArrData[1];
  $lStrSTitle = $pArrData[2];
  $lStrComment = $pArrData[3];
  $lStrLTitle = $pArrData[4];
  $lStrSiglum = $pArrData[5];

  // Parameters to replace !
  $idxfield = 0;
  $patterns = array();
  $replacements = array();

  // INSERT FIELS
  $patterns[$idxfield] = '/DEFAULT_OBJTABLE_STITLE/';
  $replacements[$idxfield] = $lStrSTitle;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_OBJTABLE_LTITLE/';
  $replacements[$idxfield] = $lStrLTitle;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_OBJTABLE_COMMENT/';
  $replacements[$idxfield] = $lStrComment;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_OBJTABLE_PREFIX/';
  $replacements[$idxfield] = $lStrSiglum;
  $idxfield++;

  // Table name (i.e : ECM_DOCUMENT).
  // formmat rule: DBPrefix_ObjectNAME
  $patterns[$idxfield] = '/DEFAULT_OBJTABLE/';
  $replacements[$idxfield] = $dbobj_prefix.'_'.$lStrObjectName;
  $idxfield++;

  // Default DB Schema
  $patterns[$idxfield] = '/TARGET_SCHEMA/';
  $replacements[$idxfield] = $target_db;
  $idxfield++;

  $patterns[$idxfield] = '/DEFOBJ/';
  $replacements[$idxfield] = $lStrSiglum;
  $idxfield++;

  // preg_replace($patterns, $replacements, $patternContent);
  file_put_contents($pStrOutputfile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);

}//end generateSimpleObject()

/**
 *
 */
function generateComplexObject($pArrData,$pStrOutputfile){

  global $target_db;
  global $dbobj_prefix;

  // get pattern file ...
  $patternfile = './patterns/OBJC.sql';
  $patternContent = file_get_contents($patternfile);

  // ****** Getting & validating CSV Data !
  // $lStr = $pArrData[];
  $lStrObjectName = $pArrData[1];
  $lStrSTitle = $pArrData[2];
  $lStrComment = $pArrData[3];
  $lStrLTitle = $pArrData[4];
  $lStrSiglum = $pArrData[5];

  // Parameters to replace !
  $idxfield = 0;
  $patterns = array();
  $replacements = array();

  // INSERT FIELS
  $patterns[$idxfield] = '/DEFAULT_COMPLEX_OBJECT_STITLE/';
  $replacements[$idxfield] = $lStrSTitle;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_COMPLEX_OBJECT_LTITLE/';
  $replacements[$idxfield] = $lStrLTitle;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_COMPLEX_OBJECT_COMMENT/';
  $replacements[$idxfield] = $lStrComment;
  $idxfield++;
  $patterns[$idxfield] = '/DEFAULT_COMPLEX_OBJECT_SIGLE/';
  $replacements[$idxfield] = $lStrSiglum;
  $idxfield++;

  // Table name (i.e : ECM_DOCUMENT).
  // formmat rule: DBPrefix_ObjectNAME
  $patterns[$idxfield] = '/DEFAULT_COMPLEX_OBJTABLE/';
  $replacements[$idxfield] = $dbobj_prefix.'_'.$lStrObjectName;
  $idxfield++;

  // Default DB Schema
  $patterns[$idxfield] = '/TARGET_SCHEMA/';
  $replacements[$idxfield] = $target_db;
  $idxfield++;

  $patterns[$idxfield] = '/DEFCOMPOBJ/';
  $replacements[$idxfield] = $lStrSiglum;
  $idxfield++;

  $patterns[$idxfield] = '/DBPREFIX/';
  $replacements[$idxfield] = $dbobj_prefix;
  $idxfield++;

  $patterns[$idxfield] = '/OBJECT_NAME_UCF/';
  $replacements[$idxfield] = ucfirst(strtolower($lStrObjectName));
  $idxfield++;

  // preg_replace($patterns, $replacements, $patternContent);
  file_put_contents($pStrOutputfile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
}//end generateComplexObject()

/**
 * Generate an attribute definition on object
 */
function generateAttributeDefinitionOnObject($pArrData,$pStrOutputfile){

  global $target_db;
  global $dbobj_prefix;

  // get pattern file ...
  $patternfile = './patterns/ATTROBJDEF.sql';
  $patternContent = file_get_contents($patternfile);

  // ****** Getting & validating CSV Data !
  // $lStr = $pArrData[];
  $lStrObjectName = $pArrData[1];
  $lStrAttrUName = $pArrData[2];
  $lStrSTitle = $pArrData[3];
  $lStrComment = $pArrData[4];
  $lStrLTitle = $pArrData[5];
  $lStrAttrType = $pArrData[6];
  $lStrDefault = $pArrData[7];
  $lStrPattern = $pArrData[8];

  // Parameters to replace !
  $idxfield = 0;
  $patterns = array();
  $replacements = array();

  // INSERT FIELS
  $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME/';
  $replacements[$idxfield] = $dbobj_prefix.'_'.strtoupper($lStrObjectName);
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_STITLE/';
  $replacements[$idxfield] = $lStrSTitle;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_LTITLE/';
  $replacements[$idxfield] = $lStrLTitle;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_COMMENT/';
  $replacements[$idxfield] = $lStrComment;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_TYPE/';
  $replacements[$idxfield] = $lStrAttrType;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_PATTERN/';
  $replacements[$idxfield] = $lStrPattern;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_DEFAULT_VALUE/';
  $replacements[$idxfield] = $lStrDefault;
  $idxfield++;


  // preg_replace($patterns, $replacements, $patternContent);
  file_put_contents($pStrOutputfile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
}//end generateAttributeDefinition()

/**
 * Generate a Link definition
 */
function generateLink($pArrData,$pStrOutputfile){

    global $target_db;
    global $dbobj_prefix;

    // get pattern file ...
    $patternfile = './patterns/LNK.sql';
    $patternContent = file_get_contents($patternfile);

    // ****** Getting & validating CSV Data !
    // $lStr = $pArrData[];
    $lStrObjectName = $pArrData[1];
    $lStrSTitle = $pArrData[2];
    $lStrParent = $pArrData[3];
    $lStrSon = $pArrData[4];
    $lStrComment = $pArrData[5];
    $lStrLTitle = $pArrData[6];

    // Parameters to replace !
    $idxfield = 0;
    $patterns = array();
    $replacements = array();

    // INSERT FIELS
    $patterns[$idxfield] = '/LNK_STITLE/';
    $replacements[$idxfield] = $lStrSTitle;
    $idxfield++;
    $patterns[$idxfield] = '/LNK_LTITLE/';
    $replacements[$idxfield] = $lStrLTitle;
    $idxfield++;
    $patterns[$idxfield] = '/LNK_COMMENT/';
    $replacements[$idxfield] = $lStrComment;
    $idxfield++;
    $patterns[$idxfield] = '/LNK_TABLE_OBJPARENT/';
    $replacements[$idxfield] = $dbobj_prefix.'_'.strtoupper($lStrParent);
    $idxfield++;
    $patterns[$idxfield] = '/LNK_TABLE_OBJSON/';
    $replacements[$idxfield] = $dbobj_prefix.'_'.strtoupper($lStrSon);
    $idxfield++;

    // preg_replace($patterns, $replacements, $patternContent);
    file_put_contents($pStrOutputfile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
}//end generateAttributeDefinition()

/**
 * Generate an attribute definition on object
 */
function generateAttributeDefinitionOnLink($pArrData,$pStrOutputfile){

  global $target_db;
  global $dbobj_prefix;

  // get pattern file ...
  $patternfile = './patterns/ATTRLNKDEF.sql';
  $patternContent = file_get_contents($patternfile);

  // ****** Getting & validating CSV Data !
  // $lStr = $pArrData[];
  $lStrObjectNameSrc = $pArrData[1];
  $lStrObjectNameDst = $pArrData[2];
  $lStrSTitle = $pArrData[3];
  $lStrComment = $pArrData[4];
  $lStrLTitle = $pArrData[5];
  $lStrAttrType = $pArrData[6];
  $lStrDefault = $pArrData[7];
  $lStrPattern = $pArrData[8];

  // Parameters to replace !
  $idxfield = 0;
  $patterns = array();
  $replacements = array();

  // INSERT FIELS
  $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME_SRC/';
  $replacements[$idxfield] = $dbobj_prefix.'_'.strtoupper($lStrObjectNameSrc);
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME_DST/';
  $replacements[$idxfield] = $dbobj_prefix.'_'.strtoupper($lStrObjectNameDst);
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_STITLE/';
  $replacements[$idxfield] = $lStrSTitle;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_LTITLE/';
  $replacements[$idxfield] = $lStrLTitle;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_COMMENT/';
  $replacements[$idxfield] = $lStrComment;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_TYPE/';
  $replacements[$idxfield] = $lStrAttrType;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_PATTERN/';
  $replacements[$idxfield] = $lStrPattern;
  $idxfield++;
  $patterns[$idxfield] = '/ATTR_DEFAULT_VALUE/';
  $replacements[$idxfield] = $lStrDefault;
  $idxfield++;


  // preg_replace($patterns, $replacements, $patternContent);
  file_put_contents($pStrOutputfile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
}//end generateAttributeDefinitionOnLink()




// <------------------------- begin of the script -------------------------> //
$output_filename = '';
$output_filehandler = null;

// ARGV Parameters
$target_db = $argv[1];
$dbobj_prefix = strtoupper($argv[2]);
$input_csv_file = $argv[3];
$output_filename = $argv[4];

// check if output_file exists !
if(file_exists($output_filename)){  unlink($output_filename); }

$row = 1;
if (($handle = @fopen($input_csv_file, "r")) !== FALSE) {

  // CSV File reading !
  while (($data = fgetcsv($handle, 0, ";")) !== FALSE) {
    $num = count($data);
    manageLine($data,$row);
    $row++;
  }

  fclose($handle);
}
else {
  echo "ERROR : '".$argv[1]."' can't be reached ! \n";
}


// <------------------------- end of the script -------------------------> //
exit;

 ?>
