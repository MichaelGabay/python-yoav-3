# שליפת נתונים ממספר טבלאות

## מטרה

לשלב נתונים מטבלאות שונות לפי קשר לוגי – בדרך כלל מפתח זר שמקשר ביניהן.

## דרכים לשלב טבלאות

1. **JOIN** – חיבור לפי תנאי (שדות תואמים)
2. **UNION** – איחוד תוצאות משאילתות עם אותו מבנה עמודות

## סוגי JOIN

| סוג | תיאור |
|-----|--------|
| INNER JOIN | רק שורות שיש התאמה בשתי הטבלאות |
| LEFT JOIN | כל השורות משמאל + התאמות מימין |
| RIGHT JOIN | כל השורות מימין + התאמות משמאל |
| FULL OUTER JOIN | כל השורות משתי הטבלאות |
| CROSS JOIN | מכפלה קרטזית (כל שורה עם כל שורה) |

## דוגמה – Northwind

```sql
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
```

## תרגילים (Northwind)

### תרגיל 1
הצג `order_id`, `company_name`, `order_date` – חבר את `orders` ל-`customers` לפי `customer_id`.

### תרגיל 2
הצג `product_name`, `quantity`, `order_id` – חבר את `order_details` ל-`products` לפי `product_id`.

### תרגיל 3
הצג `order_id`, `product_name`, `unit_price`, `quantity` – חבר `order_details` ל-`products`.

### תרגיל 4
הצג `company_name`, `order_id`, `order_date` – חבר `customers` ל-`orders`. הצג רק הזמנות מ-1997.

### תרגיל 5
הצג `order_id`, `company_name`, `product_name`, `quantity` – חבר 3 טבלאות: `orders`, `customers`, `order_details`, `products`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT o.order_id, c.company_name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
```

### תרגיל 2
```sql
SELECT od.order_id, p.product_name, od.quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id;
```

### תרגיל 3
```sql
SELECT od.order_id, p.product_name, od.unit_price, od.quantity
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id;
```

### תרגיל 4
```sql
SELECT c.company_name, o.order_id, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '1997-01-01' AND o.order_date < '1998-01-01';
```

### תרגיל 5
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;
```

</details>
