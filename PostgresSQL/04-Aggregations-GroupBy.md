# 04 – אגרגציות ו-GROUP BY

נלמד פונקציות אגרגציה: COUNT, SUM, AVG, MIN, MAX, ולקבץ שורות לפי קבוצות עם GROUP BY ו-HAVING.

---

## מטרה

- להשתמש ב-COUNT, SUM, AVG, MIN, MAX
- לקבץ תוצאות עם GROUP BY
- לסנן קבוצות עם HAVING (בניגוד ל-WHERE שמסנן שורות בודדות)

---

## פונקציות אגרגציה בסיסיות

### דוגמה 1: COUNT – ספירת שורות

```sql
-- code| ספירת כל הלקוחות
SELECT COUNT(*) FROM customers;

-- code| ספירת שורות שבהן region לא NULL
SELECT COUNT(region) FROM customers;

-- code| ספירת ערכים ייחודיים במדינה
SELECT COUNT(DISTINCT country) FROM customers;
```

- `COUNT(*)` – סופר שורות (כולל NULL).
- `COUNT(column)` – סופר שורות שבהן העמודה לא NULL.
- `COUNT(DISTINCT column)` – סופר ערכים ייחודיים.

---

### דוגמה 2: SUM – סכום

```sql
-- code| סכום הכמות והמחיר ליחידה בכל order_details
SELECT SUM(quantity) AS total_quantity, SUM(quantity * unit_price) AS total_value
FROM order_details;
```

---

### דוגמה 3: AVG – ממוצע

```sql
-- code| ממוצע מחיר מוצרים
SELECT AVG(unit_price) AS avg_price FROM products;

-- code| ממוצע מחיר לפי קטגוריה (לפני GROUP BY)
SELECT category_id, AVG(unit_price) AS avg_price
FROM products
GROUP BY category_id;
```

---

### דוגמה 4: MIN ו-MAX

```sql
-- code| המחיר הנמוך והגבוה ביותר
SELECT MIN(unit_price) AS min_price, MAX(unit_price) AS max_price
FROM products;

-- code| תאריך ההזמנה המוקדם והמאוחר ביותר
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM orders;
```

---

## GROUP BY – קיבוץ לפי עמודה

כשמשתמשים באגרגציה יחד עם עמודות רגילות, כל העמודות שלא בתוך פונקציית אגרגציה חייבות להופיע ב-GROUP BY.

### דוגמה 1: ספירה לפי קבוצה

```sql
-- code| מספר הלקוחות בכל מדינה
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;
```

---

### דוגמה 2: סכום וממוצע לפי קבוצה

```sql
-- code| סכום כמות וממוצע מחיר לכל order_id ב-order_details
SELECT order_id,
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS avg_price
FROM order_details
GROUP BY order_id
ORDER BY total_quantity DESC;
```

---

### דוגמה 3: GROUP BY על כמה עמודות

```sql
-- code| מספר הזמנות לכל צירוף customer_id ו-employee_id
SELECT customer_id, employee_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id, employee_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;
```

---

## HAVING – סינון קבוצות

WHERE מסנן שורות לפני הקיבוץ; HAVING מסנן קבוצות אחרי האגרגציה.

### דוגמה 1: רק קבוצות עם ספירה מעל ערך

```sql
-- code| מדינות עם יותר מ-5 לקוחות
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY customer_count DESC;
```

---

### דוגמה 2: HAVING עם אגרגציה אחרת

```sql
-- code| מוצרים שסכום הכמות שנמכרה שלהם מעל 500
SELECT product_id, SUM(quantity) AS total_sold
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) > 500
ORDER BY total_sold DESC;
```

---

### דוגמה 3: WHERE ו-HAVING יחד

```sql
-- code| סינון שורות (WHERE) ואז סינון קבוצות (HAVING)
SELECT category_id, AVG(unit_price) AS avg_price
FROM products
WHERE discontinued = 0
GROUP BY category_id
HAVING AVG(unit_price) > 20
ORDER BY avg_price;
```

---

## סדר כתיבה (לוגי)

SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT

```sql
-- code| דוגמה מלאה: מוצרים פעילים, ממוצע מחיר לפי קטגוריה, רק קטגוריות עם ממוצע > 25
SELECT category_id, COUNT(*) AS product_count, AVG(unit_price) AS avg_price
FROM products
WHERE discontinued = 0
GROUP BY category_id
HAVING AVG(unit_price) > 25
ORDER BY avg_price DESC
LIMIT 5;
```

---

## תרגיל

1. **COUNT:** כמה מוצרים יש בכל קטגוריה ב-`products`? הצג category_id ומספר המוצרים, ממוין לפי המספר יורד.
2. **SUM:** לכל הזמנה ב-`order_details`, חשב את סכום `quantity * unit_price * (1 - discount)` והצג את 10 ההזמנות עם הסכום הגבוה ביותר.
3. **AVG + HAVING:** הצג ממוצע מחיר לכל קטגוריה ב-`products`, רק לקטגוריות שבהן יש לפחות 3 מוצרים.
4. **MIN/MAX:** לכל מדינה ב-`customers`, מצא את מספר הלקוחות ואת העיר הראשונה והאחרונה לפי סדר אלפביתי (MIN(city), MAX(city)).
5. **GROUP BY + HAVING:** מ-`orders`, הצג customer_id שמהם יצאו יותר מ-5 הזמנות, עם מספר ההזמנות, ממוין לפי מספר ההזמנות יורד.
