SELECT
    gu.name as `tecnico`
	,count(gt.id) AS 'Fechados Mês'
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
	INNER JOIN glpi_itilcategories gic ON gic.id = gt.itilcategories_id
    inner join glpi_tickets_users gtu on gtu.tickets_id = gt.id
    inner join glpi_users gu on gu.id = gtu.users_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (5,6)
    and ggt.`type` = 2
    AND ggt.groups_id = 201
    and year(gt.solvedate) = year(now())
    and month(gt.solvedate) = month(now())
    and gtu.type = 2
group by tecnico
ORDER BY COUNT(gt.id) DESC
LIMIT 5