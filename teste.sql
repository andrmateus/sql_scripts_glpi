select
    a.id
    ,a.time_to_own
    ,a.data_atribuicao
    ,a.status
    ,a.type
    ,b.user_name
from
    (
    select
        *
        ,date_add(date, interval sec_to_time(takeintoaccount_delay_stat) HOUR_SECOND) `data_atribuicao`
    from
        glpi_tickets
    where
        time_to_own is not null
        and time_to_own > date
        and status != 1
    ) `a`
    left join (select * from glpi_logs where itemtype = 'Ticket' and  id_search_option = 12 and old_value = 1) `b` on (b.items_id = a.id)
where
    b.user_name is null
    and a.type = 2
order by a.id desc