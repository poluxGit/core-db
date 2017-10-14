-- -----------------------------------------------------------------------------
-- View definition header about complex Object named `V_OBJNAME_ALL`
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW `DBPREFIX_V_OBJNAME` AS
SELECT
  obj.tid,
  obj.bid,
  obj.stitle
  SQL_QUERY_SELECT
  ,obj.ltitle,
  obj.comment,
  obj.cuser,
  obj.ctime,
  obj.uuser,
  obj.utime,
  obj.isActive
FROM SQL_QUERY_FROM
WHERE
  obj.isActive = 1
ORDER BY obj.tid;
