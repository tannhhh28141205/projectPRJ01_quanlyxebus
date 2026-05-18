package controller;

import dao.BusDAO;
import dao.RouteDAO;
import dao.ScheduleDAO;
import dao.UserDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bus;
import model.Route;
import model.Schedule;
import model.User;

@WebServlet(name = "StaffController", urlPatterns = {"/staff-dashboard"})
public class StaffController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || !u.getRoleCode().equals("DISPATCHER")) {
            response.sendRedirect("login");
            return;
        }

        BusDAO bDao = new BusDAO();
        RouteDAO rDao = new RouteDAO();
        ScheduleDAO sDao = new ScheduleDAO();
        UserDAO uDao = new UserDAO();
        
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("addBus")) {
                String plate = request.getParameter("plate");
                int capacity = Integer.parseInt(request.getParameter("capacity"));
                bDao.addBus(new Bus(0, plate, capacity));
            } else if (action.equals("addSchedule")) {
                int busID = Integer.parseInt(request.getParameter("busID"));
                int routeID = Integer.parseInt(request.getParameter("routeID"));
                int driverID = Integer.parseInt(request.getParameter("driverID"));
                int assistantID = Integer.parseInt(request.getParameter("assistantID"));
                String date = request.getParameter("date");
                
                // Assuming default start time or fetching from request
                Timestamp startTime = Timestamp.valueOf(date + " 08:00:00"); 
                sDao.addSchedule(new Schedule(0, busID, routeID, driverID, assistantID, date, "OUTBOUND", startTime, null, null, null, "SCHEDULED"));
            }
        }

        List<Bus> listB = bDao.getAllBuses();
        List<Route> listR = rDao.getAllRoutes();
        List<User> listD = uDao.getUsersByRole("DRIVER");
        List<User> listA = uDao.getUsersByRole("ASSISTANT");
        List<Schedule> listS = sDao.getAllSchedules();
        
        request.setAttribute("listB", listB);
        request.setAttribute("listR", listR);
        request.setAttribute("listD", listD);
        request.setAttribute("listA", listA);
        request.setAttribute("listS", listS);
        
        request.getRequestDispatcher("staff-dashboard.jsp").forward(request, response);
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
