/* 
SELECT 
    deweyClass AS Dewey,
    title AS BookTitle,
    subject AS Category,
    DATE(checkOut) AS CheckoutDate,
    TIME(checkOut) AS CheckoutTime,
    COUNT(checkOut) AS CheckoutCount,
    itemtype AS ItemType,
    TIMESTAMPDIFF(DAY, checkOut, checkIn) AS TimeCheckedOut
FROM
    spl_2016.deweyClass,
    spl_2016.transactions,
    spl_2016.title,
    spl_2016.itemType,
    spl_2016.itemToBib,
    spl_2016.subject
WHERE
  (TIMESTAMPDIFF(DAY, checkOut, checkIn) != '')
    AND deweyClass != "" 
    AND spl_2016.deweyClass.bibNumber = spl_2016.transactions.bibNumber 
    AND spl_2016.deweyClass.bibNumber = spl_2016.title.bibNumber 
    AND spl_2016.deweyClass.bibNumber = spl_2016.subject.bibNumber 
    AND spl_2016.deweyClass.bibNumber = spl_2016.itemToBib.bibNumber 
    AND spl_2016.itemToBib.itemNumber = spl_2016.itemType.itemNumber
    AND (itemType = 'arbk') 
    AND YEAR(checkOut) >= '2005' 
    GROUP BY title 
    ORDER BY CheckoutCount DESC
*/