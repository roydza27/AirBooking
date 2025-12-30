# ✈️ Airplane Booking System (J2EE)

A complete beginner-friendly J2EE web application for flight booking with user management, admin panel, and security features.

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

## ✨ Features

### User Features
- ✅ User Registration with validation
- ✅ User Login with session management
- ✅ Remember Me functionality using cookies
- ✅ Flight search by route and date
- ✅ Real-time seat availability check
- ✅ Booking with overbooking prevention
- ✅ Unique booking ID generation (BK2025XXXX format)
- ✅ Promo code system with dynamic price calculation
- ✅ Booking history view
- ✅ Booking cancellation with date validation
- ✅ PDF ticket download (UI implemented)

### Admin Features
- ✅ Admin login with role-based access
- ✅ Add new flights
- ✅ View all flights
- ✅ Delete flights
- ✅ Admin panel accessible only to admin users

### Security Features
- ✅ Session-based authentication
- ✅ Authorization filter (AuthFilter)
- ✅ Protected routes
- ✅ Custom 403 Access Denied page
- ✅ Role-based access control

## 🛠 Technologies Used

### Backend
- **Java** - Core programming language
- **JSP** (JavaServer Pages) - View layer
- **Servlets** - Controller layer
- **Java Beans** (POJOs) - Data objects
- **JDBC** - Database connectivity
- **MySQL** - Database

### Frontend
- **HTML5** - Structure
- **CSS3** - Styling with gradients and animations
- **JavaScript** - Client-side validation and promo code logic
- **JSTL** - JSP Standard Tag Library for loops and conditionals

### Server
- **Apache Tomcat 9+** - Application server
- **MySQL 8.0+** - Database server

## 📁 Project Structure

```
AirBooking/
├── src/main/java/
│   ├── beans/
│   │   ├── User.java                 # User POJO
│   │   ├── Flight.java               # Flight POJO
│   │   ├── Booking.java              # Booking POJO
│   │   └── DBConnection.java         # Database utility
│   ├── servlets/
│   │   ├── RegisterServlet.java      # User registration
│   │   ├── LoginServlet.java         # User login
│   │   ├── LogoutServlet.java        # User logout
│   │   ├── SearchFlightServlet.java  # Flight search
│   │   ├── BookingServlet.java       # Flight booking
│   │   ├── BookingHistoryServlet.java # View bookings
│   │   ├── CancelBookingServlet.java # Cancel booking
│   │   └── AdminFlightServlet.java   # Admin operations
│   └── filters/
│       └── AuthFilter.java           # Security filter
├── src/main/webapp/
│   ├── css/
│   │   └── style.css                 # Main stylesheet
│   ├── WEB-INF/
│   │   ├── web.xml                   # Deployment descriptor
│   │   └── taglibs.jsp               # JSTL configuration
│   ├── login.jsp                     # Login page
│   ├── register.jsp                  # Registration page
│   ├── search.jsp                    # Flight search page
│   ├── results.jsp                   # Search results
│   ├── confirm.jsp                   # Booking confirmation
│   ├── history.jsp                   # Booking history
│   ├── admin.jsp                     # Admin panel
│   ├── navbar.jsp                    # Navigation bar
│   └── 403.jsp                       # Access denied page
└── database_setup.sql                # Database schema
```

## 🚀 Setup Instructions

