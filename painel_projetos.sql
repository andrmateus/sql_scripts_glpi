SELECT
	gp.name `projeto`
	,if(gpt_inner.name IS NULL, gpt.name, gpt_inner.name) `tarefa`
	,if(gpt_inner.name IS NULL, gpt_inner.name, gpt.name) `subtarefa`
	,gptt_task.tickets_id `tickets_task`
	,gptt_subtask.tickets_id `tickets_subtask`
FROM
	glpi_projects gp
	INNER JOIN glpi_entities ge ON ge.id = gp.entities_id
	LEFT JOIN glpi_projecttasks gpt ON gpt.projects_id = gp.id
	LEFT JOIN (
		select
			gpt_inner.id
			,gpt_inner.name
		from 
			glpi_projecttasks gpt_inner
	) AS gpt_inner ON gpt_inner.id = gpt.projecttasks_id
	LEFT JOIN glpi_projecttasks_tickets gptt_task ON gptt_task.projecttasks_id = gpt.id
	LEFT JOIN glpi_projecttasks_tickets gptt_subtask ON gptt_subtask.projecttasks_id = gpt_inner.id
WHERE 
	gp.is_deleted = 0
	AND ge.completename NOT LIKE '%MANUTENCAO%'
	AND gp.entities_id != 0
