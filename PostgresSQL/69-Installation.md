# התקנת PostgreSQL

## דרכי התקנה

### Windows
1. הורדה מ-[postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
2. הרצת המתקין (EnterpriseDB)
3. הגדרת סיסמה למשתמש `postgres`
4. פורט ברירת מחדל: 5432

### macOS
- **Postgres.app** – [postgresapp.com](https://postgresapp.com/) – פשוט
- **Homebrew** – `brew install postgresql@16`

### Linux
- Ubuntu/Debian: `sudo apt install postgresql postgresql-contrib`
- Fedora: `sudo dnf install postgresql-server`

## כלי ניהול

- **psql** – ממשק שורת פקודה (מותקן עם PostgreSQL)
- **Beekeeper Studio** – ממשק גרפי
- **pgAdmin** – כלי רשמי

## חיבור בסיסי

```bash
psql -U postgres -d postgres
```

פרמטרים: `-h` host, `-p` port, `-U` user, `-d` database.

## תרגילים

### תרגיל 1
התקן PostgreSQL במחשב שלך (לפי מערכת ההפעלה). תאר את השלבים שביצעת.

### תרגיל 2
התחבר ל-psql למסד `postgres`. הרץ `SELECT version();` – מה מוצג?

### תרגיל 3
התקן Beekeeper Studio (או כלי גרפי אחר). צור חיבור ל-PostgreSQL המקומי.

### תרגיל 4
מהו פורט ברירת המחדל של PostgreSQL? איך משנים אותו?

### תרגיל 5
צור מסד נתונים חדש בשם `practice_db`. התחבר אליו והרץ שאילתת `SELECT 1`.

---

## פתרונות

<details>
<summary>לחץ כדי לראות פתרונות</summary>

### תרגיל 1
תלוי במערכת. Windows: הורדה מהאתר, הרצת exe, בחירת רכיבים, הגדרת סיסמה. Mac: Postgres.app – גרירה ל-Applications. Linux: פקודת apt/dnf.

### תרגיל 2
```bash
psql -U postgres -d postgres
```
```sql
SELECT version();
```
מוצגת גרסת PostgreSQL (למשל "PostgreSQL 16.x on...").

### תרגיל 3
הורדת Beekeeper, פתיחה, New Connection, PostgreSQL, host: localhost, port: 5432, user: postgres, password: (הסיסמה שהגדרת).

### תרגיל 4
פורט 5432. שינוי: בעת התקנה או בקובץ `postgresql.conf` – `port = 5433` (לדוגמה).

### תרגיל 5
```sql
CREATE DATABASE practice_db;
\c practice_db
SELECT 1;
```

</details>
