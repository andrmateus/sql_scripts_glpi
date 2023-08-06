SELECT
    CURDATE() AS 'data_dados',
    gc.name AS'hostname',
    gs.completename AS 'status',
    gl.completename AS 'localizacao',
    gl.name AS 'localizacao_abrev',
    gm.name AS 'fabricante',
    gc.serial AS 'numero_de_serie',
    gcm.name AS 'modelo',
    gc.contact AS 'usuario',
    gct.name AS 'tipo',
    (
        select
            gosv.name
        from
            glpi_items_operatingsystems gios
            INNER JOIN glpi_operatingsystemversions gosv ON gios.operatingsystemversions_id = gosv.id
        where
            gios.itemtype = 'Computer' AND
            gios.items_id = gc.id

        ORDER by gios.id DESC LIMIT 1
    ) AS 'sistema_operacional',
    (
        select
            gpfa.last_contact
        from
            glpi_plugin_fusioninventory_agents gpfa
        WHERE gpfa.computers_id = gc.id
    ) AS 'fusion_ultimo_contato',
    (
        select
            gpfic.last_fusioninventory_update
        from
            glpi_plugin_fusioninventory_inventorycomputercomputers gpfic
        where
            gpfic.computers_id = gc.id
    ) AS 'fusion_ultimo_inventario',
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
            CONCAT(CEILING(sum(gidm.size) / 1024), ' GB')
        from
            glpi_items_devicememories gidm
        where

            gidm.items_id = gc.id
        ORDER BY gidm.id LIMIT 3
    ) AS 'memoria',
    (
        select
            gic.warranty_date
        from
            glpi_infocoms gic
        where
            gic.itemtype = 'Computer' and
            gic.items_id = gc.id
    ) AS 'garantia_inicio',
    (
        select
            DATE_ADD(gic.warranty_date, INTERVAL gic.warranty_duration MONTH)
        from
            glpi_infocoms gic
        where
            gic.itemtype = 'Computer' and
            gic.items_id = gc.id
    ) AS 'garantia_fim',
    (
        select
            gs.name
        from
            glpi_infocoms gic
            INNER JOIN glpi_suppliers gs ON gic.suppliers_id = gs.id
        where
            gic.itemtype = 'Computer' and
            gic.items_id = gc.id
    ) AS 'fornecedor',
    (
        select
            gic.immo_number
        from
            glpi_infocoms gic
        where
            gic.itemtype LIKE 'Computer' and
            gic.items_id = gc.id
    ) AS 'patrimonio'
    ,gc.id AS 'id_glpi'
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
    and gc.serial in ("FP2NFV3","9P2NFV3","5P2NFV3","1Q2NFV3","HP2NFV3","3R2NFV3","2R2NFV3","1R2NFV3","JQ2NFV3","6R2NFV3","9R2NFV3","7R2NFV3","JP2NFV3","8R2NFV3","BR2NFV3","CR2NFV3","GR2NFV3","DR2NFV3","FR2NFV3","7Q2NFV3","6Q2NFV3","8Q2NFV3","9Q2NFV3","BP2NFV3","GQ2NFV3","CQ2NFV3")