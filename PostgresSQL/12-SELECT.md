# פקודת SELECT

## מבנה בסיסי

```sql
SELECT column1, column2, ...
FROM table_name;
```

## וריאציות

### כל העמודות
```sql
SELECT * FROM products;
```

### ביטויים
```sql
SELECT product_name, unit_price * 1.17 AS price_with_vat
FROM products;
```

### ערכים קבועים
```sql
SELECT 'active' AS status, product_name FROM products;
```

### DISTINCT (ללא כפילויות)
```sql
SELECT DISTINCT country FROM customers;
```

## סדר הפקודות (בהמשך)

```sql
SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT ...;
```

## תרגילים

### תרגיל 1
שלוף מטבלת `products` (Northwind) את `product_name`, `unit_price`, ו-`units_in_stock`. הוסף עמודה מחושבת: `unit_price * units_in_stock` בשם `stock_value`.

### תרגיל 2
שלוף מ-`customers` את `company_name` ו-`city`. הוסף עמודה קבועה עם הערך `'Customer'` בשם `type`.

### תרגיל 3
מה ההבדל בין `SELECT *` ל-`SELECT column1, column2`? מתי עדיף כל אחד?

### תרגיל 4
שלוף את כל המדינות הייחודיות מטבלת `customers` (Northwind).

### תרגיל 5
שלוף מ-`products` את `product_name` ו-`unit_price`, וחישוב: מחיר לאחר הנחה של 10% (`unit_price * 0.9`) עם כינוי `price_after_discount`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name, unit_price, units_in_stock,
       unit_price * units_in_stock AS stock_value
FROM products;
```

### תרגיל 2
```sql
SELECT company_name, city, 'Customer' AS type
FROM customers;
```

### תרגיל 3
`SELECT *` – כל העמודות, שימושי לבדיקה מהירה. `SELECT col1, col2` – רק עמודות נבחרות, עדיף כשצריך ביצועים טובים או תוצאה נקייה.

### תרגיל 4
```sql
SELECT DISTINCT country FROM customers;
```

### תרגיל 5
```sql
SELECT product_name, unit_price,
       unit_price * 0.9 AS price_after_discount
FROM products;
```

</details>
