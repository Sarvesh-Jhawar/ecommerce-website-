package cn.techtutorial.model;

import java.sql.Timestamp; // Import Timestamp

public class User {
    private int id;
    private String email;
    private String name;
    private String password;
    private String role; // Role field
    private Timestamp lastLogin; // New field for last login timestamp

    // Constructor with all parameters including 'lastLogin'
    public User(int id, String email, String name, String password, String role, Timestamp lastLogin) {
        this.id = id;
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
        this.lastLogin = lastLogin; // Initialize lastLogin
    }

    // Default constructor
    public User() {
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getLastLogin() { // Getter for lastLogin
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) { // Setter for lastLogin
        this.lastLogin = lastLogin;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", name=" + name + ", password=" + password +
               ", role=" + role + ", lastLogin=" + lastLogin + "]";
    }
}
