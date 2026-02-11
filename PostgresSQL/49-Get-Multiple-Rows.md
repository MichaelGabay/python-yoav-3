# החזרת מספר שורות – Get Multiple Rows

## מטרה

פונקציה שמחזירה **סט שורות** – כמו טבלה. משתמשים ב-`RETURNS SETOF` או `RETURNS TABLE`.

## RETURNS TABLE

```sql
CREATE FUNCTION get_top_products(n INT)
RETURNS TABLE(product_name TEXT, unit_price DECIMAL)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price
  FROM products
  ORDER BY unit_price DESC
  LIMIT n;
$$;
```

## RETURNS SETOF table_type

```sql
CREATE FUNCTION get_products_above_price(min_p DECIMAL)
RETURNS SETOF products
LANGUAGE sql
AS $$
  SELECT * FROM products WHERE unit_price > min_p;
$$;
```

## RETURN QUERY (ב-plpgsql)

```sql
CREATE FUNCTION get_expensive()
RETURNS SETOF products
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT * FROM products WHERE unit_price > 50;
END;
$$;
```

## תרגילים (Northwind)

### תרגיל 1
צור פונקציה `get_products_by_category(cat_id INT)` שמחזירה כל המוצרים בקטגוריה נתונה. הצג `product_name`, `unit_price`.

### תרגיל 2
צור פונקציה `get_top_n_products(n INT)` שמחזירה את n המוצרים היקרים ביותר.

### תרגיל 3
צור פונקציה `get_customers_in_country(country_name TEXT)` שמחזירה את כל הלקוחות במדינה – `company_name`, `city`.

### תרגיל 4
צור פונקציה `get_orders_in_year(y INT)` שמחזירה `order_id`, `order_date`, `customer_id` להזמנות באותה שנה.

### תרגיל 5
צור פונקציה `get_products_price_range(min_p DECIMAL, max_p DECIMAL)` שמחזירה מוצרים במחיר בטווח הנתון. השתמש ב-RETURNS TABLE.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_products_by_category(cat_id INT)
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price
  FROM products
  WHERE category_id = cat_id;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_top_n_products(n INT)
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price
  FROM products
  ORDER BY unit_price DESC
  LIMIT n;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_customers_in_country(country_name TEXT)
RETURNS TABLE(company_name VARCHAR(40), city VARCHAR(15))
LANGUAGE sql
AS $$
  SELECT company_name, city
  FROM customers
  WHERE country = country_name;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION get_orders_in_year(y INT)
RETURNS TABLE(order_id SMALLINT, order_date DATE, customer_id VARCHAR(5))
LANGUAGE sql
AS $$
  SELECT order_id, order_date, customer_id
  FROM orders
  WHERE EXTRACT(YEAR FROM order_date) = y;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_products_price_range(min_p DECIMAL, max_p DECIMAL)
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE sql
AS $$
  SELECT product_name, unit_price
  FROM products
  WHERE unit_price BETWEEN min_p AND max_p;
$$;
```

</details>
