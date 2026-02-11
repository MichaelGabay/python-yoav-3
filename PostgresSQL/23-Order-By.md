# מיון תוצאות – ORDER BY

## סינטקס

```sql
SELECT ... FROM ... ORDER BY column [ASC | DESC];
```

- `ASC` – עולה (ברירת מחדל)
- `DESC` – יורד

## מיון לפי כמה עמודות

```sql
ORDER BY country ASC, company_name ASC;
```

קודם לפי מדינה, ואז לפי שם חברה.

## מיון לפי מספר עמודה

```sql
SELECT product_name, unit_price FROM products ORDER BY 2 DESC;
-- 2 = העמודה השנייה (unit_price)
```

## NULL

ב-PostgreSQL: `NULL` נחשב "גדול" – בסוף ב-ASC, בתחילה ב-DESC. אפשר לשלוט עם `NULLS FIRST` / `NULLS LAST`.

```sql
ORDER BY phone NULLS LAST;
```

## תרגילים (Northwind)

### תרגיל 1
שלוף מ-`products` את `product_name`, `unit_price`. מיין לפי מחיר **יורד**.

### תרגיל 2
שלוף מ-`customers` את `company_name`, `city`, `country`. מיין לפי מדינה ואז לפי שם חברה.

### תרגיל 3
שלוף מ-`products` את 5 המוצרים הזולים ביותר. השתמש ב-`ORDER BY` ו-`LIMIT`.

### תרגיל 4
שלוף מ-`products` מוצרים שמחירם מעל 30. הצג `product_name`, `unit_price` ממוין לפי מחיר עולה.

### תרגיל 5
שלוף מ-`customers` את `company_name`, `city`, `country` ללקוחות מ-`'Germany'`. מיין לפי עיר יורד ואז לפי שם חברה עולה.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;
```

### תרגיל 2
```sql
SELECT company_name, city, country
FROM customers
ORDER BY country, company_name;
```

### תרגיל 3
```sql
SELECT product_name, unit_price
FROM products
ORDER BY unit_price ASC
LIMIT 5;
```

### תרגיל 4
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 30
ORDER BY unit_price ASC;
```

### תרגיל 5
```sql
SELECT company_name, city, country
FROM customers
WHERE country = 'Germany'
ORDER BY city DESC, company_name ASC;
```

</details>
