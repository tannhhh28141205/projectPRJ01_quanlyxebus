package controller;

import dao.RouteDAO;
import dao.StationDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Route;
import model.Station;

@WebServlet(name = "SearchRouteController", urlPatterns = {"/tim-tuyen"})
public class SearchRouteController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StationDAO sDao = new StationDAO();
        RouteDAO rDao = new RouteDAO();
        
        List<Station> listS = sDao.getAllStations();
        request.setAttribute("listS", listS);
        
        String startStr = request.getParameter("startStation");
        String endStr = request.getParameter("endStation");
        
        if (startStr != null && endStr != null) {
            int start = Integer.parseInt(startStr);
            int end = Integer.parseInt(endStr);
            List<Route> routes = rDao.getRoutesByStations(start, end);
            request.setAttribute("routeList", routes);
        }
        
        request.getRequestDispatcher("search.jsp").forward(request, response);
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
