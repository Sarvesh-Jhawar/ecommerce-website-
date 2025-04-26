package cn.techtutorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cn.techtutorial.model.User;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    public User userLogin(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role")); // Fetch role
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in userLogin: " + e.getMessage());
        }

        return user;
    }
    public boolean userRegister(String name, String email, String password) {
        boolean result = false;
        String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'user')";  // Default role is 'user'

        try {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            int rowsAffected = pst.executeUpdate();
            

            if (rowsAffected > 0) {
                result = true; // Registration successful
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result; // Return true if registration was successful, false otherwise
    }
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users";

        try {
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }
    public User getUserById(int userId) {
    	String query="select * from users where id=?";
    	User user = null;
    	try {
    		PreparedStatement pst=con.prepareStatement(query);
    		pst.setInt(1, userId);
    		ResultSet rs = pst.executeQuery();
    		
    		while(rs.next()) {
    			user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setLastLogin(rs.getTimestamp("last_login"));
    		}
    	} catch (Exception e) {
            e.printStackTrace();
        }
    	return user;
    }

}
