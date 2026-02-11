# לולאות – Loop

## LOOP בסיסי

```sql
LOOP
  statements;
  EXIT WHEN condition;
END LOOP;
```

## דוגמה – ספירה

```sql
DECLARE
  i INT := 0;
BEGIN
  LOOP
    i := i + 1;
    EXIT WHEN i > 5;
    RAISE NOTICE 'i = %', i;
  END LOOP;
  RETURN i;
END;
```

## EXIT ו-CONTINUE

- `EXIT` – יוצא מהלולאה
- `EXIT WHEN condition`
- `CONTINUE` – מדלג לאיטרציה הבאה

## תרגילים

### תרגיל 1
צור פונקציה `sum_first_n(n INT)` שמחשבת את הסכום 1+2+...+n עם LOOP.

### תרגיל 2
צור פונקציה `factorial(n INT)` שמחשבת n! עם לולאה.

### תרגיל 3
צור פונקציה שמדפיסה (RAISE NOTICE) את המספרים 1 עד 5 ומחזירה 0.

### תרגיל 4
מה קורה אם שוכחים EXIT בלולאה? איך למנוע?

### תרגיל 5
צור פונקציה `count_digits(num INT)` שסופרת כמה ספרות יש במספר (עם לולאה וחילוק ב-10).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION sum_first_n(n INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  i INT := 0;
  s INT := 0;
BEGIN
  LOOP
    i := i + 1;
    s := s + i;
    EXIT WHEN i >= n;
  END LOOP;
  RETURN s;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION factorial(n INT)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE
  i INT := 1;
  result BIGINT := 1;
BEGIN
  LOOP
    result := result * i;
    i := i + 1;
    EXIT WHEN i > n;
  END LOOP;
  RETURN result;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION print_loop()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE i INT := 0;
BEGIN
  LOOP
    i := i + 1;
    RAISE NOTICE 'i = %', i;
    EXIT WHEN i >= 5;
  END LOOP;
  RETURN 0;
END;
$$;
```

### תרגיל 4
לולאה אינסופית – המסד ייתקע. חייבים EXIT מתישהו. מומלץ להגביל (למשל counter עם max iterations).

### תרגיל 5
```sql
CREATE FUNCTION count_digits(num INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  n INT := ABS(num);
  cnt INT := 0;
BEGIN
  IF n = 0 THEN RETURN 1; END IF;
  LOOP
    cnt := cnt + 1;
    n := n / 10;
    EXIT WHEN n = 0;
  END LOOP;
  RETURN cnt;
END;
$$;
```

</details>
