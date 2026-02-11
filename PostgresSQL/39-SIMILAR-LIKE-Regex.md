# תבניות מחרוזות – LIKE, SIMILAR TO, regex (~)

## LIKE

- `%` – כל תו (כולל ריק)
- `_` – תו בודד אחד

```sql
WHERE product_name LIKE 'Ch%'    -- מתחיל ב-Ch
WHERE product_name LIKE '%tea%'  -- מכיל tea
WHERE product_name LIKE 'C_e'    -- C, תו אחד, e
```

## ILIKE (PostgreSQL)

כמו LIKE אבל **לא רגיש לרישיות**:

```sql
WHERE product_name ILIKE '%cheese%'
```

## SIMILAR TO (PostgreSQL)

תומך בתבניות דמויות regex:

- `%` – כמו ב-LIKE
- `_` – כמו ב-LIKE
- `[abc]` – אחד מהתווים
- `[a-z]` – טווח
- `*` – חזרה 0 או יותר
- `|` – או

```sql
WHERE product_name SIMILAR TO 'C%t'
WHERE phone SIMILAR TO '[0-9]{3}-[0-9]{4}'
```

## אופרטור ~ (regex)

```sql
WHERE product_name ~ '^Ch'       -- מתחיל ב-Ch
WHERE product_name ~* 'cheese'   -- מכיל cheese (לא רגיש רישיות)
WHERE product_name ~ '[0-9]+'    -- מכיל ספרות
```

- `~` – רגיש רישיות
- `~*` – לא רגיש רישיות

## תרגילים (Northwind)

### תרגיל 1
הצג מוצרים ששמם מתחיל ב-`'Ch'`. השתמש ב-LIKE.

### תרגיל 2
הצג מוצרים ששמם מכיל את המילה `'cheese'` (לא רגיש רישיות). השתמש ב-ILIKE.

### תרגיל 3
הצג לקוחות ש-`company_name` מסתיים ב-`'Ltd'` או `'Inc'`.

### תרגיל 4
הצג מוצרים ששמם בדיוק 4 תווים. השתמש ב-LIKE עם `_`.

### תרגיל 5
השתמש ב-regex (`~`) – הצג מוצרים ששמם מתחיל באות גדולה ואחריה אותיות קטנות.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT product_name FROM products WHERE product_name LIKE 'Ch%';
```

### תרגיל 2
```sql
SELECT product_name FROM products WHERE product_name ILIKE '%cheese%';
```

### תרגיל 3
```sql
SELECT company_name FROM customers
WHERE company_name LIKE '%Ltd' OR company_name LIKE '%Inc';
```

### תרגיל 4
```sql
SELECT product_name FROM products WHERE product_name LIKE '____';
```

### תרגיל 5
```sql
SELECT product_name FROM products WHERE product_name ~ '^[A-Z][a-z]+';
```

</details>
