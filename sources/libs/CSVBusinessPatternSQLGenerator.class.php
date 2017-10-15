<?php

/**
 * Classe CSVBusinessPatternSQLGenerator
 *
 * @author poluxGit
 */
class CSVBusinessPatternSQLGenerator
{
  /**
   * Schema cible de la base de données
   *
   * @var string
   * @access protected
   */
  protected $sTargetSchemaName = null;

  /**
   * Fichier du modèle métier
   *
   * @var string
   * @access protected
   */
  protected $sModelFile = null;

  /**
   * Schema cible de la base de données
   *
   * @var array
   * @access protected
   */
  protected $aFileLines = [];

  /**
   * Par type de line, le nombre de colonnes minimum
   *
   * @var array
   * @access protected
   */
  protected $aFileCheckColumnsCount = [];

  /**
   * Attributs (titre) par type d'objet
   *
   * @var array
   * @access protected
   */
  protected $aAttrObjet = [];



  /**
   * Contructeur par défaut
   */
  function __construct($pStrCSVFile,$pStrSchemaName)
  {
      $this->sTargetSchemaName = $pStrSchemaName;
      $this->sModelFile = $pStrCSVFile;
      $this->_initializeInternalDataArrays();
  }//end __construct()

  /**
   * Initialise les types de lignes possibles aux chargement du fichier CSV
   */
  private function _initializeInternalDataArrays(){
    $this->aFileLines['OBJC'] = [];
    $this->aFileLines['OBJS'] = [];
    $this->aFileLines['LNK'] = [];
    $this->aFileLines['ATTROBJDEF'] = [];
    $this->aFileLines['ATTRLNKDEF'] = [];

    $this->aFileCheckColumnsCount['OBJC'] = 6;
    $this->aFileCheckColumnsCount['OBJS'] = 6;
    $this->aFileCheckColumnsCount['LNK'] = 7;
    $this->aFileCheckColumnsCount['ATTROBJDEF'] = 8;
    $this->aFileCheckColumnsCount['ATTRLNKDEF'] = 8;

  }//end _initializeInternalDataArrays()


  /**
   * Check du nombre de colonnes minimal de la ligne de données passée en argument
   *
   * @internal Renvoi vrai si le type n'est pas trouvé dans le tableau du nombre de colonnes minimal.
   */
  private function _checkColumnsLine($pArrLine){
    $lBoolResultat = false;
    if(array_key_exists($pArrLine[0],$this->aFileLines))
    {
        if(array_key_exists($pArrLine[0],  $this->aFileCheckColumnsCount)){
            $lBoolResultat = count($pArrLine)>=$this->aFileCheckColumnsCount[$pArrLine[0]];
        }
        else
        {
            $lBoolResultat =  true;
        }
    }
    else {
      throw new Exception(sprintf("Le type de ligne '%s' n'est pas pris en charge. \n",$pArrLine[0]));
    }

    return $lBoolResultat;

  }//end _initializeInternalDataArrays()

  /**
   * Gère le chargement des définitions dans la structure interne
   *
   * @access private
   *
   * @return string Message
   */
  private function _loadCSVLine($pArrLine,$pIntLineNumber)
  {
    if(!empty($pArrLine[0])){
      if($this->_checkColumnsLine($pArrLine)){
        // According type of line (first information)...
        //$lArrDataPrepared =
        // TODO Implémenter pour le sattributs => [ATTROBJEDF][DOCUMENT][0][data]
        $this->aFileLines[strtoupper($pArrLine[0])] = array_merge($this->aFileLines[strtoupper($pArrLine[0])],array($pArrLine[1] => $pArrLine));
      }
    }
    else {
      throw new Exception("Empty Line => ignored !");
    }
  }//end _loadCSVLine()

  /**
   * Method 'loadModel'
   *
   * @access public
   * @throws Exception Si le fichier CSV n'est pas lisible.
   */
  public function loadModel($pBoolVerbose=true){
    // check if inpoutfile exists !
    if(file_exists($this->sModelFile))
    {
      $row = 1;
      if (($handle = @fopen($this->sModelFile, "r")) !== FALSE) {

        // CSV File reading !
        while (($data = fgetcsv($handle, 0, ";")) !== FALSE) {
          try {
            $this->_loadCSVLine($data,$row);
          }
          catch(Exception $e)
          {
            if($pBoolVerbose)
            {
              echo sprintf("ERR => Ligne %d - %s",
                $row,
                $e->getMessage());
            }
          }
          finally{
            $row++;
          }
        }
        fclose($handle);
      }
    }
    else {
      throw new Exception(sprintf("Le fichier source '%s' n'existe pas ! Chargement annulé.",$this->sModelFile));
    }
  }//end loadModel()

