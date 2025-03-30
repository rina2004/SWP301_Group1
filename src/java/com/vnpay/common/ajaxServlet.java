package com.vnpay.common;
import dal.*;
import java.util.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.*;
import java.sql.*;

/**
 *
 * @author A A
 */
public class ajaxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bankCode = request.getParameter("bankCode");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/view/Login.jsp");
            return;
        }
         // Get all form parameters
        String flightId = request.getParameter("flightId");
        int passengers = Integer.parseInt(request.getParameter("passengers"));
        String adult = request.getParameter("adult");
        String child = request.getParameter("child");
        String baby = request.getParameter("baby");
        
        String compartmentType = request.getParameter("compartmentType");
        String ticketType = request.getParameter("ticketType");
        double finalPrice = Double.parseDouble(request.getParameter("finalPrice"));
        
        AccountDAO ad = new AccountDAO();
        String username = (String) request.getSession().getAttribute("user");
        Account a = ad.getAccountByUsername(username);
        
        TicketTypeDAO ttd = new TicketTypeDAO();
        OrderDAO od = new OrderDAO();
        Order order = new Order();
        String orderID = "ORD" + UUID.randomUUID().toString().substring(0, 4).toUpperCase();
        order.setId(orderID);
        order.setCustomer(a);
        order.setStaff(ad.getAccountByUsername("staff1"));
        order.setStatus("Confirmed");
        order.setTime(LocalDateTime.now());
        order.setFinalPrice(finalPrice);
        order.setFinalNum(passengers);
        order.setTt(ttd.get(ticketType));
        od.insert(order);
        
        FlightDAO fd = new FlightDAO(); 
        Flight f = fd.getFlightById(flightId);
        CompartmentDAO cd = new CompartmentDAO();
        TicketDAO td = new TicketDAO();
        OrderPassengerDAO opd = new OrderPassengerDAO();
        
        List<OrderPassenger> passengerList = new ArrayList<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        
        for (int i = 1; i <= passengers; i++) {
            String passengerTypeId = request.getParameter("passengerType" + i);
            String fullName = request.getParameter("fullName" + i);
            String dobStr = request.getParameter("dob" + i);
            String nationalityId = request.getParameter("nationality" + i);
            
            OrderPassenger op = new OrderPassenger();
            String passengerId = orderID + "-" + i;
            op.setId(passengerId);
            op.setOrder(order);
            
            PassengerTypeDAO ptd = new PassengerTypeDAO();
            PassengerType pt = ptd.get(passengerTypeId);
            op.setPassengerType(pt);
            op.setName(fullName);
            LocalDate localDate = LocalDate.parse(dobStr, dateFormatter);
            java.sql.Date dob = java.sql.Date.valueOf(localDate);
            op.setDob(dob);
            
            NationDAO nd = new NationDAO();
            Nation nation = nd.get(nationalityId);
            op.setNation(nation);
            
            passengerList.add(op);
            opd.insert(op);
            
            // Tạo Ticket cho mỗi OrderPassenger
            Ticket ticket = new Ticket();
            ticket.setOrderP(op);
            ticket.setFlight(f);
            ticket.setCompartment(cd.getCompartmentByTypeAndAirplaneId(compartmentType, f.getAirplane().getId()));
            ticket.setStatus("Confirmed");
            td.insert(ticket);
        }
        
        
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        
        long amount = (long) (finalPrice * 100);
        String vnp_TxnRef = orderID;
        String vnp_IpAddr = Config.getIpAddress(request);
        String vnp_TmnCode = Config.vnp_TmnCode;
        
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        
        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = request.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
        
        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
        response.sendRedirect(paymentUrl);
    }

}

