# מכפלה קרטזית – CROSS JOIN

## מטרה

CROSS JOIN מחזיר את **מכפלת** כל שורה מהטבלה הראשונה עם כל שורה מהשנייה – בלי תנאי חיבור.

## סינטקס

```sql
SELECT * FROM table1 CROSS JOIN table2;
```

או:
```sql
SELECT * FROM table1, table2;
```

## דוגמה

אם `colors` יש 3 שורות ו-`sizes` יש 4 שורות – התוצאה: 3×4 = 12 שורות.

```sql
SELECT c.color, s.size
FROM colors c
CROSS JOIN sizes s;
```

## שימושים

- יצירת צירופים מלאים (למשל צבעים × מידות)
- טבלאות עזר עם ערכים קבועים

## תרגילים

### תרגיל 1
צור טבלאות `A(id)` עם ערכים 1,2 ו-`B(id)` עם ערכים 1,2,3. הרץ CROSS JOIN – כמה שורות מתקבלות?

### תרגיל 2
בטבלת `products` (Northwind) יש קטגוריות. צור רשימת כל צירופי `product_id` ו-`category_id` (מטבלאות products ו-categories) – לא לפי קשר אמיתי, אלא CROSS JOIN. הגבל ל-5 שורות.

### תרגיל 3
מה ההבדל בין CROSS JOIN ל-INNER JOIN ללא תנאי ON? (רמז: ב-INNER JOIN עם ON 1=1 התוצאה דומה.)

### תרגיל 4
מתי CROSS JOIN עלול להיות מסוכן? מה קורה עם טבלאות גדולות?

### תרגיל 5
כתוב CROSS JOIN בין `customers` ל-`suppliers` (Northwind). הצג רק `company_name` משתי הטבלאות. הגבל ל-3 שורות.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE TABLE A (id INT);
INSERT INTO A VALUES (1), (2);
CREATE TABLE B (id INT);
INSERT INTO B VALUES (1), (2), (3);

SELECT * FROM A CROSS JOIN B;
-- 6 שורות (2×3)
```

### תרגיל 2
```sql
SELECT p.product_id, c.category_id
FROM products p
CROSS JOIN categories c
LIMIT 5;
```

### תרגיל 3
CROSS JOIN תמיד מכפיל. INNER JOIN עם ON 1=1 גם נותן מכפלה. ההבדל העיקרי: INNER JOIN משמש לחיבור לוגי; CROSS JOIN מפורש למכפלה קרטזית.

### תרגיל 4
עם טבלאות גדולות המכפלה מתפוצצת – 1000×1000 = מיליון שורות. יכול להאט או להפיל את המסד.

### תרגיל 5
```sql
SELECT c.company_name AS customer, s.company_name AS supplier
FROM customers c
CROSS JOIN suppliers s
LIMIT 3;
```

</details>