  /**
   * Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pBoolVerbose        Affichage des messages sur la sortie standard.
   */
  public function generateSQLScript($pStrDBObjectPrefix,$pStrOutputFile,$pBoolVerbose=true)
  {
    $this->_generateSimpleObject($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/OBJS.sql');
    $this->_generateComplexObject($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/OBJC.sql');
    $this->_generateLink($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/LNK.sql');
    $this->_generateAttributeDefinitionOnObject($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/ATTROBJDEF.sql');
    $this->_generateAttributeDefinitionOnLink($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/ATTRLNKDEF.sql');
    $this->generateComplexObjectView($pStrDBObjectPrefix,$pStrOutputFile,'./sources/patterns/OBJVIEWC_ALL.sql','./sources/patterns/OBJVIEWS_ALL.sql','./sources/patterns/OBJVIEW_LAST.sql');

  }//end generateSQLScript()

  /**
   * Objet Complexe - Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pStrFilePattern     Fichier du modele SQL
   */
  protected function _generateComplexObject($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePattern)
  {
    if(!file_exists($pStrFilePattern))
    {
      throw new Exception(sprintf("Le fichier SQL Pattern '%s' n'as pu être trouvé !",$pStrFilePattern));
    }

    $patternContent = file_get_contents($pStrFilePattern);

    foreach($this->aFileLines['OBJC'] as $lStrKey => $lArrDataObjet){

      // ****** Getting & validating CSV Data !
      $lStrObjectName = $lArrDataObjet[1];
      $lStrSTitle     = $lArrDataObjet[2];
      $lStrComment    = $lArrDataObjet[3];
      $lStrLTitle     = $lArrDataObjet[4];
      $lStrSiglum     = $lArrDataObjet[5];

      // Parameters to replace !
      $idxfield     = 0;
      $patterns     = array();
      $replacements = array();

      // INSERT FIELS
      $patterns[$idxfield]     = '/DEFAULT_COMPLEX_OBJECT_STITLE/';
      $replacements[$idxfield] = $lStrSTitle;
      $idxfield++;
      $patterns[$idxfield]     = '/DEFAULT_COMPLEX_OBJECT_LTITLE/';
      $replacements[$idxfield] = $lStrLTitle;
      $idxfield++;
      $patterns[$idxfield]     = '/DEFAULT_COMPLEX_OBJECT_COMMENT/';
      $replacements[$idxfield] = $lStrComment;
      $idxfield++;
      $patterns[$idxfield]     = '/DEFAULT_COMPLEX_OBJECT_SIGLE/';
      $replacements[$idxfield] = $lStrSiglum;
      $idxfield++;

      // Table name (i.e : ECM_DOCUMENT).
      // formmat rule: DBPrefix_ObjectNAME
      $patterns[$idxfield]     = '/DEFAULT_COMPLEX_OBJTABLE/';
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.$lStrObjectName;
      $idxfield++;

      // Default DB Schema
      $patterns[$idxfield]     = '/TARGET_SCHEMA/';
      $replacements[$idxfield] = $this->sTargetSchemaName;
      $idxfield++;

      $patterns[$idxfield]     = '/DEFCOMPOBJ/';
      $replacements[$idxfield] = $lStrSiglum;
      $idxfield++;

      $patterns[$idxfield]     = '/DBPREFIX/';
      $replacements[$idxfield] = $pStrDBObjectPrefix;
      $idxfield++;

      $patterns[$idxfield]     = '/OBJECT_NAME_UCF/';
      $replacements[$idxfield] = ucfirst(strtolower($lStrObjectName));
      $idxfield++;

      // preg_replace($patterns, $replacements, $patternContent);
      file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
    }
  }//end _generateComplexObject()

  /**
   * Objet Simple - Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pStrFilePattern     Fichier du modele SQL
   */
  protected function _generateSimpleObject($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePattern)
  {
    if(!file_exists($pStrFilePattern))
    {
      throw new Exception(sprintf("Le fichier SQL Pattern '%s' n'as pu être trouvé !",$pStrFilePattern));
    }

    $patternContent = file_get_contents($pStrFilePattern);

    foreach($this->aFileLines['OBJS'] as $lStrKey => $lArrDataObjet){

      // ****** Getting & validating CSV Data !
      $lStrObjectName = $lArrDataObjet[1];
      $lStrSTitle = $lArrDataObjet[2];
      $lStrComment = $lArrDataObjet[3];
      $lStrLTitle = $lArrDataObjet[4];
      $lStrSiglum = $lArrDataObjet[5];

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
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.$lStrObjectName;
      $idxfield++;

      // Default DB Schema
      $patterns[$idxfield] = '/TARGET_SCHEMA/';
      $replacements[$idxfield] = $this->sTargetSchemaName;
      $idxfield++;

      $patterns[$idxfield] = '/DEFOBJ/';
      $replacements[$idxfield] = $lStrSiglum;
      $idxfield++;

      // preg_replace($patterns, $replacements, $patternContent);
      file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
    }
  }//end generateSimpleObject()

  /**
   * Attribut sur objet - Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pStrFilePattern     Fichier du modele SQL
   */
  public function _generateAttributeDefinitionOnObject($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePattern)
  {
    if(!file_exists($pStrFilePattern))
    {
      throw new Exception(sprintf("Le fichier SQL Pattern '%s' n'as pu être trouvé !",$pStrFilePattern));
    }

    $patternContent = file_get_contents($pStrFilePattern);

    foreach($this->aFileLines['ATTROBJDEF'] as $lStrKey => $lArrDataObjet){

      // TODO : Rajouter une niveau de parcours
      // ****** Getting & validating CSV Data !
      $lStrObjectName = $lArrDataObjet[1];
      $lStrAttrUName = $lArrDataObjet[2];
      $lStrSTitle = $lArrDataObjet[3];
      $lStrComment = $lArrDataObjet[4];
      $lStrLTitle = $lArrDataObjet[5];
      $lStrAttrType = $lArrDataObjet[6];
      $lStrDefault = $lArrDataObjet[7];
      $lStrPattern = $lArrDataObjet[8];

      // Parameters to replace !
      $idxfield = 0;
      $patterns = array();
      $replacements = array();

      // INSERT FIELS
      $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME/';
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.strtoupper($lStrObjectName);
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

      // Specific store only for complex Object on attribute
      if(!array_key_exists($lStrObjectName,$this->aAttrObjet)){
        $this->aAttrObjet[$lStrObjectName] = [];
      }
      array_push($this->aAttrObjet[$lStrObjectName],$lStrSTitle);

      file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
    }
  }//end _generateAttributeDefinitionOnObject()

  /**
   * Attribut sur liens - Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pStrFilePattern     Fichier du modele SQL
   */
  public function _generateAttributeDefinitionOnLink($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePattern)
  {
    if(!file_exists($pStrFilePattern))
    {
      throw new Exception(sprintf("Le fichier SQL Pattern '%s' n'as pu être trouvé !",$pStrFilePattern));
    }

    $patternContent = file_get_contents($pStrFilePattern);

    foreach($this->aFileLines['ATTRLNKDEF'] as $lStrKey => $lArrDataObjet){

      $lStrObjectNameSrc = $lArrDataObjet[1];
      $lStrObjectNameDst = $lArrDataObjet[2];
      $lStrSTitle = $lArrDataObjet[3];
      $lStrComment = $lArrDataObjet[4];
      $lStrLTitle = $lArrDataObjet[5];
      $lStrAttrType = $lArrDataObjet[6];
      $lStrDefault = $lArrDataObjet[7];
      $lStrPattern = $lArrDataObjet[8];

      // Parameters to replace !
      $idxfield = 0;
      $patterns = array();
      $replacements = array();

      // INSERT FIELS
      $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME_SRC/';
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.strtoupper($lStrObjectNameSrc);
      $idxfield++;
      $patterns[$idxfield] = '/ATTR_TYPEOBJ_TABLENAME_DST/';
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.strtoupper($lStrObjectNameDst);
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
      file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
    }
  }//end _generateAttributeDefinitionOnLink()


  /**
   * Liens - Generation du script SQL dans le fichier spécifié
   *
   * @param string $pStrDBObjectPrefix  Prefix des objets de la base de données.
   * @param string $pStrOutputFile      Fichier Script SQL généré
   * @param string $pStrFilePattern     Fichier du modele SQL
   */
  public function _generateLink($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePattern)
  {
    if(!file_exists($pStrFilePattern))
    {
      throw new Exception(sprintf("Le fichier SQL Pattern '%s' n'as pu être trouvé !",$pStrFilePattern));
    }

    $patternContent = file_get_contents($pStrFilePattern);

    foreach($this->aFileLines['LNK'] as $lStrKey => $lArrDataObjet){

      $lStrObjectName = $lArrDataObjet[1];
      $lStrSTitle = $lArrDataObjet[2];
      $lStrParent = $lArrDataObjet[3];
      $lStrSon = $lArrDataObjet[4];
      $lStrComment = $lArrDataObjet[5];
      $lStrLTitle = $lArrDataObjet[6];

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
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.strtoupper($lStrParent);
      $idxfield++;
      $patterns[$idxfield] = '/LNK_TABLE_OBJSON/';
      $replacements[$idxfield] = $pStrDBObjectPrefix.'_'.strtoupper($lStrSon);
      $idxfield++;

      // preg_replace($patterns, $replacements, $patternContent);
      file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContent),FILE_APPEND);
    }
  }//end _generateLink()

  /**
   * Generation du script SQL dans le fichier spécifié
   *
   */
  public function generateComplexObjectView($pStrDBObjectPrefix,$pStrOutputFile,$pStrFilePatternCALL,$pStrFilePatternSALL,$pStrFilePatternLast)
  {

    // get pattern files ...
    //$patternfileAll = './sources/patterns/OBJVIEWC_ALL.sql';
    $patternContentAll = file_get_contents($pStrFilePatternCALL);

  //  $patternfileAllS = './sources/patterns/OBJVIEWS_ALL.sql';
    $patternContentAllS = file_get_contents($pStrFilePatternSALL);

  //  $patternfileLast = './sources/patterns/OBJVIEW_LAST.sql';
    $patternContentLast = file_get_contents($pStrFilePatternLast);

    // For each Complex Objects having attributes
    foreach($this->aAttrObjet as $lStrObjectName => $lCObjAttribute)
    {
      // Parameters to replace !
      $idxfield = 0;
      $patterns = array();
      $replacements = array();
      $lStrSQLAttr = "";
      $lStrSQLFrom = "";
      $lStrSQLWhere = "";
      $lStrSQLWhereLast = "";

      // CREATE VIEW
      $patterns[$idxfield] = '/OBJNAME/';
      $replacements[$idxfield] = strtoupper($lStrObjectName);
      $idxfield++;

      // FROM - Building FROM Part of SQL Query defining Object' View
      $lStrSQLFrom = sprintf("`%s` obj \n",$pStrDBObjectPrefix.'_'.strtoupper($lStrObjectName));

      // for each attributes recorded!
      $lIntIdxAttr = 1;
      foreach($lCObjAttribute as $lStrAttributeSTitle)
      {
        $lStrSQLAttr .= sprintf(", aobj%d.attr_value AS `%s` \n",$lIntIdxAttr,$lStrAttributeSTitle);
        $lStrSQLFrom .= sprintf(
          "LEFT JOIN CORE_ATTROBJECTS aobj%d ON (aobj%d.stitle = '%s' AND aobj%d.obj_tid = obj.tid) \n",
          $lIntIdxAttr,
          $lIntIdxAttr,
          $lStrAttributeSTitle,
          $lIntIdxAttr);

        $lIntIdxAttr++;
      }

      $patterns[$idxfield] = '/SQL_QUERY_SELECT/';
      $replacements[$idxfield] = $lStrSQLAttr;
      $idxfield++;

      $patterns[$idxfield] = '/DBPREFIX/';
      $replacements[$idxfield] = $pStrDBObjectPrefix;
      $idxfield++;

      $patterns[$idxfield] = '/SQL_QUERY_FROM/';
      $replacements[$idxfield] = $lStrSQLFrom;
      $idxfield++;

      print_r($this->aFileLines);

      if(array_key_exists(strtoupper($lStrObjectName),$this->aFileLines['OBJS'])){
        file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContentAllS),FILE_APPEND);
      }else{
        // One more value for LAST View : OBJECT_NAME_UCF
        file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContentAll),FILE_APPEND);
        $patterns[$idxfield] = '/OBJECT_NAME_UCF/';
        $replacements[$idxfield] = ucfirst(strtolower($lStrObjectName));
        $idxfield++;

        file_put_contents($pStrOutputFile,preg_replace($patterns, $replacements, $patternContentLast),FILE_APPEND);
      }
    }// next Complex Objects

  }//end generateComplexObjectView()

}//end class

?>
