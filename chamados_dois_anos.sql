SELECT        gt.id AS id_chamado, CASE WHEN gt.type = 1 THEN 'Incidente' WHEN gt.type = 2 THEN 'Requisicao' END AS tipo, gt.date AS data_abertura, gt.solvedate AS data_solucao, gt.closedate AS data_fechamento,
              CASE WHEN gt.status = 1 THEN 'Novo' WHEN gt.status IN (2, 3) THEN 'Em atendimento' WHEN gt.status = 4 THEN 'Pendente' WHEN gt.status = 5 THEN 'Solucionado' WHEN gt.status = 6 THEN 'Fechado' END AS status,
              (SELECT        TOP (1) gu.name
               FROM            dbo.glpi_tickets_users AS gtu INNER JOIN
                               dbo.glpi_users AS gu ON gu.id = gtu.users_id
               WHERE        (gtu.tickets_id = gt.id) AND (gtu.type = 1)
               ORDER BY gtu.id DESC) AS requerente, gu.name AS autor, gic.completename AS categoria_completa, gic_sub.name AS categoria_2, gic_sub_two.name AS categoria_3, gl.completename AS unidade_para_atendimento,
              gl.name AS unidade_abrev, ge.completename AS entidade, ge.name AS entidade_abrev, gg.name AS grupo_solucionador
FROM            dbo.glpi_tickets AS gt LEFT OUTER JOIN
                dbo.glpi_entities AS ge ON ge.id = gt.entities_id LEFT OUTER JOIN
                dbo.glpi_itilcategories AS gic ON gic.id = gt.itilcategories_id LEFT OUTER JOIN
                dbo.glpi_itilcategories AS gic_sub ON gic_sub.id = gic.itilcategories_id LEFT OUTER JOIN
                dbo.glpi_itilcategories AS gic_sub_two ON gic_sub_two.id = gic_sub.itilcategories_id LEFT OUTER JOIN
                dbo.glpi_groups_tickets AS ggt ON ggt.tickets_id = gt.id LEFT OUTER JOIN
                dbo.glpi_groups AS gg ON gg.id = ggt.groups_id LEFT OUTER JOIN
                dbo.glpi_users AS gu ON gt.users_id_recipient = gu.id LEFT OUTER JOIN
                dbo.glpi_locations AS gl ON gl.id = gt.locations_id
WHERE        (gt.is_deleted = 0) AND (ge.completename NOT LIKE '%MANUTENCAO%') AND (ggt.type = 2)