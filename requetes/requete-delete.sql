SELECT * FROM `wf3__blog_demo`.`user`;


DELETE FROM
    `wf3__blog_demo`.`user`
WHERE 
    `id`=1;


DELETE FROM
    `wf3__blog_demo`.`user`
WHERE 
    `id`=3 || `firstname`="jane";


-- NE JAMAIS EXECUTER UNE REQUETE NON FILTREE
-- Delete : supprime les données et conserve l'index des ID
DELETE FROM
    `wf3__blog_demo`.`user`;

-- Truncate : supprime les données et l'index des ID
TRUNCATE `wf3__blog_demo`.`user`;