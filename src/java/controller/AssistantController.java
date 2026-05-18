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

@WebServlet(name = "AssistantController", urlPatterns = {"/assistant-dashboard"})
public class AssistantController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || !u.getRoleCode().equals("ASSISTANT")) {
            response.sendRedirect("login");
            return;
        }

        TicketDAO tDao = new TicketDAO();
        RouteDAO rDao = new RouteDAO();

        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("checkTicket")) {
                String tid = request.getParameter("ticketID");
                if (tid != null && !tid.isEmpty()) {
                    Ticket t = tDao.getTicketByID(Integer.parseInt(tid));
                    if (t != null) {
                        request.setAttribute("foundTicket", t);
                    } else {
                        request.setAttribute("error", "Không tìm thấy vé!");
                    }
                }
            } else if (action.equals("sellTicket")) {
                int routeID = Integer.parseInt(request.getParameter("routeID"));
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                String category = request.getParameter("category");
                Route route = rDao.getRouteByID(routeID);
                double baseFare = (route != null && route.getBaseFare() != null) ? route.getBaseFare().doubleValue() : 7000;
                double price = baseFare;
                if (category.equals("STUDENT") || category.equals("SENIOR")) price *= 0.5;

                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DAY_OF_YEAR, 1);
                Date expiryDate = new Date(cal.getTimeInMillis());

                String ticketCode = "TK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                Timestamp validFrom = new Timestamp(System.currentTimeMillis());
                Ticket t = new Ticket(0, ticketCode, customerID, routeID, 0, "SINGLE", category, price, validFrom, expiryDate, ticketCode, "ACTIVE", validFrom);
                tDao.addTicket(t);
                request.setAttribute("success", "Đã bán vé thành công!");
            }
        }

        List<Route> listR = rDao.getAllRoutes();
        request.setAttribute("listR", listR);
        request.getRequestDispatcher("assistant-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
