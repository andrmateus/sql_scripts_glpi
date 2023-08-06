SELECT
    gl.*
    ,(DATEDIFF(gl.date_mod,
	 (
        SELECT gl_next.date_mod
        FROM glpi_logs gl_next
        WHERE gl_next.items_id = gl.items_id
            AND gl_next.itemtype = gl.itemtype
            AND gl_next.id_search_option = gl.id_search_option
            AND gl_next.linked_action = gl.linked_action
            AND gl_next.id < gl.id
        ORDER BY gl_next.id desc
        LIMIT 1
    ))) AS `tempo_fila_anterior (dias)`
FROM
    glpi_logs gl
WHERE
    gl.itemtype = 'Ticket'
    AND gl.items_id in (SELECT gt.id FROM glpi_tickets gt WHERE gt.time_to_resolve < gt.solvedate AND gt.is_deleted = 0)
    AND gl.id_search_option = 8
    AND gl.linked_action = 15
ORDER BY
    gl.items_id DESC , gl.id
