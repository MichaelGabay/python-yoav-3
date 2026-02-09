# תרגילים - שיעור 3 (09.02)
## SELECT, FROM, WHERE וכל האופרטורים

מסד הנתונים: **Northwind**

---

## תרגיל 1
שלוף את כל העמודות מהטבלה `customers` והצג רק את 5 השורות הראשונות.

---

## תרגיל 2
שלוף מהטבלה `products` רק את העמודות `product_name` ו-`unit_price`.

---

## תרגיל 3
שלוף מהטבלה `customers` את כל הלקוחות שנמצאים במדינה `'Germany'`. הצג את `company_name`, `city`, ו-`country`.

---

## תרגיל 4
שלוף מהטבלה `products` את כל המוצרים שמחירם (`unit_price`) גדול מ-50. הצג את `product_name` ו-`unit_price`, ממוין לפי מחיר יורד.

---

## תרגיל 5
שלוף מהטבלה `products` את כל המוצרים שמחירם (`unit_price`) קטן מ-10. הצג את `product_name` ו-`unit_price`, ממוין לפי מחיר עולה.

---

## תרגיל 6
שלוף מהטבלה `products` את כל המוצרים שמחירם (`unit_price`) גדול מ-20 **וגם** קטן מ-50. הצג את `product_name` ו-`unit_price`.

---

## תרגיל 7
שלוף מהטבלה `customers` את כל הלקוחות שנמצאים במדינה `'UK'` **או** `'USA'`. הצג את `company_name`, `city`, ו-`country`.

---

## תרגיל 8
שלוף מהטבלה `products` את כל המוצרים שמחירם (`unit_price`) בין 15 ל-30 (כולל הקצוות). הצג את `product_name` ו-`unit_price`, ממוין לפי מחיר עולה.

---

## תרגיל 9
שלוף מהטבלה `products` את כל המוצרים ששמם (`product_name`) מתחיל באותיות `'Ch'`. הצג את `product_name` ו-`unit_price`.

---

## תרגיל 10
שלוף מהטבלה `customers` את כל הלקוחות שנמצאים במדינות: `'UK'`, `'USA'`, `'Germany'`, `'France'`. הצג את `company_name`, `city`, ו-`country`, ממוין לפי מדינה ואז לפי שם החברה.

---

## תרגיל בונוס
שלוף מהטבלה `products` את כל המוצרים שמחירם (`unit_price`) גדול מ-25 **או** קטן מ-10, וששמם (`product_name`) מכיל את המילה `'cheese'`. הצג את `product_name` ו-`unit_price`, ממוין לפי מחיר יורד.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### פתרון תרגיל 1:
```sql
SELECT * FROM customers LIMIT 5;
```

### פתרון תרגיל 2:
```sql
SELECT product_name, unit_price FROM products;
```

### פתרון תרגיל 3:
```sql
SELECT company_name, city, country
FROM customers
WHERE country = 'Germany';
```

### פתרון תרגיל 4:
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC;
```

### פתרון תרגיל 5:
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price < 10
ORDER BY unit_price;
```

### פתרון תרגיל 6:
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price > 20 AND unit_price < 50;
```

### פתרון תרגיל 7:
```sql
SELECT company_name, city, country
FROM customers
WHERE country = 'UK' OR country = 'USA';
```

### פתרון תרגיל 8:
```sql
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 15 AND 30
ORDER BY unit_price;
```

### פתרון תרגיל 9:
```sql
SELECT product_name, unit_price
FROM products
WHERE product_name LIKE 'Ch%';
```

### פתרון תרגיל 10:
```sql
SELECT company_name, city, country
FROM customers
WHERE country IN ('UK', 'USA', 'Germany', 'France')
ORDER BY country, company_name;
```

### פתרון תרגיל בונוס:
```sql
SELECT product_name, unit_price
FROM products
WHERE (unit_price > 25 OR unit_price < 10)
  AND product_name ILIKE '%cheese%'
ORDER BY unit_price DESC;
```

</details>
