SELECT
    gc.name as 'Computador',
    gc.serial as 'Número de serie',
    gst.name as 'Status',
    gs.name as 'Office'

FROM
	glpi_items_softwareversions isv
    inner join glpi_softwareversions sl on sl.id = isv.softwareversions_id
    inner join glpi_softwares gs on gs.id = sl.softwares_id
    inner join glpi_computers gc on isv.items_id = gc.id
    inner join glpi_states gst on gst.id = gc.states_id
WHERE
    gs.name like "Microsoft Office%" and
    gc.states_id in (3,4,5,8,18,30)
