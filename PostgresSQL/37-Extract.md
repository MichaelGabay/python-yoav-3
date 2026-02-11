# חילוץ חלקי תאריך – EXTRACT

## מטרה

לחלץ חלק מסוים מתאריך או זמן: שנה, חודש, יום, שעה, דקה וכו'.

## סינטקס

```sql
EXTRACT(field FROM date_or_timestamp)
```

## שדות נפוצים

| שדה | משמעות |
|-----|--------|
| `YEAR` | שנה |
| `MONTH` | חודש (1-12) |
| `DAY` | יום בחודש |
| `DOW` | יום בשבוע (0=ראשון, 6=שבת) |
| `QUARTER` | רבעון (1-4) |
| `HOUR`, `MINUTE`, `SECOND` | זמן |

## דוגמה

```sql
SELECT EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(MONTH FROM order_date) AS month
FROM orders;
```

## תרגילים (Northwind)

### תרגיל 1
הצג `order_id`, `order_date`, ושנה בלבד (`order_year`) מטבלת `orders`.

### תרגיל 2
ספור כמה הזמנות היו בכל שנה. הצג `year` ו-`order_count`.

### תרגיל 3
הצג `order_id`, `order_date`, ורבעון (`quarter`) – 1,2,3 או 4.

### תרגיל 4
הצג הזמנות שנעשו בחודש 3 (מרץ). הצג `order_id`, `order_date`.

### תרגיל 5
ספור הזמנות לפי חודש ושנה. הצג `year`, `month`, `order_count`, ממוין לפי שנה ואז חודש.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
SELECT order_id, order_date, EXTRACT(YEAR FROM order_date) AS order_year
FROM orders;
```

### תרגיל 2
```sql
SELECT EXTRACT(YEAR FROM order_date) AS year, COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date);
```

### תרגיל 3
```sql
SELECT order_id, order_date, EXTRACT(QUARTER FROM order_date) AS quarter
FROM orders;
```

### תרגיל 4
```sql
SELECT order_id, order_date
FROM orders
WHERE EXTRACT(MONTH FROM order_date) = 3;
```

### תרגיל 5
```sql
SELECT EXTRACT(YEAR FROM order_date) AS year,
       EXTRACT(MONTH FROM order_date) AS month,
       COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
```

</details>
