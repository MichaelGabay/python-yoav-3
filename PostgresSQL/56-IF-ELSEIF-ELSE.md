# תנאים – IF, ELSIF, ELSE

## סינטקס

```sql
IF condition THEN
  statements;
ELSIF condition2 THEN
  statements;
ELSE
  statements;
END IF;
```

## דוגמה

```sql
IF price > 100 THEN
  RETURN 'expensive';
ELSIF price > 50 THEN
  RETURN 'medium';
ELSE
  RETURN 'cheap';
END IF;
```

## תרגילים

### תרגיל 1
צור פונקציה `price_category(price DECIMAL)` שמחזירה 'high' אם price>100, 'medium' אם 50-100, אחרת 'low'.

### תרגיל 2
צור פונקציה `max_of_three(a INT, b INT, c INT)` שמחזירה את המספר הגדול ביותר – עם IF/ELSIF.

### תרגיל 3
צור פונקציה `greet(hour INT)` שמחזירה 'Good morning' (0-11), 'Good afternoon' (12-17), 'Good evening' (18-23).

### תרגיל 4
צור פונקציה `is_leap_year(y INT)` שמחזירה TRUE אם השנה מעוברת.

### תרגיל 5
צור פונקציה `discount_level(amount DECIMAL)` – החזר 0 אם amount<100, 5 אם 100-500, 10 אחרת (אחוזי הנחה).

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION price_category(price DECIMAL)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
  IF price > 100 THEN RETURN 'high';
  ELSIF price > 50 THEN RETURN 'medium';
  ELSE RETURN 'low';
  END IF;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION max_of_three(a INT, b INT, c INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
  IF a >= b AND a >= c THEN RETURN a;
  ELSIF b >= a AND b >= c THEN RETURN b;
  ELSE RETURN c;
  END IF;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION greet(hour INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
  IF hour >= 0 AND hour <= 11 THEN RETURN 'Good morning';
  ELSIF hour >= 12 AND hour <= 17 THEN RETURN 'Good afternoon';
  ELSE RETURN 'Good evening';
  END IF;
END;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION is_leap_year(y INT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
  IF (y % 4 = 0 AND y % 100 <> 0) OR (y % 400 = 0) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION discount_level(amount DECIMAL)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
  IF amount < 100 THEN RETURN 0;
  ELSIF amount <= 500 THEN RETURN 5;
  ELSE RETURN 10;
  END IF;
END;
$$;
```

</details>
