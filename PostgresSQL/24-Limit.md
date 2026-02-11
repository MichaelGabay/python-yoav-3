# הגבלת מספר שורות – LIMIT

## סינטקס

```sql
SELECT ... FROM ... LIMIT n;
```

מחזיר רק את **n** השורות הראשונות (לפי סדר הביצוע).

## LIMIT עם OFFSET

```sql
SELECT ... FROM ... ORDER BY col LIMIT 10 OFFSET 20;
```

מדלג על 20 שורות ומחזיר 10 הבאות – שימושי לדפדוף (pagination).

## סדר חשוב

`LIMIT` ו-`OFFSET` מופעלים **אחרי** `ORDER BY`, לכן חיוני ל-`ORDER BY` כשצריך תוצאה קבועה (למשל "10 המוצרים היקרים").

```sql
-- נכון:
SELECT * FROM products ORDER BY unit_price DESC LIMIT 5;

-- לא צפוי (ללא ORDER BY):
SELECT * FROM products LIMIT 5;  -- 5 שורות אקראיות
```

## תרגילים (Northwind)

### תרגיל 1
שלוף את 5 הלקוחות הראשונים מטבלת `customers` (לפי הסדר בטבלה).

### תרגיל 2
שלוף את 3 המוצרים היקרים ביותר מטבלת `products`. הצג `product_name`, `unit_price`.

### תרגיל 3
שלוף 10 מוצרים הזולים ביותר שמחירם מעל 10.

### תרגיל 4
שלוף מ-`customers` 5 לקוחות, מדלג על 10 הראשונים. מיין לפי `company_name`.

### תרגיל 5
שלוף 5 מוצרים שמחירם בין 20 ל-50, ממוינים לפי מחיר יורד. הצג `product_name`, `unit_price`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT * FROM customers LIMIT 5;
```

### תרגיל 2
```sql
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 3;
```

### תרגיל 3
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 10
ORDER BY unit_price ASC
LIMIT 10;
```

### תרגיל 4
```sql
SELECT company_name, city, country
FROM customers
ORDER BY company_name
LIMIT 5 OFFSET 10;
```

### תרגיל 5
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 20 AND 50
ORDER BY unit_price DESC
LIMIT 5;
```

</details>
