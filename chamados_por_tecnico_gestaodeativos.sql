select
    (select * from glpi_tickets_users gtu inner join glpi_users gu on gu.id = gtu.users_id where gtu.tickets_id = a.id) as `tecnico`
    ,a.*
from
    (SELECT gt.id
	 FROM glpi_tickets gt
		  left JOIN glpi_groups_tickets ggt ON gt.id = ggt.tickets_id
	 WHERE gt.is_deleted = 0
	   and gt.`status` IN (1, 2, 3, 4)
	   and ggt.groups_id = 271
	   and ggt.`type` = 2) as `a`