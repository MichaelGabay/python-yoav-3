# שליפת נתונים מטבלה אחת

## מבנה שאילתה בסיסית

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column
LIMIT n;
```

## סדר הביצוע (לוגי)

1. `FROM` – בחירת הטבלה
2. `WHERE` – סינון שורות
3. `SELECT` – בחירת עמודות וביטויים
4. `ORDER BY` – מיון
5. `LIMIT` – הגבלת מספר שורות

## דוגמה – Northwind

```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 20
ORDER BY unit_price DESC
LIMIT 10;
```

## תרגילים (מסד Northwind)

### תרגיל 1
שלוף את `company_name`, `city`, `country` מטבלת `customers`. הצג 5 שורות ראשונות.

### תרגיל 2
שלוף מטבלת `products` את המוצרים שמחירם (`unit_price`) מעל 50. הצג `product_name` ו-`unit_price`, ממוין לפי מחיר יורד.

### תרגיל 3
שלוף מ-`customers` לקוחות ממדינה `'Germany'`. הצג `company_name`, `city`.

### תרגיל 4
שלוף מ-`products` את 10 המוצרים היקרים ביותר. השתמש ב-`ORDER BY` ו-`LIMIT`.

### תרגיל 5
שלוף מ-`products` את `product_name`, `unit_price` ו-`units_in_stock` למוצרים שיש במלאי פחות מ-20 יחידות.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT company_name, city, country
FROM customers
LIMIT 5;
```

### תרגיל 2
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC;
```

### תרגיל 3
```sql
SELECT company_name, city
FROM customers
WHERE country = 'Germany';
```

### תרגיל 4
```sql
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 10;
```

### תרגיל 5
```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE units_in_stock < 20;
```

</details>
