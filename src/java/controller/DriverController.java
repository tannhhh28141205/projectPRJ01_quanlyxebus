package controller;

import dao.ScheduleDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Schedule;
import model.User;

@WebServlet(name = "DriverController", urlPatterns = {"/driver-dashboard"})
public class DriverController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || (!u.getRoleCode().equals("DRIVER") && !u.getRoleCode().equals("ASSISTANT"))) {
            response.sendRedirect("login");
            return;
        }

        ScheduleDAO dao = new ScheduleDAO();
        
        String action = request.getParameter("action");
        String sid = request.getParameter("sid");
        if (action != null && sid != null) {
            dao.updateStatus(Integer.parseInt(sid), action);
        }

        List<Schedule> list = dao.getSchedulesByUser(u.getUserID());
        request.setAttribute("listS", list);
        request.getRequestDispatcher("driver-dashboard.jsp").forward(request, response);
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
