select
    name,
    case
        when name like "Field BA%" then "NORDESTE"
        when name like "Field PB%" then "NORDESTE"
        when name like "Field PE%" then "NORDESTE"
        when name like "Field SE%" then "NORDESTE"
        when name like "Field DF%" then "CENTRO-OESTE"
        when name like "Field GO%" then "CENTRO-OESTE"
        when name like "Field PR%" then "SUL"
        when name like "Field SC%" then "SUL"
        when name like "Field RS%" then "SUL"
        when name like "Field RJ%" then "RIO"
        when name like "Field ES%" then "RIO"
        when name like "Field SP%" then "SP"
        when name like "Field MG%" then "MG"
        when name like "Suporte CSO%" then "Central"
        when name like "Gestão de Ativos%" then "Central"
        when name like "Suporte Simpress%" then "Central"
        when name like "Central%" then "Central"
    end `region`
from
    glpi_groups
where
    groups_id in (198, 295);


select
    *
from
    glpi_groups
where
    groups_id in (198, 295);


SELECT
   case
		when b.exceeded_count is null then 100
		ELSE ((1 - (b.exceeded_count / a.total_count)) * 100)
	END AS SLA
FROM
    (SELECT
        COUNT(*) AS total_count,
        MONTH(gt.closedate) AS month_num
     FROM
        glpi_tickets gt
		  INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
			inner join glpi_groups gg on gg.id = ggt.groups_id
     WHERE
        gt.is_deleted = 0
        AND YEAR(gt.closedate) = YEAR(NOW())
        AND ggt.`type` = 2
	     and gg.name = "$group_name"
        AND gt.type = 2
     GROUP BY
        month_num) AS a
    left JOIN
    (SELECT
        COUNT(*) AS exceeded_count,
        MONTH(gt.closedate) AS month_num
     FROM
        glpi_tickets gt
        INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
				inner join glpi_groups gg on gg.id = ggt.groups_id
     WHERE
        is_deleted = 0
        AND YEAR(gt.closedate) = YEAR(NOW())
        AND ggt.`type` = 2
	    and gg.name = "$group_name"
        AND gt.type = 2
        AND gt.solvedate > time_to_resolve
     GROUP BY
        month_num) AS b ON a.month_num = b.month_num
WHERE
    a.month_num = MONTH(NOW());


select
count(*)
FROM
(SELECT
	a.id
	,c.name
	,case
        when c.name like "Field BA%" then "NORDESTE"
        when c.name like "Field PB%" then "NORDESTE"
        when c.name like "Field PE%" then "NORDESTE"
        when c.name like "Field SE%" then "NORDESTE"
        when c.name like "Field DF%" then "CENTRO-OESTE"
        when c.name like "Field GO%" then "CENTRO-OESTE"
        when c.name like "Field PR%" then "SUL"
        when c.name like "Field SC%" then "SUL"
        when c.name like "Field RS%" then "SUL"
        when c.name like "Field RJ%" then "RIO"
        when c.name like "Field ES%" then "RIO"
        when c.name like "Field SP%" then "SP"
        when c.name like "Field MG%" then "MG"
        when c.name like "Suporte CSO%" then "Central"
        when c.name like "Gestão de Ativos%" then "Central"
        when c.name like "Suporte Simpress%" then "Central"
        when c.name like "Central%" then "Central"
    end `region`
FROM
	glpi_tickets a
	INNER JOIN glpi_groups_tickets b ON b.tickets_id = a.id
	INNER JOIN glpi_groups c ON c.id = b.groups_id
WHERE
	a.is_deleted = 0
    and a.type = 2
	AND a.status IN (4)
	AND b.`type` = 2
	and c.groups_id in(198, 295)
) `a`
WHERE
    a.region = "Central";

SELECT
	gt.id AS 'Chamado',
	gu.name as 'Usuario',
	date_format(timediff(now(), gt.date_mod), '%Hh:%im') as 'Tempo Modificação'

FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
	left join (select *, case
        when name like "Field BA%" then "NORDESTE"
        when name like "Field PB%" then "NORDESTE"
        when name like "Field PE%" then "NORDESTE"
        when name like "Field SE%" then "NORDESTE"
        when name like "Field DF%" then "CENTRO-OESTE"
        when name like "Field GO%" then "CENTRO-OESTE"
        when name like "Field PR%" then "SUL"
        when name like "Field SC%" then "SUL"
        when name like "Field RS%" then "SUL"
        when name like "Field RJ%" then "RIO"
        when name like "Field ES%" then "RIO"
        when name like "Field SP%" then "SP"
        when name like "Field MG%" then "MG"
        when name like "Suporte CSO%" then "Central"
        when name like "Gestão de Ativos%" then "Central"
        when name like "Suporte Simpress%" then "Central"
        when name like "Central%" then "Central"
    end `region` from glpi_groups) gg on gg.id = ggt.groups_id
	LEFT JOIN glpi_users gu ON gu.id = gt.users_id_lastupdater
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3,4) and
	ggt.`type` = 2
	and gg.region = "MG"
	and gt.date_mod > NOW() - INTERVAL 1 day

ORDER BY gt.date_mod DESC;

SELECT
	gg.name,
	count(gt.id) AS 'Backlog'
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
	INNER JOIN (select *, case
        when name like "Field BA%" then "NORDESTE"
        when name like "Field PB%" then "NORDESTE"
        when name like "Field PE%" then "NORDESTE"
        when name like "Field SE%" then "NORDESTE"
        when name like "Field DF%" then "CENTRO-OESTE"
        when name like "Field GO%" then "CENTRO-OESTE"
        when name like "Field PR%" then "SUL"
        when name like "Field SC%" then "SUL"
        when name like "Field RS%" then "SUL"
        when name like "Field RJ%" then "RIO"
        when name like "Field ES%" then "RIO"
        when name like "Field SP%" then "SP"
        when name like "Field MG%" then "MG"
        when name like "Suporte CSO%" then "Central"
        when name like "Gestão de Ativos%" then "Central"
        when name like "Suporte Simpress%" then "Central"
        when name like "Central%" then "Central"
    end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3,4) and
	ggt.`type` = 2
    and gg.region = "Central"
GROUP BY gg.name
ORDER BY count(gt.id) desc;

SELECT
	gu.name `atribuido`
	,count(gt.id) `chamados`
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
	LEFT JOIN glpi_tickets_users gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
    left JOIN (select *, case
        when name like "Field BA%" then "NORDESTE"
        when name like "Field PB%" then "NORDESTE"
        when name like "Field PE%" then "NORDESTE"
        when name like "Field SE%" then "NORDESTE"
        when name like "Field DF%" then "CENTRO-OESTE"
        when name like "Field GO%" then "CENTRO-OESTE"
        when name like "Field PR%" then "SUL"
        when name like "Field SC%" then "SUL"
        when name like "Field RS%" then "SUL"
        when name like "Field RJ%" then "RIO"
        when name like "Field ES%" then "RIO"
        when name like "Field SP%" then "SP"
        when name like "Field MG%" then "MG"
        when name like "Suporte CSO%" then "Central"
        when name like "Gestão de Ativos%" then "Central"
        when name like "Suporte Simpress%" then "Central"
        when name like "Central%" then "Central"
    end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3,4) and
	ggt.`type` = 2 and
	gtu.`type` = 2 and
	gg.region = 'Central'
GROUP BY atribuido;

SELECT
	count(a.id)
FROM
	(
	SELECT
			gt.id AS id
		FROM
			glpi_tickets gt
			left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
               left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
		WHERE
			gt.is_deleted = 0 and
			gt.`status` IN (1,2,3,4) and
			ggt.`type` = 2
	) AS `a`
where
	a.id NOT IN  (
		SELECT
			gt.id AS id
		FROM
			glpi_tickets gt
			left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
			left JOIN glpi_tickets_users gtu ON gtu.tickets_id = gt.id
           left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
		WHERE
			gt.is_deleted = 0 and
			gt.`status` IN (1,2,3,4) and
			ggt.`type` = 2 and
			gtu.`type` = 2
	);

