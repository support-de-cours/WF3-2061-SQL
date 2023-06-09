INSERT INTO `wf3_blog`.`user`
        (`firstname`,   `lastname`,     `sreenname`,    `email`,            `password`,     `role`,         `birth_date`,   `birth_place`, `gender`,    `country` )
VALUES  ("John",        "DOE",          "John D.",      "john@doe.com",     "123456",       "contributor",  "2015-12-31",   "Lille",        "M",        "FR"),
        ("Jane",        "DOE",          "Jane D.",      "jane@doe.com",     "123456",       "contributor",  "2005-12-31",   "Lille",        "F",        "FR"), 
        ("Bob",         "DOE",          "Bob D.",       "bob@doe.com",      "123456",       "contributor",  "2015-12-31",   "Lille",        "M",        "FR"), 
        ("Bruce",       "DOE",          "Bruce D.",     "bruce@doe.com",    "123456",       "contributor",  "2015-12-31",   "Lille",        "M",        "FR");


INSERT INTO `wf3_blog`.`article`
        (`title`,       `slug`,         `summary`,              `excerpt_html`,             `excerpt_text`,             `content_html`,             `content_text`)
VALUES  ("Article 1",   "article-1",    "article-1 summary",    "Article 1 excerpt HTML",   "article 1 excerpt text",   "article 1 content html",   "article 1 content text"),
        ("Article 2",   "article-2",    "article-2 summary",    "Article 2 excerpt HTML",   "article 2 excerpt text",   "article 2 content html",   "article 2 content text"), 
        ("Article 3",   "article-3",    "article-3 summary",    "Article 3 excerpt HTML",   "article 3 excerpt text",   "article 3 content html",   "article 3 content text"), 
        ("Article 4",   "article-4",    "article-4 summary",    "Article 4 excerpt HTML",   "article 4 excerpt text",   "article 4 content html",   "article 4 content text");


-- Article 1, author 3 & 2
-- Article 2, author 3
-- Article 3, author 1 & 4
-- Article 4, author 4 & 2
INSERT INTO  `wf3_blog`.`article_author`
        (`article_id`,  `user_id`)
VALUES  (1,             3),
        (3,             4),
        (4,             4),
        (3,             1),
        (1,             2),
        (2,             3),
        (4,             2);



-- Recup le titre et la date de création des articles ecrit par l'auteur id 3
SELECT 
    `wf3_blog`.`article`.`id`, 
    `wf3_blog`.`article`.`title`,
    `wf3_blog`.`article`.`created_at`
FROM
    `wf3_blog`.`article`
    INNER JOIN 
        `wf3_blog`.`article_author`
    ON
        `wf3_blog`.`article_author`.`article_id` = `wf3_blog`.`article`.`id` 
WHERE 
    `wf3_blog`.`article_author`.`user_id` = 3;

--

SELECT 
    `t1`.`id`, 
    `t1`.`title`,
    `t1`.`created_at`
FROM
    `wf3_blog`.`article` AS `t1`
    INNER JOIN  `wf3_blog`.`article_author` AS `t2`
        ON `t2`.`article_id` = `t1`.`id` 
WHERE 
    `t2`.`user_id` = 3;



-- Recup les nom et prénom des auteurs et titre de l'article, de l'article ID 1
SELECT 
    `t1`.`id` AS `id_article`, 
    `t3`.`id` AS `id_author`, 
    `t1`.`title`, 
    `t3`.`firstname`, 
    `t3`.`lastname`
FROM 
    `wf3_blog`.`article` AS `t1`
    INNER JOIN `wf3_blog`.`article_author`  AS `t2` ON `t2`.`article_id` = `t1`.`id` 
    INNER JOIN `wf3_blog`.`user`            AS `t3` ON `t3`.`id` = `t2`.`user_id`
WHERE
    `t1`.`id` = 3
    -- `t2`.`article_id` = 1

