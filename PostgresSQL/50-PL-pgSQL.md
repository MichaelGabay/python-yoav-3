# PL/pgSQL – שפת הפרוצדורות של PostgreSQL

## מהי PL/pgSQL?

**PL/pgSQL** היא שפת תכנות פרוצדורלית המובנית ב-PostgreSQL. מאפשרת לוגיקה מורכבת: משתנים, תנאים, לולאות, טיפול בשגיאות, ועוד.

## מבנה בסיסי

```sql
CREATE FUNCTION func_name(params)
RETURNS return_type
LANGUAGE plpgsql
AS $$
DECLARE
  var_name type;
BEGIN
  -- קוד
  RETURN value;
END;
$$;
```

## יתרונות על פני SQL טהור

- משתנים
- תנאים (IF, CASE)
- לולאות (LOOP, FOR, WHILE)
- טיפול בשגיאות
- דינמיות

## תרגילים

### תרגיל 1
צור פונקציה `hello_plpgsql()` שמחזירה את המחרוזת `'Hello from PL/pgSQL'` – עם גוף BEGIN...END.

### תרגיל 2
צור פונקציה `add_numbers(a INT, b INT)` שמחשבת a+b בתוך משתנה ומחזירה אותו.

### תרגיל 3
מה ההבדל בין פונקציה ב-LANGUAGE sql ל-LANGUAGE plpgsql?

### תרגיל 4
צור פונקציה שמגדירה משתנה `x INT := 10`, מעדכנת אותו ל-20, ומחזירה אותו.

### תרגיל 5
צור פונקציה `get_message()` שמגדירה משתנה מחרוזת, מקצה לו ערך, ומחזירה אותו.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION hello_plpgsql()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN 'Hello from PL/pgSQL';
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  result INT;
BEGIN
  result := a + b;
  RETURN result;
END;
$$;
```

### תרגיל 3
SQL – שאילתות בלבד, אין משתנים או לוגיקה. PL/pgSQL – לוגיקה מלאה, משתנים, תנאים, לולאות.

### תרגיל 4
```sql
CREATE FUNCTION test_var()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  x INT := 10;
BEGIN
  x := 20;
  RETURN x;
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_message()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
  msg TEXT;
BEGIN
  msg := 'Hello, World!';
  RETURN msg;
END;
$$;
```

</details>
