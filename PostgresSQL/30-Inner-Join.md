# חיבור פנימי – INNER JOIN

## מטרה

להחזיר רק שורות שיש **התאמה** בשתי הטבלאות לפי תנאי החיבור.

## סינטקס

```sql
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;
```

או:
```sql
SELECT columns
FROM table1
JOIN table2 ON table1.column = table2.column;
```

## דוגמה – Northwind

```sql
SELECT p.product_name, c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;
```

## כינויים (Aliases)

```sql
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;
```

## תרגילים (Northwind)

### תרגיל 1
הצג `product_name` ו-`category_name` – חבר `products` ל-`categories`.

### תרגיל 2
הצג `order_id`, `company_name`, `order_date` – חבר `orders` ל-`customers`.

### תרגיל 3
הצג `order_id`, `product_name`, `quantity` – חבר `order_details` ל-`products`. הגבל ל-10 שורות.

### תרגיל 4
הצג `employee_id`, `first_name`, `last_name`, `order_id` – חבר `employees` ל-`orders` לפי `employee_id`.

### תרגיל 5
הצג מוצרים עם שם הקטגוריה שלהם, רק למוצרים שמחירם מעל 50.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT p.product_name, c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;
```

### תרגיל 2
```sql
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
```

### תרגיל 3
```sql
SELECT od.order_id, p.product_name, od.quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
LIMIT 10;
```

### תרגיל 4
```sql
SELECT e.employee_id, e.first_name, e.last_name, o.order_id
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id;
```

### תרגיל 5
```sql
SELECT p.product_name, c.category_name, p.unit_price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.unit_price > 50;
```

</details>
