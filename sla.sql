select
    *
from
    glpi_rules a
    left join glpi_rulecriterias b on b.rules_id = a.id
    left join glpi_itilcategories c on c.id = b.pattern
    left join glpi_ruleactions d on d.rules_id = a.id
    left join glpi_slas e on e.id = d.value
where
    a.id = 2343;


select
    a.id
    ,a.completename `itilcategory_completename`
    ,c.name
    ,c.id
    ,e.name `rule_name`
    ,e.number_time `qtd_tempo`
    ,e.definition_time `tempo`
from
    glpi_itilcategories a
    left join glpi_rulecriterias b on b.pattern = a.id
    left join glpi_rules c on c.id = b.rules_id
    left join glpi_ruleactions d on d.rules_id = c.id
    left join (select * from glpi_slas e_sub where e_sub.type = 0) as `e` on e.id = d.value
where
    a.id = 5160;


select

    a.name `regras`
    ,count(a.id) `sla`
from
    glpi_itilcategories a
    left join glpi_rulecriterias b on b.pattern = a.id
    left join glpi_rules c on c.id = b.rules_id
    left join glpi_ruleactions d on d.rules_id = c.id
    left join glpi_slas e on e.id = d.value
where
    e.type = 0
    and a.id != 1
group by regras;


select
    *
from
    glpi_tickets a
    left join glpi_slas b on b.id = a.slas_id_tto
where
    a.type = 1
order by a.id desc
limit 10;

select
    a.rules_id
    ,e.pattern `priority`
    ,d.name
    ,d.number_time
    ,d.definition_time
from
    glpi_rulecriterias a
    left join glpi_rules b on a.rules_id = b.id
    left join glpi_ruleactions c on c.rules_id = b.id
    left join glpi_slas d on d.id = c.value
    left join (select a.rules_id, a.pattern from glpi_rulecriterias a where a.criteria = 'priority') e on e.rules_id = a.rules_id

where
    a.criteria = 'type'
    and a.pattern = 1
    and d.type = 0;


select
    priority
from
    glpi_tickets
where id = 444481