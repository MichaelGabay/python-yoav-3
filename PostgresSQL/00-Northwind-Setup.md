# 00 – טעינת מסד Northwind

מסד Northwind הוא מסד נתונים לדוגמה של חברת סחר. בקובץ זה: איך ליצור את המסד ולטעון את הנתונים, ורשימת הטבלאות הרלוונטיות לקורס.

---

## יצירת מסד הנתונים

לפני טעינת הסקריפט, צור מסד נתונים חדש בשם `northwind`:

```sql
-- code| יצירת מסד נתונים northwind
CREATE DATABASE northwind;
```

ב-Beekeeper Studio (או pgAdmin): התחבר לשרת, ימני על Databases → Create database, והזן את השם `northwind`. לאחר מכן בחר את המסד `northwind` לפני הרצת הסקריפט.

---

## טעינת סקריפט Northwind ל-PostgreSQL

קיימים סקריפטים מוכנים ל-PostgreSQL:

1. **pthom/northwind_psql** – קובץ `northwind.sql`:  
   [https://github.com/pthom/northwind_psql](https://github.com/pthom/northwind_psql)  
   הורד את `northwind.sql` והרץ אותו במסד `northwind`.

2. **הרצה ב-Beekeeper Studio:**  
   File → Open SQL File → בחר את `northwind.sql` → Run.

3. **הרצה משורת הפקודה:**

```bash
# code| הרצת סקריפט northwind.sql על המסד northwind
psql -U postgres -d northwind -f northwind.sql
```

(התאם את שם המשתמש והנתיב לקובץ לפי המחשב שלך.)

---

## טבלאות עיקריות במסד Northwind

| טבלה | תיאור |
|------|--------|
| **categories** | קטגוריות מוצרים (מזון, משקאות וכו') |
| **customers** | לקוחות (company_name, contact_name, city, country) |
| **employees** | עובדים (first_name, last_name, title, reports_to) |
| **orders** | הזמנות (order_date, customer_id, employee_id, ship_country) |
| **order_details** | פרטי הזמנה – מוצרים בהזמנה (order_id, product_id, quantity, unit_price) |
| **products** | מוצרים (product_name, category_id, supplier_id, unit_price) |
| **shippers** | חברות משלוחים |
| **suppliers** | ספקים |

---

## קשרים בין טבלאות (בקצרה)

- `orders.customer_id` → `customers.customer_id`
- `orders.employee_id` → `employees.employee_id`
- `orders.ship_via` → `shippers.shipper_id`
- `order_details.order_id` → `orders.order_id`
- `order_details.product_id` → `products.product_id`
- `products.category_id` → `categories.category_id`
- `products.supplier_id` → `suppliers.supplier_id`
- `employees.reports_to` → `employees.employee_id` (Self-Join)

---

## בדיקה שהמסד נטען

לאחר הרצת הסקריפט, הרץ:

```sql
-- code| בדיקה שטבלאות Northwind קיימות
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

אמור להופיע רשימת טבלאות כולל `customers`, `orders`, `products` ועוד.

---

## תרגיל קצר

1. הרץ את השאילתה למעלה וודא שכל הטבלאות קיימות.
2. הרץ `SELECT * FROM customers LIMIT 5;` וודא שיש נתונים.
