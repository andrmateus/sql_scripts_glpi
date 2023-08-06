SELECT
	gt.id `id`
    ,gg.name `fila_atendimento`
    ,gt.time_to_resolve
    ,gu.name
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN glpi_groups gg ON gg.id = ggt.groups_id
    left join (select * from glpi_tickets_users where type = 2) gtu on gtu.tickets_id = gt.id
    left join glpi_users gu on gu.id = gtu.users_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gg.groups_id in(198, 295) AND
    gt.time_to_resolve < now();