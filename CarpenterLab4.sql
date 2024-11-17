/* A */
SELECT ColorName, GROUP_CONCAT(ColorantName ORDER BY ColorantName DESC SEPARATOR ',') AS Colorants FROM Color NATURAL JOIN Formula NATURAL JOIN Colorant GROUP BY ColorName ORDER BY ColorName ASC;

/* B */
SELECT ColorantName, COUNT(*) AS Colorant_Count FROM Formula NATURAL JOIN Colorant GROUP BY ColorantName ORDER BY ColorantName ASC;

/* C */
SELECT ColorantName FROM Colorant WHERE ColorantName LIKE '%Oxide';

/* D */
SELECT ColorName FROM Color NATURAL JOIN Formula WHERE ColorantCode = (SELECT ColorantCode FROM Colorant WHERE ColorantName = 'Magenta') GROUP BY ColorName HAVING MAX(Oz) = 0 ORDER BY ColorName;

/* E */
SELECT ColorantName, SUM(OZ + Shot/48 + HalfShot/96) AS Total_Ounces FROM Formula NATURAL JOIN Colorant GROUP BY ColorantName ORDER BY ColorantName ASC;

/* F */
SELECT ColorantName, GROUP_CONCAT(ColorName ORDER BY ColorName DESC SEPARATOR ',') AS Paints FROM Colorant NATURAL JOIN Formula NATURAL JOIN Color GROUP BY ColorantName ORDER BY ColorantName ASC;