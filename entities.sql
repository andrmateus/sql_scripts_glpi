select
    count(*)
from
    glpi_tickets a
    left join glpi_entities f on f.id = a.entities_id
where
    f.completename not like "ONCOCLINICAS DO BRASIL > MANUTENÇÃO%";

select
    count(*)
from
    glpi_tickets a
    left join (select * from glpi_entities where completename not like "ONCOCLINICAS DO BRASIL > MANUTENÇÃO%") f on f.id = a.entities_id
where f.name is not null;

select
    count(*)
from
    glpi_tickets a
    inner join (select * from glpi_entities where completename not like "ONCOCLINICAS DO BRASIL > MANUTENÇÃO%") f on f.id = a.entities_id;

select
    count(*)
from
    glpi_tickets a
    inner join glpi_entities f on f.id = a.entities_id and f.completename not like "ONCOCLINICAS DO BRASIL > MANUTENÇÃO%";