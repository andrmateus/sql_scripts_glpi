select
 a.id
,a.entities_id
,a.name
,a.date
,a.closedate
,a.solvedate
,a.is_deleted
,a.date_mod
,a.users_id_lastupdater  as id_lastupdater
,j.name               as users_id_lastupdater
,i.name               as users_id_recipient
,a.time_to_resolve
,case   when a.status = 1 then 'Novo'
        when a.status = 2 then 'Processando Atribuido'
        when a.status = 3 then 'Processando Planejado'
        when a.status = 4 then 'Pendente'
        when a.status = 5 then 'Solucionado'
        when a.status = 6 then 'Fechado'
        else 'classificar'
        end as status_tratado
,a.users_id_recipient  as id_recepient
,a.urgency
,a.impact
,case   when a.priority = 1 then 'Aguardando classificacao'
        when a.priority = 2 then 'Baixa'
        when a.priority = 3 then 'Media'
        when a.priority = 4 then 'Alta'
        when a.priority = 5 then 'Muito Alta'
        when a.priority = 6 then 'Nao ha'
        else 'Nao ha'
        end as priority_tratado
,a.itilcategories_id
,case   when a.type = 1 then 'Incidente'
        when a.type = 2 and a.itilcategories_id in (2003, 2008, 2019, 2034, 2040, 2051, 2057, 2064, 2071, 2077, 2764, 2765, 2767) then 'Demanda'
		when a.type = 2 then 'Requisicao'
        else 'classificar'
        end as type_tratado
,a.date_creation
,b.solutiontypes_id
,case   when b.solutiontypes_id = 163 then 'Solucao definitiva'
        when b.solutiontypes_id = 164 then 'Solucao de Contorno'
        when b.solutiontypes_id = 165 then 'Chamado Cancelado'
        when b.solutiontypes_id = 166 then 'Solucao Pro Ativa'
        when b.solutiontypes_id = 167 then 'Recusa de Aprovacao'
        when b.solutiontypes_id = 168 then 'Erro de Parametrizacao'
        when b.solutiontypes_id = 169 then 'Erro do Usuario'
        when b.solutiontypes_id = 170 then 'Risco compartilhado'
        when a.status in (5,6) then 'Fechado'
        else 'Abertos'
        end as solutiontypes_tratado
,case   when c.type = 1 then 'Solicitante'
        when c.type = 2 then 'Atribuido'
        when c.type = 3 then 'Observador'
        else 'classificar'
        end as status_chamado
,d.date_answered
,d.satisfaction
,d.comment
,f.name as unidade
,g.name as tipo_chamado
,g.completename as caminho_chamado
,h.name as grupo
,case   when h.name in ('Gestao de Ativos','Suporte CSO','Suporte Simpress','Central de Atendimento','Suporte Telemedicina') then 'Central de servicos de TI'

        when h.name in ('Suporte RPA | Integracoes') then 'ANTIGO - Suporte RPA e Integracao'

        when h.name in ('Custos E Contratos') then 'ANTIGO - Custos e Contratos'

        when h.name in ('Lider Portifolio - CSO') then 'ANTIGO - Lider Portifolio - CSO'

        when h.name in ('Projetos Tasy') then 'ANTIGO - Projetos Tasy'

        when h.name in ('Suporte Integracoes e RPA') then 'ANTIGO - Suporte Integracoes e RPA'

        when h.name in ('Suporte Fluig','Suporte Folha','Suporte Protheus','Suporte Chatbot','Projetos Fluig','Projetos Folha','Projetos Protheus','Projetos Chatbot','Time BackOffice',
        'Desenvolvedores Backoffice','Suporte Abax','Suporte Compila','Suporte RPA','Suporte Senior','Suporte SGP','Integracao Fluig','Suporte Succes Factor') then 'Sistemas BackOffice'

        when h.name in ('Suporte Assistencial','Parametrizacao TASY','Desenvolvedores Assistencial','Parametrizacao Aproxima') then 'Sistemas Assistenciais'

        when h.name in ('Gestao de Acessos','Usuarios, Senhas e Acessos','Seguranca Da Informacao') then 'Seguranca da Informacao'

        when h.name in ('Infra Supote DBA Tasy','Infra Suporte','Infra Projetos','Infra Melhoria Continua','Suporte DBA','Suporte Infra') then 'Infraestrutura'

        when h.name in ('Sites','Portais','Aplicativos Mobile','Suporte Comissoes','Salesforce','NPS','Chatbots') then 'Solucoes Moveis & WEB (Digital e CRM)'

        when h.name in ('Demandas e Melhorias BI','Suporte Data Lake','Qualidade e Governan�a') then 'Engenharia e Govern. de Dados'

        when h.name in ('Extracoes e Analises AD-HOC','Analytics e Data Science','Suporte BI') then 'Analytics e Data Science (BI)'

        when h.name in ('Integracoes') then 'Arquitetura e Integracao'

        when h.name in ('Implantacao EMR') then 'Parametros e Regras do TASY'

        when h.name like '%Field%' then 'Field'
        else 'Nao Possui Coord.'
        end as grupo_coordenacao
,case when i.user_dn like '%OU=TI%' then 'TI' else 'Nao' end as usuario_ti

from glpi_tickets as a
left join glpi_itilsolutions as b on a.id = b.items_id and a.solvedate = b.date_creation
left join glpi_groups_tickets as c on a.id = c.tickets_id and c.type = 2
left join glpi_ticketsatisfactions as d on a.id = d.tickets_id
left join glpi_slas as e on a.slas_id_ttr = e.id
left join glpi_entities as f on a.entities_id = f.id
left join glpi_itilcategories   as g on a.itilcategories_id = g.id
left join glpi_groups   as h on c.groups_id = h.id
left join glpi_users    as i on i.id = a.users_id_recipient
left join glpi_users    as j on j.id = a.users_id_lastupdater


where 1=1
and cast(a.date as DATE) >= DATE_SUB(NOW(),INTERVAL 1 YEAR)
and a.is_deleted = 0