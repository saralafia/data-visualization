SELECT 
    (i.title LIKE '%java%') || (i.title LIKE '%python%') || (i.title LIKE '%php%') || (i.title LIKE '%javascript%') || (i.title LIKE '%perl%') || (i.title LIKE '%ruby%') AS Language,
    MONTH(checkOut) AS MONTH,
    SUM(CASE
        WHEN YEAR(checkOut) = 2006 THEN 1
        ELSE 0
    END) AS '2006',
    SUM(CASE
        WHEN YEAR(checkOut) = 2007 THEN 1
        ELSE 0
    END) AS '2007',
    SUM(CASE
        WHEN YEAR(checkOut) = 2008 THEN 1
        ELSE 0
    END) AS '2008',
    SUM(CASE
        WHEN YEAR(checkOut) = 2009 THEN 1
        ELSE 0
    END) AS '2009',
    SUM(CASE
        WHEN YEAR(checkOut) = 2010 THEN 1
        ELSE 0
    END) AS '2010',
    SUM(CASE
        WHEN YEAR(checkOut) = 2011 THEN 1
        ELSE 0
    END) AS '2011',
    SUM(CASE
        WHEN YEAR(checkOut) = 2012 THEN 1
        ELSE 0
    END) AS '2012',
    SUM(CASE
        WHEN YEAR(checkOut) = 2013 THEN 1
        ELSE 0
    END) AS '2013',
    SUM(CASE
        WHEN YEAR(checkOut) = 2014 THEN 1
        ELSE 0
    END) AS '2014',
    SUM(CASE
        WHEN YEAR(checkOut) = 2015 THEN 1
        ELSE 0
    END) AS '2015'
FROM
    (spl_2016.transactions AS t
    INNER JOIN spl_2016.title AS i ON t.bibNumber = i.bibNumber)
        INNER JOIN
    spl_2016.deweyClass AS d ON (t.bibNumber = d.bibNumber)
WHERE
    (d.deweyClass = 005)
GROUP BY MONTH