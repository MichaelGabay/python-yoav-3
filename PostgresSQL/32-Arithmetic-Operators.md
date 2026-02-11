# אופרטורים אריתמטיים

## אופרטורים

| אופרטור | פעולה |
|---------|--------|
| `+` | חיבור |
| `-` | חיסור |
| `*` | כפל |
| `/` | חילוק |
| `%` | שארית (modulo) |

## דוגמאות בשאילתות

```sql
SELECT unit_price * 1.17 AS price_with_vat FROM products;
SELECT quantity * unit_price AS line_total FROM order_details;
SELECT (unit_price - 5) AS discounted_price FROM products;
```

## שרשור מחרוזות

```sql
SELECT first_name || ' ' || last_name AS full_name FROM employees;
```

## תרגילים (Northwind)

### תרגיל 1
חשב את ערך המלאי לכל מוצר: `unit_price * units_in_stock`. הצג `product_name` ו-`stock_value`.

### תרגיל 2
מטבלת `order_details` חשב את הסכום לפני הנחה: `quantity * unit_price`. הצג `order_id`, `product_id` ו-`line_total`.

### תרגיל 3
חשב מחיר לאחר הנחה של 15%: `unit_price * 0.85`. הצג `product_name`, `unit_price`, `price_after_discount`.

### תרגיל 4
מטבלת `order_details` חשב את הערך לאחר הנחה: `quantity * unit_price * (1 - discount)`. הצג את הסכום הכולל של כל השורות.

### תרגיל 5
הצג `first_name`, `last_name` ושם מלא בשרשור (`first_name || ' ' || last_name`) מטבלת `employees`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name, unit_price * units_in_stock AS stock_value
FROM products;
```

### תרגיל 2
```sql
SELECT order_id, product_id, quantity * unit_price AS line_total
FROM order_details;
```

### תרגיל 3
```sql
SELECT product_name, unit_price, unit_price * 0.85 AS price_after_discount
FROM products;
```

### תרגיל 4
```sql
SELECT SUM(quantity * unit_price * (1 - discount)) AS total_after_discount
FROM order_details;
```

### תרגיל 5
```sql
SELECT first_name, last_name, first_name || ' ' || last_name AS full_name
FROM employees;
```

</details>
