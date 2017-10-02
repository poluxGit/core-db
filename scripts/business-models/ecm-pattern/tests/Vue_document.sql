select
	doc.*, 
	aobj1.attr_value as 'Mois',
    aobj3.attr_value as 'Jour',
    aobj2.attr_value as 'Année'
FROM  (ECM_DOCUMENT doc)
	LEFT JOIN CORE_ATTROBJECTS aobj1 ON (aobj1.adef_tid = 'ATDEF-000000000000000000000001'  AND aobj1.obj_tid = doc.tid)
    LEFT JOIN CORE_ATTROBJECTS aobj2 ON (aobj2.adef_tid = 'ATDEF-000000000000000000000002'  AND aobj2.obj_tid = doc.tid)
    LEFT JOIN CORE_ATTROBJECTS aobj3 ON (aobj3.adef_tid = 'ATDEF-000000000000000000000003'  AND aobj3.obj_tid = doc.tid);
		


