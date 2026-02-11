# פירוק טבלאות

## מטרה

להפוך טבלה "שטוחה" עם כפילויות לטבלאות מנורמלות, כדי להפחית כפילויות ולשמור על עקביות.

## תהליך בסיסי

1. זיהוי ערכים חוזרים (למשל שם מדינה, קטגוריה)
2. יצירת טבלה חדשה לערכים הייחודיים
3. הוספת מפתח זר בטבלה המקורית
4. העברת הנתונים והסרת העמודה הכפולה

## דוגמה

### לפני
| order_id | customer_name | customer_city |
|----------|---------------|---------------|
| 1        | אלפא         | תל אביב      |
| 2        | בטא          | תל אביב      |

### אחרי
**customers**  
| id | name | city_id |
|----|------|---------|
| 1  | אלפא | 1       |
| 2  | בטא  | 1       |

**cities**  
| id | name    |
|----|---------|
| 1  | תל אביב |

## סינטקס – יצירת טבלה חדשה והעברה

```sql
-- 1. יצירת טבלת cities
CREATE TABLE cities (id SERIAL PRIMARY KEY, name VARCHAR(100));

-- 2. מילוי cities
INSERT INTO cities (name)
SELECT DISTINCT customer_city FROM old_orders;

-- 3. הוספת city_id והעברת נתונים (פשטני)
ALTER TABLE old_orders ADD COLUMN city_id INTEGER REFERENCES cities(id);
-- ואז עדכון city_id לפי city name...
```

## תרגילים

### תרגיל 1
טבלה `employees` מכילה `department_name` חוזר. תאר את הצעדים לפירוק לטבלאות `employees` ו-`departments`.

### תרגיל 2
למה לא למחוק את עמודת `customer_city` לפני יצירת טבלת `cities` והכנסת הנתונים?

### תרגיל 3
טבלה `products` עם `category_name` שחוזר. כתוב את ה-`CREATE TABLE` ל-`categories` ואת השינוי ב-`products`.

### תרגיל 4
מתי כדאי **לא** לפרק טבלה? תן דוגמה.

### תרגיל 5
בטבלה `orders` יש `customer_id` ו-`customer_name`. אחרי פירוק – מה נשאר ב-`orders` ומה עובר ל-`customers`?

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
1. יצירת `departments(id, name)`  
2. `INSERT INTO departments(name) SELECT DISTINCT department_name FROM employees`  
3. הוספת `department_id` ל-`employees`  
4. עדכון `department_id` לפי `department_name`  
5. מחיקת `department_name`  
6. הוספת Foreign Key  

### תרגיל 2
צריך את הערכים כדי ליצור את `cities` ולקשר. רק אחרי עדכון ה-`city_id` אפשר להסיר את `customer_city`.

### תרגיל 3
```sql
CREATE TABLE categories (id SERIAL PRIMARY KEY, name VARCHAR(100));

ALTER TABLE products ADD COLUMN category_id INTEGER REFERENCES categories(id);
-- לאחר מילוי category_id:
-- ALTER TABLE products DROP COLUMN category_name;
```

### תרגיל 4
כשהשדה כמעט לא חוזר או שהמבנה פשוט מדי – למשל טבלה עם 5 שורות בלבד. פירוק מופרז יוסיף מורכבות ללא תועלת.

### תרגיל 5
ב-`orders` נשאר רק `customer_id`. `customer_name` ועוד פרטי לקוח עוברים לטבלת `customers`. `orders` מפנה ל-`customers` דרך `customer_id`.

</details>
