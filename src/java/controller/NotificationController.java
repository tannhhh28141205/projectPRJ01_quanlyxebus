package controller;

import dao.NotificationDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Notification;
import model.User;

@WebServlet(name = "NotificationController", urlPatterns = {"/thong-bao"})
public class NotificationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null) {
            response.sendRedirect("login");
            return;
        }

        NotificationDAO dao = new NotificationDAO();
        List<Notification> list = dao.getNotificationsByUserID(u.getUserID());
        request.setAttribute("notificationList", list);
        request.getRequestDispatcher("notifications.jsp").forward(request, response);
    }
}
