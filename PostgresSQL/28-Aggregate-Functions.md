# פונקציות אגריגציה

## פונקציות בסיסיות

| פונקציה | משמעות |
|---------|--------|
| `COUNT(*)` | ספירת שורות |
| `COUNT(column)` | ספירת ערכים לא-NULL בעמודה |
| `SUM(column)` | סכום |
| `AVG(column)` | ממוצע |
| `MIN(column)` | מינימום |
| `MAX(column)` | מקסימום |

## דוגמאות

```sql
SELECT COUNT(*) FROM products;
SELECT AVG(unit_price) FROM products;
SELECT SUM(quantity * unit_price) FROM order_details;
SELECT MIN(unit_price), MAX(unit_price) FROM products;
```

## COUNT(DISTINCT column)

ספירת ערכים **ייחודיים**:

```sql
SELECT COUNT(DISTINCT country) FROM customers;
```

## תרגילים (Northwind)

### תרגיל 1
חשב את ממוצע המחיר (`unit_price`) בטבלת `products`. הצג עם כינוי `avg_price`.

### תרגיל 2
חשב את סכום הכמות (`quantity`) הכוללת שנמכרה בטבלת `order_details`.

### תרגיל 3
מצא את המחיר הנמוך והגבוה ביותר בטבלת `products`. הצג `min_price` ו-`max_price`.

### תרגיל 4
ספור כמה מוצרים יש בסך הכל בטבלת `products`. הצג `total_products`.

### תרגיל 5
חשב את ערך המלאי הכולל: `unit_price * units_in_stock` לכל מוצר, ואז סכום לכל הטבלה. הצג `total_inventory_value`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT AVG(unit_price) AS avg_price FROM products;
```

### תרגיל 2
```sql
SELECT SUM(quantity) AS total_quantity FROM order_details;
```

### תרגיל 3
```sql
SELECT MIN(unit_price) AS min_price, MAX(unit_price) AS max_price
FROM products;
```

### תרגיל 4
```sql
SELECT COUNT(*) AS total_products FROM products;
```

### תרגיל 5
```sql
SELECT SUM(unit_price * units_in_stock) AS total_inventory_value
FROM products;
```

</details>
