# משתנים בפונקציות PL/pgSQL

## הצהרת משתנים

```sql
DECLARE
  var_name type;
  another_var type := default_value;
BEGIN
  var_name := expression;
  RETURN var_name;
END;
```

## דוגמאות

```sql
DECLARE
  total INT := 0;
  name TEXT;
  price DECIMAL(10,2);
BEGIN
  total := total + 10;
  name := 'Product';
  RETURN total;
END;
```

## %TYPE – התאמה לטיפוס עמודה

```sql
DECLARE
  prod_price products.unit_price%TYPE;
```

## תרגילים

### תרגיל 1
צור פונקציה שמגדירה `x INT`, `y INT`, מחשבת x+y במשתנה `sum` ומחזירה אותו.

### תרגיל 2
צור פונקציה שמגדירה משתנה `msg TEXT` עם ערך ברירת מחדל `'default'`, מעדכנת אותו בתוך הבלוק, ומחזירה.

### תרגיל 3
צור פונקציה `get_product_price(pid INT)` שמשתמשת ב-`%TYPE` להתאמה ל-`products.unit_price`.

### תרגיל 4
הסבר מה עושה `%TYPE` ולמה זה שימושי.

### תרגיל 5
צור פונקציה עם 3 משתנים: `a`, `b`, `c` (מספרים). החזר את הממוצע (a+b+c)/3.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION sum_two()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
  x INT := 5;
  y INT := 3;
  sum INT;
BEGIN
  sum := x + y;
  RETURN sum;
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION test_default()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
  msg TEXT := 'default';
BEGIN
  msg := 'updated';
  RETURN msg;
END;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_product_price(pid INT)
RETURNS products.unit_price%TYPE
LANGUAGE plpgsql
AS $$
DECLARE
  p products.unit_price%TYPE;
BEGIN
  SELECT unit_price INTO p FROM products WHERE product_id = pid;
  RETURN p;
END;
$$;
```

### תרגיל 4
`%TYPE` מתאים את הטיפוס לטיפוס של עמודה בטבלה. אם משנים את הטיפוס בעמודה, המשתנה יתעדכן אוטומטית.

### תרגיל 5
```sql
CREATE FUNCTION avg_three(a INT, b INT, c INT)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE
  avg_val DECIMAL;
BEGIN
  avg_val := (a + b + c)::DECIMAL / 3;
  RETURN avg_val;
END;
$$;
```

</details>
