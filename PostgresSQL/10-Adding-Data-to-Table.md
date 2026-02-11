# הוספת נתונים לטבלה

## סינטקס בסיסי

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

## דוגמה

```sql
INSERT INTO customers (id, name, email)
VALUES (1, 'אלפא בע"מ', 'alpha@example.com');
```

## הוספת מספר שורות

```sql
INSERT INTO products (name, price)
VALUES
    ('מחשב', 3500),
    ('מקלדת', 150),
    ('עכבר', 80);
```

## הוספה ללא ציון שמות עמודות

אם מציינים ערכים לכל העמודות לפי הסדר:

```sql
INSERT INTO customers
VALUES (1, 'בטא', 'beta@example.com');
```

## עמודות עם DEFAULT

אם יש ברירת מחדל – אפשר שלא לציין את העמודה:

```sql
INSERT INTO products (name, price)
VALUES ('מדפסת', 500);
-- in_stock יקבל 0 (DEFAULT), created_at את CURRENT_TIMESTAMP
```

## תרגילים

### תרגיל 1
לטבלה `students(id, name, grade)` הוסף שלושה תלמידים: יוסי (85), שרה (92), דוד (78).

### תרגיל 2
לטבלה `orders(order_id, customer_id, order_date)` הוסף הזמנה אחת. השתמש ב-`CURRENT_DATE` לתאריך.

### תרגיל 3
מה קורה כשהוספת שורה ללא ערך לעמודה עם `NOT NULL` וללא `DEFAULT`?

### תרגיל 4
הוסף שתי שורות לטבלה `products(name, price, in_stock)` בשורת `INSERT` אחת. `in_stock` יש DEFAULT 0.

### תרגיל 5
כתוב `INSERT` שמחזיר את ה-`id` של השורה שנוצרה (בטבלה עם SERIAL). חפש איך עושים זאת ב-PostgreSQL.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
INSERT INTO students (id, name, grade)
VALUES (1, 'יוסי', 85), (2, 'שרה', 92), (3, 'דוד', 78);
```

### תרגיל 2
```sql
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (1, 100, CURRENT_DATE);
```

### תרגיל 3
מתקבלת שגיאה: העמודה דורשת ערך ואין ברירת מחדל. ה-INSERT ייכשל.

### תרגיל 4
```sql
INSERT INTO products (name, price, in_stock)
VALUES ('מוצר א', 100, 10), ('מוצר ב', 200, 0);
-- או ללא in_stock (DEFAULT):
INSERT INTO products (name, price)
VALUES ('מוצר א', 100), ('מוצר ב', 200);
```

### תרגיל 5
```sql
INSERT INTO products (name, price)
VALUES ('מוצר חדש', 99)
RETURNING id;
```
`RETURNING` מחזיר את הערכים של השורה שנוספה.

</details>