SELECT
	count(gt.id) AS 'Qtd Abertos Fora do Prazo'
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gg.name = "$group_name" and
	date(gt.time_to_resolve) < date(now());

SELECT
    gt.id `chamado`
    ,gu.name `tecnico_atribuido`
    ,gg.name `fila_atendimento`
    ,gt.time_to_resolve
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve), 60), 'm') as 'tempo_para_resolver'
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN glpi_tickets_users gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gtu.type = 2 AND
	#gg.region = "$group_name" and
    (gt.time_to_resolve < date_add(now(), interval 1 day) and gt.time_to_resolve >= now() )
order by tempo_para_resolver;

SELECT
	gt.id AS 'Chamado',
	gu.name as 'Usuario',
	gt.date_mod,
	date_format(timediff(now(), gt.date_mod), '%Hh:%im') as 'Tempo Modificação'

FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
	left join (select *, case
        when name like "Field BA%" then "NORDESTE"
        when name like "Field PB%" then "NORDESTE"
        when name like "Field PE%" then "NORDESTE"
        when name like "Field SE%" then "NORDESTE"
        when name like "Field DF%" then "CENTRO-OESTE"
        when name like "Field GO%" then "CENTRO-OESTE"
        when name like "Field PR%" then "SUL"
        when name like "Field SC%" then "SUL"
        when name like "Field RS%" then "SUL"
        when name like "Field RJ%" then "RIO"
        when name like "Field ES%" then "RIO"
        when name like "Field SP%" then "SP"
        when name like "Field MG%" then "MG"
        when name like "Suporte CSO%" then "Central"
        when name like "Gestão de Ativos%" then "Central"
        when name like "Suporte Simpress%" then "Central"
        when name like "Central%" then "Central"
    end `region` from glpi_groups) gg on gg.id = ggt.groups_id
	LEFT JOIN glpi_users gu ON gu.id = gt.users_id_lastupdater
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3,4) and
	ggt.`type` = 2
	#and gg.region = "$group_name"
	and gt.date_mod < date_add(now(), interval -3 day)

ORDER BY gt.date_mod asc;

SELECT
   case
		when b.exceeded_count is null then 100
		ELSE ((1 - (b.exceeded_count / a.total_count)) * 100)
	END AS SLA
FROM
    (SELECT
        COUNT(*) AS total_count,
        MONTH(gt.closedate) AS month_num
     FROM
        glpi_tickets gt
		  INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
		  left join (select *, case
                when name like "Field BA%" then "NORDESTE"
                when name like "Field PB%" then "NORDESTE"
                when name like "Field PE%" then "NORDESTE"
                when name like "Field SE%" then "NORDESTE"
                when name like "Field DF%" then "CENTRO-OESTE"
                when name like "Field GO%" then "CENTRO-OESTE"
                when name like "Field PR%" then "SUL"
                when name like "Field SC%" then "SUL"
                when name like "Field RS%" then "SUL"
                when name like "Field RJ%" then "RIO"
                when name like "Field ES%" then "RIO"
                when name like "Field SP%" then "SP"
                when name like "Field MG%" then "MG"
                when name like "Suporte CSO%" then "Central"
                when name like "Gestão de Ativos%" then "Central"
                when name like "Suporte Simpress%" then "Central"
                when name like "Central%" then "Central"
            end `region` from glpi_groups) gg on gg.id = ggt.groups_id
     WHERE
        gt.is_deleted = 0
        AND YEAR(gt.closedate) = YEAR(NOW())
        AND ggt.`type` = 2
	    #and gg.name = "$group_name"
        AND gt.type = 1
     GROUP BY
        month_num) AS a
    left JOIN
    (SELECT
        COUNT(*) AS exceeded_count,
        MONTH(gt.closedate) AS month_num
     FROM
        glpi_tickets gt
        INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
		left join (select *, case
            when name like "Field BA%" then "NORDESTE"
            when name like "Field PB%" then "NORDESTE"
            when name like "Field PE%" then "NORDESTE"
            when name like "Field SE%" then "NORDESTE"
            when name like "Field DF%" then "CENTRO-OESTE"
            when name like "Field GO%" then "CENTRO-OESTE"
            when name like "Field PR%" then "SUL"
            when name like "Field SC%" then "SUL"
            when name like "Field RS%" then "SUL"
            when name like "Field RJ%" then "RIO"
            when name like "Field ES%" then "RIO"
            when name like "Field SP%" then "SP"
            when name like "Field MG%" then "MG"
            when name like "Suporte CSO%" then "Central"
            when name like "Gestão de Ativos%" then "Central"
            when name like "Suporte Simpress%" then "Central"
            when name like "Central%" then "Central"
        end `region` from glpi_groups) gg on gg.id = ggt.groups_id
     WHERE
        is_deleted = 0
        AND YEAR(gt.closedate) = YEAR(NOW())
        AND ggt.`type` = 2
	    #and gg.name = "$group_name"
        AND gt.type = 1
        AND gt.solvedate > time_to_resolve
     GROUP BY
        month_num) AS b ON a.month_num = b.month_num
