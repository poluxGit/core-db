UPDATE
  myecm.tobj_fichiers fic INNER JOIN vobj_fichiers_src_target vfic ON fic.uid = vfic.FIC_UID
SET fic.filename = vfic.TRGT_FILENAME,fic.filepath = vfic.TRGT_PATH ;
