package controller;

import dao.BusDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bus;
import model.User;

@WebServlet(name = "BusController", urlPatterns = {"/manage-buses"})
public class BusController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u == null || (!u.getRoleCode().equals("ADMIN") && !u.getRoleCode().equals("DISPATCHER"))) {
            response.sendRedirect("login");
            return;
        }

        BusDAO dao = new BusDAO();
        String action = request.getParameter("action");
        
        try {
            if (action != null) {
                if (action.equals("add")) {
                    String plate = request.getParameter("plate");
                    String fleet = request.getParameter("fleet");
                    int seats = getIntParam(request, "seats", 30);
                    int standing = getIntParam(request, "standing", 30);
                    String type = request.getParameter("type");
                    String brand = request.getParameter("brand");
                    int year = getIntParam(request, "year", 2023);
                    
                    Bus b = new Bus(0, plate, fleet, seats, standing, type, brand, year, null, "ACTIVE");
                    dao.addBus(b);
                } else if (action.equals("edit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String plate = request.getParameter("plate");
                    String fleet = request.getParameter("fleet");
                    int seats = getIntParam(request, "seats", 30);
                    int standing = getIntParam(request, "standing", 30);
                    String type = request.getParameter("type");
                    String brand = request.getParameter("brand");
                    int year = getIntParam(request, "year", 2023);
                    String status = request.getParameter("status");
                    
                    Bus b = dao.getBusByID(id);
                    if (b != null) {
                        b.setLicensePlate(plate);
                        b.setFleetNumber(fleet);
                        b.setCapacitySeats(seats);
                        b.setCapacityStanding(standing);
                        b.setBusType(type);
                        b.setBrand(brand);
                        b.setManufactureYear(year);
                        b.setStatus(status);
                        dao.updateBus(b);
                    }
                } else if (action.equals("delete")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.deleteBus(id);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý dữ liệu: " + e.getMessage());
        }

        List<Bus> list = dao.getAllBuses();
        request.setAttribute("busList", list);
        request.getRequestDispatcher("views/bus-management.jsp").forward(request, response);
    }

    private int getIntParam(HttpServletRequest request, String name, int defaultValue) {
        String val = request.getParameter(name);
        if (val == null || val.isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(val);
        } catch (NumberFormatException e) {
            return defaultValue;
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
