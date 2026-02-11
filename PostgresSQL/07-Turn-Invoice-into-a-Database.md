# המרת חשבונית למסד נתונים

## מטרה

להפוך מסמך חשבונית (נייר או PDF) למבנה טבלאות מסודר במסד נתונים.

## דוגמת חשבונית

```
חשבונית מס' 1001
תאריך: 01/02/2025
לקוח: חברת אלפא בע"מ, ת"ד 123, תל אביב

פריט           | כמות | מחיר ליח' | סכום
מחשב נייד      | 2    | 3500      | 7000
מקלדת          | 5    | 150       | 750
סה"כ: 7750 ש"ח
```

## פירוק לישויות

| ישות | עמודות | הסבר |
|------|---------|------|
| `customers` | id, name, address, city | פרטי הלקוח |
| `invoices` | id, customer_id, invoice_date, total | כותרת החשבונית |
| `products` | id, name, unit_price | מוצרים |
| `invoice_items` | invoice_id, product_id, quantity, line_total | שורות בחשבונית |

## קשרים

- `invoices.customer_id` → `customers.id`
- `invoice_items.invoice_id` → `invoices.id`
- `invoice_items.product_id` → `products.id`

## תרגילים

### תרגיל 1
חשבונית מכילה: מספר חשבונית, תאריך, שם ספק, כתובת ספק, פריט 1 (שם, כמות, מחיר), פריט 2... אילו טבלאות תיצור?

### תרגיל 2
למה לא לאחסן את שם הלקוח בתוך כל שורת חשבונית? מה הבעיה בכך?

### תרגיל 3
כתוב את מבנה הטבלה `invoice_items` – עמודות ומפתחות. הסבר למה צריך גם `invoice_id` וגם `product_id`.

### תרגיל 4
איך מחשבים את `total` של החשבונית? האם לשמור אותו בטבלה או לחשב בשאילתה?

### תרגיל 5
חשבונית יכולה להכיל פריטים שונים, וכל פריט יכול להופיע בחשבוניות שונות. איזה סוג קשר זה? איך מייצגים אותו בטבלאות?

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
- `suppliers` – id, name, address  
- `invoices` – id, supplier_id, invoice_date  
- `products` – id, name, unit_price  
- `invoice_items` – invoice_id, product_id, quantity, line_total  

### תרגיל 2
כפילות: אותו לקוח יופיע בהרבה שורות. עדכון שם/כתובת ידרוש שינוי בכל השורות. עדיף טבלת `customers` והפניה אליה ב-`customer_id`.

### תרגיל 3
`invoice_items`: `invoice_id` (FK), `product_id` (FK), `quantity`, `unit_price`, `line_total`. `invoice_id` מקשר לשורת החשבונית, `product_id` למוצר. ביחד הם מזהים שורת פריט ספציפית.

### תרגיל 4
אפשר לחשב ב-SQL: `SELECT invoice_id, SUM(line_total) FROM invoice_items GROUP BY invoice_id`. שמירה ב-`invoices.total` נוחה לביצועים ושאילתות פשוטות, אבל דורשת עדכון בכל הוספת פריט.

### תרגיל 5
קשר רבים-לרבים: חשבונית ↔ מוצרים. מייצגים באמצעות טבלת ביניים `invoice_items` שמקשרת בין `invoices` ל-`products`.

</details>
