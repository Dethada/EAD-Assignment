package com.spmovy.beans;

public class UserJB {
    private int ID;
    private String username;
    private String role;
    private String email;
    private String contact;
    private String creditcard;
    private String password;

    public UserJB() {
    }

    public UserJB(int ID, String username, String role, String email, String contact, String creditcard, String password) {
        this.ID = ID;
        this.username = username;
        this.role = role;
        this.email = email;
        this.contact = contact;
        this.creditcard = creditcard;
        this.password = password;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getCreditcard() {
        return creditcard;
    }

    public void setCreditcard(String creditcard) {
        this.creditcard = creditcard;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
