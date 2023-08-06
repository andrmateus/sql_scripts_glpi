SELECT
    gc.name AS'hostname',
    gc.serial AS 'numero_de_serie',
    gcm.name AS 'modelo',
    (
        select
            gdp.designation
        from
            glpi_items_deviceprocessors gidp
            INNER JOIN glpi_deviceprocessors gdp ON gidp.deviceprocessors_id = gdp.id
        where
            gidp.itemtype = 'Computer' AND
            gidp.items_id = gc.id
        ORDER BY gidp.id DESC LIMIT 1
    ) AS 'processador',
    (
        select
            gic.immo_number
        from
            glpi_infocoms gic
        where
            gic.itemtype LIKE 'Computer' and
            gic.items_id = gc.id
    ) AS 'patrimonio'
    ,gc.otherserial `patrimonio_2`

FROM
    glpi_computers gc
    INNER JOIN glpi_states gs ON gc.states_id = gs.id
    INNER JOIN glpi_locations gl ON gc.locations_id = gl.id
    INNER JOIN glpi_manufacturers gm ON gc.manufacturers_id = gm.id
    INNER JOIN glpi_computertypes gct ON gct.id = gc.computertypes_id
    INNER JOIN glpi_computermodels gcm ON gc.computermodels_id = gcm.id

WHERE
    gc.is_deleted = 0
    and gc.serial in (
"3J0VPT3",
"2J0VPT3",
"4J0VPT3",
"6J0VPT3",
"5K0VPT3",
"4K0VPT3",
"1K0VPT3",
"9K0VPT3",
"7K0VPT3",
"2K0VPT3",
"5J0VPT3",
"9J0VPT3",
"8J0VPT3",
"8K0VPT3",
"BK0VPT3",
"3K0VPT3",
"CJ0VPT3",
"7J0VPT3",
"FJ0VPT3",
"BJ0VPT3",
"JJ0VPT3",
"HJ0VPT3",
"GJ0VPT3",
"DJ0VPT3",
"6K0VPT3"




)