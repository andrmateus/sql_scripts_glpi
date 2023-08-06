SELECT
	git.tickets_id, 
	CASE WHEN gt.type = 1 THEN 'Incidente' WHEN gt.type = 2 THEN 'Requisição' END AS 'Tipo',
	gp.name AS 'Hostname',
	gp.serial,
	gpt.name as 'Tipo Impressora',
	gt.date AS 'Data de Abertura',
	gl.completename AS 'Localizacao',
	gic.completename AS 'Categoria',
	(
		SELECT 
			gp.name
		FROM
					glpi_groups_tickets ggt, glpi_groups gp
		WHERE 
					ggt.tickets_id = gt.id AND
					gp.id = ggt.groups_id AND
					ggt.`type` = 2
	) AS 'Grupo Solucionador'
FROM
	glpi_tickets gt
	INNER JOIN glpi_items_tickets git ON git.tickets_id = gt.id
	INNER JOIN glpi_printers gp ON gp.id = git.items_id
	INNER JOIN glpi_locations gl ON gl.id = gt.locations_id
	INNER JOIN glpi_itilcategories gic ON gt.itilcategories_id = gic.id
    inner join glpi_printertypes gpt on gpt.id = gp.printertypes_id
WHERE 
	gt.date > '2023-03-01' AND
	git.itemtype LIKE 'Printer' AND
	gt.`status` IN (5,6)