# מפתחות ראשיים וזרים

## מפתח ראשי (Primary Key)

- מזהה **ייחודי** לכל שורה
- לא יכול להיות `NULL`
- טבלה יכולה לקבל מפתח ראשי אחד (אחד או צירוף עמודות)

```sql
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
```

## מפתח זר (Foreign Key)

- עמודה שמפנה למפתח ראשי **בטבלה אחרת**
- מוודא שהערך קיים בטבלה המקושרת
- יוצר קשר לוגי בין טבלאות

```sql
CREATE TABLE orders (
    id          SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date  DATE
);
```

## יתרונות

- **עקביות** – אי אפשר להפנות ללקוח שלא קיים
- **נרמליזציה** – הימנעות מכפילויות
- **שאילתות** – JOIN בין טבלאות

## ON DELETE

```sql
customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE
-- כשמוחקים לקוח – מוחקים גם את ההזמנות שלו
```

אפשרויות: `CASCADE`, `SET NULL`, `RESTRICT` (ברירת מחדל), `NO ACTION`.

## תרגילים

### תרגיל 1
צור טבלת `departments` עם `id` כמפתח ראשי, וטבלת `employees` עם `department_id` כמפתח זר ל-`departments`.

### תרגיל 2
מה קורה כשמנסים להוסיף שורת `orders` עם `customer_id` שלא קיים ב-`customers`?

### תרגיל 3
מה ההבדל בין `ON DELETE CASCADE` ל-`ON DELETE SET NULL`? תן דוגמה לשימוש.

### תרגיל 4
האם מפתח ראשי חייב להיות עמודה אחת? הסבר ומצא דוגמה למפתח מרובה עמודות.

### תרגיל 5
צור טבלאות: `products`, `order_items`. `order_items` מקשרת הזמנות למוצרים עם `quantity`. הגדר מפתחות ראשיים וזרים.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE TABLE departments (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employees (
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(100),
    department_id INTEGER REFERENCES departments(id)
);
```

### תרגיל 2
מתקבלת שגיאה – הפרת Foreign Key. PostgreSQL לא יאפשר ערך שלא קיים בטבלה המקושרת.

### תרגיל 3
**CASCADE** – מחיקת השורה המקושרת מוחקת גם את השורות שמפנות אליה. **SET NULL** – במקום מחיקה, הערך במפתח הזר יהפוך ל-NULL. CASCADE טוב ל"שייכים רק לזה"; SET NULL כשהקישור אופציונלי.

### תרגיל 4
מפתח ראשי יכול להיות מורכב ממספר עמודות. דוגמה: `order_items` – `(order_id, product_id)` כמפתח ראשי, כי צירוף הזמנה+מוצר ייחודי.

### תרגיל 5
```sql
CREATE TABLE products (id SERIAL PRIMARY KEY, name VARCHAR(100), price DECIMAL(10,2));

CREATE TABLE order_items (
    order_id   INTEGER,
    product_id INTEGER REFERENCES products(id),
    quantity   INTEGER,
    PRIMARY KEY (order_id, product_id)
);
-- נדרש גם orders עם order_id – נניח קיים
```

</details>
