-- -----------------------------------------------------------------------------
-- View definition header about complex Object named `V_OBJNAME_ALL`
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW `DBPREFIX_V_OBJNAME_LAST` AS
SELECT
  obj.tid,
  obj.bid,
  obj.version,
  obj.revision,
  obj.stitle
  SQL_QUERY_SELECT
  ,obj.ltitle,
  obj.comment,
  obj.cuser,
  obj.ctime,
  obj.uuser,
  obj.utime
FROM SQL_QUERY_FROM
WHERE
  obj.version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(obj.bid)
  AND obj.revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF (obj.bid)
ORDER BY obj.tid;
