# קיבוץ שורות – GROUP BY

## מטרה

לקבץ שורות לפי ערכים זהים בעמודות מסוימות, ולחשב ערכים מצטברים (סכום, ממוצע, ספירה וכו').

## סינטקס

```sql
SELECT column, aggregate_function(column)
FROM table_name
GROUP BY column;
```

## כלל חשוב

כל עמודה ב-`SELECT` חייבת להיות:
- ב-`GROUP BY`, או
- בתוך פונקציית אגריגציה (COUNT, SUM, AVG, וכו')

## דוגמה

```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country;
```

## תרגילים (Northwind)

### תרגיל 1
ספור כמה לקוחות יש בכל מדינה. הצג `country` ו-`customer_count`.

### תרגיל 2
חשב את ממוצע המחיר (`unit_price`) לכל קטגוריה (`category_id`). הצג `category_id` ו-`avg_price`.

### תרגיל 3
חשב את סכום הכמות (`quantity`) שנמכרה לכל מוצר (`product_id`) מטבלת `order_details`. הצג `product_id` ו-`total_quantity`.

### תרגיל 4
ספור כמה מוצרים יש בכל קטגוריה. הצג `category_id` ו-`product_count`.

### תרגיל 5
חשב את הסכום הכולל (`quantity * unit_price`) לכל הזמנה (`order_id`) בטבלת `order_details`. הצג `order_id` ו-`order_total`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country;
```

### תרגיל 2
```sql
SELECT category_id, AVG(unit_price) AS avg_price
FROM products
GROUP BY category_id;
```

### תרגיל 3
```sql
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id;
```

### תרגיל 4
```sql
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id;
```

### תרגיל 5
```sql
SELECT order_id, SUM(quantity * unit_price) AS order_total
FROM order_details
GROUP BY order_id;
```

</details>
