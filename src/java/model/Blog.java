/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;
import java.time.LocalDateTime;
import java.util.Date;
/**
 *
 * @author DUCDA
 */
public class Blog {
    private String id;
    private BlogPost post;
    private String title;
    private String description;
    private String image;
    private BlogCategory category;
    private Account author;
    private LocalDateTime created_at;

    public Blog() {
    }

    public Blog(String id, BlogPost post, String title, String description, String image, BlogCategory category, Account author, LocalDateTime created_at) {
        this.id = id;
        this.post = post;
        this.title = title;
        this.description = description;
        this.image = image;
        this.category = category;
        this.author = author;
        this.created_at = created_at;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public BlogPost getPost() {
        return post;
    }

    public void setPost(BlogPost post) {
        this.post = post;
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

    public BlogCategory getCategory() {
        return category;
    }

    public void setCategory(BlogCategory category) {
        this.category = category;
    }

    public Account getAuthor() {
        return author;
    }

    public void setAuthor(Account author) {
        this.author = author;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
    
    
}
