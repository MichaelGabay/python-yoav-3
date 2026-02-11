# חיבור שלוש טבלאות ומעלה

## עקרון

מחברים טבלאות אחת אחרי השנייה לפי מפתחות משותפים. כל JOIN מוסיף טבלה נוספת.

## דוגמה – 3 טבלאות

```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;
```

## סדר החיבור

הסדר יכול להשפיע על הביצועים, אבל לא על התוצאה הלוגית (ב-INNER JOIN). חשוב לוודא שכל טבלה מחוברת למשהו שכבר בשאילתה.

## תרגילים (Northwind)

### תרגיל 1
הצג `order_id`, `company_name`, `product_name`, `quantity` – חבר `orders`, `customers`, `order_details`, `products`.

### תרגיל 2
הצג `order_id`, `product_name`, `category_name` – חבר `orders`, `order_details`, `products`, `categories`.

### תרגיל 3
הצג `order_id`, `company_name`, `product_name`, `quantity`, `unit_price` – חבר 4 טבלאות. חשב גם `quantity * unit_price` בשם `line_total`.

### תרגיל 4
הצג הזמנות עם שם הלקוח, שם המוצר וכמות – רק למוצרים בקטגוריה 1.

### תרגיל 5
הצג `order_id`, `company_name`, `employee` (first_name + last_name), `order_date` – חבר `orders`, `customers`, `employees`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;
```

### תרגיל 2
```sql
SELECT o.order_id, p.product_name, c.category_name
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
INNER JOIN categories c ON p.category_id = c.category_id;
```

### תרגיל 3
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity, od.unit_price,
       od.quantity * od.unit_price AS line_total
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;
```

### תרגיל 4
```sql
SELECT o.order_id, c.company_name, p.product_name, od.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id
WHERE p.category_id = 1;
```

### תרגיל 5
```sql
SELECT o.order_id, c.company_name,
       e.first_name || ' ' || e.last_name AS employee,
       o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id;
```

</details>
