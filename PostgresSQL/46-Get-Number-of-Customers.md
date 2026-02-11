# פונקציה – מספר לקוחות

## מטרה

ליצור פונקציה שמחזירה את מספר הלקוחות – כולל או לפי תנאי (מדינה, עיר וכו').

## דוגמה

```sql
CREATE FUNCTION get_customer_count()
RETURNS BIGINT
LANGUAGE sql
AS $$
  SELECT COUNT(*) FROM customers;
$$;
```

## תרגילים (Northwind)

### תרגיל 1
צור פונקציה `get_customer_count()` שמחזירה את מספר הלקוחות הכולל.

### תרגיל 2
צור פונקציה `get_customers_in_country(country_name TEXT)` שמחזירה כמה לקוחות יש במדינה הנתונה.

### תרגיל 3
צור פונקציה `get_customer_count_with_fax()` שמחזירה כמה לקוחות יש עם ערך לא-NULL ב-`fax`.

### תרגיל 4
צור פונקציה שמחזירה טבלה: `country` ומספר הלקוחות בכל מדינה. השתמש ב-RETURNS TABLE.

### תרגיל 5
צור פונקציה `get_customer_count_in_cities(city1 TEXT, city2 TEXT)` שמחזירה את סכום הלקוחות בשתי הערים.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE FUNCTION get_customer_count()
RETURNS BIGINT
LANGUAGE sql
AS $$
  SELECT COUNT(*) FROM customers;
$$;
```

### תרגיל 2
```sql
CREATE FUNCTION get_customers_in_country(country_name TEXT)
RETURNS BIGINT
LANGUAGE sql
AS $$
  SELECT COUNT(*) FROM customers WHERE country = country_name;
$$;
```

### תרגיל 3
```sql
CREATE FUNCTION get_customer_count_with_fax()
RETURNS BIGINT
LANGUAGE sql
AS $$
  SELECT COUNT(*) FROM customers WHERE fax IS NOT NULL;
$$;
```

### תרגיל 4
```sql
CREATE FUNCTION get_customers_per_country()
RETURNS TABLE(country VARCHAR(15), cnt BIGINT)
LANGUAGE sql
AS $$
  SELECT country, COUNT(*) FROM customers GROUP BY country;
$$;
```

### תרגיל 5
```sql
CREATE FUNCTION get_customer_count_in_cities(city1 TEXT, city2 TEXT)
RETURNS BIGINT
LANGUAGE sql
AS $$
  SELECT COUNT(*) FROM customers WHERE city IN (city1, city2);
$$;
```

</details>
