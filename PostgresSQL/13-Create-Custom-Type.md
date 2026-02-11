# יצירת טיפוס מותאם (Custom Type)

## למה טיפוס מותאם?

כדי להגדיר מבנה נתונים משותף – למשל "כתובת" או "שם פרטי+משפחה" – ולהשתמש בו במספר טבלאות.

## סינטקס – טיפוס מורכב (Composite)

```sql
CREATE TYPE address_type AS (
    street  VARCHAR(100),
    city    VARCHAR(50),
    zip     VARCHAR(10)
);
```

## שימוש בטיפוס

```sql
CREATE TABLE companies (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100),
    address address_type
);
```

## הכנסת ערכים

```sql
INSERT INTO companies (name, address)
VALUES ('חברה א', ROW('רחוב הרצל 1', 'תל אביב', '12345')::address_type);
```

## או עם סינטקס סוגריים

```sql
INSERT INTO companies (name, address)
VALUES ('חברה א', ('רחוב הרצל 1', 'תל אביב', '12345'));
```

## גישה לשדות

```sql
SELECT name, (address).city FROM companies;
```

## טיפוס ENUM

```sql
CREATE TYPE order_status AS ENUM ('pending', 'approved', 'shipped', 'cancelled');

CREATE TABLE orders (
    id     SERIAL PRIMARY KEY,
    status order_status DEFAULT 'pending'
);
```

## תרגילים

### תרגיל 1
צור טיפוס `person_name` עם שדות: `first_name`, `last_name`. צור טבלה `employees` שמשתמשת בו בעמודה `full_name`.

### תרגיל 2
צור ENUM בשם `priority` עם ערכים: 'low', 'medium', 'high'. צור טבלת `tasks` עם עמודת `priority` מסוג זה.

### תרגיל 3
הוסף שורה ל-`companies` (מהדוגמה למעלה) עם כתובת מלאה.

### תרגיל 4
שלוף מטבלת `companies` את השם ואת העיר מתוך השדה `address`.

### תרגיל 5
מה היתרון ביצירת טיפוס `address_type` במקום להגדיר 3 עמודות נפרדות (`street`, `city`, `zip`) בכל טבלה?

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE TYPE person_name AS (first_name VARCHAR(50), last_name VARCHAR(50));

CREATE TABLE employees (
    id         SERIAL PRIMARY KEY,
    full_name  person_name
);
```

### תרגיל 2
```sql
CREATE TYPE priority AS ENUM ('low', 'medium', 'high');

CREATE TABLE tasks (
    id       SERIAL PRIMARY KEY,
    title    VARCHAR(200),
    priority priority DEFAULT 'medium'
);
```

### תרגיל 3
```sql
INSERT INTO companies (name, address)
VALUES ('חברה ב', ('רחוב ויצמן 10', 'חיפה', '34567'));
```

### תרגיל 4
```sql
SELECT name, (address).city FROM companies;
```

### תרגיל 5
שימוש חוזר: אותו מבנה במקומות רבים, שינוי במבנה נעשה במקום אחד, קריאות ועקביות טובה יותר.

</details>
