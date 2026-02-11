# בדיקת ערכי NULL

## מהו NULL?

`NULL` מסמן "אין ערך" או "לא ידוע". הוא שונה מכל ערך אחר, כולל מחרוזת ריקה `''`.

## בדיקה ל-NULL

```sql
WHERE column IS NULL
WHERE column IS NOT NULL
```

## שים לב

- `column = NULL` **לא** עובד – התוצאה תמיד NULL (unknown)
- חייבים `IS NULL` או `IS NOT NULL`

## COALESCE – ערך חלופי

```sql
SELECT COALESCE(phone, 'לא צוין') AS phone FROM customers;
-- אם phone הוא NULL, יחזיר 'לא צוין'
```

## תרגילים (Northwind)

### תרגיל 1
הצג לקוחות ש-`region` שלהם הוא NULL. הצג `company_name`, `region`.

### תרגיל 2
הצג לקוחות ש-`fax` שלהם אינו NULL.

### תרגיל 3
הצג `company_name`, `region` – השתמש ב-COALESCE כדי להציג 'לא צוין' כש-region הוא NULL.

### תרגיל 4
ספור כמה לקוחות יש עם `region` NULL וכמה עם `region` לא NULL.

### תרגיל 5
הצג `product_name`, `units_in_stock` – רק למוצרים ש-`units_on_order` הוא NULL או 0.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT company_name, region
FROM customers
WHERE region IS NULL;
```

### תרגיל 2
```sql
SELECT company_name, fax
FROM customers
WHERE fax IS NOT NULL;
```

### תרגיל 3
```sql
SELECT company_name, COALESCE(region, 'לא צוין') AS region
FROM customers;
```

### תרגיל 4
```sql
SELECT
  COUNT(*) FILTER (WHERE region IS NULL) AS with_null_region,
  COUNT(*) FILTER (WHERE region IS NOT NULL) AS with_region
FROM customers;
-- או:
SELECT
  SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS null_region,
  SUM(CASE WHEN region IS NOT NULL THEN 1 ELSE 0 END) AS has_region
FROM customers;
```

### תרגיל 5
```sql
SELECT product_name, units_in_stock
FROM products
WHERE units_on_order IS NULL OR units_on_order = 0;
```

</details>
