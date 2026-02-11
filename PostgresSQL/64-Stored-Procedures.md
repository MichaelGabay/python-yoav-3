# פרוצדורות מאוחסנות – Stored Procedures

## מהי פרוצדורה?

**Procedure** מבצעת פעולה **ללא** החזרת ערך (או עם OUT בלבד). בניגוד לפונקציה – לא קוראים לה מתוך SELECT, אלא עם `CALL`.

## יצירה

```sql
CREATE PROCEDURE proc_name(params)
LANGUAGE plpgsql
AS $$
BEGIN
  -- פעולות
END;
$$;
```

## קריאה

```sql
CALL proc_name(args);
```

## COMMIT / TRANSACTION

פרוצדורה יכולה לכלול `COMMIT` (מ-PostgreSQL 11) – שימושי לפעולות בטלה.

## תרגילים

### תרגיל 1
צור פרוצדורה `say_hello()` שמדפיסה RAISE NOTICE 'Hello'. קרא לה.

### תרגיל 2
צור פרוצדורה `reset_counter()` שמעדכנת עמודה בטבלה (למשל SET counter=0). נניח טבלה `config(key, value)`.

### תרגיל 3
צור פרוצדורה עם פרמטר IN – `add_customer(name TEXT)` שמוסיפה לקוח לטבלה.

### תרגיל 4
מה ההבדל העיקרי בין PROCEDURE ל-FUNCTION?

### תרגיל 5
צור פרוצדורה `log_action(msg TEXT)` שמוסיפה שורה לטבלת `audit_log(message, created_at)`. קרא לה עם הודעה.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE PROCEDURE say_hello()
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE 'Hello';
END;
$$;

CALL say_hello();
```

### תרגיל 2
```sql
-- נניח: CREATE TABLE config(key TEXT, value INT);
CREATE PROCEDURE reset_counter()
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE config SET value = 0 WHERE key = 'counter';
END;
$$;
```

### תרגיל 3
```sql
-- נניח: CREATE TABLE my_customers(id SERIAL, name TEXT);
CREATE PROCEDURE add_customer(name TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO my_customers(name) VALUES (name);
END;
$$;
```

### תרגיל 4
FUNCTION מחזירה ערך, ניתנת לקריאה ב-SELECT. PROCEDURE לא מחזירה ערך (או רק דרך OUT), נקראת ב-CALL. Procedure תומכת ב-COMMIT בתוכה.

### תרגיל 5
```sql
CREATE TABLE audit_log(message TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE PROCEDURE log_action(msg TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO audit_log(message) VALUES (msg);
END;
$$;

CALL log_action('User logged in');
```

</details>
