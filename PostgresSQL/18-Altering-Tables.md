# שינוי טבלאות – ALTER TABLE

## הוספת עמודה

```sql
ALTER TABLE table_name ADD COLUMN column_name datatype;
```

דוגמה:
```sql
ALTER TABLE products ADD COLUMN discount DECIMAL(5,2) DEFAULT 0;
```

## מחיקת עמודה

```sql
ALTER TABLE table_name DROP COLUMN column_name;
```

## שינוי שם עמודה

```sql
ALTER TABLE table_name RENAME COLUMN old_name TO new_name;
```

## שינוי טיפוס עמודה

```sql
ALTER TABLE table_name ALTER COLUMN column_name TYPE new_type;
```

## הוספת מפתח ראשי

```sql
ALTER TABLE table_name ADD PRIMARY KEY (column_name);
```

## הוספת מפתח זר

```sql
ALTER TABLE table_name
ADD CONSTRAINT fk_name FOREIGN KEY (col) REFERENCES other_table(id);
```

## שינוי שם טבלה

```sql
ALTER TABLE old_name RENAME TO new_name;
```

## הסרת אילוץ (Constraint)

```sql
ALTER TABLE table_name DROP CONSTRAINT constraint_name;
```

## תרגילים

### תרגיל 1
הוסף עמודה `phone` מסוג `VARCHAR(20)` לטבלת `customers`.

### תרגיל 2
שנה את שם העמודה `name` ל-`full_name` בטבלת `employees`.

### תרגיל 3
הוסף מפתח זר: `orders.customer_id` → `customers.id`. נניח ששתי הטבלאות והעמודה כבר קיימות.

### תרגיל 4
הסר את עמודת `temp_data` מטבלת `logs`.

### תרגיל 5
בטבלת `products` הוסף עמודה `category_id` והגדר אותה כמפתח זר ל-`categories(id)`. השתמש ב-`REFERENCES`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
ALTER TABLE customers ADD COLUMN phone VARCHAR(20);
```

### תרגיל 2
```sql
ALTER TABLE employees RENAME COLUMN name TO full_name;
```

### תרגיל 3
```sql
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(id);
```

### תרגיל 4
```sql
ALTER TABLE logs DROP COLUMN temp_data;
```

### תרגיל 5
```sql
ALTER TABLE products ADD COLUMN category_id INTEGER REFERENCES categories(id);
```

</details>
