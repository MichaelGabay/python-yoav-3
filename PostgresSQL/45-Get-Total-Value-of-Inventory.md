# פונקציה – ערך מלאי כולל

## מטרה

לחשב את הערך הכולל של המלאי: סכום `unit_price * units_in_stock` לכל המוצרים.

## דוגמה

```sql
CREATE FUNCTION get_total_inventory_value()
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT SUM(unit_price * units_in_stock) FROM products;
$$;
```

## תרגילים (Northwind)

### תרגיל 1
צור פונקציה `get_total_inventory_value()` שמחזירה את סכום `unit_price * units_in_stock` מכל המוצרים.

### תרגיל 2
צור פונקציה `get_inventory_value_by_category(cat_id INT)` שמחזירה ערך מלאי רק לקטגוריה נתונה.

### תרגיל 3
צור פונקציה `get_inventory_value_discontinued()` שמחזירה ערך מלאי רק למוצרים שסומנו כ-discontinued (discontinued = 1).

### תרגיל 4
צור פונקציה שמחזירה ערך מלאי לכל קטגוריה – `RETURNS TABLE(category_id INT, total_value DECIMAL)`.

### תרגיל 5
צור פונקציה `get_inventory_above_threshold(min_value DECIMAL)` שמחזירה את סכום ערך המלאי רק למוצרים שערך המלאי שלהם (unit_price * units_in_stock) מעל min_value.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_total_inventory_value()
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT SUM(unit_price * units_in_stock) FROM products;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_inventory_value_by_category(cat_id INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT SUM(unit_price * units_in_stock)
  FROM products
  WHERE category_id = cat_id;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_inventory_value_discontinued()
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT SUM(unit_price * units_in_stock)
  FROM products
  WHERE discontinued = 1;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION get_inventory_by_category()
RETURNS TABLE(category_id INT, total_value DECIMAL)
LANGUAGE sql
AS $$
  SELECT category_id, SUM(unit_price * units_in_stock)
  FROM products
  GROUP BY category_id;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_inventory_above_threshold(min_value DECIMAL)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT SUM(unit_price * units_in_stock)
  FROM products
  WHERE (unit_price * units_in_stock) > min_value;
$$;
```

</details>
