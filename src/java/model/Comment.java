/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DUCDA
 */
public class Comment {
    private String id, account, content, post;

    public Comment() {
    }

    public Comment(String account, String content, String post) {
        this.account = account;
        this.content = content;
        this.post = post;
    }

    public Comment(String id, String account, String content, String post) {
        this.id = id;
        this.account = account;
        this.content = content;
        this.post = post;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    @Override
    public String toString() {
        return "Comment{" + "id=" + id + ", account=" + account + ", content=" + content + ", post=" + post + '}';
    }
}