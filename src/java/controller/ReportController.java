package controller;

import dao.ReportDAO;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "ReportController", urlPatterns = {"/bao-cao"})
public class ReportController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        // Chỉ Admin và Dispatcher mới được xem báo cáo
        if (u == null || (!u.getRole().equals("ADMIN") && !u.getRole().equals("DISPATCHER"))) {
            response.sendRedirect("login");
            return;
        }

        ReportDAO dao = new ReportDAO();
        
        double totalRevenue = dao.getTotalRevenue();
        Map<String, Double> revenueByCategory = dao.getRevenueByCategory();
        Map<String, Integer> tripStats = dao.getTripStats();
        Map<String, Integer> popularRoutes = dao.getPopularRoutes();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revCat", revenueByCategory);
        request.setAttribute("tripStats", tripStats);
        request.setAttribute("popRoutes", popularRoutes);

        request.getRequestDispatcher("reports.jsp").forward(request, response);
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
