# מדריך התקנה – PostgreSQL Server ו-Beekeeper Studio

מדריך מסודר להתקנת שרת PostgreSQL ולכלי Beekeeper Studio לחיבור ולניהול מסד הנתונים, **ל-Windows ול-macOS**.

---

## תוכן עניינים

1. [התקנת PostgreSQL Server](#1-התקנת-postgresql-server)
   - [Windows](#windows-postgresql)
   - [Mac](#mac-postgresql)
2. [התקנת Beekeeper Studio](#2-התקנת-beekeeper-studio)
   - [קישורי הורדה](#קישורי-הורדה-beekeeper-studio)
   - [Windows](#windows-beekeeper)
   - [Mac](#mac-beekeeper)
3. [חיבור Beekeeper ל-PostgreSQL](#3-חיבור-beekeeper-studio-l-postgresql)

---

## 1. התקנת PostgreSQL Server

### Windows (PostgreSQL)

1. **הורדת PostgreSQL**
   - גלוש לאתר: [https://www.postgresql.org/download/windows/](https://www.postgresql.org/download/windows/)
   - לחץ על "Download the installer" (או היכנס ל-[EnterpriseDB](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)) והורד את הגרסה המתאימה ל-Windows (למשל 16 או 17).

2. **הרצת המתקין**
   - הרץ את קובץ ההתקנה (`.exe`).
   - בחר את התיקייה להתקנה (ברירת המחדל מתאימה) והמשך.

3. **בחירת רכיבים**
   - השאר מסומנים: PostgreSQL Server, pgAdmin, Stack Builder (אופציונלי), Command Line Tools.
   - המשך "Next".

4. **תיקיית Data**
   - השאר את תיקיית ה-Data כברירת מחדל והמשך.

5. **סיסמה למשתמש `postgres`** ⭐
   - בשלב "Password" יבקשו ממך להגדיר סיסמה למשתמש **postgres** (משתמש מנהל המסד).
   - **הזן את הסיסמה: `123456`**

6. **פורט**
   - השאר את הפורט **5432** (ברירת מחדל) והמשך.

7. **Locale**
   - השאר כברירת מחדל והמשך עד לסיום ההתקנה.

8. **סיום**
   - סיים את ההתקנה. אם מופיעה אפשרות להפעיל Stack Builder – אפשר לדלג.
   - **PostgreSQL Server פועל כשירות ברקע.**

---

### Mac (PostgreSQL)

#### אופציה א': התקנה עם Postgres.app (פשוט)

1. **הורדת Postgres.app**
   - גלוש ל: [https://postgresapp.com/](https://postgresapp.com/)
   - הורד את הגרסה המתאימה:
     - **מעבדי M (Apple Silicon):** בחר את הקובץ ל-arm64 / Apple Silicon.
     - **מעבדי Intel:** בחר את הקובץ ל-Intel.

2. **התקנה**
   - גרור את `Postgres.app` לתיקיית היישומים (Applications).
   - פתח את Postgres.app ולחץ "Initialize" כדי ליצור שרת מקומי.

3. **סיסמה**
   - Postgres.app יוצר משתמש עם שם המשתמש של ה-Mac; לעיתים לא נדרשת סיסמה בחיבור מקומי.
   - **אם תרצה סיסמה אחידה כמו ב-Windows:** אחרי ההתקנה, פתח Terminal והרץ:
     ```bash
     psql -d postgres -c "ALTER USER $(whoami) PASSWORD '123456';"
     ```
     או אם משתמשים ב-`postgres`:
     ```bash
     psql -d postgres -c "ALTER USER postgres PASSWORD '123456';"
     ```

#### אופציה ב': התקנה עם Homebrew

1. **התקנת Homebrew** (אם עדיין אין):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **התקנת PostgreSQL**

   ```bash
   brew install postgresql@16
   brew services start postgresql@16
   ```

3. **הגדרת סיסמה למשתמש postgres**
   - התחבר למסד:
     ```bash
     psql postgres
     ```
   - בתוך `psql` הרץ:
     ```sql
     ALTER USER postgres PASSWORD '123456';
     \q
     ```

---

## 2. התקנת Beekeeper Studio

Beekeeper Studio הוא כלי גרפי נוח לחיבור למסדי נתונים (כולל PostgreSQL), הרצת שאילתות וניהול טבלאות.

### קישורי הורדה (Beekeeper Studio)

| מערכת                             | קובץ                  | קישור                                                                                                                                                    |
| --------------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Windows**                       | גרסה ניידת (portable) | [Beekeeper-Studio-5.5.6-portable.exe](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-portable.exe) |
| **Mac – מעבדי M (Apple Silicon)** | גרסה ל-arm64          | [Beekeeper-Studio-5.5.6-arm64.dmg](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-arm64.dmg)       |
| **Mac – מעבדי Intel**             | גרסה ל-Intel          | [Beekeeper-Studio-5.5.6.dmg](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6.dmg)                   |

- **Windows:** [https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-portable.exe](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-portable.exe)
- **Mac M (ARM):** [https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-arm64.dmg](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6-arm64.dmg)
- **Mac Intel:** [https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6.dmg](https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v5.5.6/Beekeeper-Studio-5.5.6.dmg)

---

### Windows (Beekeeper)

1. הורד את הקובץ: **Beekeeper-Studio-5.5.6-portable.exe** (מהקישור למעלה).
2. הרץ את הקובץ – זו גרסה ניידת, אין צורך בהתקנה מלאה.
3. אם תרצה גרסה מותקנת: הורד מהאתר [https://www.beekeeperstudio.io/](https://www.beekeeperstudio.io/) את מתקין Windows והתקן כרגיל.

---

### Mac (Beekeeper)

1. **בחר את הקובץ המתאים למחשב שלך:**
   - **מעבד M (M1/M2/M3):** הורד **Beekeeper-Studio-5.5.6-arm64.dmg**
   - **מעבד Intel:** הורד **Beekeeper-Studio-5.5.6.dmg**

2. **התקנה**
   - פתח את קובץ ה-.dmg שהורדת.
   - גרור את **Beekeeper Studio** לתיקיית **Applications**.

3. **הרצה**
   - פתח את Beekeeper Studio מתיקיית Applications (ייתכן שיהיה צורך לאשר ב-"אבטחה ופרטיות" שהאפליקציה מורשית לרוץ).

---

## 3. חיבור Beekeeper Studio ל-PostgreSQL

1. **פתח את Beekeeper Studio.**

2. **יצירת חיבור חדש**
   - לחץ "New connection" או "Add connection".
   - בחר **PostgreSQL**.

3. **פרטי החיבור**
   - **Host:** `localhost` (או `127.0.0.1`)
   - **Port:** `5432`
   - **User:** `postgres`
   - **Password:** `123456` (או הסיסמה שהגדרת בהתקנת PostgreSQL)
   - **Default database:** `postgres` (או השאר ריק)

4. **שמירה וחיבור**
   - לחץ "Test" כדי לבדוק שהחיבור עובד.
   - אחר כך "Connect" או "Save & Connect".

מעכשיו אפשר להריץ שאילתות SQL, ליצור טבלאות ולנהל את מסד הנתונים מתוך Beekeeper Studio.

---

## סיכום – סיסמה לסטודנטים

| פריט         | ערך         |
| ------------ | ----------- |
| משתמש        | `postgres`  |
| סיסמה        | `123456`    |
| פורט         | `5432`      |
| Host (מקומי) | `localhost` |

**חשוב:** בסביבת ייצור (production) יש להשתמש בסיסמה חזקה; הסיסמה `123456` מתאימה רק ללימוד ולפיתוח מקומי.

---
