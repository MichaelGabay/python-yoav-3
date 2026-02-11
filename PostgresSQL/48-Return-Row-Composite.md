# החזרת שורה מורכבת – Return Row / Composite

## מטרה

להחזיר **שורה שלמה** (מבנה מורכב) במקום ערך סקלרי בודד. אפשר להשתמש ב-`RETURNS TABLE` או ב-`RETURNS composite_type`.

## RETURNS TABLE

```sql
CREATE FUNCTION get_product_info(pid INT)
RETURNS TABLE(product_name TEXT, unit_price DECIMAL, units_in_stock SMALLINT)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price, units_in_stock
  FROM products
  WHERE product_id = pid;
$$;
```

## RETURNS composite type

```sql
CREATE TYPE product_info AS (product_name TEXT, unit_price DECIMAL);

CREATE FUNCTION get_product(pid INT)
RETURNS product_info
LANGUAGE sql
AS $$
  SELECT (product_name, unit_price)::product_info
  FROM products
  WHERE product_id = pid;
$$;
```

## תרגילים (Northwind)

### תרגיל 1
צור פונקציה `get_product_row(pid INT)` שמחזירה שורה עם `product_name`, `unit_price`, `units_in_stock` מטבלת products.

### תרגיל 2
צור פונקציה `get_customer_row(cid TEXT)` שמחזירה `company_name`, `city`, `country` ללקוח נתון.

### תרגיל 3
צור טיפוס מורכב `order_summary_type(order_id INT, order_date DATE, total DECIMAL)` ופונקציה שמחזירה אותו.

### תרגיל 4
צור פונקציה שמחזירה את המוצר היקר ביותר כ-RETURNS TABLE עם `product_name`, `unit_price`.

### תרגיל 5
מה ההבדל בין `RETURNS TABLE` ל-`RETURNS record`? חפש בתיעוד.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_product_row(pid INT)
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL, units_in_stock SMALLINT)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price, units_in_stock
  FROM products
  WHERE product_id = pid;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_customer_row(cid VARCHAR(5))
RETURNS TABLE(company_name VARCHAR(40), city VARCHAR(15), country VARCHAR(15))
LANGUAGE sql
AS $$
  SELECT company_name, city, country
  FROM customers
  WHERE customer_id = cid;
$$;
```

### תרגיל 3
```sql
CREATE TYPE order_summary_type AS (order_id INT, order_date DATE, total DECIMAL);

CREATE FUNCTION get_order_summary(oid INT)
RETURNS order_summary_type
LANGUAGE sql
AS $$
  SELECT o.order_id, o.order_date, SUM(od.quantity * od.unit_price)::DECIMAL
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  WHERE o.order_id = oid
  GROUP BY o.order_id, o.order_date;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION get_most_expensive_product()
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price
  FROM products
  ORDER BY unit_price DESC
  LIMIT 1;
$$;
```

### תרגיל 5
`RETURNS TABLE` – מבנה קבוע ומפורש. `RETURNS record` – גמיש, המבנה נקבע בשאילתה הקוראת. ל-record צריך לציין את העמודות בקריאה או להשתמש ב-SETOF.

</details>
