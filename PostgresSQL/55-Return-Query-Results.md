# החזרת תוצאות שאילתה – RETURN QUERY

## RETURN QUERY

מחזיר את תוצאות השאילתה כסט שורות:

```sql
CREATE FUNCTION get_expensive_products()
RETURNS SETOF products
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT * FROM products WHERE unit_price > 50;
END;
$$;
```

## RETURN QUERY SELECT

```sql
RETURN QUERY SELECT col1, col2 FROM table WHERE condition;
```

## RETURN NEXT (שורה בודדת)

```sql
RETURN NEXT row_value;
```

## תרגילים

### תרגיל 1
צור פונקציה `get_products_above(limit DECIMAL)` שמחזירה מוצרים שמחירם מעל limit.

### תרגיל 2
צור פונקציה שמחזירה `product_name`, `unit_price` – רק למוצרים בקטגוריה 1. השתמש ב-RETURNS TABLE.

### תרגיל 3
צור פונקציה `get_top_products(n INT)` שמחזירה n המוצרים היקרים – RETURN QUERY עם ORDER BY ו-LIMIT.

### תרגיל 4
הסבר את ההבדל בין RETURN QUERY ל-RETURN (ערך בודד).

### תרגיל 5
צור פונקציה שמחזירה לקוחות ממדינה נתונה – `company_name`, `city`. השתמש ב-RETURN QUERY.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_products_above(limit DECIMAL)
RETURNS SETOF products
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT * FROM products WHERE unit_price > limit;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_category1_products()
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY SELECT p.product_name, p.unit_price FROM products p WHERE category_id = 1;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_top_products(n INT)
RETURNS TABLE(product_name VARCHAR(40), unit_price REAL)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT p.product_name, p.unit_price
  FROM products p
  ORDER BY unit_price DESC
  LIMIT n;
END;
$$;
```

### תרגיל 4
RETURN – מחזיר ערך אחד וסוגר. RETURN QUERY – מוסיף שורות לתוצאה וממשיך (אפשר כמה RETURN QUERY).

### תרגיל 5
```sql
CREATE FUNCTION get_customers_in_country(cname TEXT)
RETURNS TABLE(company_name VARCHAR(40), city VARCHAR(15))
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT c.company_name, c.city
  FROM customers c
  WHERE c.country = cname;
END;
$$;
```

</details>