WHERE
    a.month_num = MONTH(NOW());

SELECT
    gt.id `chamado`
    ,gu.name `tecnico_atribuido`
    ,gg.name `fila_atendimento`
    ,gt.time_to_resolve
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve), 60), 'm') as 'tempo_para_resolver'
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select * from glpi_tickets_users where type = 2) gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	#gg.region = "$group_name" and
    (gt.time_to_resolve < date_add(now(), interval 1 day) and gt.time_to_resolve >= now() )
order by gt.time_to_resolve;

SELECT
    gt.id `Chamado`
    ,gu.name `Técnico Atribuido`
    ,gg.name `Fila de Atendimento`
    ,gt.time_to_resolve `Tempo para Solução`
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select * from glpi_tickets_users where type = 2) gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gg.region = "$group_name" and
    (gt.time_to_resolve < date_add(now(), interval 1 day) and gt.time_to_resolve >= now() )
order by gt.time_to_resolve;

SELECT
    a.id `Chamado`
    ,d.name `Fila de Atendimento`
    ,(select date_suspension from glpi_plugin_moreticket_waitingtickets where a.id = tickets_id order by date_suspension desc limit 1) `Data Pendencia`
    ,(select datediff(now(), date_suspension) from glpi_plugin_moreticket_waitingtickets where a.id = tickets_id order by date_suspension desc limit 1) `Dias Pendente`
FROM
	glpi_tickets a
    left join (select * from glpi_groups_tickets where type = 2) c on c.tickets_id = a.id
      left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) d ON d.id = c.groups_id
where
    a.status = 4
    and a.is_deleted = 0
    and d.region = "Central"
order by 'Dias Pendente' asc;

SELECT
    gt.id `Chamado`
    ,gu.name `Técnico Atribuido`
    ,gg.name `Fila de Atendimento`
    ,gt.time_to_resolve `Tempo para Solução`
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve), 60), 'm') as 'Diferenca'
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select * from glpi_tickets_users where type = 2) gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	#gg.region = "$group_name" and
	 gg.groups_id in (198, 295) and
    gt.time_to_resolve < date_add(now(), interval 3 day)
order by gt.time_to_resolve;

SELECT
	count(gt.id) AS 'Qtd Abertos Fora do Prazo'
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "Central"
                    when name like "Gestão de Ativos%" then "Central"
                    when name like "Suporte Simpress%" then "Central"
                    when name like "Central%" then "Central"
                end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	#gg.region = "RIO" and
	gg.groups_id != 218 and
    gt.time_to_resolve < now();

select
    *
from
    glpi_groups
where
    level = 1;

