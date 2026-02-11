# פונקציה – קבלת מחיר מקסימלי

## מטרה

ליצור פונקציה שמחזירה את המחיר הגבוה ביותר של מוצר – או מטבלה ספציפית או כפרמטר כללי.

## דוגמה – מחזירה סקלר

```sql
CREATE FUNCTION get_max_product_price()
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products;
$$;
```

## עם פרמטר – מגבלת קטגוריה

```sql
CREATE FUNCTION get_max_price_by_category(cat_id INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products WHERE category_id = cat_id;
$$;
```

## תרגילים (Northwind)

### תרגיל 1
צור פונקציה `get_max_product_price()` שמחזירה את המחיר הגבוה ביותר מטבלת `products`.

### תרגיל 2
צור פונקציה `get_max_price_in_category(cat_id INT)` שמחזירה את המחיר המקסימלי בקטגוריה נתונה.

### תרגיל 3
צור פונקציה `get_max_and_min_price()` שמחזירה שורה עם `max_price` ו-`min_price`. השתמש ב-RETURNS TABLE.

### תרגיל 4
צור פונקציה `get_product_name_with_max_price()` שמחזירה את **שם** המוצר היקר ביותר.

### תרגיל 5
צור פונקציה `get_max_price_discontinued(discontinued INT)` – מחזירה את המחיר המקסימלי למוצרים לפי `discontinued` (0 או 1).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_max_product_price()
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_max_price_in_category(cat_id INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products WHERE category_id = cat_id;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_max_and_min_price()
RETURNS TABLE(max_price DECIMAL, min_price DECIMAL)
LANGUAGE sql
AS $$
  SELECT MAX(unit_price), MIN(unit_price) FROM products;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION get_product_name_with_max_price()
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT product_name FROM products ORDER BY unit_price DESC LIMIT 1;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_max_price_discontinued(discontinued INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products WHERE products.discontinued = get_max_price_discontinued.discontinued;
$$;
-- או עם שם פרמטר שונה:
CREATE FUNCTION get_max_price_discontinued(d INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT MAX(unit_price) FROM products WHERE products.discontinued = d;
$$;
```

</details>
