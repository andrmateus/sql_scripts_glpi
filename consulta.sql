select
    gc.serial,
    gc.name,
    git.tickets_id,
    gic.completename

from
    glpi_computers gc
    inner join glpi_items_tickets git on git.items_id = gc.id
    inner join glpi_tickets gt on git.tickets_id = gt.id
    inner join glpi_itilcategories gic on gic.id = gt.itilcategories_id
where
    git.itemtype = 'Computer' and
    gc.is_deleted = 0 and
    gt.id not in (356194) and
    gc.serial in ('1K22LV3','JJ22LV3','3K22LV3','HJ22LV3','4K22LV3','2K22LV3','7K22LV3','JK22LV3','HK22LV3','2L22LV3','GK22LV3','3L22LV3','6L22LV3','4L22LV3','BK22LV3','DK22LV3','FL22LV3','FK22LV3','CK22LV3','9K22LV3','1L22LV3','6K22LV3','FJ22LV3','GJ22LV3','8K22LV3','CJ22LV3','7J22LV3','5K22LV3','9J22LV3','1M22LV3','BL22LV3','HL22LV3','GL22LV3','DL22LV3','8L22LV3','7L22LV3','2M22LV3','3M22LV3','5L22LV3','DJ22LV3','BJ22LV3','9L22LV3','JL22LV3','8M22LV3','6M22LV3','7M22LV3','5M22LV3','4M22LV3','CL22LV3','8J22LV3','FP2NFV3','DP2NFV3','9P2NFV3','7P2NFV3','5P2NFV3','4P2NFV3','BQ2NFV3','GP2NFV3','2Q2NFV3','1Q2NFV3','3P2NFV3','CP2NFV3','HP2NFV3','FQ2NFV3','DQ2NFV3','3R2NFV3','2R2NFV3','1R2NFV3','HQ2NFV3','JQ2NFV3','6R2NFV3','9R2NFV3','5R2NFV3','7R2NFV3','JP2NFV3','8R2NFV3','BR2NFV3','CR2NFV3','GR2NFV3','DR2NFV3','FR2NFV3','4R2NFV3','2S2NFV3','7Q2NFV3','6Q2NFV3','8Q2NFV3','9Q2NFV3','JR2NFV3','1S2NFV3','3Q2NFV3','4Q2NFV3','6P2NFV3','BP2NFV3','5Q2NFV3','GQ2NFV3','2P2NFV3','HR2NFV3','8P2NFV3','CQ2NFV3','1MT22S3','5MT22S3','9MT22S3','8MT22S3','7MT22S3','JMT22S3','HMT22S3','1NT22S3','GMT22S3','4NT22S3','3NT22S3','2NT22S3','FMT22S3','4MT22S3','GLT22S3','3MT22S3','JLT22S3','CMT22S3','HLT22S3','BMT22S3','6MT22S3','5NT22S3','2MT22S3','3PT22S3','FNT22S3','7NT22S3','GNT22S3','1PT22S3','4PT22S3','BNT22S3','2PT22S3','8NT22S3','CNT22S3','HNT22S3','JNT22S3','6NT22S3','9NT22S3','DNT22S3','DMT22S3','HHT22S3','GHT22S3','FHT22S3','JHT22S3','4JT22S3','DHT22S3','1JT22S3','2JT22S3','5JT22S3','3JT22S3','DJT22S3','BJT22S3','6JT22S3','7JT22S3','1KT22S3','8JT22S3','JJT22S3','9KT22S3','CJT22S3','7KT22S3','3KT22S3','9JT22S3','6KT22S3','5KT22S3','GJT22S3','FJT22S3','CLT22S3','4LT22S3','1LT22S3','5LT22S3','3LT22S3','4KT22S3','FLT22S3','2LT22S3','BLT22S3','8LT22S3','7LT22S3','DLT22S3','HKT22S3','CKT22S3','DKT22S3','BKT22S3','GKT22S3','FKT22S3','8KT22S3','9LT22S3','JKT22S3','HJT22S3','6LT22S3','2KT22S3','9L7RDT3','4M7RDT3','3M7RDT3','JL7RDT3','FL7RDT3','HL7RDT3','GL7RDT3','CL7RDT3','BL7RDT3','DM7RDT3','9M7RDT3','2M7RDT3','BM7RDT3','3P7RDT3','JN7RDT3','1P7RDT3','5P7RDT3','9P7RDT3','4P7RDT3','8P7RDT3','8N7RDT3','7P7RDT3','GN7RDT3','FN7RDT3','HM7RDT3','JM7RDT3','1N7RDT3','4N7RDT3','2N7RDT3','6P7RDT3','GM7RDT3','FM7RDT3','CN7RDT3','DN7RDT3','6N7RDT3','BN7RDT3','9N7RDT3','7N7RDT3','8L7RDT3','5N7RDT3','CM7RDT3','2P7RDT3','8M7RDT3','7M7RDT3','6M7RDT3','1M7RDT3','HN7RDT3','DL7RDT3','5M7RDT3','3N7RDT3','BP7RDT3','CP7RDT3','HP7RDT3','JP7RDT3','2Q7RDT3','1Q7RDT3','GP7RDT3','DP7RDT3','HQ7RDT3','CQ7RDT3','3R7RDT3','DQ7RDT3','5Q7RDT3','9Q7RDT3','6Q7RDT3','3Q7RDT3','4Q7RDT3','FQ7RDT3','1R7RDT3','7Q7RDT3','JQ7RDT3','6R7RDT3','8R7RDT3','2R7RDT3','7R7RDT3','DR7RDT3','GR7RDT3','CR7RDT3','FR7RDT3','9R7RDT3','HR7RDT3','BR7RDT3','4R7RDT3','5R7RDT3','6S7RDT3','3S7RDT3','4S7RDT3','2S7RDT3','5S7RDT3','1S7RDT3','JR7RDT3','BS7RDT3','FP7RDT3','8S7RDT3','9S7RDT3','CS7RDT3','7S7RDT3','GQ7RDT3','BQ7RDT3','8Q7RDT3','CH7RDT3','4J7RDT3','5J7RDT3','6J7RDT3','FJ7RDT3','DH7RDT3','1J7RDT3','6H7RDT3','9J7RDT3','HH7RDT3','7J7RDT3','JH7RDT3','BJ7RDT3','8J7RDT3','DJ7RDT3','7K7RDT3','4K7RDT3','6K7RDT3','BH7RDT3','8H7RDT3','7H7RDT3','9H7RDT3','CJ7RDT3','HJ7RDT3','1K7RDT3','3K7RDT3','3J7RDT3','2J7RDT3','GH7RDT3','FH7RDT3','DK7RDT3','FK7RDT3','GK7RDT3','HK7RDT3','JK7RDT3','1L7RDT3','3L7RDT3','4L7RDT3','9K7RDT3','8K7RDT3','CK7RDT3','6L7RDT3','7L7RDT3','5L7RDT3','5K7RDT3','2L7RDT3','GJ7RDT3','JJ7RDT3','2K7RDT3','BK7RDT3','JJK9QT3','2KK9QT3','DJK9QT3','5JK9QT3','GJK9QT3','HJK9QT3','5KK9QT3','BJK9QT3','4LK9QT3','GLK9QT3','9KK9QT3','9LK9QT3','HKK9QT3','8LK9QT3','DKK9QT3','JKK9QT3','9JK9QT3','4MK9QT3','1MK9QT3','JLK9QT3','3LK9QT3','5LK9QT3','6LK9QT3','4KK9QT3','HLK9QT3','CJK9QT3','FKK9QT3','6KK9QT3','3KK9QT3','1KK9QT3','CKK9QT3','3MK9QT3','7KK9QT3','DLK9QT3','FLK9QT3','CLK9QT3','7LK9QT3','6MK9QT3','BLK9QT3','2LK9QT3','BKK9QT3','2MK9QT3','6JK9QT3','FJK9QT3','8JK9QT3','7JK9QT3','5MK9QT3','GKK9QT3','1LK9QT3','8KK9QT3','3J0VPT3','2J0VPT3','4J0VPT3','6J0VPT3','5K0VPT3','4K0VPT3','1K0VPT3','9K0VPT3','7K0VPT3','2K0VPT3','5J0VPT3','9J0VPT3','8J0VPT3','8K0VPT3','BK0VPT3','3K0VPT3','CJ0VPT3','7J0VPT3','FJ0VPT3','BJ0VPT3','JJ0VPT3','HJ0VPT3','GJ0VPT3','DJ0VPT3','6K0VPT3','DK0VPT3','CK0VPT3','GK0VPT3','GL0VPT3','FL0VPT3','HK0VPT3','CL0VPT3','8L0VPT3','7L0VPT3','BL0VPT3','FM0VPT3','8N0VPT3','BN0VPT3','HL0VPT3','JL0VPT3','9N0VPT3','3L0VPT3','FK0VPT3','6L0VPT3','4L0VPT3','5L0VPT3','JK0VPT3','2L0VPT3','1L0VPT3','3M0VPT3','4M0VPT3','9L0VPT3','9FS05V3','8FS05V3','6FS05V3','BFS05V3','7GS05V3','5GS05V3','1GS05V3','DFS05V3','HFS05V3','JFS05V3','CFS05V3','2FS05V3','3FS05V3','5FS05V3','1FS05V3','2GS05V3','8GS05V3','6GS05V3','7FS05V3','FFS05V3','9GS05V3','4GS05V3','GFS05V3','4FS05V3','3GS05V3','H9X05V3','4BX05V3','29X05V3','5BX05V3','3BX05V3','C9X05V3','49X05V3','B9X05V3','99X05V3','39X05V3','59X05V3','D9X05V3','F9X05V3','J9X05V3','3DX05V3','7BX05V3','8BX05V3','9BX05V3','7CX05V3','FBX05V3','CCX05V3','6CX05V3','3CX05V3','5CX05V3','CBX05V3','DBX05V3','2BX05V3','BCX05V3','9CX05V3','JBX05V3','BBX05V3','DCX05V3','FCX05V3','JCX05V3','GCX05V3','1DX05V3','6BX05V3','69X05V3','2DX05V3','G9X05V3','1CX05V3','HCX05V3','HBX05V3','4CX05V3','1BX05V3','8CX05V3','89X05V3','GBX05V3','2CX05V3','79X05V3','49246V3','59246V3','F9246V3','D9246V3','19246V3','G9246V3','69246V3','5B246V3','4B246V3','3B246V3','H9246V3','2B246V3','DC246V3','J8246V3','J9246V3','3C246V3','CC246V3','2C246V3','99246V3','1B246V3','39246V3','H8246V3','F8246V3','G8246V3','DB246V3','29246V3','9B246V3','BB246V3','79246V3','89246V3','B9246V3','C9246V3','FC246V3','6B246V3','FB246V3','CB246V3','JB246V3','GB246V3','BC246V3','9C246V3','1C246V3','6C246V3','8B246V3','8C246V3','7B246V3','HB246V3','D8246V3','4C246V3','5C246V3','7C246V3','7M0VPT3','9M0VPT3','8M0VPT3','DN0VPT3','CN0VPT3','GM0VPT3','1M0VPT3','6M0VPT3','4N0VPT3','HM0VPT3','5N0VPT3','3N0VPT3','CM0VPT3','2M0VPT3','1N0VPT3','JM0VPT3','BM0VPT3','5M0VPT3','2N0VPT3','DM0VPT3','7N0VPT3','6N0VPT3','DL0VPT3')