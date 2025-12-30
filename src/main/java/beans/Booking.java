package beans;

/**
 * Booking Bean - Represents a flight booking in the system
 * Links users to their flight bookings
 */
public class Booking {
    private String bookingId;
    private int userId;
    private String flightId;
    private int seatsBooked;
    private int totalPrice;
    private String bookingDate;
    
    // Additional fields for display purposes (not in DB)
    private String userName;
    private String fromCity;
    private String toCity;
    private String flightDate;

    // Default constructor
    public Booking() {
    }

    // Constructor for database operations
    public Booking(String bookingId, int userId, String flightId, int seatsBooked, int totalPrice, String bookingDate) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.flightId = flightId;
        this.seatsBooked = seatsBooked;
        this.totalPrice = totalPrice;
        this.bookingDate = bookingDate;
    }

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public int getSeatsBooked() {
        return seatsBooked;
    }

    public void setSeatsBooked(int seatsBooked) {
        this.seatsBooked = seatsBooked;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFromCity() {
        return fromCity;
    }

    public void setFromCity(String fromCity) {
        this.fromCity = fromCity;
    }

    public String getToCity() {
        return toCity;
    }

    public void setToCity(String toCity) {
        this.toCity = toCity;
    }

    public String getFlightDate() {
        return flightDate;
    }

    public void setFlightDate(String flightDate) {
        this.flightDate = flightDate;
    }

    @Override
    public String toString() {
        return "Booking{bookingId='" + bookingId + "', userId=" + userId + ", flightId='" + flightId + 
               "', seats=" + seatsBooked + ", totalPrice=" + totalPrice + ", date='" + bookingDate + "'}";
    }
}