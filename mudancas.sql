select
    a.id `id_mudanca`
    ,a.name `mudanca`
    ,case

        when a.status = 1 then 'Novo'
        when a.status = 4 then 'Pendente'
        when a.status = 5 then 'Aplicado'
        when a.status = 6 then 'Fechado'
        when a.status = 7 then 'Aceito'
        when a.status = 10 then 'Aprovacao'
     end as `status`
    ,(
        select
            end
        from
            glpi_changetasks
        where
            changes_id = a.id
        order by id desc
        limit 1
    ) as `data_programada`
    ,a.date `data_abertura`
    ,a.closedate `data_fechamento`
    ,a.solvedate `data_solucao`
    ,d.completename `tipo_mudanca`
    ,f.name `fila_atendimento`
    ,h.name `resolvedor`

from
    glpi_changes a
    left join glpi_plugin_fields_changeinformaesmudanas c on c.items_id = a.id
    left join glpi_plugin_fields_tipodamudanafielddropdowns d on d.id = c.plugin_fields_tipodamudanafielddropdowns_id
    left join glpi_changes_groups e on e.changes_id = a.id
    left join glpi_groups f on f.id = e.groups_id
    left join glpi_changes_users g on g.changes_id = a.id
    left join glpi_users h on h.id = g.users_id
where
    a.is_deleted = 0
    and a.status in (1,4,7,10,6,5)
    and e.type = 2
    and g.type = 2
    and (date(a.date) >= date(date_sub(curdate(), interval 1 month)) or date(a.solvedate) = date(date_sub(curdate(), interval 1 month)));


select
    case

        when a.status = 1 then 'Novo'
        when a.status = 4 then 'Pendente'
        when a.status = 5 then 'Aplicado'
        when a.status = 6 then 'Fechado'
        when a.status = 7 then 'Aceito'
        when a.status = 10 then 'Aprovacao'
     end as `status`
    ,count(a.id) `chamados`
from
    glpi_changes a
    left join glpi_plugin_fields_changeinformaesmudanas c on c.items_id = a.id
    left join glpi_plugin_fields_tipodamudanafielddropdowns d on d.id = c.plugin_fields_tipodamudanafielddropdowns_id
    left join glpi_changes_groups e on e.changes_id = a.id
    left join glpi_groups f on f.id = e.groups_id
    left join glpi_changes_users g on g.changes_id = a.id
    left join glpi_users h on h.id = g.users_id
where
    a.is_deleted = 0
    and a.status in (1,4,7,10,6,5)
    and e.type = 2
    and g.type = 2
    and (date(a.date) >= date(date_sub(curdate(), interval 1 month)) or date(a.solvedate) = date(date_sub(curdate(), interval 1 month)))

group by status
order by chamados desc;
