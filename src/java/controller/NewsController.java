package controller;

import dao.NewsDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.News;

@WebServlet(name = "NewsController", urlPatterns = {"/tin-tuc"})
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NewsDAO dao = new NewsDAO();
        List<News> list = dao.getLatestPublishedNews(10);
        request.setAttribute("newsList", list);
        request.getRequestDispatcher("news.jsp").forward(request, response);
    }
}
