# חיבורים חיצוניים – Outer Joins

## LEFT JOIN (LEFT OUTER JOIN)

מחזיר **כל** השורות מהטבלה השמאלית, גם כשאין התאמה בימין. במקרה כזה – עמודות מהטבלה הימנית יהיו NULL.

```sql
SELECT c.company_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
-- גם לקוחות בלי הזמנות יופיעו
```

## RIGHT JOIN

ההפך: כל השורות מימין + התאמות משמאל.

```sql
SELECT c.company_name, o.order_id
FROM orders o
RIGHT JOIN customers c ON c.customer_id = o.customer_id;
```

## FULL OUTER JOIN

כל השורות משתי הטבלאות – התאמות יחוברו, ושורות בלי התאמה יופיעו עם NULL בצד השני.

```sql
SELECT c.company_name, o.order_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;
```

## זיהוי שורות ללא התאמה

```sql
SELECT c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-- לקוחות שעוד לא הזמינו
```

## תרגילים (Northwind)

### תרגיל 1
הצג כל הלקוחות (`company_name`) וההזמנות שלהם. כלול גם לקוחות בלי הזמנות.

### תרגיל 2
מצא לקוחות שאין להם אף הזמנה.

### תרגיל 3
הצג כל המוצרים (`product_name`) וכמות המכירות שלהם. כלול גם מוצרים שלא נמכרו.

### תרגיל 4
מצא מוצרים שמעולם לא הופיעו ב-`order_details`.

### תרגיל 5
הצג `company_name`, `order_id` – LEFT JOIN. הצג רק שורות שבהן `order_id` הוא NULL (לקוחות בלי הזמנות).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT c.company_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

### תרגיל 2
```sql
SELECT c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

### תרגיל 3
```sql
SELECT p.product_name, COALESCE(SUM(od.quantity), 0) AS total_sold
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name;
```

### תרגיל 4
```sql
SELECT p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.order_id IS NULL;
```

### תרגיל 5
```sql
SELECT c.company_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

</details>
