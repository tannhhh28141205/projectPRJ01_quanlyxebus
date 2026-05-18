package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.News;

public class NewsDAO {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<News> getLatestPublishedNews(int limit) {
        List<News> list = new ArrayList<>();
        int safeLimit = Math.max(1, Math.min(limit, 50));
        String query = "SELECT TOP " + safeLimit + " n.newsID, n.authorID, u.fullName AS authorName, n.title, n.slug, n.content, n.thumbnailUrl, n.category, n.viewCount, n.isPublished, n.createdAt " +
                       "FROM News n JOIN Users u ON n.authorID = u.userID " +
                       "WHERE n.isPublished = 1 ORDER BY n.createdAt DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new News(
                    rs.getInt("newsID"),
                    rs.getInt("authorID"),
                    rs.getString("authorName"),
                    rs.getString("title"),
                    rs.getString("slug"),
                    rs.getString("content"),
                    rs.getString("thumbnailUrl"),
                    rs.getString("category"),
                    rs.getInt("viewCount"),
                    rs.getBoolean("isPublished"),
                    rs.getTimestamp("createdAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
