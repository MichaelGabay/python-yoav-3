# יצירת מסד נתונים

## יצירת מסד נתונים ב-PostgreSQL

### סינטקס

```sql
CREATE DATABASE database_name;
```

### דוגמה

```sql
CREATE DATABASE my_company;
```

## אפשרויות נוספות

### עם קידוד ואינקודינג

```sql
CREATE DATABASE my_db
    WITH ENCODING = 'UTF8'
         LC_COLLATE = 'en_US.UTF-8'
         LC_CTYPE = 'en_US.UTF-8';
```

### התעלמות משגיאה אם המסד כבר קיים

```sql
CREATE DATABASE IF NOT EXISTS my_db;  -- PostgreSQL 15+
-- או:
SELECT 'CREATE DATABASE my_db' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'my_db')\gexec
```

## רשימת מסדי נתונים

```sql
\l
```

או:

```sql
SELECT datname FROM pg_database;
```

## מחיקת מסד נתונים

```sql
DROP DATABASE database_name;
```

**אזהרה:** המחיקה לא הפיכה. יש להתנתק מהמסד לפני המחיקה (למשל להתחבר ל-`postgres`).

## חיבור למסד נתונים

```sql
\c database_name
```

## תרגילים

### תרגיל 1
צור מסד נתונים בשם `school`. הרץ את הפקודה והצג את רשימת מסדי הנתונים.

### תרגיל 2
צור מסד נתונים בשם `inventory` עם קידוד UTF8. איך בודקים שהמסד נוצר?

### תרגיל 3
מה קורה כשמנסים ליצור מסד נתונים בשם שכבר קיים? איך אפשר למנוע שגיאה?

### תרגיל 4
התחבר למסד `school` שיצרת בתרגיל 1. הרץ `SELECT current_database();` – מה מוחזר?

### תרגיל 5
כתוב את סדר הפקודות הנדרש: יצירת מסד `test_db`, חיבור אליו, ובדיקה שאתה במסד הנכון.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE DATABASE school;
\l
```

### תרגיל 2
```sql
CREATE DATABASE inventory WITH ENCODING = 'UTF8';
\l
-- או:
SELECT datname FROM pg_database WHERE datname = 'inventory';
```

### תרגיל 3
מתקבלת שגיאה: "database already exists". אפשר להשתמש ב-`CREATE DATABASE IF NOT EXISTS` (מ-PostgreSQL 15) או לבדוק קודם אם המסד קיים לפני יצירה.

### תרגיל 4
```sql
\c school
SELECT current_database();
```
התוצאה: `school`.

### תרגיל 5
```sql
CREATE DATABASE test_db;
\c test_db
SELECT current_database();
```

</details>
