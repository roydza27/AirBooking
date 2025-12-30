Here is the **complete file in proper Markdown** for your `README.md`:

````md
# ✈ AirBooking System — Setup Guide

## ✅ Prerequisites Checklist
- [ ] JDK 8+ installed (Built using **JDK 17**)
- [ ] MySQL 8+ installed
- [ ] GlassFish Server 7+ installed & running
- [ ] NetBeans IDE (used for development)
- [ ] Maven WAR project structure intact
- [ ] `database_setup.sql` available for DB import

---

## ⚙ Step-by-Step Setup

### 1. Database Setup (5 minutes)
```sql
mysql -u root -p
CREATE DATABASE airbooking;
exit;
mysql -u root -p airbooking < database_setup.sql
````

**Verify Database:**

```sql
USE airbooking;
SHOW TABLES;  -- Should list: users, flights, bookings
SELECT * FROM users;  -- Should show sample users
```

---

### 2. Update Database Password

Edit:

```
src/main/java/beans/DBConnection.java
```

Update:

```java
private static final String DB_PASSWORD = "YOUR_MYSQL_PASSWORD";
```

---

### 3. Required Libraries

You do **NOT need to add javax.servlet or JSTL manually**, because GlassFish 7+ uses **Jakarta 9+ API**.

Make sure your servlets use:

```java
import jakarta.servlet.*;
import jakarta.servlet.http.*;
```

---

### 4. Deploy to GlassFish

#### 🌐 Deploy using Admin Console

1. Open in browser:

```
http://localhost:4848
```

2. Navigate:

```
Applications → Deploy
```

3. Select WAR file from:

```
C:\temp\Project\AirBooking\target\AirBooking.war
```

4. Enable:
   ✔ **Force Redeploy**
5. Click **Deploy**

---

#### 💻 Deploy using CLI

```bash
cd C:\Users\royal\GlassFish_Server\bin
asadmin start-domain
asadmin deploy --force=true "C:\temp\Project\AirBooking\target\AirBooking.war"
asadmin restart-domain
```

---

### 5. Access Application

| Panel               | URL                                                    |
| ------------------- | ------------------------------------------------------ |
| Admin Console       | `http://localhost:4848`                                |
| App (Flight Search) | `http://localhost:8080/AirBooking/SearchFlightServlet` |
| Admin Panel JSP     | `http://localhost:8080/AirBooking/admin.jsp`           |

---

## 🔑 Default Login Credentials

### 👑 Admin Account

* **Email:** `admin@airbooking.com`
* **Password:** `admin123`

### 👤 User Account

* **Email:** `john@example.com`
* **Password:** `user123`

---

## 🧪 Quick Test

1. **User Flow**

* Login as user
* Search flights
* Book a seat
* View booking history

2. **Admin Flow**

* Login as admin
* Add a flight
* View flights
* Delete a flight

---

## 📁 Project Structure Used

```
AirBooking/
├── src/main/java/beans/          # POJOs + DB connection
├── src/main/java/servlets/       # Servlet controllers
├── src/main/webapp/              # JSP pages, navbar, CSS
│     └── WEB-INF/web.xml         # XML-based servlet mapping
└── target/AirBooking.war         # Deployable WAR
```

---

## ⚠ Common Issues & Fixes

### Issue 1: Flight Delete shows "Flight not found!"

✔ Caused when JSP sends wrong param — already fixed.

### Issue 2: Database connection fails

```bash
mysql -u root -p   # Test DB login
```

### Issue 3: WAR not deployed

```bash
asadmin start-domain  # Must run before deploy
```

### Issue 4: 500 JSP Compilation Error

❗ Happens if `javax.servlet` is used instead of `jakarta.servlet`.

### Issue 5: 403 Redirect Loop

✔ Always redirect using:

```java
response.sendRedirect(request.getContextPath() + "/403.jsp");
```

---

## 🔧 Modify Data (Admin)

### Add New City

1. Edit: `search.jsp`, `admin.jsp`
2. Add `<option>` in city dropdown
3. Add sample flights to DB

### Modify Booking ID Format

1. Edit `generateBookingId()` in `BookingServlet.java`

### Add New Field to User

1. Update `User.java` (add field + getters/setters)
2. Run:

```sql
ALTER TABLE users ADD COLUMN new_field VARCHAR(50);
```

3. Update: `register.jsp`, `RegisterServlet.java`

---

## 🚀 Next Steps

1. Test admin & user flows
2. Read servlet code for CRUD understanding
3. Extend project later if needed

---

## 💡 Deployment Style Used

* **Server:** GlassFish 7+
* **Build:** Maven WAR
* **Servlet Mapping:** `web.xml` (XML approach)
* **Servlet API:** Jakarta 9+
* **Database:** MySQL 8+
* **Frontend:** JSP + JSTL

---

## 📤 Push to GitHub

```bash
cd C:\temp\Project\AirBooking
git init
git add .
git commit -m "Initial commit – AirBooking GlassFish WAR with XML servlet mapping"
git branch -M main
git remote add origin https://github.com/RoyalDSouza/AirBooking.git
git push -u origin main
```

---

Happy Coding! 🚀💪

```

---

### ✅ Save this content into:
```

README.md

```

Then push to GitHub.

---

You're all set, Royal. Ship it. 🚀
```
