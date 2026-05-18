package controller;

import dao.RouteDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Time;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Route;
import model.User;

@WebServlet(name = "RouteController", urlPatterns = {"/manage-routes"})
public class RouteController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || (!u.getRoleCode().equals("ADMIN") && !u.getRoleCode().equals("DISPATCHER"))) {
            response.sendRedirect("login");
            return;
        }

        RouteDAO dao = new RouteDAO();
        String action = request.getParameter("action");
        
        if (action != null) {
            if (action.equals("add") || action.equals("edit")) {
                String number = request.getParameter("number");
                String name = request.getParameter("name");
                String type = request.getParameter("type");
                Time start = Time.valueOf(request.getParameter("start") + ":00");
                Time end = Time.valueOf(request.getParameter("end") + ":00");
                int freq = Integer.parseInt(request.getParameter("freq"));
                BigDecimal distance = new BigDecimal(request.getParameter("distance"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                BigDecimal fare = new BigDecimal(request.getParameter("fare"));
                String color = request.getParameter("color");
                
                Route r = new Route(0, number, name, type, start, end, freq, distance, duration, fare, color, "", true);
                if (action.equals("add")) {
                    dao.addRoute(r);
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    r.setRouteID(id);
                    dao.updateRoute(r);
                }
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteRoute(id);
            }
        }

        List<Route> list = dao.getAllRoutes();
        request.setAttribute("routeList", list);
        request.getRequestDispatcher("views/route-management.jsp").forward(request, response);
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
