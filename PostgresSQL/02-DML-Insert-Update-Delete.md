# 02 – הוספה, עדכון ומחיקה (DML)

DML = Data Manipulation Language. נלמד להוסיף שורות עם `INSERT`, לעדכן עם `UPDATE` ולמחוק עם `DELETE`.

---

## מטרה

- להכניס נתונים עם INSERT (ערכים ישירים או מתוך SELECT)
- לעדכן שורות קיימות עם UPDATE
- למחוק שורות עם DELETE

---

## INSERT – הוספת שורות

### דוגמה 1: הוספת שורה אחת עם כל העמודות

```sql
-- code| הוספת שורה אחת לטבלת customers (Northwind)
INSERT INTO customers (
    customer_id, company_name, contact_name, contact_title,
    address, city, region, postal_code, country, phone, fax
) VALUES (
    'NEW01', 'חברת הדגמה', 'ישראל ישראלי', 'מנהל',
    'רחוב הדגמה 1', 'תל אביב', NULL, '12345', 'Israel', '03-1234567', NULL
);
```

הסדר ב-`VALUES` חייב להתאים לסדר העמודות ב-`INSERT INTO`.

---

### דוגמה 2: הוספת שורה עם חלק מהעמודות

```sql
-- code| INSERT רק לעמודות שציינו – השאר NULL או DEFAULT
INSERT INTO products (product_name, category_id, unit_price)
VALUES ('מוצר חדש', 1, 25.50);
```

עמודות שלא צוינו יקבלו NULL או ערך DEFAULT (אם הוגדר).

---

### דוגמה 3: הוספת כמה שורות בפקודה אחת

```sql
-- code| הוספת מספר שורות ב-INSERT אחד
INSERT INTO categories (category_name, description)
VALUES
    ('קטגוריה א', 'תיאור א'),
    ('קטגוריה ב', 'תיאור ב'),
    ('קטגוריה ג', 'תיאור ג');
```

---

### דוגמה 4: INSERT מתוך שאילתת SELECT

```sql
-- code| הוספת שורות מתוך תוצאה של SELECT (דוגמה: טבלת גיבוי)
INSERT INTO customers_backup (customer_id, company_name, city, country)
SELECT customer_id, company_name, city, country
FROM customers
WHERE country = 'UK';
```

(מניחים שקיימת טבלה `customers_backup` עם העמודות המתאימות.)

---

## UPDATE – עדכון שורות

### דוגמה 1: עדכון לפי תנאי

```sql
-- code| עדכון שדה אחת או יותר לפי WHERE
UPDATE products
SET unit_price = 30.00, discontinued = 0
WHERE product_id = 1;
```

בלי `WHERE` – כל השורות בטבלה מתעדכנות (זהירות).

---

### דוגמה 2: עדכון עם חישוב

```sql
-- code| עדכון מחיר בהנחה של 10%
UPDATE products
SET unit_price = unit_price * 0.9
WHERE category_id = 2;
```

---

### דוגמה 3: עדכון לפי תת-שאילתה (טעימה)

```sql
-- code| עדכון לפי ערך שמגיע משאילתה אחרת
UPDATE order_details
SET discount = 0.05
WHERE product_id IN (SELECT product_id FROM products WHERE category_id = 1);
```

---

## DELETE – מחיקת שורות

### דוגמה 1: מחיקה לפי תנאי

```sql
-- code| מחיקת שורות לפי WHERE
DELETE FROM order_details
WHERE order_id = 10248;
```

רק שורות שעונות על התנאי נמחקות.

---

### דוגמה 2: מחיקת כל השורות (ריקון הטבלה)

```sql
-- code| מחיקת כל השורות בטבלה – המבנה נשאר
DELETE FROM customers_backup;
```

הטבלה נשארת, בלי שורות. אלטרנטיבה מהירה: `TRUNCATE TABLE customers_backup;`

---

### דוגמה 3: מחיקה עם תת-שאילתה

```sql
-- code| מחיקת שורות לפי תוצאה של SELECT
DELETE FROM orders
WHERE customer_id IN (
    SELECT customer_id FROM customers WHERE country = 'USA'
);
```

(במסד Northwind אמיתי עדיף לא להריץ זאת כדי לא לאבד נתונים – השתמש בטבלת עותק לתרגול.)

---

## סדר ביצוע מומלץ (בטבלאות עם קשרים)

כשמוחקים או מעדכנים טבלאות עם מפתחות זרים:

1. למחוק/לעדכן קודם את הטבלאות התלויות (למשל `order_details`) ואז את `orders`.
2. או להגדיר ON DELETE CASCADE / ON UPDATE CASCADE ב-Foreign Key (נלמד ב-DDL מתקדם).

---

## תרגיל

1. **INSERT:** הוסף קטגוריה חדשה ל-`categories` (שם ותיאור לבחירתך).
2. **UPDATE:** עדכן את ה-`contact_title` של לקוח אחד ב-`customers` ל-'Senior Manager'.
3. **DELETE:** צור טבלה זמנית `test_orders` עם `SELECT * INTO test_orders FROM orders LIMIT 0;` (או CREATE TABLE ... AS עם WHERE false), הוסף שורה אחת, ואז מחק רק את השורה שהוספת.
4. **INSERT ... SELECT:** צור טבלה `uk_customers` עם אותם עמודות כמו ב-`customers`, והכנס אליה רק לקוחות מ-UK מתוך `customers`.
