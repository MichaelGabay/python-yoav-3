# תוצאות, בלוקים ו-RAISE NOTICE

## RAISE NOTICE

מדפיס הודעות ללוג / לקונסול (לא לתוצאה):

```sql
RAISE NOTICE 'Message: %', variable;
RAISE NOTICE 'Value is %', some_value;
```

## רמות RAISE

- `NOTICE` – מידע
- `WARNING` – אזהרה
- `EXCEPTION` – זורק שגיאה ועוצר

## בלוקים מקוננים

```sql
BEGIN
  ...
  BEGIN
    ...
  EXCEPTION
    WHEN OTHERS THEN ...
  END;
  ...
END;
```

## תרגילים

### תרגיל 1
צור פונקציה שמדפיסה "Hello" ואז "World" בשתי הודעות RAISE NOTICE.

### תרגיל 2
צור פונקציה שמקבלת מספר ומדפיסה "The number is X".

### תרגיל 3
צור פונקציה שמדפיסה RAISE WARNING אם המחיר שלילי.

### תרגיל 4
מה ההבדל בין RAISE NOTICE ל-RETURN? האם RAISE מופיע בתוצאה של SELECT?

### תרגיל 5
צור פונקציה עם בלוק פנימי שמטפל ב-EXCEPTION – נסה לחלק ב-0 ותתפוס את השגיאה.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION hello_world()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE 'Hello';
  RAISE NOTICE 'World';
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION show_number(x INT)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE 'The number is %', x;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION check_price(price DECIMAL)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  IF price < 0 THEN
    RAISE WARNING 'Price is negative: %', price;
  END IF;
END;
$$;
```

### תרגיל 4
RETURN מחזיר ערך לתוצאה. RAISE NOTICE שולח הודעה ללוג – לא מופיע בתוצאה של SELECT.

### תרגיל 5
```sql
CREATE FUNCTION safe_divide(a INT, b INT)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE result DECIMAL;
BEGIN
  BEGIN
    result := a::DECIMAL / b;
    RETURN result;
  EXCEPTION
    WHEN division_by_zero THEN
      RAISE NOTICE 'Division by zero';
      RETURN NULL;
  END;
END;
$$;
```

</details>
