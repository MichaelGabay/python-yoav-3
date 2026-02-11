# פרמטרים IN, INOUT, OUT

## IN (ברירת מחדל)

פרמטר לקריאה בלבד – לא משתנה בתוך הפונקציה.

```sql
CREATE FUNCTION double_it(a IN INT) RETURNS INT ...
```

## OUT

פרמטר להחזרה – הערך שהוקצה לו מוחזר לקריאה.

```sql
CREATE FUNCTION get_pair(OUT x INT, OUT y INT)
AS $$
BEGIN
  x := 1;
  y := 2;
END;
$$;
```

## INOUT

קלט **ו**פלט – נכנס עם ערך ויכול להשתנות.

```sql
CREATE FUNCTION increment(INOUT val INT)
AS $$
BEGIN
  val := val + 1;
END;
$$;
```

## תרגילים

### תרגיל 1
צור פונקציה `get_min_max(a INT, b INT, OUT mn INT, OUT mx INT)` שמחזירה את המינימום והמקסימום.

### תרגיל 2
צור פונקציה `square_inplace(INOUT x INT)` שמעדכנת את x ל-x*x.

### תרגיל 3
הסבר את ההבדל בין IN ל-INOUT.

### תרגיל 4
צור פונקציה עם OUT בלבד שמחזירה 3 ערכים: `(1, 2, 3)`.

### תרגיל 5
צור פונקציה `swap(INOUT a INT, INOUT b INT)` שמחליפה בין a ו-b.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_min_max(a INT, b INT, OUT mn INT, OUT mx INT)
LANGUAGE plpgsql
AS $$
BEGIN
  mn := LEAST(a, b);
  mx := GREATEST(a, b);
END;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION square_inplace(INOUT x INT)
LANGUAGE plpgsql
AS $$
BEGIN
  x := x * x;
END;
$$;
```

### תרגיל 3
IN – רק קלט, לא משתנה. INOUT – קלט ויציאה, הערך יכול להשתנות ומוחזר.

### תרגיל 4
```sql
CREATE FUNCTION get_three(OUT a INT, OUT b INT, OUT c INT)
LANGUAGE plpgsql
AS $$
BEGIN
  a := 1;
  b := 2;
  c := 3;
END;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION swap(INOUT a INT, INOUT b INT)
LANGUAGE plpgsql
AS $$
DECLARE
  t INT;
BEGIN
  t := a;
  a := b;
  b := t;
END;
$$;
```

</details>
