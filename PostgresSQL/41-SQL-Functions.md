# פונקציות SQL

## מהי פונקציה?

פונקציה היא בלוק קוד שניתן לקרוא לו בשם, עם פרמטרים וערך החזרה.

## יצירת פונקציה ב-PostgreSQL

```sql
CREATE OR REPLACE FUNCTION function_name(param1 type, param2 type)
RETURNS return_type
LANGUAGE sql
AS $$
  SELECT ... ;
$$;
```

## דוגמה

```sql
CREATE FUNCTION double_price(price DECIMAL)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT price * 2;
$$;
```

## קריאה

```sql
SELECT double_price(10);  -- 20
```

## תרגילים

### תרגיל 1
צור פונקציה `add_vat(price DECIMAL)` שמחזירה מחיר + 17% מע"מ.

### תרגיל 2
צור פונקציה `full_name(first TEXT, last TEXT)` שמחזירה את שני הפרמטרים משורשרים עם רווח ביניהם.

### תרגיל 3
צור פונקציה `is_expensive(price DECIMAL, threshold DECIMAL DEFAULT 50)` שמחזירה TRUE אם price > threshold.

### תרגיל 4
צור פונקציה `min_of_three(a INT, b INT, c INT)` שמחזירה את הקטן מבין שלושת המספרים.

### תרגיל 5
צור פונקציה `discount_price(price DECIMAL, pct INT)` שמחזירה מחיר לאחר הנחה של pct אחוזים.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE OR REPLACE FUNCTION add_vat(price DECIMAL)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT price * 1.17;
$$;
```

### תרגיל 2
```sql
CREATE OR REPLACE FUNCTION full_name(first TEXT, last TEXT)
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT first || ' ' || last;
$$;
```

### תרגיל 3
```sql
CREATE OR REPLACE FUNCTION is_expensive(price DECIMAL, threshold DECIMAL DEFAULT 50)
RETURNS BOOLEAN
LANGUAGE sql
AS $$
  SELECT price > threshold;
$$;
```

### תרגיל 4
```sql
CREATE OR REPLACE FUNCTION min_of_three(a INT, b INT, c INT)
RETURNS INT
LANGUAGE sql
AS $$
  SELECT LEAST(a, b, c);
$$;
```

### תרגיל 5
```sql
CREATE OR REPLACE FUNCTION discount_price(price DECIMAL, pct INT)
RETURNS DECIMAL
LANGUAGE sql
AS $$
  SELECT price * (1 - pct::DECIMAL / 100);
$$;
```

</details>
