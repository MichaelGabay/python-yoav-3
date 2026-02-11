# טריגרים – Triggers

## מהו טריגר?

**Trigger** הוא קוד שרץ **אוטומטית** בעת אירוע מסוים: INSERT, UPDATE, DELETE על טבלה.

## יצירה

```sql
CREATE TRIGGER trigger_name
  BEFORE | AFTER INSERT | UPDATE | DELETE ON table_name
  FOR EACH ROW | FOR EACH STATEMENT
  EXECUTE FUNCTION function_name();
```

## פונקציית טריגר

```sql
CREATE FUNCTION trigger_func()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- NEW – השורה החדשה (INSERT/UPDATE)
  -- OLD – השורה הישנה (UPDATE/DELETE)
  RETURN NEW;  -- או OLD
END;
$$;
```

## דוגמה – לוג שינויים

```sql
CREATE TABLE audit_log(op TEXT, old_val TEXT, new_val TEXT);

CREATE FUNCTION audit_trigger()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO audit_log(op, old_val, new_val)
  VALUES (TG_OP, OLD.name, NEW.name);
  RETURN NEW;
END;
$$;

CREATE TRIGGER t_audit
  AFTER UPDATE ON products
  FOR EACH ROW EXECUTE FUNCTION audit_trigger();
```

## תרגילים

### תרגיל 1
צור טבלת `log_ops(action TEXT, table_name TEXT, ts TIMESTAMP)`. צור טריגר שמבצע INSERT ל-log_ops בכל INSERT על טבלת `products`.

### תרגיל 2
צור טריגר שב-BEFORE INSERT על `products` בודק אם `unit_price` שלילי – אם כן, זורק EXCEPTION.

### תרגיל 3
מה ההבדל בין FOR EACH ROW ל-FOR EACH STATEMENT?

### תרגיל 4
צור טריגר שמריץ פונקציה שמדפיסה RAISE NOTICE עם TG_OP (סוג הפעולה) בכל UPDATE על `customers`.

### תרגיל 5
צור טריגר AFTER DELETE שמכניס לטבלת `deleted_products` את המזהה והשם של המוצר שנמחק.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
```sql
CREATE TABLE log_ops(action TEXT, table_name TEXT, ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE FUNCTION log_insert()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO log_ops(action, table_name) VALUES ('INSERT', TG_TABLE_NAME);
  RETURN NEW;
END;
$$;

CREATE TRIGGER t_log_insert
  AFTER INSERT ON products
  FOR EACH ROW EXECUTE FUNCTION log_insert();
```

### תרגיל 2
```sql
CREATE FUNCTION check_positive_price()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.unit_price < 0 THEN
    RAISE EXCEPTION 'Price cannot be negative';
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER t_check_price
  BEFORE INSERT ON products
  FOR EACH ROW EXECUTE FUNCTION check_positive_price();
```

### תרגיל 3
FOR EACH ROW – פועל על כל שורה. FOR EACH STATEMENT – פועל פעם אחת לפקודה (למשל 100 שורות ב-INSERT אחד = 1 הרצה).

### תרגיל 4
```sql
CREATE FUNCTION notify_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE NOTICE 'Operation: %', TG_OP;
  RETURN NEW;
END;
$$;

CREATE TRIGGER t_notify
  AFTER UPDATE ON customers
  FOR EACH ROW EXECUTE FUNCTION notify_update();
```

### תרגיל 5
```sql
CREATE TABLE deleted_products(product_id INT, product_name TEXT);

CREATE FUNCTION save_deleted()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO deleted_products(product_id, product_name)
  VALUES (OLD.product_id, OLD.product_name);
  RETURN OLD;
END;
$$;

CREATE TRIGGER t_save_deleted
  BEFORE DELETE ON products
  FOR EACH ROW EXECUTE FUNCTION save_deleted();
```

</details>
