/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author DUCDA
 */
public class Blog {

    private String id, postID, title, description, image, categoryID, authorID;
//    private Date  create_at;

    public String getAuthorID() {
        return authorID;
    }

    public void setAuthorID(String authorID) {
        this.authorID = authorID;
    }

    public Blog() {
    }

    public Blog(String postID, String title, String description) {
        this.postID = postID;
        this.title = title;
        this.description = description;
    }

    public Blog(String postID, String title, String description, String image, String categoryID, String authorID) {
        this.postID = postID;
        this.title = title;
        this.description = description;
        this.image = image;
        this.categoryID = categoryID;
        this.authorID = authorID;
    }

    public Blog(String id, String postID, String title, String description, String image, String categoryID, String authorID) {
        this.id = id;
        this.postID = postID;
        this.title = title;
        this.description = description;
        this.image = image;
        this.categoryID = categoryID;
        this.authorID = authorID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPostID() {
        return postID;
    }

    public void setPostID(String postID) {
        this.postID = postID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return "Blog{" + "id=" + id + ", postID=" + postID + ", title=" + title + ", description=" + description + ", image=" + image + ", categoryID=" + categoryID + ", authorID=" + authorID + '}';
    }

}