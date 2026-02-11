# משפט CASE

## CASE בשאילתה

```sql
SELECT product_name,
  CASE
    WHEN unit_price > 100 THEN 'expensive'
    WHEN unit_price > 50 THEN 'medium'
    ELSE 'cheap'
  END AS category
FROM products;
```

## CASE בבלוק PL/pgSQL

```sql
CASE
  WHEN condition1 THEN result1;
  WHEN condition2 THEN result2;
  ELSE result3;
END CASE;
```

## CASE עם ביטוי

```sql
CASE expression
  WHEN value1 THEN result1;
  WHEN value2 THEN result2;
  ELSE result3;
END CASE;
```

## תרגילים

### תרגיל 1
צור פונקציה `grade_letter(score INT)` שמחזירה 'A' (90+), 'B' (80-89), 'C' (70-79), 'F' (פחות) – עם CASE.

### תרגיל 2
צור פונקציה `day_name(dow INT)` שמחזירה שם היום (1=Sunday...7=Saturday) – CASE עם ביטוי.

### תרגיל 3
השתמש ב-CASE בשאילתה: הצג `product_name`, `unit_price` ועמודה `price_range`: 'low'/'mid'/'high'.

### תרגיל 4
צור פונקציה `discount_pct(category TEXT)` – החזר 10 ל-'premium', 5 ל-'standard', 0 אחרת.

### תרגיל 5
מה היתרון של CASE על פני IF/ELSIF במקרים מסוימים?

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION grade_letter(score INT)
RETURNS CHAR
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN CASE
    WHEN score >= 90 THEN 'A'
    WHEN score >= 80 THEN 'B'
    WHEN score >= 70 THEN 'C'
    ELSE 'F'
  END;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION day_name(dow INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN CASE dow
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
    ELSE 'Invalid'
  END;
END;
$$;
```

### תרגיל 3
```sql
SELECT product_name, unit_price,
  CASE
    WHEN unit_price < 20 THEN 'low'
    WHEN unit_price < 50 THEN 'mid'
    ELSE 'high'
  END AS price_range
FROM products;
```

### תרגיל 4
```sql
CREATE FUNCTION discount_pct(category TEXT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN CASE category
    WHEN 'premium' THEN 10
    WHEN 'standard' THEN 5
    ELSE 0
  END;
END;
$$;
```

### תרגיל 5
CASE קריא יותר כשמשווים אותו ערך למספר אפשרויות. IF מתאים ללוגיקה מורכבת יותר עם תנאים שונים.

</details>
