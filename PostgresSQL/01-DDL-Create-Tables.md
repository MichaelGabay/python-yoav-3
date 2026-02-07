# 01 – יצירת טבלאות (DDL)

DDL = Data Definition Language. נלמד ליצור טבלאות עם `CREATE TABLE`, טיפוסי נתונים בסיסיים, מפתח ראשי ואילוצים.

---

## מטרה

- להבין את מבנה `CREATE TABLE`
- להכיר טיפוסי נתונים נפוצים ב-PostgreSQL
- להשתמש ב-PRIMARY KEY, NOT NULL, DEFAULT

---

## CREATE TABLE – מבנה בסיסי

```sql
-- code| מבנה כללי של CREATE TABLE
CREATE TABLE שם_טבלה (
    עמודה1 טיפוס [אילוצים],
    עמודה2 טיפוס [אילוצים],
    ...
);
```

---

## טיפוסי נתונים נפוצים

| טיפוס | תיאור | דוגמה |
|--------|--------|--------|
| `INTEGER` / `INT` | מספר שלם | 42 |
| `SERIAL` | מספר שלם אוטומטי (מונה) | מזהה שורה |
| `VARCHAR(n)` | מחרוזת באורך עד n | 'תל אביב' |
| `TEXT` | מחרוזת באורך חופשי | תיאור ארוך |
| `DECIMAL(p,s)` | מספר עשרוני | מחיר, כמות |
| `DATE` | תאריך | '2024-01-15' |
| `BOOLEAN` | true/false | true |

---

## דוגמה 1: טבלה פשוטה עם מפתח ראשי

```sql
-- code| יצירת טבלה עם מפתח ראשי ועמודות בסיסיות
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE
);
```

- `SERIAL` – ערך אוטומטי שעולה בכל שורה.
- `PRIMARY KEY` – מזהה ייחודי לכל שורה; אוסר NULL וכפילות.
- `NOT NULL` – השדה חובה.

---

## דוגמה 2: טבלה עם ערך ברירת מחדל

```sql
-- code| טבלה עם DEFAULT ו-NOT NULL
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    done BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

- `DEFAULT FALSE` – אם לא מציינים ערך, יוכנס false.
- `DEFAULT CURRENT_TIMESTAMP` – תאריך ושעה נוכחיים אוטומטית.

---

## דוגמה 3: טבלה עם מפתח זר (Foreign Key)

```sql
-- code| טבלה עם קשר לטבלה אחרת (Foreign Key)
CREATE TABLE grades (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(id),
    subject VARCHAR(100) NOT NULL,
    score DECIMAL(5,2) CHECK (score >= 0 AND score <= 100)
);
```

- `REFERENCES students(id)` – `student_id` חייב להצביע על `id` קיים ב-`students`.
- `CHECK` – אילוץ: הציון בין 0 ל-100.

---

## דוגמה 4: מחיקת טבלה

```sql
-- code| מחיקת טבלה (זהירות – מוחק גם נתונים)
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS students;
```

`IF EXISTS` מונע שגיאה אם הטבלה לא קיימת.

---

## תרגיל

1. צור טבלה `courses` עם: `id` (SERIAL PRIMARY KEY), `name` (VARCHAR לא NULL), `credits` (INTEGER, ברירת מחדל 2).
2. צור טבלה `enrollments` עם: `id` (SERIAL PRIMARY KEY), `student_id` (REFERENCES students), `course_id` (REFERENCES courses), `enrolled_at` (DATE, DEFAULT היום).
3. הרץ `\d students` ב-psql (או צפה במבנה הטבלה ב-Beekeeper) וודא שהעמודות וה-PK מופיעים.

**הערה:** אם יצרת את הטבלאות `students` ו-`grades` קודם, צור קודם `courses` ואז `enrollments`; אם לא – צור גם `students` ו-`courses` לפני `enrollments`.
