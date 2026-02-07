# 05 – חיבורי טבלאות (Joins)

נלמד לחבר טבלאות: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, כינויי טבלאות (Aliases) ו-Self-Join.

---

## מטרה

- להבין מתי משתמשים ב-JOIN
- לכתוב INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN
- להשתמש בכינויי טבלאות (AS) לקריאות
- לחבר טבלה לעצמה (Self-Join) – למשל employees.reports_to

---

## INNER JOIN – חיבור לפי התאמה

רק שורות שיש להן התאמה בשתי הטבלאות מוחזרות.

### דוגמה 1: חיבור הזמנות ללקוחות

```sql
-- code| הצגת הזמנות עם שם החברה של הלקוח
SELECT o.order_id, o.order_date, c.company_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;
```

`o` ו-`c` הם כינויי טבלאות (Aliases). התנאי `ON` מגדיר את עמודות החיבור.

---

### דוגמה 2: חיבור שלוש טבלאות

```sql
-- code| הזמנות עם שם לקוח ושם עובד
SELECT o.order_id, o.order_date, c.company_name, e.first_name || ' ' || e.last_name AS employee_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC
LIMIT 10;
```

`||` ב-PostgreSQL = שרשור מחרוזות.

---

### דוגמה 3: חיבור order_details עם products ו-orders

```sql
-- code| פרטי הזמנה עם שם מוצר ותאריך הזמנה
SELECT od.order_id, o.order_date, p.product_name, od.quantity, od.unit_price
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN orders o ON od.order_id = o.order_id
ORDER BY od.order_id, p.product_name;
```

---

## LEFT JOIN – כל השורות משמאל + התאמות מימין

כל השורות מהטבלה השמאלית מוחזרות; אם אין התאמה מימין, העמודות מימין יהיו NULL.

### דוגמה 1: כל הלקוחות וההזמנות שלהם

```sql
-- code| כל הלקוחות – גם כאלה בלי הזמנות (הזמנה תהיה NULL)
SELECT c.company_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.company_name, o.order_date;
```

לקוחות בלי הזמנות יופיעו עם order_id ו-order_date כ-NULL.

---

### דוגמה 2: מוצרים שלא נמכרו (אין ב-order_details)

```sql
-- code| מוצרים שאין להם אף שורה ב-order_details
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.order_id IS NULL;
```

---

## RIGHT JOIN – כל השורות מימין + התאמות משמאל

הפוך ל-LEFT: כל השורות מהטבלה הימנית; אם אין התאמה משמאל – NULL.

### דוגמה 1: RIGHT JOIN – כל ההזמנות ורק לקוחות שהתאימו

```sql
-- code| RIGHT JOIN – כל ההזמנות, גם אם אין לקוח (נדיר)
SELECT o.order_id, c.company_name
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.order_id;
```

במסד Northwind תקין כל הזמנה תמיד תתאים ללקוח, אז התוצאה דומה ל-INNER JOIN. RIGHT JOIN שימושי כשהסדר של הטבלאות חשוב לקריאות.

---

## FULL OUTER JOIN – כל השורות משתי הטבלאות

כל שורה משתי הטבלאות מוחזרת; אם אין התאמה – NULL בצד השני.

### דוגמה 1: FULL OUTER JOIN (להמחשה)

```sql
-- code| כל הלקוחות וכל ההזמנות – גם בלי התאמה
SELECT c.company_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.company_name IS NULL OR o.order_id IS NULL;
```

במסד Northwind תקין בדרך כלל לא יהיו שורות כאלה; הדוגמה מראה את ההתנהגות.

---

## כינויי טבלאות (Table Aliases)

### דוגמה 1: שימוש ב-AS

```sql
-- code| כינויי טבלאות עם AS
SELECT ord.order_id, cust.company_name
FROM orders AS ord
INNER JOIN customers AS cust ON ord.customer_id = cust.customer_id;
```

---

### דוגמה 2: כינוי בלי AS

```sql
-- code| כינויי טבלאות בלי AS
SELECT o.order_id, c.company_name, p.product_name
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
LIMIT 5;
```

---

## Self-Join – חיבור טבלה לעצמה

כשעמודה בטבלה מפנה לשורה אחרת באותה טבלה (למשל מנהל – reports_to).

### דוגמה 1: עובדים ומנהליהם

```sql
-- code| Self-Join – עובד ומנהלו (employees.reports_to)
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       m.first_name || ' ' || m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id
ORDER BY manager_name, employee_name;
```

`e` = עובד, `m` = מנהל. LEFT JOIN כדי לכלול גם עובדים בלי מנהל (reports_to NULL).

---

### דוגמה 2: מספר עובדים תחת כל מנהל

```sql
-- code| ספירת עובדים לכל מנהל (Self-Join + GROUP BY)
SELECT m.first_name || ' ' || m.last_name AS manager_name,
       COUNT(e.employee_id) AS employee_count
FROM employees m
INNER JOIN employees e ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.first_name, m.last_name
ORDER BY employee_count DESC;
```

---

## סיכום סוגי JOIN

| JOIN | משמעות |
|------|--------|
| INNER JOIN | רק שורות עם התאמה בשתי הטבלאות |
| LEFT JOIN | כל השורות משמאל + התאמות מימין (NULL אם אין) |
| RIGHT JOIN | כל השורות מימין + התאמות משמאל (NULL אם אין) |
| FULL OUTER JOIN | כל השורות משתי הטבלאות (NULL בצד שאין התאמה) |

---

## תרגיל

1. **INNER JOIN:** הצג לכל הזמנה ב-`orders` את order_id, order_date, company_name (מ-customers) ו-first_name + last_name של העובד (מ-employees). הגבל ל-10 שורות.
2. **LEFT JOIN:** הצג את כל המוצרים מ-`products` עם שם הקטגוריה (מ-categories). מוצרים בלי קטגוריה יופיעו עם שם קטגוריה NULL.
3. **חיבור 3 טבלאות:** הצג order_id, product_name (מ-products), quantity, unit_price מ-order_details. מיין לפי order_id ואז לפי product_name.
4. **Self-Join:** הצג רשימת עובדים מ-`employees` עם שם המנהל שלהם (אם יש). השתמש ב-LEFT JOIN על employees.
5. **LEFT JOIN + WHERE:** מצא מוצרים מ-`products` שלא מופיעים ב-`order_details` (לא נמכרו אף פעם). הצג product_id ו-product_name.
