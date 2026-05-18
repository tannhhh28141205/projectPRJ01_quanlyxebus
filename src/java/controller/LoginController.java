package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        
        UserDAO dao = new UserDAO();
        User u = dao.login(user, pass);
        
        if (u == null) {
            request.setAttribute("mess", "Sai tài khoản hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", u);
            
            String role = u.getRoleCode();
            if (role.equals("ADMIN")) {
                response.sendRedirect("admin-dashboard");
            } else if (role.equals("DISPATCHER")) {
                response.sendRedirect("manage-schedules");
            } else if (role.equals("DRIVER")) {
                response.sendRedirect("driver-dashboard");
            } else if (role.equals("ASSISTANT")) {
                response.sendRedirect("assistant-dashboard");
            } else {
                response.sendRedirect("tim-tuyen");
            }
        }
    }
}
