# ערכים ייחודיים – DISTINCT

## מטרה

להחזיר ערכים **בלי כפילויות** מתוך עמודה או צירוף עמודות.

## סינטקס

```sql
SELECT DISTINCT column1, column2 FROM table_name;
```

## דוגמה

```sql
SELECT DISTINCT country FROM customers;
-- מחזיר כל מדינה פעם אחת
```

## DISTINCT ON (PostgreSQL)

מחזיר שורה אחת **לכל קבוצת ערכים** של עמודות ה-ON:

```sql
SELECT DISTINCT ON (country) company_name, country, city
FROM customers
ORDER BY country, company_name;
-- שורה אחת לכל מדינה (לפי סדר company_name)
```

## תרגילים (Northwind)

### תרגיל 1
שלוף את כל המדינות הייחודיות מטבלת `customers`.

### תרגיל 2
שלוף צירופים ייחודיים של `city` ו-`country` מטבלת `customers`.

### תרגיל 3
שלוף את מספר הקטגוריות השונות (`category_id`) מטבלת `products`. השתמש ב-`COUNT(DISTINCT ...)`.

### תרגיל 4
שלוף 5 מדינות שונות ראשונות מטבלת `customers`, ממוינות לפי שם מדינה.

### תרגיל 5
השתמש ב-`DISTINCT ON` – שלוף מ-`customers` שורה אחת לכל עיר, כשהשורה היא הלקוח הראשון לפי `company_name`. הצג `company_name`, `city`, `country`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT DISTINCT country FROM customers;
```

### תרגיל 2
```sql
SELECT DISTINCT city, country FROM customers;
```

### תרגיל 3
```sql
SELECT COUNT(DISTINCT category_id) FROM products;
```

### תרגיל 4
```sql
SELECT DISTINCT country FROM customers ORDER BY country LIMIT 5;
```

### תרגיל 5
```sql
SELECT DISTINCT ON (city) company_name, city, country
FROM customers
ORDER BY city, company_name;
```

</details>
