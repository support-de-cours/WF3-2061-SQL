-- All rows with all columns
SELECT * FROM `wf3__blog_demo`.`user`;


UPDATE `wf3__blog_demo`.`user`
SET `firstname` = "Bruce"
WHERE `id`=1;


UPDATE `wf3__blog_demo`.`user`
SET `firstname` = "Bruce", `lastname` = "WAYNE"
WHERE `id`=3;


-- NE JAMAIS EXECUTER UNE REQUETE NON FILTREE
UPDATE `wf3__blog_demo`.`user`
SET `password`="123456";


-- Modifier 2 lines en meme temps
UPDATE `wf3__blog_demo`.`user`
SET `password`="123456"
WHERE `id`=7 || `id`=11;

-- Modifier 2 lines en meme temps, filtrées sur plusieurs champs
UPDATE 
    `wf3__blog_demo`.`user`
SET 
    `role`="admin"
WHERE 
    (`firstname`="bruce" && `lastname`="wayne") 
    || 
    (`firstname`="jane" && `lastname`="doe")
;
