<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - AirBooking System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <div class="confirm-box">
            <div class="success-icon">✅</div>
            <h2>Booking Confirmed!</h2>
            
            <div class="booking-details">
                <h3>Booking Details</h3>
                <table class="details-table">
                    <tr>
                        <th>Booking ID:</th>
                        <td><strong>${bookingId}</strong></td>
                    </tr>
                    <tr>
                        <th>Flight ID:</th>
                        <td>${flightId}</td>
                    </tr>
                    <tr>
                        <th>Passenger Name:</th>
                        <td><%= session.getAttribute("userName") %></td>
                    </tr>
                    <tr>
                        <th>Seats Booked:</th>
                        <td>${seatsBooked}</td>
                    </tr>
                    <tr>
                        <th>Booking Date:</th>
                        <td>${bookingDate}</td>
                    </tr>
                </table>
                
                <div class="promo-section">
                    <h4>Have a Promo Code?</h4>
                    <div class="promo-input-group">
                        <input type="text" id="promoCode" placeholder="Enter Promo Code">
                        <button onclick="applyPromo()" class="btn btn-secondary">Apply</button>
                    </div>
                    <p id="promoMsg" class="promo-message"></p>
                </div>
                
                <div class="price-section">
                    <h3>Total Price: ₹<span id="totalPrice">${totalPrice}</span></h3>
                </div>
                
                <div class="promo-info">
                    <p><small>💡 Available Promo Codes:</small></p>
                    <ul>
                        <li><code>FLYHIGH10</code> - 10% discount</li>
                        <li><code>NEWUSER5</code> - 5% discount</li>
                    </ul>
                </div>
            </div>
            
            <div class="action-buttons">
                <button onclick="downloadPDF()" class="btn btn-primary">📄 Download Ticket</button>
                <a href="BookingHistoryServlet" class="btn btn-secondary">View Booking History</a>
                <a href="search.jsp" class="btn btn-success">Book Another Flight</a>
            </div>
        </div>
    </div>

    <script>
        const originalPrice = ${totalPrice};
        let currentPrice = originalPrice;
        let promoApplied = false;
        
        function applyPromo() {
            if (promoApplied) {
                document.getElementById("promoMsg").innerHTML = 
                    '<span style="color: orange;">⚠️ Promo code already applied!</span>';
                return;
            }
            
            const code = document.getElementById("promoCode").value.trim().toUpperCase();
            let price = originalPrice;
            const msg = document.getElementById("promoMsg");

            if (code === "FLYHIGH10") {
                price -= price * 0.10;
                msg.innerHTML = '<span style="color: green;">✅ Promo Applied! 10% Discount Added</span>';
                promoApplied = true;
            }
            else if (code === "NEWUSER5") {
                price -= price * 0.05;
                msg.innerHTML = '<span style="color: green;">✅ Promo Applied! 5% Discount Added</span>';
                promoApplied = true;
            }
            else if (code === "") {
                msg.innerHTML = '<span style="color: red;">❌ Please enter a promo code!</span>';
                return;
            }
            else {
                msg.innerHTML = '<span style="color: red;">❌ Invalid Promo Code!</span>';
                return;
            }

            currentPrice = Math.round(price);
            document.getElementById("totalPrice").innerText = currentPrice;
            document.getElementById("promoCode").disabled = true;
        }
        
        function downloadPDF() {
            alert('📄 PDF download feature coming soon!\n\nYour booking ID: ${bookingId}\n\nPlease save this booking ID for your records.');
        }
    </script>
</body>
</html>