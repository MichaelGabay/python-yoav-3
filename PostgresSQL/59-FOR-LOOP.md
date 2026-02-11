# לולאת FOR

## FOR על טווח מספרים

```sql
FOR i IN 1..10 LOOP
  -- i עובר 1, 2, ..., 10
END LOOP;
```

## FOR על תוצאות שאילתה

```sql
FOR rec IN SELECT * FROM products LOOP
  -- rec הוא שורה
  RAISE NOTICE '%', rec.product_name;
END LOOP;
```

## FOR עם REVERSE

```sql
FOR i IN REVERSE 10..1 LOOP
  -- i: 10, 9, ..., 1
END LOOP;
```

## תרגילים

### תרגיל 1
צור פונקציה `sum_range(a INT, b INT)` שמחשבת סכום המספרים מ-a עד b עם FOR.

### תרגיל 2
צור פונקציה שמדפיסה (RAISE NOTICE) את שמות כל המוצרים – FOR על SELECT.

### תרגיל 3
צור פונקציה `product_count_above(limit DECIMAL)` שסופרת כמה מוצרים מעל limit – עם FOR ו-counter.

### תרגיל 4
צור פונקציה שמדפיסה מספרים 5,4,3,2,1 – FOR REVERSE.

### תרגיל 5
צור פונקציה שמעבירה על `customers` ומחזירה את מספר הלקוחות ממדינה נתונה – עם FOR ו-counter.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION sum_range(a INT, b INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE s INT := 0;
BEGIN
  FOR i IN a..b LOOP
    s := s + i;
  END LOOP;
  RETURN s;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION list_products()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE rec RECORD;
BEGIN
  FOR rec IN SELECT product_name FROM products LOOP
    RAISE NOTICE '%', rec.product_name;
  END LOOP;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION product_count_above(limit DECIMAL)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  cnt INT := 0;
  rec RECORD;
BEGIN
  FOR rec IN SELECT * FROM products WHERE unit_price > limit LOOP
    cnt := cnt + 1;
  END LOOP;
  RETURN cnt;
END;
$$;
-- או פשוט: RETURN (SELECT COUNT(*) FROM products WHERE unit_price > limit);
```

### תרגיל 4
```sql
CREATE FUNCTION countdown()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  FOR i IN REVERSE 5..1 LOOP
    RAISE NOTICE '%', i;
  END LOOP;
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION count_by_country(cname TEXT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE cnt INT := 0; rec RECORD;
BEGIN
  FOR rec IN SELECT * FROM customers WHERE country = cname LOOP
    cnt := cnt + 1;
  END LOOP;
  RETURN cnt;
END;
$$;
```

</details>
