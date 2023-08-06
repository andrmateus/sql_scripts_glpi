select
    gt.id `id_chamado`
     ,case when gt.type = 1 then 'Incidente' when gt.type = 2 then 'Requisicao' end `tipo`
     ,gt.date `data_abertura`
     ,gt.solvedate `data_solucao`
     ,gt.closedate `data_fechamento`
     ,case
          when gt.status = 1 then 'Novo'
          when gt.status in (2,3) then 'Em atendimento'
          when gt.status = 4 then 'Pendente'
          when gt.status = 5 then 'Solucionado'
          when gt.status = 6 then 'Fechado'
    end `status`
     ,(
    select
        gu.name
    from
        glpi_tickets_users gtu
            inner join glpi_users gu on gu.id = gtu.users_id
    where
            gtu.tickets_id = gt.id
      and gtu.type = 1
    order by gtu.id desc
    limit 1
) `requerente`
     ,gu.name `autor`
     ,gic.completename `categoria`
     ,gl.completename `unidade_para_atendimento`
     ,ge.completename `entidade`
from
    glpi_tickets gt
    left join glpi_entities ge on ge.id = gt.entities_id
    left join glpi_itilcategories gic on gic.id = gt.itilcategories_id
    left join glpi_groups_tickets ggt on ggt.tickets_id = gt.id
    left join glpi_groups gg on gg.id = ggt.groups_id
    left join glpi_users gu on gt.users_id_recipient = gu.id
    left join glpi_locations gl on gl.id = gt.locations_id
where
    gt.is_deleted = 0
    and ge.completename not like '%MANUTENCAO%'
    and month(gt.date) = month(date_sub(curdate(), interval 1 month))
    and year(gt.date) = year(date_sub(curdate(), interval 1 month))
    and ggt.type = 2