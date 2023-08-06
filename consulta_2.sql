select
    a.date
    ,a.time_to_own
    ,a.takeintoaccount_delay_stat
    ,date_add(date, interval sec_to_time(takeintoaccount_delay_stat) HOUR_SECOND) `data_atribuicao`
from
    glpi_tickets a
where
    a.id = 445918