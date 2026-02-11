# אופרטורים לוגיים

## AND, OR, NOT

| אופרטור | משמעות |
|---------|--------|
| `AND` | שני התנאים חייבים להתקיים |
| `OR` | לפחות תנאי אחד מתקיים |
| `NOT` | שלילת התנאי |

## דוגמאות

```sql
WHERE country = 'Germany' AND city = 'Berlin'
WHERE unit_price > 50 OR units_in_stock = 0
WHERE NOT (country = 'USA')
WHERE country <> 'USA'  -- שקול ל-NOT (country = 'USA')
```

## סדר עדיפות

`NOT` > `AND` > `OR`

כדי לשנות סדר – להשתמש בסוגריים:

```sql
WHERE (country = 'UK' OR country = 'USA') AND units_in_stock > 0
```

## תרגילים (Northwind)

### תרגיל 1
שלוף מ-`products` מוצרים שמחירם מעל 20 **וגם** יש במלאי לפחות 5 יחידות.

### תרגיל 2
שלוף מ-`customers` לקוחות שנמצאים ב-`'Germany'` **או** ב-`'France'`.

### תרגיל 3
שלוף מ-`products` מוצרים שמחירם קטן מ-15 **או** גדול מ-50. הצג `product_name`, `unit_price`.

### תרגיל 4
שלוף מ-`customers` לקוחות שלא נמצאים ב-`'USA'`. הצג `company_name`, `country`.

### תרגיל 5
שלוף מ-`products` מוצרים שמחירם בין 10 ל-30 **וגם** ששמם מכיל `'Cheese'`, **או** שמחירם מעל 100. הצג `product_name`, `unit_price`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price > 20 AND units_in_stock >= 5;
```

### תרגיל 2
```sql
SELECT company_name, country
FROM customers
WHERE country IN ('Germany', 'France');
```

### תרגיל 3
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price < 15 OR unit_price > 50;
```

### תרגיל 4
```sql
SELECT company_name, country
FROM customers
WHERE country <> 'USA';
```

### תרגיל 5
```sql
SELECT product_name, unit_price
FROM products
WHERE (unit_price BETWEEN 10 AND 30 AND product_name LIKE '%Cheese%')
   OR unit_price > 100;
```

</details>
