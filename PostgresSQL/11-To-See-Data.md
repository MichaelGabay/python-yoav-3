# צפייה בנתונים

## SELECT – פקודת הבסיס

```sql
SELECT * FROM table_name;
```

`*` = כל העמודות.

## צפייה בעמודות מסוימות

```sql
SELECT column1, column2 FROM table_name;
```

## כינוי (Alias)

```sql
SELECT name AS customer_name, city AS customer_city
FROM customers;
```

## צפייה במבנה הטבלה (psql)

```sql
\d table_name
```

## צפייה ברשימת טבלאות

```sql
\dt
```

## כלים גרפיים

ב-Beekeeper Studio ו-pgAdmin: לחיצה על טבלה מציגה את הנתונים, או הרצת `SELECT * FROM table_name` בחלון השאילתות.

## תרגילים

### תרגיל 1
שלוף את כל העמודות מטבלת `products`. מה מתקבל?

### תרגיל 2
שלוף רק את העמודות `product_name` ו-`unit_price` מטבלת `products` (Northwind).

### תרגיל 3
שלוף את `company_name` ו-`country` מ-`customers` עם כינויים: `חברה` ו-`מדינה`.

### תרגיל 4
הרץ `\dt` – מה הפלט? מה המידע שמוצג?

### תרגיל 5
שלוף את כל השורות מטבלה חדשה שיצרת. הוסף כינוי לעמודה אחת והסבר למה זה שימושי.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT * FROM products;
```
מתקבלות כל השורות וכל העמודות של הטבלה.

### תרגיל 2
```sql
SELECT product_name, unit_price FROM products;
```

### תרגיל 3
```sql
SELECT company_name AS חברה, country AS מדינה
FROM customers;
```

### תרגיל 4
`\dt` מציג את רשימת הטבלאות במסד (schema, שם טבלה, סוג). עוזר לראות אילו טבלאות קיימות.

### תרגיל 5
דוגמה:
```sql
SELECT id, name AS product_name FROM my_products;
```
כינויים שימושיים כשהשם באנגלית ונרצה כותרת מובנת, או כשמחשבים ערך (למשל `SUM(x) AS total`).

</details>
