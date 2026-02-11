# ציטוטים בדולר – Dollar Quotes

## מטרה

ב-PostgreSQL משתמשים ב-**Dollar Quoting** (`$$`) כדי לציין מחרוזת שלא תפרש סימנים מיוחדים כמו `'` ו-`\`.

## סינטקס

```sql
$$text here$$
```

## שימוש בפונקציות

כשגוף הפונקציה מכיל גרשיים בודדים, עדיף $$:

```sql
CREATE FUNCTION greet(name TEXT)
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT 'Hello, ' || name || '!';
$$;
```

במקום:
```sql
AS '
  SELECT ''Hello, '' || name || ''!'';
'
```

## תגים מותאמים

אפשר להשתמש בתג ייחודי כדי למנוע התנגשויות:

```sql
$body$
  SELECT 'It''s working' AS msg;
$body$
```

## תרגילים

### תרגיל 1
צור פונקציה שמחזירה את המחרוזת `It's a nice day` באמצעות dollar quotes.

### תרגיל 2
צור פונקציה שמחזירה `O'Reilly` – הסבר למה dollar quotes נוחים כאן.

### תרגיל 3
צור פונקציה עם תג `$fn$` במקום `$$`. הראה דוגמה.

### תרגיל 4
מה קורה אם נשתמש בגרשיים בודדים בתוך מחרוזת רגילה? תן דוגמה לשגיאה.

### תרגיל 5
כתוב CREATE FUNCTION שמשתמש ב-$$ וגם מכיל בתוכו מחרוזת עם גרש – למשל `Don't panic`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION nice_day()
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT 'It''s a nice day';
$$;
-- או עם $:
AS $$
  SELECT $$It's a nice day$$;
$$;
```

### תרגיל 2
עם גרשיים רגילים צריך בריחה: `'O''Reilly'`. עם $$ אפשר: `$$O'Reilly$$` – פשוט וברור יותר.

```sql
CREATE FUNCTION oreilly()
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT 'O''Reilly';
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION example()
RETURNS TEXT
LANGUAGE sql
AS $fn$
  SELECT 'Hello';
$fn$;
```

### תרגיל 4
שגיאה: גרש בודד בתוך מחרוזת נחשב סיום המחרוזת. לדוגמה: `'It's'` יגרום לשגיאת תחביר.

### תרגיל 5
```sql
CREATE FUNCTION dont_panic()
RETURNS TEXT
LANGUAGE sql
AS $$
  SELECT $$Don't panic$$;
$$;
```

</details>
