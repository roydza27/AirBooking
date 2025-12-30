package beans;

/**
 * Flight Bean - Represents a flight in the system
 * Contains all flight details including availability and pricing
 */
public class Flight {
    private String flightId;
    private String fromCity;
    private String toCity;
    private String date;
    private int seatsAvailable;
    private int price;

    // Default constructor
    public Flight() {
    }

    // Parameterized constructor
    public Flight(String flightId, String fromCity, String toCity, String date, int seatsAvailable, int price) {
        this.flightId = flightId;
        this.fromCity = fromCity;
        this.toCity = toCity;
        this.date = date;
        this.seatsAvailable = seatsAvailable;
        this.price = price;
    }

    // Getters and Setters
    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getSeatsAvailable() {
        return seatsAvailable;
    }

    public void setSeatsAvailable(int seatsAvailable) {
        this.seatsAvailable = seatsAvailable;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Flight{flightId='" + flightId + "', from='" + fromCity + "', to='" + toCity + 
               "', date='" + date + "', seats=" + seatsAvailable + ", price=" + price + "}";
    }
}