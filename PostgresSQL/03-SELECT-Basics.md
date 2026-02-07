# 03 – SELECT בסיסי

נלמד לשלוף נתונים עם `SELECT`: בחירת עמודות, סינון עם `WHERE`, מיון עם `ORDER BY`, הגבלת מספר שורות עם `LIMIT`, והסרת כפילויות עם `DISTINCT`.

---

## מטרה

- לכתוב SELECT עם FROM, WHERE, ORDER BY, LIMIT, DISTINCT
- להשתמש באופרטורים: AND, OR, IN, BETWEEN, LIKE
- לסנן ולמיין נתונים על Northwind

---

## SELECT ו-FROM

### דוגמה 1: שליפת כל העמודות

```sql
-- code| שליפת כל הלקוחות ממסד Northwind
SELECT * FROM customers;
```

`*` = כל העמודות מהטבלה.

---

### דוגמה 2: שליפת עמודות ספציפיות

```sql
-- code| שליפת שם חברה, עיר ומדינה בלבד
SELECT company_name, city, country
FROM customers;
```

---

### דוגמה 3: כינוי לעמודה (Alias)

```sql
-- code| כינוי לעמודה בתוצאה
SELECT product_name AS name, unit_price AS price
FROM products;
```

או בלי `AS`:

```sql
-- code| כינוי בלי AS
SELECT product_name name, unit_price price
FROM products;
```

---

## WHERE – סינון שורות

### דוגמה 1: תנאי פשוט

```sql
-- code| לקוחות מגרמניה
SELECT company_name, city
FROM customers
WHERE country = 'Germany';
```

---

### דוגמה 2: AND ו-OR

```sql
-- code| AND – שני התנאים חייבים להתקיים
SELECT * FROM products
WHERE category_id = 1 AND unit_price > 20;

-- code| OR – לפחות תנאי אחד
SELECT * FROM customers
WHERE country = 'UK' OR country = 'USA';
```

---

### דוגמה 3: IN – שייכות לרשימה

```sql
-- code| IN – ערך שווה לאחד מהערכים ברשימה
SELECT * FROM customers
WHERE country IN ('UK', 'USA', 'Germany');
```

---

### דוגמה 4: BETWEEN – טווח

```sql
-- code| BETWEEN – מחיר בטווח (כולל הקצוות)
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 50;
```

שווה ערך ל-`unit_price >= 10 AND unit_price <= 50`.

---

### דוגמה 5: LIKE – התאמת מחרוזת

```sql
-- code| LIKE – שם מוצר שמתחיל ב-Ch
SELECT product_name FROM products
WHERE product_name LIKE 'Ch%';

-- code| LIKE – שם שמכיל 'cheese' (לא תלוי רישיות ב-PostgreSQL)
SELECT product_name FROM products
WHERE product_name ILIKE '%cheese%';
```

- `%` = כל רצף תווים (כולל ריק).
- `_` = תו אחד.
- `ILIKE` ב-PostgreSQL = LIKE לא תלוי רישיות.

---

### דוגמה 6: NULL

```sql
-- code| שורות שבהן region לא NULL
SELECT company_name, region FROM customers
WHERE region IS NOT NULL;

-- code| שורות שבהן region הוא NULL
SELECT company_name, region FROM customers
WHERE region IS NULL;
```

לא משתמשים ב-`= NULL` אלא ב-`IS NULL` / `IS NOT NULL`.

---

## ORDER BY – מיון

### דוגמה 1: מיון עולה ויורד

```sql
-- code| מיון לפי מחיר עולה (ברירת מחדל)
SELECT product_name, unit_price
FROM products
ORDER BY unit_price;

-- code| מיון לפי מחיר יורד (DESC)
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;
```

---

### דוגמה 2: מיון לפי כמה עמודות

```sql
-- code| מיון לפי מדינה ואז לפי שם חברה
SELECT company_name, city, country
FROM customers
ORDER BY country, company_name;
```

---

### דוגמה 3: מיון לפי מספר עמודה

```sql
-- code| מיון לפי העמודה השנייה בתוצאה
SELECT product_name, unit_price FROM products
ORDER BY 2 DESC;
```

(2 = העמודה השנייה, `unit_price`.)

---

## LIMIT ו-OFFSET

### דוגמה 1: הגבלת מספר שורות

```sql
-- code| 10 המוצרים הראשונים לפי המחיר
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;
```

---

### דוגמה 2: דילוג ו־LIMIT (דפדוף)

```sql
-- code| שורות 11–20 (דילוג על 10, אז 10 הבאות)
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
OFFSET 10 LIMIT 10;
```

---

## DISTINCT – הסרת כפילויות

### דוגמה 1: ערכים ייחודיים

```sql
-- code| רשימת מדינות ייחודית של לקוחות
SELECT DISTINCT country FROM customers
ORDER BY country;
```

---

### דוגמה 2: DISTINCT על כמה עמודות

```sql
-- code| צירופים ייחודיים של עיר ומדינה
SELECT DISTINCT city, country FROM customers
ORDER BY country, city;
```

---

## שילוב: WHERE, ORDER BY, LIMIT

```sql
-- code| 5 המוצרים היקרים ביותר בקטגוריה 1
SELECT product_name, unit_price
FROM products
WHERE category_id = 1
ORDER BY unit_price DESC
LIMIT 5;
```

---

## תרגיל

1. שלוף את כל שמות המוצרים והמחירים מ-`products` שמחירם מעל 30, ממוינים לפי מחיר יורד.
2. שלוף לקוחות מ-`customers` שנמצאים ב-`city` שמכיל את האות 'a' (השתמש ב-LIKE או ILIKE).
3. שלוף 3 ההזמנות הראשונות מ-`orders` (לפי `order_id`), עם `order_id`, `order_date`, `customer_id`.
4. שלוף רשימת מדינות ייחודית מ-`customers` עם `DISTINCT`, ממוינת לפי שם המדינה.
5. שלוף מוצרים מ-`products` שמחירם בין 15 ל-25 (כולל), עם `product_name` ו-`unit_price`, ממוינים לפי מחיר.
