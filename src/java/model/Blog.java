/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DUCDA
 */
public class Blog {
    private String id, title, image, description;
    private int categoryID;

    public Blog() {
    }

    public Blog(String id, String title, String image, String description, int categoryID) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.description = description;
        this.categoryID = categoryID;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    @Override
    public String toString() {
        return "Blog{" + "id=" + id + ", title=" + title + ", image=" + image + ", description=" + description + ", categoryID=" + categoryID + '}';
    }

    
    
}

