# פרמטרים בשם – Named Parameters

## עקרון

בקריאה לפונקציה אפשר לציין פרמטרים **בשם** במקום לפי סדר. זה מקל על קריאות ומאפשר לדלג על פרמטרים עם ברירת מחדל.

## דוגמה – פונקציה עם פרמטרים

```sql
CREATE FUNCTION greet(first TEXT, last TEXT DEFAULT 'User')
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT 'Hello, ' || first || ' ' || last;
$$;
```

## קריאה עם שמות

```sql
SELECT greet(first => 'John', last => 'Doe');
SELECT greet(last => 'Smith', first => 'Jane');
SELECT greet(first => 'Admin');  -- last ישתמש ב-DEFAULT
```

## תרגילים

### תרגיל 1
צור פונקציה `calc(a INT, b INT, op TEXT DEFAULT '+')` שמחשבת a+b או a-b לפי op. קרא לה עם פרמטרים בשם.

### תרגיל 2
צור פונקציה `format_date(d DATE, fmt TEXT DEFAULT 'YYYY-MM-DD')` שמחזירה תאריך כמחרוזת (פושט – השתמש ב-to_char). קרא עם `fmt => 'DD/MM/YYYY'`.

### תרגיל 3
מה היתרון בשימוש בפרמטרים בשם כשהפונקציה מקבלת 5 פרמטרים?

### תרגיל 4
צור פונקציה `range_sum(start_val INT, end_val INT)` שמחזירה סכום המספרים מ-start_val עד end_val. קרא עם `end_val => 10, start_val => 1`.

### תרגיל 5
האם אפשר לערבב פרמטרים בשם ובמיקום? בדוק בתיעוד או נסה.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION calc(a INT, b INT, op TEXT DEFAULT '+')
RETURNS INT
LANGUAGE sql
AS $$
  SELECT CASE op
    WHEN '+' THEN a + b
    WHEN '-' THEN a - b
    ELSE NULL
  END;
$$;

SELECT calc(a => 5, b => 3);
SELECT calc(b => 3, a => 5, op => '-');
```

### תרגיל 2
```sql
CREATE FUNCTION format_date(d DATE, fmt TEXT DEFAULT 'YYYY-MM-DD')
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT to_char(d, fmt);
$$;

SELECT format_date(d => CURRENT_DATE, fmt => 'DD/MM/YYYY');
```

### תרגיל 3
קריאות – ברור איזה ערך שייך לאיזה פרמטר. פחות טעויות בסדר. קל לדלג על פרמטרים עם DEFAULT.

### תרגיל 4
```sql
CREATE FUNCTION range_sum(start_val INT, end_val INT)
RETURNS INT
LANGUAGE sql
AS $$
  SELECT SUM(n) FROM generate_series(start_val, end_val) AS n;
$$;

SELECT range_sum(start_val => 1, end_val => 10);
```

### תרגיל 5
ב-PostgreSQL אפשר לערבב, אבל אחרי פרמטר בשם כל הפרמטרים הבאים חייבים להיות בשם. עדיף להיות עקבי.

</details>
