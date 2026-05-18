package controller;

import dao.RouteDAO;
import dao.TicketDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;
import jakarta.servlet.ServletException; 
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Route;
import model.Ticket;
import model.User;

@WebServlet(name = "BuyTicketController", urlPatterns = {"/mua-ve"})
public class BuyTicketController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RouteDAO rDao = new RouteDAO();
        List<Route> listR = rDao.getAllRoutes();
        request.setAttribute("listR", listR);
        request.getRequestDispatcher("buy-ticket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String category = request.getParameter("category");
        String routeIdStr = request.getParameter("routeID");
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null) {
            response.sendRedirect("login");
            return;
        }

        int customerID = u.getUserID();
        int routeID = (routeIdStr != null && !routeIdStr.isEmpty()) ? Integer.parseInt(routeIdStr) : 0;

        Route route = routeID > 0 ? new RouteDAO().getRouteByID(routeID) : null;
        double baseFare = (route != null && route.getBaseFare() != null) ? route.getBaseFare().doubleValue() : 7000;
        double price = baseFare;
        if (type != null) {
            if (type.equals("MONTHLY_ONE")) price = baseFare * 12;
            else if (type.equals("MONTHLY_ALL")) price = baseFare * 24;
        }
        if (category != null && (category.equals("STUDENT") || category.equals("SENIOR"))) {
            price *= 0.5;
        }

        Calendar cal = Calendar.getInstance();
        if (type != null && type.startsWith("MONTHLY")) {
            cal.add(Calendar.MONTH, 1);
        } else {
            cal.add(Calendar.DAY_OF_YEAR, 1);
        }
        Date expiryDate = new Date(cal.getTimeInMillis());

        String ticketCode = "TK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        Timestamp validFrom = new Timestamp(System.currentTimeMillis());
        Ticket t = new Ticket(0, ticketCode, customerID, routeID, 0, type, category, price, validFrom, expiryDate, ticketCode, "ACTIVE", validFrom);
        TicketDAO tDao = new TicketDAO();
        tDao.addTicket(t);
        
        request.setAttribute("mess", "Đăng ký vé thành công! Vui lòng thanh toán tại quầy.");
        doGet(request, response);
    }
}
