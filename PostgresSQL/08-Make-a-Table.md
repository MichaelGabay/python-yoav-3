# יצירת טבלה

## סינטקס בסיסי

```sql
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);
```

## דוגמה

```sql
CREATE TABLE customers (
    id          INTEGER,
    name        VARCHAR(100),
    email       VARCHAR(255),
    created_at  TIMESTAMP
);
```

## תכונות נפוצות לעמודות

| תכונה | משמעות |
|-------|--------|
| `PRIMARY KEY` | מפתח ראשי – ייחודי ולא NULL |
| `NOT NULL` | חובה למלא ערך |
| `UNIQUE` | ערך ייחודי בטבלה |
| `DEFAULT value` | ערך ברירת מחדל |

## דוגמה מלאה

```sql
CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    in_stock    INTEGER DEFAULT 0,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## צפייה במבנה טבלה

```sql
\d table_name
```

## תרגילים

### תרגיל 1
צור טבלה `students` עם עמודות: `id` (מספר שלם), `name` (מחרוזת עד 100 תווים), `birth_date` (תאריך).

### תרגיל 2
צור טבלה `books` עם `id` כמפתח ראשי אוטומטי (`SERIAL`), `title` חובה, `author` אופציונלי, `year` ברירת מחדל 2025.

### תרגיל 3
מה ההבדל בין `id INTEGER` ל-`id SERIAL PRIMARY KEY`?

### תרגיל 4
צור טבלה `orders` עם: `order_id` (מפתח ראשי), `customer_id` (מספר שלם), `order_date` (תאריך), `status` (מחרוזת, ברירת מחדל 'pending').

### תרגיל 5
הרץ `\d students` אחרי יצירת הטבלה – מה מוצג? הסבר את המשמעות של כל עמודה בפלט.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE TABLE students (
    id          INTEGER,
    name        VARCHAR(100),
    birth_date  DATE
);
```

### תרגיל 2
```sql
CREATE TABLE books (
    id     SERIAL PRIMARY KEY,
    title  VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    year   INTEGER DEFAULT 2025
);
```

### תרגיל 3
`INTEGER` – סוג הנתונים בלבד, צריך להזין ערך ידנית. `SERIAL PRIMARY KEY` – מספר אוטומטי שעולה בכל שורה חדשה, ומשמש כמפתח ראשי ייחודי.

### תרגיל 4
```sql
CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date  DATE,
    status      VARCHAR(50) DEFAULT 'pending'
);
```

### תרגיל 5
`\d students` מציג את מבנה הטבלה: שם כל עמודה, טיפוס, האם מותר NULL, ברירת מחדל. עוזר להבין את הסכמה ללא צורך בקוד.

</details>
