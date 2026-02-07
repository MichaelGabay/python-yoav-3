# 06 – תת-שאילתות (Subqueries)

נלמד להשתמש בתת-שאילתות: בתוך WHERE (עם IN, EXISTS, השוואות), בתוך FROM, ובתוך SELECT.

---

## מטרה

- לכתוב תת-שאילתה ב-WHERE (IN, EXISTS, =, >, < וכו')
- להשתמש בתת-שאילתה כ"טבלה" ב-FROM
- להחזיר ערך בודד בתת-שאילתה ב-SELECT

---

## תת-שאילתה ב-WHERE – IN

תת-שאילתה שמחזירה רשימת ערכים; התנאי בודק אם הערך שייך לרשימה.

### דוגמה 1: מוצרים בקטגוריות מסוימות

```sql
-- code| לקוחות שהזמינו – customer_id מופיע ב-orders
SELECT company_name, country
FROM customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders)
ORDER BY country;
```

---

### דוגמה 2: מוצרים שנמכרו בהזמנות מגרמניה

```sql
-- code| מוצרים שמופיעים ב-order_details בהזמנות של לקוחות מגרמניה
SELECT product_id, product_name, unit_price
FROM products
WHERE product_id IN (
    SELECT od.product_id
    FROM order_details od
    INNER JOIN orders o ON od.order_id = o.order_id
    INNER JOIN customers c ON o.customer_id = c.customer_id
    WHERE c.country = 'Germany'
)
ORDER BY product_name;
```

---

### דוגמה 3: NOT IN – מוצרים שלא נמכרו

```sql
-- code| מוצרים שלא מופיעים ב-order_details
SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (SELECT product_id FROM order_details);
```

**הערה:** אם בתת-שאילתה יש NULL, NOT IN עלול להחזיר תוצאה ריקה. אלטרנטיבה: `WHERE NOT EXISTS (SELECT 1 FROM order_details od WHERE od.product_id = products.product_id)`.

---

## תת-שאילתה ב-WHERE – השוואה (ערך בודד)

תת-שאילתה שמחזירה שורה אחת ועמודה אחת – משמשת בהשוואה (=, >, <, >=, <=).

### דוגמה 1: מוצרים יקרים מהממוצע

```sql
-- code| מוצרים שמחירם מעל ממוצע המחירים
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;
```

---

### דוגמה 2: ההזמנה הראשונה (לפי תאריך)

```sql
-- code| הזמנות מתאריך ההזמנה המוקדם ביותר
SELECT order_id, order_date, customer_id
FROM orders
WHERE order_date = (SELECT MIN(order_date) FROM orders);
```

---

### דוגמה 3: מוצר היקר ביותר בקטגוריה

```sql
-- code| מוצרים שמחירם שווה למחיר המקסימלי בקטגוריה שלהם
SELECT p.product_name, p.category_id, p.unit_price
FROM products p
WHERE p.unit_price = (
    SELECT MAX(unit_price)
    FROM products
    WHERE category_id = p.category_id
);
```

כאן התת-שאילתה "תלויה" (correlated) – מתייחסת ל-`p.category_id` מהשאילתה החיצונית.

---

## תת-שאילתה ב-WHERE – EXISTS

EXISTS מחזיר true אם לתת-שאילתה יש לפחות שורה אחת. שימושי לבדיקת "קיים/לא קיים".

### דוגמה 1: לקוחות עם הזמנות

```sql
-- code| EXISTS – לקוחות שיש להם לפחות הזמנה אחת
SELECT company_name, country
FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id)
ORDER BY company_name;
```

---

### דוגמה 2: מוצרים שלא נמכרו (EXISTS במקום NOT IN)

```sql
-- code| מוצרים שלא נמכרו – עם NOT EXISTS
SELECT product_id, product_name
FROM products p
WHERE NOT EXISTS (SELECT 1 FROM order_details od WHERE od.product_id = p.product_id);
```

---

### דוגמה 3: עובדים שיש להם הזמנות

```sql
-- code| עובדים שטיפלו בהזמנות
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.employee_id = e.employee_id);
```

---

## תת-שאילתה ב-FROM – טבלה וירטואלית

תת-שאילתה ב-FROM חייבת לקבל כינוי (alias) וניתן להתייחס אליה כמו לטבלה.

### דוגמה 1: ממוצע לפי קטגוריה ואז סינון

```sql
-- code| תת-שאילתה ב-FROM – ממוצע מחיר לפי קטגוריה, רק קטגוריות עם ממוצע > 25
SELECT cat_avg.category_id, cat_avg.avg_price
FROM (
    SELECT category_id, AVG(unit_price) AS avg_price
    FROM products
    GROUP BY category_id
) AS cat_avg
WHERE cat_avg.avg_price > 25
ORDER BY cat_avg.avg_price DESC;
```

---

### דוגמה 2: סכום הזמנה ואז מיון

```sql
-- code| סכום לכל order_id מתוך order_details, ואז 5 ההזמנות היקרות ביותר
SELECT order_totals.order_id, order_totals.total
FROM (
    SELECT order_id, SUM(quantity * unit_price) AS total
    FROM order_details
    GROUP BY order_id
) AS order_totals
ORDER BY order_totals.total DESC
LIMIT 5;
```

---

### דוגמה 3: חיבור תת-שאילתה לטבלה

```sql
-- code| חיבור תת-שאילתה ל-categories
SELECT c.category_name, sub.product_count
FROM categories c
INNER JOIN (
    SELECT category_id, COUNT(*) AS product_count
    FROM products
    GROUP BY category_id
) AS sub ON c.category_id = sub.category_id
ORDER BY sub.product_count DESC;
```

---

## תת-שאילתה ב-SELECT – עמודה מחושבת

תת-שאילתה ב-SELECT חייבת להחזיר שורה אחת ועמודה אחת (סקלר).

### דוגמה 1: ממוצע לצד כל שורה

```sql
-- code| כל מוצר עם המחיר שלו וממוצע המחירים במסד
SELECT product_name, unit_price,
       (SELECT AVG(unit_price) FROM products) AS avg_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;
```

---

### דוגמה 2: ממוצע בקטגוריה לצד כל מוצר

```sql
-- code| תת-שאילתה תלויה ב-SELECT – ממוצע קטגוריה
SELECT product_name, category_id, unit_price,
       (SELECT AVG(unit_price) FROM products p2 WHERE p2.category_id = products.category_id) AS category_avg
FROM products
ORDER BY category_id, unit_price DESC
LIMIT 15;
```

---

## סיכום מיקומי תת-שאילתה

| מיקום | דרישה | דוגמה |
|--------|--------|--------|
| WHERE ... IN (subquery) | תת-שאילתה מחזירה עמודה אחת | רשימת IDs |
| WHERE ... op (subquery) | תת-שאילתה מחזירה ערך בודד | השוואה לממוצע |
| WHERE EXISTS (subquery) | תת-שאילתה – יש/אין שורות | בדיקת קיום |
| FROM (subquery) AS alias | חובה כינוי | טבלה וירטואלית |
| SELECT (subquery) | תת-שאילתה מחזירה ערך בודד | עמודה מחושבת |

---

## תרגיל

1. **IN:** הצג את שמות הלקוחות (company_name) שנמצאים באותן מדינות כמו הלקוח 'Alfreds Futterkiste' (השתמש בתת-שאילתה שמחזירה את country של הלקוח הזה).
2. **השוואה:** הצג מוצרים מ-`products` שמחירם נמוך מהממוצע בקטגוריה שלהם (תת-שאילתה תלויה).
3. **EXISTS:** הצג קטגוריות (מ-`categories`) שיש בהן לפחות מוצר אחד עם unit_price מעל 50.
4. **FROM:** כתוב תת-שאילתה שמחשבת לכל customer_id את מספר ההזמנות; חבר ל-`customers` והצג company_name ומספר ההזמנות. מיין לפי מספר ההזמנות יורד.
5. **SELECT:** הצג לכל הזמנה ב-`orders` את order_id, order_date, וכמות ההזמנות של אותו לקוח (תת-שאילתה ב-SELECT שמספירה הזמנות לפי customer_id).
