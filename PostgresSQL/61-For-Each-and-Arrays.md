# For Each ומערכים

## FOR על מערך

```sql
DECLARE
  arr INT[] := ARRAY[1, 2, 3, 4, 5];
  x INT;
BEGIN
  FOREACH x IN ARRAY arr LOOP
    RAISE NOTICE '%', x;
  END LOOP;
END;
```

## FOR עם SLICE

למערכים רב-ממדיים – SLICE 1 לעבור על שורות.

## פונקציות מערך

- `array_length(arr, dim)` – אורך
- `unnest(arr)` – מחזיר שורות
- `ARRAY(SELECT ...)` – בניית מערך משאילתה

## תרגילים

### תרגיל 1
צור פונקציה שמעבירה על מערך [10, 20, 30] ומחזירה את הסכום.

### תרגיל 2
צור פונקציה `array_max(arr INT[])` שמחזירה את האיבר המקסימלי במערך.

### תרגיל 3
השתמש ב-`unnest` – צור שאילתה שמחזירה כל איבר ממערך [1,2,3] כשורה.

### תרגיל 4
צור פונקציה שמקבלת מערך מחרוזות ומחזירה את האורך שלו (כמות האיברים).

### תרגיל 5
צור פונקציה שמעבירה על תוצאות `SELECT product_id FROM products LIMIT 5` ומכניסה אותן למערך. החזר את המערך (או את אורכו).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION sum_array()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  arr INT[] := ARRAY[10, 20, 30];
  x INT;
  s INT := 0;
BEGIN
  FOREACH x IN ARRAY arr LOOP
    s := s + x;
  END LOOP;
  RETURN s;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION array_max(arr INT[])
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  x INT;
  mx INT := NULL;
BEGIN
  FOREACH x IN ARRAY arr LOOP
    IF mx IS NULL OR x > mx THEN mx := x; END IF;
  END LOOP;
  RETURN mx;
END;
$$;
```

### תרגיל 3
```sql
SELECT unnest(ARRAY[1, 2, 3]);
```

### תרגיל 4
```sql
CREATE FUNCTION array_len(arr TEXT[])
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN array_length(arr, 1);
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_product_ids()
RETURNS INT[]
LANGUAGE plpgsql
AS $$
DECLARE
  ids INT[];
BEGIN
  SELECT ARRAY(SELECT product_id FROM products LIMIT 5) INTO ids;
  RETURN ids;
END;
$$;
```

</details>
