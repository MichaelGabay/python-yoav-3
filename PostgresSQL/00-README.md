# PostgreSQL – מדריך מקיף

מדריך מובנה ללימוד PostgreSQL מהבסיס ועד נושאים מתקדמים. כל נושא מוסבר בצורה ברורה ומלווה בלפחות 5 תרגילים פרקטיים.

## תוכן העניינים

### מבוא ויסודות
- [01 – Intro](01-Intro.md) – מבוא ל-PostgreSQL
- [02 – Why Use Postgres](02-Why-Use-Postgres.md) – למה להשתמש ב-PostgreSQL
- [03 – What is a Database](03-What-is-a-Database.md) – מהו מסד נתונים
- [04 – Change Database Theme](04-Change-Database-Theme.md) – שינוי ערכת נושא
- [69 – Installation](69-Installation.md) – התקנת PostgreSQL

### עיצוב ויצירת מסד נתונים
- [05 – Create a Database](05-Create-a-Database.md) – יצירת מסד נתונים
- [06 – Design a Database](06-Design-a-Database.md) – עיצוב מסד נתונים
- [07 – Turn Invoice into a Database](07-Turn-Invoice-into-a-Database.md) – המרת חשבונית למסד נתונים
- [08 – Make a Table](08-Make-a-Table.md) – יצירת טבלה
- [09 – Data Types](09-Data-Types.md) – טיפוסי נתונים
- [10 – Adding Data to Table](10-Adding-Data-to-Table.md) – הוספת נתונים לטבלה
- [11 – To See Data](11-To-See-Data.md) – צפייה בנתונים
- [12 – SELECT](12-SELECT.md) – פקודת SELECT
- [13 – Create Custom Type](13-Create-Custom-Type.md) – יצירת טיפוס מותאם
- [14 – Change Column Data Type](14-Change-Column-Data-Type.md) – שינוי טיפוס עמודה
- [15 – Thinking About Tables](15-Thinking-About-Tables.md) – חשיבה על טבלאות
- [16 – Breaking Up Tables](16-Breaking-Up-Tables.md) – פירוק טבלאות
- [17 – Primary & Foreign Keys](17-Primary-Foreign-Keys.md) – מפתחות ראשיים וזרים
- [18 – Altering Tables](18-Altering-Tables.md) – שינוי טבלאות

### שליפת נתונים מטבלה אחת
- [19 – Getting Data from One Table](19-Getting-Data-from-One-Table.md) – שליפת נתונים מטבלה אחת
- [20 – Where](20-Where.md) – תנאי WHERE
- [21 – Conditional Operators](21-Conditional-Operators.md) – אופרטורים תנאיים
- [22 – Logical Operators](22-Logical-Operators.md) – אופרטורים לוגיים
- [23 – Order By](23-Order-By.md) – מיון תוצאות
- [24 – Limit](24-Limit.md) – הגבלת מספר שורות
- [25 – Distinct](25-Distinct.md) – ערכים ייחודיים
- [26 – GROUP BY](26-GROUP-BY.md) – קיבוץ לפי עמודות
- [27 – HAVING](27-HAVING.md) – סינון קבוצות
- [28 – Aggregate Functions](28-Aggregate-Functions.md) – פונקציות אגריגציה

### שליפת נתונים ממספר טבלאות
- [29 – Getting Data from Multiple Tables](29-Getting-Data-from-Multiple-Tables.md) – שליפת נתונים ממספר טבלאות
- [30 – Inner Join](30-Inner-Join.md) – חיבור פנימי
- [31 – Join 3 Tables](31-Join-3-Tables.md) – חיבור 3 טבלאות
- [32 – Arithmetic Operators](32-Arithmetic-Operators.md) – אופרטורים אריתמטיים
- [33 – Join with Where](33-Join-with-Where.md) – חיבור עם תנאי WHERE
- [34 – Outer Joins](34-Outer-Joins.md) – חיבורים חיצוניים
- [35 – Cross Joins](35-Cross-Joins.md) – מכפלה קרטזית
- [36 – Unions](36-Unions.md) – איחוד תוצאות

### תנאים ומחרוזות מתקדמים
- [37 – Extract](37-Extract.md) – חילוץ חלקי תאריך
- [38 – IS NULL](38-IS-NULL.md) – בדיקת ערכי NULL
- [39 – SIMILAR LIKE & ~](39-SIMILAR-LIKE-Regex.md) – תבניות ומחרוזות

### Views ופונקציות SQL
- [40 – Working with Views](40-Working-with-Views.md) – עבודה עם תצוגות
- [41 – SQL Functions](41-SQL-Functions.md) – פונקציות SQL
- [42 – Dollar Quotes](42-Dollar-Quotes.md) – ציטוטים בדולר
- [43 – Functions that Return Void](43-Functions-Return-Void.md) – פונקציות שמחזירות Void
- [44 – Get Maximum Product Price](44-Get-Maximum-Product-Price.md) – פונקציה להחזרת מחיר מקסימלי
- [45 – Get Total Value of Inventory](45-Get-Total-Value-of-Inventory.md) – ערך מלאי כולל
- [46 – Get Number of Customers](46-Get-Number-of-Customers.md) – מספר לקוחות
- [47 – Named Parameters](47-Named-Parameters.md) – פרמטרים בשם
- [48 – Return a Row / Composite](48-Return-Row-Composite.md) – החזרת שורה מורכבת
- [49 – Get Multiple Rows](49-Get-Multiple-Rows.md) – החזרת מספר שורות

### PL/pgSQL
- [50 – PL/pgSQL](50-PL-pgSQL.md) – שפת PL/pgSQL
- [51 – Variables in Functions](51-Variables-in-Functions.md) – משתנים בפונקציות
- [52 – Store Rows in Variables](52-Store-Rows-in-Variables.md) – שמירת שורות במשתנים
- [53 – IN INOUT and OUT](53-IN-INOUT-OUT.md) – פרמטרים IN, INOUT, OUT
- [54 – Using Multiple Outs](54-Using-Multiple-Outs.md) – שימוש במספר פרמטרי פלט
- [55 – Return Query Results](55-Return-Query-Results.md) – החזרת תוצאות שאילתה
- [56 – IF ELSEIF and ELSE](56-IF-ELSEIF-ELSE.md) – תנאים
- [57 – CASE Statement](57-CASE-Statement.md) – משפט CASE
- [58 – Loop Statement](58-Loop-Statement.md) – לולאות
- [59 – FOR LOOP](59-FOR-LOOP.md) – לולאת FOR
- [60 – Result Sets, Blocks & Raise Notice](60-Result-Sets-Blocks-Raise-Notice.md) – תוצאות, בלוקים והודעות
- [61 – For Each and Arrays](61-For-Each-and-Arrays.md) – לולאות על מערכים
- [62 – While Loop](62-While-Loop.md) – לולאת WHILE
- [63 – Continue](63-Continue.md) – המשך בלולאה
- [64 – Stored Procedures](64-Stored-Procedures.md) – פרוצדורות מאוחסנות
- [65 – Triggers](65-Triggers.md) – טריגרים
- [66 – Cursors](66-Cursors.md) – מצביעים

---

**הערה:** התרגילים בנויים בהדרגה. ככל שמתקדמים, התרגילים משלבים את כל החומר שנלמד עד אותו שלב. רוב התרגילים משתמשים במסד Northwind כדוגמה.
