select
    a.id
    ,a.level
    ,case when a.level = 4 then a.name end as `level4.name`
    ,case when a.level = 4 then a.locations_id end as `level4.locations_id`
    ,if(a.level = 3, a.name, if(a.locations_id = b.id, b.name, null)) as `level3`
    ,if(a.level = 3, a.locations_id, if(a.locations_id = b.id, b.locations_id, null)) as `level3.location_id`
    ,if(a.level = 2, a.name, if(b.locations_id = c.id, c.name, null)) as `level2`
    ,if(a.level = 2, a.locations_id, if(b.locations_id = c.id, c.locations_id, null)) as `level2.location_id`
from
    glpi_locations a
    left join (select * from glpi_locations where level = 3) `b` on b.id = a.locations_id
    left join (select * from glpi_locations where level = 2) `c` on c.id = a.locations_id;


SELECT
    a.id,
    a.level,
    CASE WHEN a.level = 4 THEN a.name ELSE NULL END AS `level4.name`,
    CASE WHEN a.level = 4 THEN a.locations_id ELSE NULL END AS `level4.locations_id`,
    CASE WHEN a.level = 3 THEN a.name ELSE IF(c.id = a.locations_id, c.name, NULL) END AS `level3.name`,
    CASE WHEN a.level = 3 THEN a.locations_id ELSE IF(c.id = a.locations_id, c.locations_id, NULL) END AS `level3.locations_id`,
    CASE WHEN a.level = 2 THEN a.name ELSE IF(d.id = c.locations_id, d.name, NULL) END AS `level2.name`,
    CASE WHEN a.level = 2 THEN a.locations_id ELSE IF(d.id = c.locations_id, d.locations_id, NULL) END AS `level2.locations_id`,
    CASE WHEN a.level = 1 THEN a.name ELSE NULL END AS `level1.name`
FROM
    glpi_locations a
LEFT JOIN
    (SELECT * FROM glpi_locations WHERE level = 3) `c`
ON
    c.id = a.locations_id
LEFT JOIN
    (SELECT * FROM glpi_locations WHERE level = 2) `d`
ON
    d.id = c.locations_id;


SELECT
    a.id,
    CASE WHEN a.level = 4 THEN a.name
         ELSE NULL END AS `Unidade.2`,
    CASE WHEN a.level = 3 THEN a.name
         WHEN a.level = 4 THEN b.name
         ELSE NULL END AS `Unidade.1`,
    CASE WHEN a.level = 2 THEN a.name
         WHEN a.level = 3 THEN b.name
         when a.level = 4 then c.name
         ELSE NULL END AS `Cidade`,
    CASE WHEN a.level = 1 THEN a.name
         WHEN a.level = 2 THEN b.name
         WHEN a.level = 3 THEN c.name
         WHEN a.level = 4 THEN d.name
         ELSE NULL END AS `Estado`
FROM
    glpi_locations a
LEFT JOIN
    glpi_locations b ON a.locations_id = b.id
LEFT JOIN
    glpi_locations c ON b.locations_id = c.id
LEFT JOIN
    glpi_locations d ON c.locations_id = d.id
where
    a.entities_id = 361