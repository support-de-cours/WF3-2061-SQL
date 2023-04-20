-- All rows with all columns
SELECT * FROM `wf3__blog_demo`.`user`;


-- All rows with "id", "firstname", "lastname" and "email" columns
SELECT `id`, `firstname`, `lastname`, `email` FROM `wf3__blog_demo`.`user`;


-- All rows with "id", "firstname", "lastname" and "email" columns
-- And alias on columns
SELECT 
    `id`, 
    `firstname` AS `Prénom`, 
    `lastname` AS `NOM`, 
    `email` AS `Adresse e-mail`
FROM `wf3__blog_demo`.`user`;


-- Only id 8 - All columns
SELECT * FROM `wf3__blog_demo`.`user` WHERE `id`=8;


-- Only id 8 with "screenname" and "profile_description" columns
SELECT `screenname`, `profile_description` FROM `wf3__blog_demo`.`user` WHERE `id`=8;


-- All John
SELECT `id`, `screenname`, `email` FROM `wf3__blog_demo`.`user` WHERE `firstname`="JOHN";


-- All John order by ID DESC
SELECT `id`, `screenname`, `email` FROM `wf3__blog_demo`.`user` WHERE `firstname`="JOHN" ORDER BY `id` DESC;

-- All rows, all columns ordered by firstname
SELECT * FROM `wf3__blog_demo`.`user` ORDER BY `firstname`;
SELECT * FROM `wf3__blog_demo`.`user` ORDER BY `firstname` ASC;
SELECT * FROM `wf3__blog_demo`.`user` ORDER BY `firstname` DESC;

-- Show 3 rows after line 2
SELECT * FROM `wf3__blog_demo`.`user` ORDER BY `firstname` LIMIT 2,3;


-- All rows with "o" in firstname
SELECT * FROM `wf3__blog_demo`.`user` WHERE `firstname` LIKE '%o%';
SELECT * FROM `wf3__blog_demo`.`user` WHERE `firstname` LIKE '%j%';



SELECT * FROM `wf3__blog_demo`.`user` ORDER BY `firstname` ASC, `lastname` DESC;


SELECT MAX(LENGTH(email)) FROM `wf3__blog_demo`.`user`;

SELECT * 
FROM `wf3__blog_demo`.`user`
WHERE LENGTH(email) = (
    SELECT MAX(LENGTH(email)) FROM `wf3__blog_demo`.`user`
)
LIMIT 0,1;
