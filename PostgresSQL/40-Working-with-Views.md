# עבודה עם תצוגות – Views

## מהי תצוגה?

**View** היא שאילתה שנשמרת בשם – כמו "טבלה וירטואלית". כששולפים ממנה, השאילתה רצה ברקע.

## יצירת תצוגה

```sql
CREATE VIEW view_name AS
SELECT column1, column2 FROM table_name WHERE condition;
```

## דוגמה

```sql
CREATE VIEW expensive_products AS
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > 50;
```

## שימוש

```sql
SELECT * FROM expensive_products;
```

## עדכון תצוגה

```sql
CREATE OR REPLACE VIEW expensive_products AS
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > 60;
```

## מחיקת תצוגה

```sql
DROP VIEW view_name;
```

## תרגילים (Northwind)

### תרגיל 1
צור תצוגה `german_customers` שמציגה לקוחות ממדינה Germany. הצג `company_name`, `city`, `country`.

### תרגיל 2
צור תצוגה `order_summary` שמציגה `order_id`, `company_name`, `order_date` מחיבור orders ו-customers.

### תרגיל 3
צור תצוגה `products_with_category` שמציגה `product_name`, `category_name`, `unit_price`.

### תרגיל 4
צור תצוגה `top_products` – מוצרים שמחירם מעל 40, ממוינים לפי מחיר יורד.

### תרגיל 5
צור תצוגה `monthly_orders` שמציגה שנה, חודש ומספר הזמנות. השתמש ב-GROUP BY ו-EXTRACT.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE VIEW german_customers AS
SELECT company_name, city, country
FROM customers
WHERE country = 'Germany';
```

### תרגיל 2
```sql
CREATE VIEW order_summary AS
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
```

### תרגיל 3
```sql
CREATE VIEW products_with_category AS
SELECT p.product_name, c.category_name, p.unit_price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;
```

### תרגיל 4
```sql
CREATE VIEW top_products AS
SELECT product_name, unit_price
FROM products
WHERE unit_price > 40
ORDER BY unit_price DESC;
```

### תרגיל 5
```sql
CREATE VIEW monthly_orders AS
SELECT EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(MONTH FROM order_date) AS month,
       COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);
```

</details>
