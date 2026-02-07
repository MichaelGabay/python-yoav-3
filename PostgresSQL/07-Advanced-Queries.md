# 07 – שאילתות מתקדמות

נלמד UNION / UNION ALL, CTE (WITH), ופונקציות חלון בסיסיות: ROW_NUMBER, RANK, DENSE_RANK ו-PARTITION BY.

---

## מטרה

- לאחד תוצאות של שאילתות עם UNION ו-UNION ALL
- לכתוב שאילתות קריאות עם CTE (Common Table Expression – WITH)
- להשתמש בפונקציות חלון: ROW_NUMBER, RANK, DENSE_RANK, PARTITION BY

---

## UNION ו-UNION ALL

איחוד שורות משתי שאילתות או יותר. מספר העמודות וטיפוסיהן חייבים להתאים.

### דוגמה 1: UNION – איחוד ללא כפילויות

```sql
-- code| UNION – רשימת ערים ייחודית מלקוחות וספקים
SELECT city FROM customers
UNION
SELECT city FROM suppliers
ORDER BY city;
```

UNION מוחק כפילויות. סדר העמודות בשתי השאילתות חייב להתאים.

---

### דוגמה 2: UNION ALL – איחוד עם כפילויות

```sql
-- code| UNION ALL – כל הערים (כולל כפולות)
SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers
ORDER BY city;
```

UNION ALL שומר כפילויות ולכן בדרך כלל מהיר יותר.

---

### דוגמה 3: UNION עם כותרות אחידות

```sql
-- code| איחוד לקוחות וספקים עם עמודת סוג
SELECT company_name, 'Customer' AS type FROM customers
UNION
SELECT company_name, 'Supplier' AS type FROM suppliers
ORDER BY company_name
LIMIT 15;
```

---

## CTE – Common Table Expression (WITH)

WITH מגדיר "טבלה וירטואלית" לשימוש בשאילתה הראשית. משפר קריאות ומאפשר שימוש חוזר.

### דוגמה 1: CTE פשוט

```sql
-- code| CTE – טבלה וירטואלית order_totals
WITH order_totals AS (
    SELECT order_id, SUM(quantity * unit_price) AS total
    FROM order_details
    GROUP BY order_id
)
SELECT ot.order_id, ot.total, o.order_date
FROM order_totals ot
INNER JOIN orders o ON ot.order_id = o.order_id
ORDER BY ot.total DESC
LIMIT 10;
```

---

### דוגמה 2: כמה CTEs ברצף

```sql
-- code| שני CTEs – קודם ממוצעים לפי קטגוריה, אז מוצרים מעל הממוצע
WITH category_avg AS (
    SELECT category_id, AVG(unit_price) AS avg_price
    FROM products
    GROUP BY category_id
),
above_avg AS (
    SELECT p.product_id, p.product_name, p.unit_price, ca.avg_price
    FROM products p
    INNER JOIN category_avg ca ON p.category_id = ca.category_id
    WHERE p.unit_price > ca.avg_price
)
SELECT * FROM above_avg ORDER BY unit_price DESC;
```

---

### דוגמה 3: CTE במקום תת-שאילתה ב-FROM

```sql
-- code| CTE – מספר הזמנות לכל לקוח, ואז רק לקוחות עם יותר מ-5
WITH customer_orders AS (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT c.company_name, co.order_count
FROM customers c
INNER JOIN customer_orders co ON c.customer_id = co.customer_id
WHERE co.order_count > 5
ORDER BY co.order_count DESC;
```

---

## פונקציות חלון (Window Functions)

פונקציות חלון מחשבות ערך על קבוצת שורות (חלון) בלי לקבץ את התוצאה – כל שורה נשארת.

תחביר: `פונקציה() OVER (PARTITION BY ... ORDER BY ...)`.

### דוגמה 1: ROW_NUMBER – מספור שורות

