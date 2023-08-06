SELECT
	a.id AS `Chamado`
	,b.completename AS `Categoria`
	,e.completename AS `Fila`
FROM
	glpi_tickets a
	INNER JOIN glpi_itilcategories b ON b.id = a.itilcategories_id
	INNER JOIN glpi_entities c ON c.id = a.entities_id
	INNER JOIN glpi_groups_tickets d ON d.tickets_id = a.id
	INNER JOIN glpi_groups e ON e.id = d.groups_id
WHERE
	a.is_deleted = 0
	AND a.`status` IN (1,2,3,4)
	AND b.completename NOT LIKE '%(Demanda)%'
	AND c.completename NOT LIKE '%MANUTENÇÃO%'
	AND a.time_to_resolve IS null
	AND d.`type` = 2