# שמירת שורות במשתנים

## SELECT INTO

שומר שורה אחת במשתנה (או קבוצת משתנים):

```sql
SELECT column1, column2 INTO var1, var2
FROM table_name WHERE condition;
```

## שורה מלאה ב-RECORD

```sql
DECLARE
  rec RECORD;
BEGIN
  SELECT * INTO rec FROM products WHERE product_id = 1;
  -- גישה: rec.product_name, rec.unit_price
  RETURN rec.product_name;
END;
```

## %ROWTYPE

משתנה שתואם את מבנה הטבלה:

```sql
DECLARE
  prod products%ROWTYPE;
BEGIN
  SELECT * INTO prod FROM products WHERE product_id = 1;
  RETURN prod.product_name;
END;
```

## תרגילים

### תרגיל 1
צור פונקציה `get_product_name(pid INT)` שמחזירה את שם המוצר. השתמש ב-SELECT INTO למשתנה מחרוזת.

### תרגיל 2
צור פונקציה שמשתמשת ב-RECORD – שולפת שורה מ-`customers` לפי `customer_id` ומחזירה `company_name`.

### תרגיל 3
צור פונקציה שמשתמשת ב-`products%ROWTYPE` – שולפת מוצר ומחזירה `unit_price * units_in_stock`.

### תרגיל 4
מה קורה כש-SELECT INTO לא מוצא שורה? איך לטפל?

### תרגיל 5
צור פונקציה שמחזירה שורה מלאה ממוצר – השתמש ב-RETURNS ובמשתנה %ROWTYPE.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_product_name(pid INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
  pname TEXT;
BEGIN
  SELECT product_name INTO pname FROM products WHERE product_id = pid;
  RETURN pname;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_company_name(cid VARCHAR(5))
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
  rec RECORD;
BEGIN
  SELECT * INTO rec FROM customers WHERE customer_id = cid;
  RETURN rec.company_name;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_stock_value(pid INT)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE
  prod products%ROWTYPE;
BEGIN
  SELECT * INTO prod FROM products WHERE product_id = pid;
  RETURN prod.unit_price * prod.units_in_stock;
END;
$$;
```

### תרגיל 4
אם אין שורה – המשתנים נשארים NULL והפונקציה ממשיכה. ניתן לבדוק עם `FOUND` או `IF NOT FOUND`. או להשתמש ב-`GET DIAGNOSTICS` או טיפול בשגיאות.

### תרגיל 5
```sql
CREATE FUNCTION get_product_row(pid INT)
RETURNS products
LANGUAGE plpgsql
AS $$
DECLARE
  prod products%ROWTYPE;
BEGIN
  SELECT * INTO prod FROM products WHERE product_id = pid;
  RETURN prod;
END;
$$;
```

</details>
