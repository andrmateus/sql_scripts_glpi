
        select
            a.id `chamado_glpi`
             ,a.date `data_abertura`
             ,a.closedate `data_fechamento`
             ,a.solvedate `data_solucao`
             ,a.date_mod `data_modificacao`
             ,a.users_id_lastupdater  as id_lastupdater
             ,a.time_to_resolve
             ,a.users_id_recipient  as id_recepient
             ,a.itilcategories_id
             ,case   when a.type = 1 then 'Incidente'
                     when a.type = 2 and a.itilcategories_id in (2003, 2008, 2019, 2034, 2040, 2051, 2057, 2064, 2071, 2077, 2764, 2765, 2767) then 'Demanda'
                     when a.type = 2 and g.completename like '%(Demanda)%' then 'Demanda'
                     when a.type = 2 and g.completename like '%Zabbix%' then 'Demanda'
                     when a.type = 2 then 'Requisicao'
                     else 'Classificar'
            end as type_tratado
             ,case
                when b.solutiontypes_id = 165 then 'Cancelado'
                when a.status in (5,6) then 'Fechado'
                when a.status in (1,2,3,4) then 'Abertos'
             end as `status_tratado`
             ,d.date_answered
             ,d.satisfaction
             ,g.name as tipo_chamado
             ,g.completename as caminho_chamado
             ,k.is_active `tecnico - ativo?`
             ,k.name `técnico`
             ,h.name as grupo
             ,n.name `grupo_coordenacao`
             ,case when i.user_dn like '%OU=TI%' then 'TI' else 'Nao' end as usuario_ti
             ,case
                 when i.user_dn like '%OU=TI%' && m.name like '%Stefanini%' then 'Stefanini'
                 when i.user_dn like '%OU=TI%' then 'Oncoclinicas'
                 else 'Nao'
             end `ti`
            ,a.locations_id `location_id`
            ,o.name `titulo_ti`
            ,a.time_to_own `prazo_atendimento`
            ,a.takeintoaccount_delay_stat `tempo_atendimento_sec`
        from (select * from glpi_tickets where is_deleted = 0 and (year(date) = year(curdate()) or year(solvedate) = year(curdate()))) as a
                 left join glpi_itilsolutions as b on a.id = b.items_id and a.solvedate = b.date_creation
                 left join glpi_groups_tickets as c on a.id = c.tickets_id and c.type = 2
                 left join glpi_ticketsatisfactions as d on a.id = d.tickets_id
                 left join glpi_slas as e on a.slas_id_ttr = e.id
                 inner join glpi_entities as f on a.entities_id = f.id and f.completename not like "ONCOCLINICAS DO BRASIL > MANUTENÇÃO%"
                 left join glpi_itilcategories   as g on a.itilcategories_id = g.id
                 left join glpi_groups   as h on c.groups_id = h.id
                 left join glpi_users    as i on i.id = a.users_id_recipient
                 left join glpi_users    as j on j.id = a.users_id_lastupdater
                 left join (select gtu.tickets_id, gu.name, gu.is_active, gu.usertitles_id from glpi_tickets_users gtu inner join glpi_users gu on gu.id = gtu.users_id where gtu.type = 2) as `k` on k.tickets_id = a.id
                 left join glpi_locations l on l.id = a.locations_id
                 left join glpi_usertitles m on m.id = i.usertitles_id
                 left join glpi_groups as n on n.id = h.groups_id
                 left join glpi_usertitles o on o.id = k.usertitles_id