select
count(*)
FROM
(SELECT
	a.id
	,c.name
	,case
        when c.name like "Field BA%" then "NORDESTE"
        when c.name like "%UMC%" then "HOSPITAIS"
        when c.name like "Field PB%" then "NORDESTE"
        when c.name like "Field PE%" then "NORDESTE"
        when c.name like "Field SE%" then "NORDESTE"
        when c.name like "Field DF%" then "CENTRO-OESTE"
        when c.name like "Field GO%" then "CENTRO-OESTE"
        when c.name like "Field PR%" then "SUL"
        when c.name like "Field SC%" then "SUL"
        when c.name like "Field RS%" then "SUL"
        when c.name like "Field RJ%" then "RIO"
        when c.name like "Field ES%" then "RIO"
        when c.name like "Field SP%" then "SP"
        when c.name like "Field MG%" then "MG"
        when c.name like "Suporte CSO%" then "MG"
        when c.name like "Gestão de Ativos%" then "CENTRAL ATENDIMENTO"
        when c.name like "Suporte Simpress%" then "CENTRAL ATENDIMENTO"
        when c.name like "Central%" then "CENTRAL ATENDIMENTO"
    end `region`
FROM
	glpi_tickets a
	INNER JOIN glpi_groups_tickets b ON b.tickets_id = a.id
	INNER JOIN glpi_groups c ON c.id = b.groups_id
WHERE
	a.is_deleted = 0
	AND a.status IN (1,2,3,4)
	AND b.`type` = 2
	and c.groups_id in(198, 295)
) `a`
WHERE
    a.region = "CENTRAL ATENDIMENTO";


select
    name,
    region
from
    (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field MG UMC%" then "HOSPITAIS"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "MG"
                    when name like "Gestão de Ativos%" then "CENTRAL"
                    when name like "Suporte Simpress%" then "CENTRAL"
                    when name like "Central%" then "CENTRAL"
            end `region` from glpi_groups) gg
where
    groups_id in(198, 295);


select
    count(*)
FROM
	glpi_tickets a
	INNER JOIN glpi_groups_tickets b ON b.tickets_id = a.id
	INNER JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field MG UMC%" then "HOSPITAIS"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "MG"
                    when name like "Gestão de Ativos%" then "CENTRAL"
                    when name like "Suporte Simpress%" then "CENTRAL"
                    when name like "Central%" then "CENTRAL"
            end `region` from glpi_groups) c ON c.id = b.groups_id
WHERE
	a.is_deleted = 0
	AND a.status IN (1,2,3,4)
	AND b.`type` = 2
    and a.type = 1
    and c.region = "CENTRAL";


SELECT
	gt.id `id`
    ,gg.name `fila_atendimento`
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field MG UMC%" then "HOSPITAIS"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "MG"
                    when name like "Gestão de Ativos%" then "CENTRAL"
                    when name like "Suporte Simpress%" then "CENTRAL"
                    when name like "Central%" then "CENTRAL"
            end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gg.groups_id in(198, 295) AND
    gt.time_to_resolve < now();

SELECT
	gt.id `id`
    ,gg.name `fila_atendimento`
    ,gt.time_to_resolve `data_expiracao`
FROM
	glpi_tickets gt
	INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select *, case
                    when name like "Field BA%" then "NORDESTE"
                    when name like "Field MG UMC%" then "HOSPITAIS"
                    when name like "Field PB%" then "NORDESTE"
                    when name like "Field PE%" then "NORDESTE"
                    when name like "Field SE%" then "NORDESTE"
                    when name like "Field DF%" then "CENTRO-OESTE"
                    when name like "Field GO%" then "CENTRO-OESTE"
                    when name like "Field PR%" then "SUL"
                    when name like "Field SC%" then "SUL"
                    when name like "Field RS%" then "SUL"
                    when name like "Field RJ%" then "RIO"
                    when name like "Field ES%" then "RIO"
                    when name like "Field SP%" then "SP"
                    when name like "Field MG%" then "MG"
                    when name like "Suporte CSO%" then "MG"
                    when name like "Gestão de Ativos%" then "CENTRAL"
                    when name like "Suporte Simpress%" then "CENTRAL"
                    when name like "Central%" then "CENTRAL"
            end `region` from glpi_groups) gg ON gg.id = ggt.groups_id
WHERE
	gt.is_deleted = 0 and
	gt.`status` IN (1,2,3) and
	ggt.`type` = 2 AND
	gg.groups_id in(198, 295) AND
    (gt.time_to_resolve >= now() and gt.time_to_resolve < date_add(now(), INTERVAL 2 HOUR));
