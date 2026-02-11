# תנאי WHERE

## מטרה

לסנן שורות לפי תנאי – רק שורות שמקיימות את התנאי יוחזרו.

## סינטקס

```sql
SELECT ... FROM table_name WHERE condition;
```

## תנאים פשוטים

```sql
WHERE country = 'Germany'
WHERE unit_price > 50
WHERE units_in_stock <= 10
WHERE product_name = 'Chai'
```

## תנאים מורכבים – AND, OR

```sql
WHERE country = 'Germany' AND city = 'Berlin'
WHERE unit_price > 20 OR units_in_stock = 0
WHERE (country = 'UK' OR country = 'USA') AND city IS NOT NULL
```

## BETWEEN, IN

```sql
WHERE unit_price BETWEEN 10 AND 50
WHERE country IN ('UK', 'USA', 'Germany')
```

## תרגילים (Northwind)

### תרגיל 1
שלוף מ-`customers` את הלקוחות שמדינתם `'France'`. הצג `company_name`, `city`, `country`.

### תרגיל 2
שלוף מ-`products` מוצרים שמחירם בין 15 ל-30 (כולל). הצג `product_name`, `unit_price`.

### תרגיל 3
שלוף מ-`customers` לקוחות שנמצאים ב-`'UK'` או ב-`'USA'`. הצג `company_name`, `country`.

### תרגיל 4
שלוף מ-`products` מוצרים שמחירם מעל 25 **וגם** שיש במלאי מעל 10 יחידות.

### תרגיל 5
שלוף מ-`products` מוצרים שמחירם קטן מ-10 **או** גדול מ-100. הצג `product_name`, `unit_price`, ממוין לפי מחיר.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT company_name, city, country
FROM customers
WHERE country = 'France';
```

### תרגיל 2
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 15 AND 30;
```

### תרגיל 3
```sql
SELECT company_name, country
FROM customers
WHERE country IN ('UK', 'USA');
```

### תרגיל 4
```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price > 25 AND units_in_stock > 10;
```

### תרגיל 5
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price < 10 OR unit_price > 100
ORDER BY unit_price;
```

</details>
