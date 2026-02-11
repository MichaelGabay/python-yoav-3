# פונקציות שמחזירות Void

## מטרה

פונקציה שמבצעת פעולה **ללא החזרת ערך** – למשל הדפסה, עדכון, או פעולת צד. מסומנת כ-`RETURNS void`.

## סינטקס

```sql
CREATE FUNCTION func_name(params)
RETURNS void
LANGUAGE sql
AS $$
  -- פעולות ללא SELECT שמחזיר ערך
$$;
```

## הערה

ב-SQL, פונקציה חייבת להחזיר משהו. `RETURNS void` אומר "לא מחזיר ערך שימושי". בפועל משתמשים לרוב ב-**PROCEDURE** (מ-PostgreSQL 11) לפעולות ללא החזרה, אבל פונקציה עם void עדיין תקפה.

## דוגמה עם RAISE NOTICE (ב-plpgsql)

```sql
CREATE FUNCTION log_message(msg TEXT)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE '%', msg;
END;
$$;
```

## תרגילים

### תרגיל 1
צור פונקציה `do_nothing()` שמחזירה void ולא עושה כלום (גוף ריק או SELECT 1 שלא מוחזר).

### תרגיל 2
הסבר מתי עדיף `RETURNS void` על פני `RETURNS TABLE` או ערך סקלרי.

### תרגיל 3
צור פונקציה `reset_counter()` שמעדכנת טבלה (למשל SET x=0) ומחזירה void.

### תרגיל 4
מה ההבדל בין פונקציה שמחזירה void לפרוצדורה (PROCEDURE)?

### תרגיל 5
צור פונקציה `audit_insert(msg TEXT)` שמכניסה שורה לטבלת `audit_log(id, message, created_at)` ומחזירה void. נניח שהטבלה קיימת.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION do_nothing()
RETURNS void
LANGUAGE sql
AS $$
  SELECT NULL;
$$;
-- או plpgsql:
AS $$
BEGIN
  NULL;
END;
$$;
```

### תרגיל 2
כשהמטרה היא פעולת צד (עדכון, הוספה, לוג) ולא תוצאה לשימוש בשאילתה. void מבהיר שלא מצפים לערך.

### תרגיל 3
```sql
-- נניח טבלה config(key, value)
CREATE FUNCTION reset_counter()
RETURNS void
LANGUAGE sql
AS $$
  UPDATE config SET value = '0' WHERE key = 'counter';
$$;
```

### תרגיל 4
PROCEDURE מתאימה לפעולות without return value; לא ניתן להשתמש בתוצאה שלה ב-SELECT. פונקציה עם void עדיין ניתנת לקריאה כ-SELECT func() אך התוצאה NULL.

### תרגיל 5
```sql
CREATE TABLE audit_log (id SERIAL, message TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE FUNCTION audit_insert(msg TEXT)
RETURNS void
LANGUAGE sql
AS $$
  INSERT INTO audit_log (message) VALUES (msg);
$$;
```

</details>
