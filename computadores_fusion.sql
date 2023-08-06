select
    *
from
    (
        select
            a.name as `hostname`
            ,c.name `status`
            ,(select b.last_fusioninventory_update from glpi_plugin_fusioninventory_inventorycomputercomputers b where b.computers_id = a.id order by b.id desc limit 1 ) as `ultimo_inventario`
        from
            glpi_computers a
            inner join glpi_states c on c.id = a.states_id
        where
            a.is_deleted = 0
            and c.name in ('Em uso')
    ) `a`
order by ultimo_inventario