package controller;

import dao.TicketDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Ticket;
import model.User;

@WebServlet(name = "MyTicketsController", urlPatterns = {"/ve-cua-toi"})
public class MyTicketsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null) {
            response.sendRedirect("login");
            return;
        }

        TicketDAO dao = new TicketDAO();
        List<Ticket> list = dao.getTicketsByCustomerID(u.getUserID());
        request.setAttribute("listT", list);
        request.getRequestDispatcher("my-tickets.jsp").forward(request, response);
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
