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
     ,gic.completename `categoria_completa`
     ,gl.completename `unidade_para_atendimento`
     ,ge.completename `entidade`
     ,gg.name `grupo_solucionador`
from
    glpi_tickets gt
    left join glpi_entities ge on ge.id = gt.entities_id
    left join glpi_itilcategories gic on gic.id = gt.itilcategories_id
    left join glpi_itilcategories gic_sub on gic_sub.id = gic.itilcategories_id
    left join glpi_groups_tickets ggt on ggt.tickets_id = gt.id
    left join glpi_groups gg on gg.id = ggt.groups_id
    left join glpi_users gu on gt.users_id_recipient = gu.id
    left join glpi_locations gl on gl.id = gt.locations_id
where
    gt.is_deleted = 0
    and ge.completename not like '%MANUTENCAO%'
    and ggt.type = 2;


    SELECT
    gt.id `Chamado`
    ,gu.name `Técnico Atribuido`
    ,gg.name `Fila de Atendimento`
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, gt.date_mod, now()) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, gt.date_mod, now()), 60), 'm') `Ultima Atualizacao`
    ,gt.time_to_resolve `Tempo para Solução`
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, now(), gt.time_to_resolve), 60), 'm') as 'Tempo Restante'
FROM
	glpi_tickets gt
	left JOIN glpi_groups_tickets ggt ON ggt.tickets_id = gt.id
    left JOIN (select * from glpi_tickets_users where type = 2) gtu ON gtu.tickets_id = gt.id
	left join glpi_users gu on gu.id = gtu.users_id
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
	gg.region = "$group_name" and
    gt.time_to_resolve < date_add(now(), interval 3 day)
order by gt.time_to_resolve;;