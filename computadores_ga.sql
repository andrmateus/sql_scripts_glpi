SELECT
	CURDATE() AS 'data_dados',
	gc.name AS'hostname',
	gs.completename AS 'status',
	gl.completename AS 'localizacao',
	gm.name AS 'fabricante',
	gc.serial AS 'numero_de_serie',
	gcm.name AS 'modelo',
	gc.contact AS 'user',
	gct.name AS 'tipo',
	(
		select
			gosv.name
		from
			glpi_items_operatingsystems gios
			INNER JOIN glpi_operatingsystemversions gosv ON gios.operatingsystemversions_id = gosv.id
		where
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
			gic.itemtype LIKE 'Computer' and
			gic.items_id = gc.id
	) AS 'garantia_inicio',
	(
		select
			DATE_ADD(gic.warranty_date, INTERVAL gic.warranty_duration MONTH)
		from
			glpi_infocoms gic
		where
			gic.itemtype LIKE 'Computer' and
			gic.items_id = gc.id
	) AS 'garantia_fim',
	(
		select
			gs.name
		from
			glpi_infocoms gic
			INNER JOIN glpi_suppliers gs ON gic.suppliers_id = gs.id
		where
			gic.itemtype LIKE 'Computer' and
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
	) AS 'patrimonio',
	gc.id AS 'id_glpi'
	
	
FROM 
	glpi_computers gc
	INNER JOIN glpi_states gs ON gc.states_id = gs.id
	INNER JOIN glpi_locations gl ON gc.locations_id = gl.id
	INNER JOIN glpi_manufacturers gm ON gc.manufacturers_id = gm.id
	INNER JOIN glpi_computertypes gct ON gct.id = gc.computertypes_id
	INNER JOIN glpi_computermodels gcm ON gc.computermodels_id = gcm.id
	
WHERE
	gc.is_deleted = 0