```sql
-- code| ROW_NUMBER – מספור מוצרים לפי מחיר יורד
SELECT product_name, unit_price,
       ROW_NUMBER() OVER (ORDER BY unit_price DESC) AS row_num
FROM products
ORDER BY unit_price DESC
LIMIT 10;
```

---

### דוגמה 2: ROW_NUMBER עם PARTITION BY – מספור בתוך קבוצה

```sql
-- code| ROW_NUMBER לפי קטגוריה – מוצר יקר 1, 2, 3 בכל קטגוריה
SELECT category_id, product_name, unit_price,
       ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS rank_in_category
FROM products
ORDER BY category_id, unit_price DESC;
```

PARTITION BY מחלק את השורות לקבוצות; ROW_NUMBER מתאפס בכל קבוצה.

---

### דוגמה 3: RANK ו-DENSE_RANK

```sql
-- code| RANK – דירוג; שוויון נותן אותו דירוג וקפיצה. DENSE_RANK – בלי קפיצה
SELECT product_name, unit_price,
       RANK() OVER (ORDER BY unit_price DESC) AS rank_price,
       DENSE_RANK() OVER (ORDER BY unit_price DESC) AS dense_rank_price
FROM products
ORDER BY unit_price DESC
LIMIT 15;
```

- RANK: שוויון נותן אותו מספר, הבא ממשיך אחרי הקפיצה (1,2,2,4).
- DENSE_RANK: שוויון אותו מספר, הבא רצוף (1,2,2,3).

---

### דוגמה 4: שלושת המוצרים היקרים בכל קטגוריה

```sql
-- code| 3 המוצרים היקרים בכל קטגוריה עם ROW_NUMBER
WITH ranked AS (
    SELECT category_id, product_name, unit_price,
           ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS rn
    FROM products
)
SELECT category_id, product_name, unit_price, rn
FROM ranked
WHERE rn <= 3
ORDER BY category_id, rn;
```

---

### דוגמה 5: חלון עם SUM – סכום מצטבר (טעימה)

```sql
-- code| סכום מצטבר לפי order_id (דוגמה לפונקציית חלון אגרגציה)
SELECT order_id, product_id, quantity, unit_price,
       SUM(quantity * unit_price) OVER (PARTITION BY order_id ORDER BY product_id) AS running_total
FROM order_details
WHERE order_id = 10248
ORDER BY order_id, product_id;
```

---

## סיכום פונקציות חלון

| פונקציה | תיאור |
|---------|--------|
| ROW_NUMBER() | מספור שורות (1,2,3...) – ייחודי בתוך PARTITION |
| RANK() | דירוג עם קפיצות אחרי שוויון |
| DENSE_RANK() | דירוג בלי קפיצות |
| PARTITION BY | חלוקה לקבוצות; החישוב מתאפס בכל קבוצה |
| ORDER BY ב-OVER | סדר החישוב בתוך החלון |

---

## תרגיל

1. **UNION:** הצג רשימת שמות (company_name) ייחודית מטבלאות `customers` ו-`suppliers`, ממוינת לפי שם.
2. **CTE:** כתוב CTE שמחשב לכל product_id את סכום הכמות שנמכרה (מ-order_details). חבר ל-`products` והצג product_name וסכום הכמות, ממוין לפי הכמות יורד, LIMIT 10.
3. **ROW_NUMBER:** הצג לכל הזמנה ב-`orders` את order_id, order_date, customer_id ומספר שורה (ROW_NUMBER) לפי order_date עולה, כאשר המספור מתחלק לפי customer_id (PARTITION BY customer_id).
4. **RANK:** דרג את המוצרים מ-`products` לפי unit_price יורד עם DENSE_RANK. הצג product_name, unit_price ו-dense_rank, LIMIT 20.
5. **CTE + חלון:** כתוב שאילתה עם CTE שמחשבת לכל employee_id את מספר ההזמנות; בתוך ה-CTE הוסף ROW_NUMBER לפי מספר ההזמנות יורד. הצג רק את העובד עם מספר ההזמנות הגבוה ביותר (row_num = 1).
