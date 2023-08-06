select
    gt.id `ticket`
    ,gg.name `fila`
    ,gic.completename `categoria`
    ,datediff(curdate(), gt.date) `dias_aberto`
from
    glpi_tickets gt
    left join glpi_groups_tickets ggt on ggt.tickets_id = gt.id
    left join glpi_groups gg on gg.id = ggt.groups_id
    left join glpi_itilcategories gic on gic.id = gt.itilcategories_id
where
    gt.is_deleted = 0
    and gt.status in (1,2,3,4)
    and ggt.type = 2
    and gg.name = 'Gestão de Acessos'
order by dias_aberto desc
limit 10