# סינון קבוצות – HAVING

## מטרה

לסנן **קבוצות** (תוצאות של GROUP BY) לפי תנאי על פונקציות אגריגציה. בניגוד ל-WHERE שמסנן **שורות בודדות**.

## סינטקס

```sql
SELECT column, aggregate(column)
FROM table_name
WHERE row_condition    -- סינון שורות לפני הקיבוץ
GROUP BY column
HAVING group_condition; -- סינון קבוצות אחרי הקיבוץ
```

## דוגמה

```sql
SELECT country, COUNT(*) AS cnt
FROM customers
GROUP BY country
HAVING COUNT(*) > 5;
-- רק מדינות עם יותר מ-5 לקוחות
```

## HAVING vs WHERE

- `WHERE` – פועל על שורות בודדות, לפני GROUP BY
- `HAVING` – פועל על קבוצות, אחרי GROUP BY, ומאפשר תנאי על אגריגציות

## תרגילים (Northwind)

### תרגיל 1
הצג מדינות שיש בהן יותר מ-3 לקוחות. הצג `country` ו-`customer_count`.

### תרגיל 2
הצג קטגוריות שבהן ממוצע המחיר מעל 30. הצג `category_id` ו-`avg_price`.

### תרגיל 3
הצג מוצרים (`product_id`) שנמכרו בסך הכל מעל 500 יחידות. הצג `product_id` ו-`total_quantity`.

### תרגיל 4
הצג הזמנות (`order_id`) שערכן הכולל מעל 1000. הצג `order_id` ו-`order_total`.

### תרגיל 5
הצג קטגוריות שיש בהן לפחות 5 מוצרים **וגם** ממוצע המחיר מעל 25.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) > 3;
```

### תרגיל 2
```sql
SELECT category_id, AVG(unit_price) AS avg_price
FROM products
GROUP BY category_id
HAVING AVG(unit_price) > 30;
```

### תרגיל 3
```sql
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) > 500;
```

### תרגיל 4
```sql
SELECT order_id, SUM(quantity * unit_price) AS order_total
FROM order_details
GROUP BY order_id
HAVING SUM(quantity * unit_price) > 1000;
```

### תרגיל 5
```sql
SELECT category_id, COUNT(*) AS product_count, AVG(unit_price) AS avg_price
FROM products
GROUP BY category_id
HAVING COUNT(*) >= 5 AND AVG(unit_price) > 25;
```

</details>
