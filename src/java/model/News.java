package model;

import java.sql.Timestamp;

public class News {
    private int newsID;
    private int authorID;
    private String authorName;
    private String title;
    private String slug;
    private String content;
    private String thumbnailUrl;
    private String category;
    private int viewCount;
    private boolean published;
    private Timestamp createdAt;

    public News() {}

    public News(int newsID, int authorID, String authorName, String title, String slug, String content,
                String thumbnailUrl, String category, int viewCount, boolean published, Timestamp createdAt) {
        this.newsID = newsID;
        this.authorID = authorID;
        this.authorName = authorName;
        this.title = title;
        this.slug = slug;
        this.content = content;
        this.thumbnailUrl = thumbnailUrl;
        this.category = category;
        this.viewCount = viewCount;
        this.published = published;
        this.createdAt = createdAt;
    }

    public int getNewsID() { return newsID; }
    public void setNewsID(int newsID) { this.newsID = newsID; }

    public int getAuthorID() { return authorID; }
    public void setAuthorID(int authorID) { this.authorID = authorID; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }

    public boolean isPublished() { return published; }
    public void setPublished(boolean published) { this.published = published; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
