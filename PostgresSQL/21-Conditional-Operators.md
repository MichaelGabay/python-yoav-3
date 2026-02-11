# אופרטורים תנאיים

## אופרטורי השוואה

| אופרטור | משמעות |
|---------|--------|
| `=` | שווה |
| `<>` או `!=` | שונה מ- |
| `>` | גדול מ- |
| `<` | קטן מ- |
| `>=` | גדול או שווה |
| `<=` | קטן או שווה |

## אופרטורים מיוחדים

| אופרטור | משמעות | דוגמה |
|---------|--------|-------|
| `BETWEEN a AND b` | בטווח (כולל) | `unit_price BETWEEN 10 AND 50` |
| `IN (list)` | אחד מהערכים | `country IN ('UK','USA')` |
| `IS NULL` | null | `phone IS NULL` |
| `IS NOT NULL` | לא null | `email IS NOT NULL` |
| `LIKE pattern` | תבנית מחרוזת | `name LIKE 'A%'` |

## LIKE – תבניות

- `%` – כל תו (כולל ריק)
- `_` – תו בודד

```sql
WHERE product_name LIKE 'Ch%'   -- מתחיל ב-Ch
WHERE product_name LIKE '%tea%' -- מכיל tea
WHERE product_name LIKE 'C_e'   -- C, כל תו, e
```

## תרגילים (Northwind)

### תרגיל 1
שלוף מ-`products` מוצרים ששמם מתחיל ב-`'Ch'`. הצג `product_name`, `unit_price`.

### תרגיל 2
שלוף מ-`customers` לקוחות שעירם אינה `'Berlin'`.

### תרגיל 3
שלוף מ-`products` מוצרים שמחירם **לא** בין 20 ל-50.

### תרגיל 4
שלוף מ-`products` מוצרים ששמם מכיל את המילה `'Sauce'`. הצג `product_name`.

### תרגיל 5
שלוף מ-`customers` לקוחות ש-`fax` שלהם הוא `NULL`. הצג `company_name`, `fax`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name, unit_price
FROM products
WHERE product_name LIKE 'Ch%';
```

### תרגיל 2
```sql
SELECT company_name, city
FROM customers
WHERE city <> 'Berlin';
```

### תרגיל 3
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price NOT BETWEEN 20 AND 50;
```

### תרגיל 4
```sql
SELECT product_name
FROM products
WHERE product_name LIKE '%Sauce%';
```

### תרגיל 5
```sql
SELECT company_name, fax
FROM customers
WHERE fax IS NULL;
```

</details>