### Prerequisites
1. **JDK 8 or higher** - [Download](https://www.oracle.com/java/technologies/downloads/)
2. **Apache Tomcat 9+** - [Download](https://tomcat.apache.org/download-90.cgi)
3. **MySQL 8.0+** - [Download](https://dev.mysql.com/downloads/mysql/)
4. **IDE** - Eclipse, IntelliJ IDEA, or NetBeans

### Step 1: Database Configuration

1. Start MySQL server
2. Create database:
```sql
CREATE DATABASE airbooking;
```

3. Run the database setup script:
```bash
mysql -u root -p airbooking < database_setup.sql
```

Or execute the SQL commands from `database_setup.sql` in MySQL Workbench.

### Step 2: Update Database Connection

Edit `src/main/java/beans/DBConnection.java` and update:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/airbooking";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "YOUR_PASSWORD"; // Your MySQL password
```

### Step 3: Add Required Libraries

Add these JAR files to your project's `lib` folder or build path:

1. **MySQL Connector/J** - [Download](https://dev.mysql.com/downloads/connector/j/)
   - `mysql-connector-java-8.0.x.jar`

2. **JSTL** - [Download from Maven](https://mvnrepository.com/artifact/javax.servlet/jstl)
   - `jstl-1.2.jar`
   - `standard-1.1.2.jar`

3. **Servlet API** (Usually included with Tomcat)
   - `servlet-api.jar`

### Step 4: Deploy to Tomcat

#### Method 1: Using IDE
1. Import project into your IDE
2. Configure Tomcat server
3. Deploy and run

#### Method 2: Manual Deployment
1. Build WAR file:
```bash
jar -cvf AirBooking.war *
```

2. Copy WAR to Tomcat's webapps folder:
```bash
cp AirBooking.war /path/to/tomcat/webapps/
```

3. Start Tomcat:
```bash
cd /path/to/tomcat/bin
./startup.sh  # Linux/Mac
startup.bat   # Windows
```

### Step 5: Access Application

Open browser and navigate to:
```
http://localhost:8080/AirBooking/
```

## 💾 Database Setup

### Tables Schema

#### Users Table
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(10) DEFAULT 'user'
);
```

#### Flights Table
```sql
CREATE TABLE flights (
    flight_id VARCHAR(20) PRIMARY KEY,
    from_city VARCHAR(30) NOT NULL,
    to_city VARCHAR(30) NOT NULL,
    date VARCHAR(20) NOT NULL,
    seats_available INT NOT NULL,
    price INT NOT NULL
);
```

#### Bookings Table
```sql
CREATE TABLE bookings (
    booking_id VARCHAR(20) PRIMARY KEY,
    user_id INT NOT NULL,
    flight_id VARCHAR(20) NOT NULL,
    seats_booked INT NOT NULL,
    total_price INT NOT NULL,
    booking_date VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);
```

### Sample Data

The setup script includes:
- 1 Admin user (admin@airbooking.com / admin123)
- 1 Regular user (john@example.com / user123)
- 8 Sample flights

## 📖 User Guide

### Registration
1. Click "Register here" on login page
2. Fill in: Name, Email, Password
3. Click "Register"

### Login
1. Enter email and password
2. Optional: Check "Remember Me"
3. Click "Login"

### Search Flights
1. Select From City, To City, and Date
2. Click "Search Flights"
3. View available flights

### Book Flight
1. Select number of seats
2. Click "Book Now"
3. Confirm booking details
4. Apply promo code (optional):
   - `FLYHIGH10` - 10% discount
   - `NEWUSER5` - 5% discount
5. Download ticket (feature UI)

### View Bookings
1. Click "My Bookings" in navbar
2. View all your bookings
3. Cancel bookings if needed

### Cancel Booking
1. Click "Cancel Booking" on booking card
2. Confirm cancellation
3. Note: Only future flights can be cancelled

## 👨‍💼 Admin Guide

### Login as Admin
- Email: admin@airbooking.com
- Password: admin123

### Add New Flight
1. Go to Admin Panel
2. Fill in flight details:
   - Flight ID (format: AA123)
   - From/To Cities
   - Date
   - Seats
   - Price
3. Click "Add Flight"

### View All Flights
- All flights displayed in a table
- Shows availability and pricing

### Delete Flight
1. Find flight in the table
2. Click "Delete"
3. Confirm deletion
4. Note: Cannot delete if active bookings exist

## 🔧 Technical Details

### Session Management
- Session timeout: 30 minutes
- Stores: userId, userName, userEmail, userRole
- Validated by AuthFilter

### Cookie Usage
- Remember Me: Stores email for 7 days
- Last Search: Stores from/to cities for 1 day

### Security Implementation
- AuthFilter protects all pages except login/register
- Admin routes protected by role check
- SQL injection prevention using PreparedStatement
- XSS prevention through proper escaping

### Booking ID Generation
Format: `BK2025XXXX`
- BK: Prefix
- 2025: Current year
- XXXX: Random 4-digit number

### Overbooking Prevention
```java
// Lock row for update
SELECT seats_available FROM flights WHERE flight_id = ? FOR UPDATE;

// Check availability
if (availableSeats < seatsBooked) {
    // Reject booking
}

// Update seats
UPDATE flights SET seats_available = seats_available - ? WHERE flight_id = ?;
```

### Transaction Management
- Database transactions used for booking
- Rollback on failure
- Ensures data consistency

## 🎯 Future Enhancements

### Recommended Features (Easy to Implement)

1. **Email Notifications**
   - Send booking confirmation via email
   - Use JavaMail API

2. **Password Hashing**
   - Currently passwords are plain text
   - Implement BCrypt or SHA-256

3. **Passenger Details**
   - Add passenger information form
   - Store multiple passenger data

4. **Seat Selection**
   - Visual seat map
   - Choose specific seats

5. **Flight Status**
   - Add on-time/delayed status
   - Real-time updates

6. **User Profile**
   - Edit profile page
   - Upload profile picture
   - Change password

7. **Advanced Search**
   - Filter by price range
   - Sort by price/time
   - Multi-city search

8. **Booking Modifications**
   - Change date
   - Add more passengers
   - Upgrade seats

9. **Payment Integration**
   - Mock payment gateway
   - Payment history

10. **Reporting Dashboard**
    - Revenue reports
    - Popular routes
    - User statistics

### Advanced Features

11. **Real PDF Generation**
    - Use iText or Apache PDFBox
    - QR code on tickets

12. **SMS Notifications**
    - Booking alerts
    - Flight reminders

13. **Multi-language Support**
    - Internationalization (i18n)
    - Multiple currencies

14. **Mobile Responsiveness**
    - Enhance mobile UI
    - Progressive Web App (PWA)

15. **API Integration**
    - RESTful API
    - Mobile app support

## 🐛 Troubleshooting

### Common Issues

**1. ClassNotFoundException: com.mysql.cj.jdbc.Driver**
- Add MySQL Connector JAR to classpath

**2. Cannot create PoolableConnectionFactory**
- Check MySQL is running
- Verify database credentials
- Ensure database exists

**3. 404 Not Found**
- Check Tomcat is running
- Verify context path
- Check WAR deployment

**4. Session is null**
- Clear browser cookies
- Check filter mapping
- Verify session timeout

**5. JSTL tags not working**
- Add JSTL JAR files
- Check taglib directive
- Verify web.xml configuration

## 📝 Important Notes

1. **Security**: This is a learning project. In production:
   - Hash passwords
   - Use HTTPS
   - Implement CSRF protection
   - Add input validation

2. **Database**: Consider using connection pooling for production

3. **Error Handling**: Add comprehensive error pages and logging

4. **Testing**: Write unit tests for servlets and DAOs

## 📄 License

This project is created for educational purposes. Feel free to use and modify as needed.

## 👥 Contributors

Created as a beginner-friendly J2EE mini-project example.

## 📞 Support

For issues or questions:
1. Check troubleshooting section
2. Review code comments
3. Verify setup steps

---

**Happy Coding! ✈️🚀**