# שינוי טיפוס עמודה

## ALTER TABLE – שינוי טיפוס

```sql
ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_type;
```

## דוגמאות

### VARCHAR קצר ל-TEXT
```sql
ALTER TABLE products
ALTER COLUMN description TYPE TEXT;
```

### INTEGER ל-BIGINT
```sql
ALTER TABLE orders
ALTER COLUMN total_amount TYPE BIGINT;
```

### המרה מפורשת (כשצריך)
```sql
ALTER TABLE products
ALTER COLUMN price TYPE DECIMAL(10,2) USING price::DECIMAL(10,2);
```

## USING – כשהמרה אוטומטית אינה אפשרית

PostgreSQL דורש `USING` כשההמרה לא ברורה מאליה:

```sql
ALTER TABLE logs
ALTER COLUMN id TYPE UUID USING id::TEXT::UUID;
```

## הוספת ערך ברירת מחדל

```sql
ALTER TABLE products
ALTER COLUMN in_stock SET DEFAULT 0;
```

## תרגילים

### תרגיל 1
שְנה את טיפוס העמודה `name` בטבלה `customers` מ-`VARCHAR(50)` ל-`VARCHAR(200)`.

### תרגיל 2
שְנה את `price` מ-`INTEGER` ל-`DECIMAL(10,2)`. השתמש ב-USING אם נדרש.

### תרגיל 3
מה עלול לקרות כשמשנים טיפוס מ-`VARCHAR(100)` ל-`VARCHAR(10)` וקיימות מחרוזות ארוכות?

### תרגיל 4
הוסף ברירת מחדל 0 לעמודה `quantity` בטבלה `order_items`.

### תרגיל 5
שְנה את עמודת `created_at` מ-`TIMESTAMP` ל-`TIMESTAMPTZ`. האם נדרש USING? הסבר.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
ALTER TABLE customers
ALTER COLUMN name TYPE VARCHAR(200);
```

### תרגיל 2
```sql
ALTER TABLE products
ALTER COLUMN price TYPE DECIMAL(10,2) USING price::DECIMAL(10,2);
```

### תרגיל 3
המרה עלולה להיכשל – מחרוזות ארוכות מ-10 תווים יגרמו לשגיאה. יש לקצר אותן קודם או לבחור אורך גדול יותר.

### תרגיל 4
```sql
ALTER TABLE order_items
ALTER COLUMN quantity SET DEFAULT 0;
```

### תרגיל 5
בדרך כלל לא נדרש USING – PostgreSQL יודע להמיר TIMESTAMP ל-TIMESTAMPTZ (יחשב שהערך באזור הזמן המקומי). אם צריך שליטה מלאה אפשר: `USING created_at AT TIME ZONE 'UTC'`.

</details>
