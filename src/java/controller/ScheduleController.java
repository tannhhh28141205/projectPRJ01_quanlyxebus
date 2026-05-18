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

@WebServlet(name = "ScheduleController", urlPatterns = {"/manage-schedules"})
public class ScheduleController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || (!u.getRoleCode().equals("ADMIN") && !u.getRoleCode().equals("DISPATCHER"))) {
            response.sendRedirect("login");
            return;
        }

        ScheduleDAO sDao = new ScheduleDAO();
        BusDAO bDao = new BusDAO();
        RouteDAO rDao = new RouteDAO();
        UserDAO uDao = new UserDAO();
        
        String action = request.getParameter("action");
        if (action != null && action.equals("add")) {
            int routeID = Integer.parseInt(request.getParameter("routeID"));
            int busID = Integer.parseInt(request.getParameter("busID"));
            int driverID = Integer.parseInt(request.getParameter("driverID"));
            int assistantID = Integer.parseInt(request.getParameter("assistantID"));
            String direction = request.getParameter("direction");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            
            Timestamp startTime = Timestamp.valueOf(date + " " + time + ":00");
            
            Schedule s = new Schedule(0, busID, routeID, driverID, assistantID, date, direction, startTime, null, null, null, "SCHEDULED");
            sDao.addSchedule(s);
        }

        List<Schedule> listS = sDao.getAllSchedules();
        List<Bus> listB = bDao.getAllBuses();
        List<Route> listR = rDao.getAllRoutes();
        List<User> listD = uDao.getUsersByRole("DRIVER");
        List<User> listA = uDao.getUsersByRole("ASSISTANT");
        
        request.setAttribute("listS", listS);
        request.setAttribute("listB", listB);
        request.setAttribute("listR", listR);
        request.setAttribute("listD", listD);
        request.setAttribute("listA", listA);
        
        request.getRequestDispatcher("views/schedule-management.jsp").forward(request, response);
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
