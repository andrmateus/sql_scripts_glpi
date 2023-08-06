select
    *
from
    (
        SELECT
            TABLE_NAME AS 'Tabela',
            TABLE_ROWS AS 'Qtd Registros',
            ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS 'Tamanho (MB)'
        FROM
            INFORMATION_SCHEMA.TABLES
        WHERE
            TABLE_SCHEMA = DATABASE()
    ) `a`
where a.Tabela != 'glpi_logs'