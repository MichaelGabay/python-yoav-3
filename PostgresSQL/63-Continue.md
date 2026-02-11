# המשך בלולאה – CONTINUE

## מטרה

`CONTINUE` מדלג על שאר האיטרציה הנוכחית ועובר ישר לאיטרציה הבאה.

## סינטקס

```sql
LOOP
  IF condition THEN
    CONTINUE;
  END IF;
  -- קוד שירוץ רק אם condition false
END LOOP;
```

## CONTINUE WHEN

```sql
LOOP
  CONTINUE WHEN condition;
  -- קוד
END LOOP;
```

## תרגילים

### תרגיל 1
צור פונקציה שמדפיסה רק מספרים אי-זוגיים מ-1 עד 10 – השתמש ב-CONTINUE כשהמספר זוגי.

### תרגיל 2
צור פונקציה `sum_odd(n INT)` ש מסכמת רק מספרים אי-זוגיים מ-1 עד n.

### תרגיל 3
צור פונקציה שעוברת על מערך [1,2,3,4,5] ומדלגת על 3 – מדפיסה 1,2,4,5.

### תרגיל 4
מה ההבדל בין CONTINUE ל-EXIT?

### תרגיל 5
צור פונקציה שעוברת על 1..10, מדלגת על 5 ו-7, ומחזירה את הסכום של השאר.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION print_odd()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE i INT := 0;
BEGIN
  LOOP
    i := i + 1;
    EXIT WHEN i > 10;
    IF i % 2 = 0 THEN CONTINUE; END IF;
    RAISE NOTICE '%', i;
  END LOOP;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION sum_odd(n INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE i INT := 0; s INT := 0;
BEGIN
  LOOP
    i := i + 1;
    EXIT WHEN i > n;
    IF i % 2 = 0 THEN CONTINUE; END IF;
    s := s + i;
  END LOOP;
  RETURN s;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION skip_three()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE arr INT[] := ARRAY[1,2,3,4,5]; x INT;
BEGIN
  FOREACH x IN ARRAY arr LOOP
    CONTINUE WHEN x = 3;
    RAISE NOTICE '%', x;
  END LOOP;
END;
$$;
```

### תרגיל 4
CONTINUE – מדלג לאיטרציה הבאה. EXIT – יוצא מהלולאה לגמרי.

### תרגיל 5
```sql
CREATE FUNCTION sum_skip_5_7()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE i INT := 0; s INT := 0;
BEGIN
  LOOP
    i := i + 1;
    EXIT WHEN i > 10;
    CONTINUE WHEN i IN (5, 7);
    s := s + i;
  END LOOP;
  RETURN s;
END;
$$;
```

</details>
