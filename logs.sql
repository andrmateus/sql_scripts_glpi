select
    a.id
    ,a.users_id_recipient
    ,a.date
    ,a.time_to_own
    ,a.data_atribuicao
    ,a.status
    ,a.type
    ,a.takeintoaccount_delay_stat
    ,case
        when a.status != 1 and a.takeintoaccount_delay_stat > 1 then (select user_name from glpi_logs where itemtype = 'Ticket' and items_id = a.id and a.data_atribuicao = date_mod limit 1)
        when (a.status != 1 and a.takeintoaccount_delay_stat = 1 and a.type = 2) then (select user_name from glpi_logs where itemtype = 'Ticket' and items_id = a.id and id_search_option = 12 and old_value = 1 limit 1)
     end `user_tempo_atendimento`

from
    (select *,date_add(date, interval sec_to_time(takeintoaccount_delay_stat) HOUR_SECOND) `data_atribuicao` from glpi_tickets where is_deleted = 0) `a`
where
    a.status != 1
    and type = 2
    and a.takeintoaccount_delay_stat = 1

order by a.id desc
limit 100