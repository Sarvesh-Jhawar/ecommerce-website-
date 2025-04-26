package cn.techtutorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import cn.techtutorial.connection.DBCon;
import cn.techtutorial.model.Cart;
import cn.techtutorial.model.Product;

public class ProductDao {
    private Connection con;

    public ProductDao(Connection con) {
        this.con = con;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        try (PreparedStatement pst = this.con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Product row = new Product();
                row.setId(rs.getInt("id"));
                row.setCategory(rs.getString("category"));
                row.setName(rs.getString("name"));
                row.setPrice(rs.getDouble("price"));
                row.setImage(rs.getString("image"));
                products.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return products;
    }

    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE id = ?";
        try {
            if (!cartList.isEmpty()) {
                for (Cart item : cartList) {
                    try (PreparedStatement pst = this.con.prepareStatement(query)) {
                        pst.setInt(1, item.getId());
                        try (ResultSet rs = pst.executeQuery()) {
                            while (rs.next()) {
                                Cart row = new Cart();
                                row.setId(rs.getInt("id"));
                                row.setName(rs.getString("name"));
                                row.setCategory(rs.getString("category"));
                                row.setPrice(rs.getDouble("price") * item.getQuantity());
                                row.setQuantity(item.getQuantity());
                                products.add(row);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        String query = "SELECT * FROM products WHERE id = ?";
        try {
            if (!cartList.isEmpty()) {
                for (Cart item : cartList) {
                    try (PreparedStatement pst = this.con.prepareStatement(query)) {
                        pst.setInt(1, item.getId());
                        try (ResultSet rs = pst.executeQuery()) {
                            while (rs.next()) {
                                sum += rs.getDouble("price") * item.getQuantity();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }

    public Product getSingleProduct(int pid) {
        Product row = null;
        String query = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            pst.setInt(1, pid);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    row = new Product();
                    row.setId(rs.getInt("id"));
                    row.setName(rs.getString("name"));
                    row.setCategory(rs.getString("category"));
                    row.setPrice(rs.getDouble("price"));
                    row.setImage(rs.getString("image"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return row;
    }
    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        if (!category.equalsIgnoreCase("all")) {
            query += " WHERE category = ?";
        }
        try (PreparedStatement pst = this.con.prepareStatement(query)) {
            if (!category.equalsIgnoreCase("all")) {
                pst.setString(1, category);
            }
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Product row = new Product();
                    row.setId(rs.getInt("id"));
                    row.setCategory(rs.getString("category"));
                    row.setName(rs.getString("name"));
                    row.setPrice(rs.getDouble("price"));
                    row.setImage(rs.getString("image"));
                    products.add(row);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT DISTINCT category FROM products";
        try (PreparedStatement pst = this.con.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
    public List<Product> getProductsByMultipleCategories(String[] categories) {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT * FROM products WHERE category IN (" + 
                String.join(",", Collections.nCopies(categories.length, "?")) + ")";
            PreparedStatement pst = this.con.prepareStatement(query);
            for (int i = 0; i < categories.length; i++) {
                pst.setString(i + 1, categories[i]);
            }
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getDouble("price"));
                product.setImage(rs.getString("image"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean deleteProduct(int productId) throws ClassNotFoundException {
        // SQL query to delete a product by ID
        String query = "DELETE FROM products WHERE id = ?";
        
        try (Connection connection = DBCon.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            // Set the product ID in the query
            statement.setInt(1, productId);
            
            // Execute the query
            int rowsAffected = statement.executeUpdate();
            
            // Return true if the product was deleted successfully (at least one row affected)
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateProduct(int productId, String name, double price, String category, String image) {
        // SQL query to update the product details by ID
        String query = "UPDATE products SET name = ?, price = ?, category = ?, image = ? WHERE id = ?";

        try (PreparedStatement statement = this.con.prepareStatement(query)) {
            
            // Set the values for the placeholders in the SQL query
            statement.setString(1, name);          // Set the product name
            statement.setDouble(2, price);         // Set the product price
            statement.setString(3, category);      // Set the product category
            statement.setString(4, image);         // Set the product image
            statement.setInt(5, productId);        // Set the product ID (for the WHERE clause)
            
            // Execute the update query
            int rowsAffected = statement.executeUpdate();
            
            // Return true if the update was successful (at least one row affected)
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Return false if there was an error during the update
        }
    }


}
