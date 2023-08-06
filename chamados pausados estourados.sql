select
    *
from
    (SELECT
         a.id `Chamado`
          ,d.name `Fila de Atendimento`
          ,a.time_to_resolve
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
     and d.groups_id != 218
     order by 'Dias Pendente' asc) `a`
where
    a.`Data Pendencia` > a.time_to_resolve;



select
    gt.id `Chamado`
    ,gt.status
    ,gu.name `Técnico Atribuido`
    ,gg.name `Fila de Atendimento`
    ,gt.`Tempo para Solução`
    ,CONCAT(FLOOR(TIMESTAMPDIFF(MINUTE, now(), gt.`Tempo para Solução`) / 60), 'h:', MOD(TIMESTAMPDIFF(MINUTE, now(), gt.`Tempo para Solução`), 60), 'm') as 'Diferenca'
from
    (SELECT
        *
        ,case
            when gt_sub.status in (1,2,3) then gt_sub.time_to_resolve
            when gt_sub.date_suspension > gt_sub.time_to_resolve then gt_sub.time_to_resolve
        end `Tempo para Solução`
    FROM


	    (select *,case when status = 4 then (select date_suspension from glpi_plugin_moreticket_waitingtickets where id = tickets_id order by date_suspension desc limit 1) end `date_suspension`  from glpi_tickets where is_deleted = 0) `gt_sub`
    ) `gt`
    left JOIN (select * from glpi_groups_tickets where type = 2) ggt ON ggt.tickets_id = gt.id
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
	gt.`status` = 4 and
	#gg.region = "$group_name" and
	#gg.groups_id not in (218) and
	#gg.groups_id in (198, 295) and
    gt.`Tempo para Solução` < date_add(now(), interval 3 day);



select
    itemtype
    ,count(*)
from
    glpi_plugin_fusioninventory_rulematchedlogs
group by itemtype;