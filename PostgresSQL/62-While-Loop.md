# לולאת WHILE

## סינטקס

```sql
WHILE condition LOOP
  statements;
END LOOP;
```

## דוגמה

```sql
DECLARE i INT := 0;
BEGIN
  WHILE i < 5 LOOP
    i := i + 1;
    RAISE NOTICE '%', i;
  END LOOP;
END;
```

## תרגילים

### תרגיל 1
צור פונקציה `sum_while(n INT)` שמחשבת 1+2+...+n עם WHILE.

### תרגיל 2
צור פונקציה `power(base INT, exp INT)` שמחשבת base^exp עם WHILE.

### תרגיל 3
צור פונקציה שמדפיסה מספרים זוגיים מ-2 עד 10 – WHILE.

### תרגיל 4
מה ההבדל בין WHILE ל-LOOP עם EXIT WHEN?

### תרגיל 5
צור פונקציה `gcd(a INT, b INT)` שמחשבת את המחלק המשותף המקסימלי עם אלגוריתם אוקלידס (WHILE).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION sum_while(n INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE i INT := 0; s INT := 0;
BEGIN
  WHILE i < n LOOP
    i := i + 1;
    s := s + i;
  END LOOP;
  RETURN s;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION power(base INT, exp INT)
RETURNS BIGINT
LANGUAGE plpgsql
AS $$
DECLARE result BIGINT := 1; e INT := exp;
BEGIN
  WHILE e > 0 LOOP
    result := result * base;
    e := e - 1;
  END LOOP;
  RETURN result;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION even_numbers()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE i INT := 2;
BEGIN
  WHILE i <= 10 LOOP
    RAISE NOTICE '%', i;
    i := i + 2;
  END LOOP;
END;
$$;
```

### תרגיל 4
WHILE בודק תנאי בתחילת כל איטרציה. LOOP + EXIT WHEN – הבדיקה יכולה להיות באמצע הלולאה. שתיהן מתאימות לרוב המקרים.

### תרגיל 5
```sql
CREATE FUNCTION gcd(a INT, b INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE x INT := a; y INT := b; t INT;
BEGIN
  WHILE y <> 0 LOOP
    t := y;
    y := x % y;
    x := t;
  END LOOP;
  RETURN x;
END;
$$;
```

</details>
