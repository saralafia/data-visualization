//SELECT 
//    MONTH(t.checkOut) AS monthOut,
//    YEAR(t.checkOut) AS yearOut,
//    SUM(i.title LIKE '%java%') AS Java,
//    SUM(i.title LIKE '%python%') AS Python,
//    SUM(i.title LIKE '%php%') AS PHP,
//    SUM(i.title LIKE '%javascript%') AS JavaScript,
//    SUM(i.title LIKE '%perl%') AS Perl,
//    SUM(i.title LIKE '%ruby%') AS Ruby,
//    SUM((i.title LIKE '%java%') + (i.title LIKE '%python%') + (i.title LIKE '%php%') + (i.title LIKE '%javascript%') + (i.title LIKE '%perl%') + (i.title LIKE '%ruby%')) AS totalPYPL,
//    SUM(d.deweyClass = 005) AS monthly005Total
//FROM
//    (spl_2016.transactions AS t
//    INNER JOIN spl_2016.title AS i ON t.bibNumber = i.bibNumber)
//        INNER JOIN
//    spl_2016.deweyClass AS d ON (t.bibNumber = d.bibNumber)
//WHERE
//    (d.deweyClass = 005)
//        AND (YEAR(t.checkOut) BETWEEN 2006 AND 2016)
//GROUP BY yearOut , monthOut 
// ORDER BY yearOut , monthOut