package controller;

import dao.RouteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Station;

@WebServlet(name = "GetRouteStationsController", urlPatterns = {"/get-route-stations"})
public class GetRouteStationsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        String idStr = request.getParameter("routeID");
        if (idStr != null) {
            int routeID = Integer.parseInt(idStr);
            RouteDAO dao = new RouteDAO();
            List<Station> stations = dao.getStationsByRoute(routeID);
            
            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (int i = 0; i < stations.size(); i++) {
                Station s = stations.get(i);
                sb.append("{");
                sb.append("\"stationID\":").append(s.getStationID()).append(",");
                sb.append("\"stationName\":\"").append(s.getStationName().replace("\"", "\\\"")).append("\",");
                sb.append("\"latitude\":").append(s.getLatitude()).append(",");
                sb.append("\"longitude\":").append(s.getLongitude());
                sb.append("}");
                if (i < stations.size() - 1) sb.append(",");
            }
            sb.append("]");
            
            PrintWriter out = response.getWriter();
            out.print(sb.toString());
            out.flush();
        }
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
