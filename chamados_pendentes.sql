SELECT
    gt.id,
    gt.name,
    gt.date,
    gpmw.date_suspension AS `data_pendencia`,
    gpmwt.name AS `tipo_pendencia`,
    DATEDIFF(NOW(), gpmw.date_suspension) AS `dias_pendentes`,
    gg.name AS `grupo_tecnico`
FROM
    glpi_tickets gt
    INNER JOIN glpi_entities ge ON ge.id = gt.entities_id
    INNER JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    INNER JOIN glpi_groups gg ON gg.id = ggt.groups_id
    LEFT JOIN (
        SELECT
            gpmw.tickets_id,
            gpmw.date_suspension,
            gpmw.plugin_moreticket_waitingtypes_id
        FROM
            glpi_plugin_moreticket_waitingtickets gpmw
        WHERE
            gpmw.id = (
                SELECT
                    MAX(gpmw_inner.id)
                FROM
                    glpi_plugin_moreticket_waitingtickets gpmw_inner
                WHERE
                    gpmw_inner.tickets_id = gpmw.tickets_id
            )
    ) gpmw ON gpmw.tickets_id = gt.id
    LEFT JOIN glpi_plugin_moreticket_waitingtypes gpmwt ON gpmwt.id = gpmw.plugin_moreticket_waitingtypes_id
WHERE
    gt.is_deleted = 0
    AND gt.`status` = 4
    AND ggt.`type` = 2
    AND ge.completename NOT LIKE '%MANUTENCAO%'
ORDER BY
    dias_pendentes DESC
