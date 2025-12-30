# ✈️ Airplane Booking System (J2EE)

A complete beginner-friendly J2EE web application for flight booking with user management, admin panel, and security features.

---

## 📋 Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [User Guide](#user-guide)
- [Admin Guide](#admin-guide)
- [Future Enhancements](#future-enhancements)
- [Troubleshooting](#troubleshooting)

---

## ✨ Features

### User Features
- ✔ User Registration with validation
- ✔ User Login with session management
- ✔ Remember Me functionality using cookies
- ✔ Flight search by route and date
- ✔ Real-time seat availability check
- ✔ Booking with overbooking prevention
- ✔ Unique booking ID generation (`BK2025XXXX` format)
- ✔ Promo code system with dynamic price calculation
- ✔ Booking history view
- ✔ Booking cancellation with date validation
- ✔ PDF ticket download (UI implemented)

### Admin Features
- ✔ Admin login with role-based access
- ✔ Add new flights
- ✔ View all flights
- ✔ Delete flights
- ✔ Admin panel accessible only to admin users

### Security Features
- ✔ Session-based authentication
- ✔ Authorization filter (`AuthFilter`)
- ✔ Protected routes
- ✔ Custom 403 Access Denied page
- ✔ Role-based access control
- ✔ SQL Injection prevention using `PreparedStatement`
- ✔ XSS prevention through escaped JSP output
- ✔ Cancellation allowed only for future flights

---

## 🛠 Technologies Used

### Backend
- **Java**
- **JSP (JavaServer Pages)** – View layer
- **Servlets** – Controller layer
- **Java Beans (POJOs)** – `User`, `Flight`, `Booking`
- **JDBC** – Database connectivity
- **MySQL 8+** – Database

### Frontend
- **HTML5**
- **CSS3** – Styling with gradients and animations
- **JavaScript** – Client-side validation and promo code logic
- **JSTL** – JSP Standard Tag Library for loops and conditionals

### Server Used
- **Eclipse GlassFish Server 7+**
  - Admin Console: `http://localhost:4848`
  - Web App runs at: `http://localhost:8080/AirBooking/...`

### Build System
- **Maven WAR Packaging**
- **Servlet mapping configured using `web.xml` (XML-based approach)**

---

## 📁 Project Structure

```

AirBooking/
├── src/main/java/
│   ├── beans/
│   │   ├── User.java
│   │   ├── Flight.java
│   │   ├── Booking.java
│   │   └── DBConnection.java
│   ├── servlets/
│   │   ├── RegisterServlet.java
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── SearchFlightServlet.java
│   │   ├── BookingServlet.java
│   │   ├── BookingHistoryServlet.java
│   │   ├── CancelBookingServlet.java
│   │   └── AdminFlightServlet.java
│   └── filters/
│       └── AuthFilter.java
├── src/main/webapp/
│   ├── css/style.css
│   ├── login.jsp
│   ├── register.jsp
│   ├── search.jsp
│   ├── results.jsp
│   ├── confirm.jsp
│   ├── history.jsp
│   ├── admin.jsp
│   ├── navbar.jsp
│   └── 403.jsp
└── database_setup.sql

````

---

## 🚀 Setup Instructions

### Step 1: Database Configuration
1. Start MySQL server
2. Create database:
```sql
CREATE DATABASE airbooking;
````

3. Import database schema:

```bash
mysql -u root -p airbooking < database_setup.sql
```

Or run the SQL file inside **MySQL Workbench**.

---

### Step 2: Update Database Connection

Edit:

```
src/main/java/beans/DBConnection.java
```

Set your MySQL password:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/airbooking";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "YOUR_MYSQL_PASSWORD";
```

---

### Step 3: Deploy to GlassFish

#### Method 1: Admin Console Deploy

1. Open → `http://localhost:4848`
2. Navigate → `Applications → Deploy`
3. Select your WAR file from:

```
C:\<FILE_PATH>\AirBooking\target\AirBooking.war
```

4. Enable **Force Redeploy**
5. Click **Deploy**

#### Method 2: Deploy using CLI

```bash
cd C:\Users\royal\GlassFish_Server\bin
asadmin start-domain
asadmin deploy --force=true "C:\temp\Project\AirBooking\target\AirBooking.war"
asadmin restart-domain
```

---

## ▶️ Running the Application

After successful deploy:

1. Open Admin Console:

```
http://localhost:4848
```

2. Confirm app is enabled:

```
Applications → Web Applications → AirBooking (Enabled)
```

3. Open in browser:

```
http://localhost:8080/AirBooking/SearchFlightServlet
```

---

## 🔑 Default Credentials

### Admin Account

* **Email:** `admin@airbooking.com`
* **Password:** `admin123`

### User Account

* **Email:** `john@example.com`
* **Password:** `user123`

---

## 📖 User Guide

### Registration

1. Click **Register**
2. Enter Name, Email, Password
3. Submit

### Login

1. Enter email & password
2. Optional: Check **Remember Me**
3. Submit

### Search Flights

1. Select From City, To City, Date
2. Click **Search Flights**
3. View results in `results.jsp`

### Book Flight

1. Select seats
2. Click **Book Now**
3. Apply promo code (optional)
4. Download ticket (PDF UI ready)

### Cancel Booking

* Only allowed for **future flight bookings**

---

## 👨‍💼 Admin Guide

### Login as Admin

* Email: `admin@airbooking.com`
* Password: `admin123`

### Add Flight

1. Open `admin.jsp`
2. Fill flight details
3. Click **Add Flight**

### View All Flights

* Flights displayed in table
* Shows seat availability and pricing

### Delete Flight

1. Find flight
2. Click **Delete**
3. Confirm

❗ Note: Deletion will fail if active bookings exist.

---

## 🐛 Troubleshooting

| Issue                 | Fix                                            |
| --------------------- | ---------------------------------------------- |
| Cannot connect to DB  | Ensure MySQL is running + credentials correct  |
| WAR not appearing     | Run `asadmin start-domain` → deploy again      |
| 404 Error             | Check GlassFish admin console + correct URL    |
| 500 JSP compile error | Use `jakarta.servlet`, not `javax.servlet`     |
| Flight not deleting   | Ensure JSP sends `flightId` using `${}` syntax |

---

## 🎯 Future Enhancements

Beginner-friendly upgrades you can add later:

1. Email notifications (JavaMail API)
2. Password hashing (BCrypt / SHA-256)
3. Passenger details form
4. Seat selection UI
5. Flight status updates
6. Admin dashboard & reports
7. Real PDF ticket generation with QR (iText / PDFBox)
8. SMS alerts
9. Multi-language support (i18n)
10. Multiple currencies
11. REST API for mobile support
12. Connection pooling via **GlassFish JDBC Resources** (production stage)

---

## 📄 License

Created for educational purposes. Free to modify and reuse.

---

**Happy Coding! 🚀**

````
