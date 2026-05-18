package controller;

import dao.StationDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Station;
import model.User;

@WebServlet(name = "StationController", urlPatterns = {"/manage-stations"})
public class StationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || (!u.getRoleCode().equals("ADMIN") && !u.getRoleCode().equals("DISPATCHER"))) {
            response.sendRedirect("login");
            return;
        }

        StationDAO dao = new StationDAO();
        String action = request.getParameter("action");
        
        if (action != null && action.equals("add")) {
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String district = request.getParameter("district");
            BigDecimal lat = new BigDecimal(request.getParameter("lat"));
            BigDecimal lon = new BigDecimal(request.getParameter("lon"));
            boolean shelter = request.getParameter("shelter") != null;
            
            Station s = new Station(0, code, name, address, "", district, lat, lon, shelter, false, true);
            dao.addStation(s);
        }

        List<Station> list = dao.getAllStations();
        request.setAttribute("stationList", list);
        request.getRequestDispatcher("views/station-management.jsp").forward(request, response);
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
