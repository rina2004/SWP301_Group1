/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DUCDA
 */
public class Post {
    private String id, title, content, image, authorID, categoryID;
    private boolean published;

    public Post() {
    }

    public Post(String id, String title, String content) {
        this.id = id;
        this.title = title;
        this.content = content;
    }

    public Post(String id, String title, String content, String image, String authorID, String categoryID, boolean published) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.authorID = authorID;
        this.categoryID = categoryID;
        this.published = published;
    }

    public Post(String title, String content, String image, String authorID, String categoryID, boolean published) {
        this.title = title;
        this.content = content;
        this.image = image;
        this.authorID = authorID;
        this.categoryID = categoryID;
        this.published = published;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAuthorID() {
        return authorID;
    }

    public void setAuthorID(String authorID) {
        this.authorID = authorID;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    @Override
    public String toString() {
        return "Post{" + "id=" + id + ", title=" + title + ", content=" + content + ", image=" + image + ", authorID=" + authorID + ", categoryID=" + categoryID + ", published=" + published + '}';
    }

    
}
