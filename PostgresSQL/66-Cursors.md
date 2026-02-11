# מצביעים – Cursors

## מהו Cursor?

**Cursor** מאפשר לעבור על תוצאות שאילתה **שורה אחר שורה**, במקום לטעון את כולן לזכרון.

## הצהרה ופתיחה

```sql
DECLARE
  cur CURSOR FOR SELECT * FROM products;
BEGIN
  OPEN cur;
  -- FETCH...
  CLOSE cur;
END;
```

## FETCH

```sql
FETCH cur INTO variable;
-- או
FETCH NEXT FROM cur INTO rec;
```

## דוגמה

```sql
DECLARE
  cur CURSOR FOR SELECT product_name, unit_price FROM products;
  pname TEXT;
  price DECIMAL;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO pname, price;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '% - %', pname, price;
  END LOOP;
  CLOSE cur;
END;
```

## תרגילים

### תרגיל 1
צור פונקציה שמשתמשת ב-cursor על `products`, מעבירה על כל שורה ומדפיסה את `product_name`.

### תרגיל 2
צור פונקציה שמחשבת את סכום `unit_price` של כל המוצרים – עם cursor ו-FETCH.

### תרגיל 3
מה היתרון של cursor על פני `FOR rec IN SELECT`?

### תרגיל 4
צור פונקציה עם cursor שמקבל פרמטר – מוצרים שמחירם מעל פרמטר. השתמש ב-cursor עם query דינמי או עם פרמטר.

### תרגיל 5
צור פונקציה שמעבירה על cursor ומחזירה את מספר השורות (בלי COUNT).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION list_products_cursor()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR FOR SELECT product_name FROM products;
  pname TEXT;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO pname;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', pname;
  END LOOP;
  CLOSE cur;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION sum_prices_cursor()
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR FOR SELECT unit_price FROM products;
  p DECIMAL;
  total DECIMAL := 0;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO p;
    EXIT WHEN NOT FOUND;
    total := total + p;
  END LOOP;
  CLOSE cur;
  RETURN total;
END;
$$;
```

### תרגיל 3
Cursor שימושי כשצריך לשלוט בזרימה (לדלג, לעצור מוקדם), או כשעובדים עם שאילתות דינמיות. FOR...IN SELECT פשוט יותר לרוב המקרים.

### תרגיל 4
```sql
CREATE FUNCTION list_above(limit DECIMAL)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR(min_p DECIMAL) FOR
    SELECT product_name, unit_price FROM products WHERE unit_price > min_p;
  pname TEXT;
  price DECIMAL;
BEGIN
  OPEN cur(limit);
  LOOP
    FETCH cur INTO pname, price;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '% - %', pname, price;
  END LOOP;
  CLOSE cur;
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION count_cursor()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  cur CURSOR FOR SELECT 1 FROM products;
  dummy INT;
  cnt INT := 0;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO dummy;
    EXIT WHEN NOT FOUND;
    cnt := cnt + 1;
  END LOOP;
  CLOSE cur;
  RETURN cnt;
END;
$$;
```

</details>
