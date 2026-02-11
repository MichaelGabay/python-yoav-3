# חיבור עם תנאי WHERE

## עקרון

משלבים JOIN עם WHERE כדי לסנן תוצאות – לפי ערכים בטבלאות המחוברות או בתנאים נוספים.

## דוגמה

```sql
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Germany' AND o.order_date >= '1997-01-01';
```

## סדר לוגי

1. FROM + JOIN – בניית טבלה וירטואלית
2. WHERE – סינון שורות
3. SELECT, ORDER BY, LIMIT

## תרגילים (Northwind)

### תרגיל 1
הצג `order_id`, `company_name`, `order_date` – רק ללקוחות מ-`'France'`.

### תרגיל 2
הצג `product_name`, `category_name` – רק למוצרים שמחירם מעל 50.

### תרגיל 3
הצג `order_id`, `company_name`, `product_name`, `quantity` – רק להזמנות משנת 1998.

### תרגיל 4
הצג `order_id`, `product_name`, `quantity` – רק למוצרים בקטגוריה 2.

### תרגיל 5
הצג הזמנות עם שם לקוח ומוצר – רק ללקוחות מ-`'UK'` ולמוצרים שמחיר היחידה בהזמנה מעל 50.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'France';
```

### תרגיל 2
```sql
SELECT p.product_name, c.category_name, p.unit_price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.unit_price > 50;
```

### תרגיל 3
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
WHERE o.order_date >= '1998-01-01' AND o.order_date < '1999-01-01';
```

### תרגיל 4
```sql
SELECT od.order_id, p.product_name, od.quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
WHERE p.category_id = 2;
```

### תרגיל 5
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity, od.unit_price
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
WHERE c.country = 'UK' AND od.unit_price > 50;
```

</details>
