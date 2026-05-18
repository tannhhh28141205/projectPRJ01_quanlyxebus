package controller;

import dao.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "AdminController", urlPatterns = {"/admin-dashboard"})
public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || !u.getRoleCode().equals("ADMIN")) {
            response.sendRedirect("login");
            return;
        }

        UserDAO dao = new UserDAO();
        
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                String user = request.getParameter("user");
                String pass = request.getParameter("pass");
                String name = request.getParameter("name");
                int roleID = Integer.parseInt(request.getParameter("roleID"));
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                
                User newUser = new User(0, roleID, user, pass, name, email, phone, true);
                dao.addUser(newUser);
            }
        }

        List<User> list = dao.getAllUsers();
        request.setAttribute("listU", list);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
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
