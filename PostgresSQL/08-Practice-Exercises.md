# 08 – תרגילים מסכמים על Northwind

אוסף תרגילים על מסד Northwind, מכל הנושאים שנלמדו. רמות: בסיסי, בינוני, מתקדם.

---

## איך לעבוד עם התרגילים

- כל תרגיל מציין את הנושאים הרלוונטיים (SELECT, JOIN, Subquery וכו').
- נסה לפתור לבד; אם נתקע – חזור ליחידה המתאימה.
- הרץ את השאילתות ב-Beekeeper Studio (או ב-psql) על מסד northwind.

---

## רמה 1 – בסיסי (SELECT, WHERE, ORDER BY, LIMIT)

### תרגיל 1.1

**נושאים:** SELECT, WHERE, ORDER BY  

רשום שאילתה שמחזירה את כל המוצרים מ-`products` שמחירם מעל 50, עם `product_name` ו-`unit_price`, ממוינים לפי מחיר יורד.

---

### תרגיל 1.2

**נושאים:** SELECT, DISTINCT, ORDER BY  

הצג רשימת מדינות ייחודית של לקוחות מ-`customers`, ממוינת לפי שם המדינה.

---

### תרגיל 1.3

**נושאים:** SELECT, WHERE, LIKE  

הצג לקוחות מ-`customers` שבשם החברה (company_name) מופיעה האות 'a' (השתמש ב-ILIKE).

---

### תרגיל 1.4

**נושאים:** SELECT, WHERE, BETWEEN  

הצג הזמנות מ-`orders` שתאריך ההזמנה (order_date) בין 1997-01-01 ל-1997-06-30. הצג order_id, order_date, customer_id.

---

## רמה 2 – בינוני (אגרגציות, GROUP BY, HAVING)

### תרגיל 2.1

**נושאים:** COUNT, GROUP BY, ORDER BY  

כמה לקוחות יש בכל מדינה? הצג country ומספר הלקוחות (customer_count), ממוין לפי המספר יורד.

---

### תרגיל 2.2

**נושאים:** SUM, GROUP BY, JOIN  

לכל הזמנה ב-`order_details`, חשב את סכום השורה: `quantity * unit_price * (1 - discount)`. הצג order_id וסכום ההזמנה (order_total), ממוין לפי order_total יורד, LIMIT 10.

---

### תרגיל 2.3

**נושאים:** AVG, GROUP BY, HAVING  

הצג ממוצע מחיר (avg_price) לכל קטגוריה ב-`products`, רק לקטגוריות שבהן יש לפחות 4 מוצרים. מיין לפי avg_price יורד.

---

### תרגיל 2.4

**נושאים:** COUNT, GROUP BY, HAVING  

הצג customer_id שמהם יצאו יותר מ-10 הזמנות, עם מספר ההזמנות. מיין לפי מספר ההזמנות יורד.

---

## רמה 3 – בינוני–גבוה (Joins)

### תרגיל 3.1

**נושאים:** INNER JOIN  

הצג לכל הזמנה: order_id, order_date, company_name (מ-customers), ושם מלא של העובד (first_name + last_name מ-employees). הגבל ל-15 שורות.

---

### תרגיל 3.2

**נושאים:** INNER JOIN (3 טבלאות)  

הצג: order_id, product_name (מ-products), quantity, unit_price מ-`order_details`. חבר את orders רק אם צריך (למשל לסינון). מיין לפי order_id ואז product_name. LIMIT 20.

---

### תרגיל 3.3

**נושאים:** LEFT JOIN, WHERE ... IS NULL  

מצא מוצרים מ-`products` שלא נמכרו אף פעם (אין להם שורה ב-`order_details`). הצג product_id, product_name.

---

### תרגיל 3.4

**נושאים:** Self-Join  

הצג רשימת עובדים מ-`employees` עם שם המנהל שלהם (first_name + last_name). השתמש ב-LEFT JOIN על employees (עובד ומנהל). הצג: שם עובד, שם מנהל.

---

## רמה 4 – מתקדם (תת-שאילתות)

### תרגיל 4.1

**נושאים:** תת-שאילתה ב-WHERE, השוואה  

הצג מוצרים מ-`products` שמחירם מעל ממוצע המחירים במסד. הצג product_name, unit_price. מיין לפי unit_price יורד.

---

### תרגיל 4.2

**נושאים:** תת-שאילתה ב-WHERE, IN  

הצג לקוחות (company_name, country) שנמצאים באותן מדינות כמו הלקוח 'Alfreds Futterkiste'. אל תכלול את Alfreds Futterkiste בתוצאה.

---

### תרגיל 4.3

**נושאים:** EXISTS  

הצג קטגוריות מ-`categories` שיש בהן לפחות מוצר אחד עם unit_price מעל 80.

---

### תרגיל 4.4

**נושאים:** תת-שאילתה ב-FROM, JOIN  

חשב לכל customer_id את מספר ההזמנות (תת-שאילתה או CTE). חבר ל-`customers` והצג company_name ומספר ההזמנות. מיין לפי מספר ההזמנות יורד. LIMIT 10.

---

## רמה 5 – מתקדם (CTE, פונקציות חלון)

### תרגיל 5.1

**נושאים:** CTE (WITH)  

כתוב שאילתה עם CTE שמחשבת לכל product_id את סכום הכמות שנמכרה (מ-order_details). חבר ל-`products` והצג product_name וסכום הכמות (total_quantity). מיין לפי total_quantity יורד. LIMIT 10.

---

### תרגיל 5.2

**נושאים:** ROW_NUMBER, PARTITION BY  

לכל קטגוריה, דרג את המוצרים לפי unit_price יורד (ROW_NUMBER בתוך קטגוריה). הצג category_id, product_name, unit_price, ו-rank_in_category. הצג רק את 3 המוצרים היקרים בכל קטגוריה (rank_in_category <= 3).

---

### תרגיל 5.3

**נושאים:** DENSE_RANK, PARTITION BY  

דרג את המוצרים בכל קטגוריה לפי unit_price יורד עם DENSE_RANK. הצג category_id, product_name, unit_price, dense_rank. LIMIT 25.

---

### תרגיל 5.4

**נושאים:** UNION  

הצג רשימה מאוחדת: כל ה-company_name מ-`customers` ומ-`suppliers`, עם עמודה נוספת 'Customer' או 'Supplier' (type). מיין לפי company_name. LIMIT 20.

---

## תרגיל מסכם – שאילתה מורכבת

**נושאים:** JOIN, אגרגציות, GROUP BY, ORDER BY, LIMIT  

כתוב שאילתה שמחזירה את 5 הלקוחות (company_name) עם הסכום הגבוה ביותר של קניות (סכום quantity * unit_price * (1 - discount) מ-order_details עבור ההזמנות שלהם). הצג: company_name, total_sales. מיין לפי total_sales יורד. LIMIT 5.

**רמז:** חבר orders → customers, ו-orders → order_details; סכם לפי order; ואז קבץ לפי customer ו-sum.

---

## פתרונות לדוגמה (לבדיקה עצמית)

אחרי שניסית, אפשר להריץ את הדוגמאות הבאות ולוודא שהמבנה דומה לתוצאה שלך.

### דוגמה לפתרון 1.1

```sql
-- code| פתרון לדוגמה – מוצרים מעל 50
SELECT product_name, unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC;
```

### דוגמה לפתרון 2.1

```sql
-- code| פתרון לדוגמה – לקוחות לפי מדינה
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;
```

### דוגמה לפתרון 3.1

```sql
-- code| פתרון לדוגמה – הזמנות עם לקוח ועובד
SELECT o.order_id, o.order_date, c.company_name,
       e.first_name || ' ' || e.last_name AS employee_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC
LIMIT 15;
```

המשך לתרגל ולשלב נושאים – שאילתות מורכבות נבנות מצירוף SELECT, JOIN, אגרגציות ותת-שאילתות.
