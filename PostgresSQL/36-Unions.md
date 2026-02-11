# איחוד תוצאות – UNION

## מטרה

לאחד תוצאות משתי שאילתות או יותר, בתנאי שיש **אותו מספר עמודות** וטיפוסים תואמים.

## UNION – ללא כפילויות

```sql
SELECT column1, column2 FROM table1
UNION
SELECT column1, column2 FROM table2;
```

## UNION ALL – כולל כפילויות

```sql
SELECT column1 FROM table1
UNION ALL
SELECT column1 FROM table2;
```

## כללים

- מספר העמודות חייב להיות זהה
- הטיפוסים חייבים להיות תואמים (או ניתנים להמרה)
- שמות העמודות נלקחים מהשאילתה הראשונה

## תרגילים (Northwind)

### תרגיל 1
אחד את כל שמות החברות מ-`customers` ומ-`suppliers` בשאילתה אחת. הצג כ-`company_name`.

### תרגיל 2
אחד `company_name` מ-`customers` ו-`suppliers` עם UNION ALL – כמה שורות מתקבלות לעומת UNION?

### תרגיל 3
אחד רשימת שמות (first_name) מ-`employees` עם `company_name` מ-`customers`. הוסף עמודה `type` עם ערך 'Employee' או 'Customer'.

### תרגיל 4
צור שאילתה שמאחדת מוצרים שמחירם מעל 50 עם מוצרים שיש במלאי מעל 100. הצג `product_name`, `unit_price`, `units_in_stock`.

### תרגיל 5
אחד 3 מקורות: `company_name` מ-`customers`, `company_name` מ-`suppliers`, ו-`product_name` מ-`products`. הוסף עמודה `source` עם הערכים 'Customer', 'Supplier', 'Product'.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT company_name FROM customers
UNION
SELECT company_name FROM suppliers;
```

### תרגיל 2
UNION ALL לא מסיר כפילויות – יש יותר שורות. UNION מסיר כפילויות – פחות שורות אם יש שמות זהים.

```sql
SELECT company_name FROM customers
UNION ALL
SELECT company_name FROM suppliers;
```

### תרגיל 3
```sql
SELECT first_name AS name, 'Employee' AS type FROM employees
UNION
SELECT company_name, 'Customer' FROM customers;
```

### תרגיל 4
```sql
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE unit_price > 50
UNION
SELECT product_name, unit_price, units_in_stock
FROM products
WHERE units_in_stock > 100;
```

### תרגיל 5
```sql
SELECT company_name AS name, 'Customer' AS source FROM customers
UNION
SELECT company_name, 'Supplier' FROM suppliers
UNION
SELECT product_name, 'Product' FROM products;
```

</details>
