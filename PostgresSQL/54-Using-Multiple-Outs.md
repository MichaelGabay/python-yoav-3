# שימוש במספר פרמטרי OUT

## עקרון

פונקציה יכולה להחזיר כמה ערכים דרך פרמטרי OUT, בלי צורך ב-RETURNS מורכב.

## דוגמה

```sql
CREATE FUNCTION get_stats(OUT cnt INT, OUT total DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT COUNT(*), SUM(unit_price) INTO cnt, total FROM products;
END;
$$;
```

## קריאה

```sql
SELECT * FROM get_stats();
-- מחזיר שורה עם cnt, total
```

## תרגילים

### תרגיל 1
צור פונקציה `product_stats(OUT min_p DECIMAL, OUT max_p DECIMAL)` שמחזירה את המחיר המינימלי והמקסימלי מ-products.

### תרגיל 2
צור פונקציה `order_stats(oid INT, OUT items INT, OUT total DECIMAL)` שמחזירה מספר פריטים וסכום ההזמנה.

### תרגיל 3
צור פונקציה `customer_info(cid TEXT, OUT name TEXT, OUT city TEXT, OUT country TEXT)`.

### תרגיל 4
כיצד מטפלים כשצריך גם פרמטרי IN וגם OUT? תן דוגמה.

### תרגיל 5
צור פונקציה `inventory_summary(OUT product_count INT, OUT total_value DECIMAL, OUT avg_price DECIMAL)` מטבלת products.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION product_stats(OUT min_p DECIMAL, OUT max_p DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT MIN(unit_price), MAX(unit_price) INTO min_p, max_p FROM products;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION order_stats(oid INT, OUT items INT, OUT total DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT COUNT(*), SUM(quantity * unit_price) INTO items, total
  FROM order_details WHERE order_id = oid;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION customer_info(cid VARCHAR(5), OUT name VARCHAR(40), OUT city VARCHAR(15), OUT country VARCHAR(15))
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT company_name, customers.city, customers.country INTO name, city, country
  FROM customers WHERE customer_id = cid;
END;
$$;
```

### תרגיל 4
מסדרים IN לפני OUT. דוגמה:
```sql
CREATE FUNCTION f(x INT, y INT, OUT sum INT, OUT product INT) ...
```

### תרגיל 5
```sql
CREATE FUNCTION inventory_summary(OUT product_count INT, OUT total_value DECIMAL, OUT avg_price DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
  SELECT COUNT(*),
         SUM(unit_price * units_in_stock),
         AVG(unit_price)
  INTO product_count, total_value, avg_price
  FROM products;
END;
$$;
```

</details>
