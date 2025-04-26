E-Commerce Website
📜 Project Description
This project is a fully functional e-commerce website built using Java, MySQL, HTML, and CSS. It allows users to browse products, add them to their cart, and place orders. Admins can manage products, view orders, and control the platform.

The project simulates the core features of popular online shopping platforms like Amazon and Flipkart.

⚙️ Features
User Login & Registration

Admin Login & Dashboard

Product Listings

Add to Cart

Order Placement

Order History Tracking

Admin Product Management (Add, Edit, Delete Products)

Secure Authentication

🛠️ Technologies Used
Backend: Java (Servlets & JSP)

Frontend: HTML, CSS

Database: MySQL

Server: Apache Tomcat

IDE: Eclipse

🚀 How to Run the Project
Follow these steps to set up and run the e-commerce website locally:

1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/your-username/your-repo-name.git
2. Open Project in Eclipse
Open Eclipse IDE.

Go to File -> Import -> Existing Projects into Workspace.

Select the cloned project folder.

3. Set Up MySQL Database
Install and run MySQL Server.

Create a new database (for example, ecommerce_db).

Import the provided .sql file into your database using MySQL Workbench or command line:

sql
Copy
Edit
source path_to_your_project/database/ecommerce_db.sql;
4. Configure Database Connection
Open the project files where the database connection is set (like DBConnection.java or similar).

Update your database URL, username, and password according to your MySQL setup:

java
Copy
Edit
String url = "jdbc:mysql://localhost:3306/ecommerce_db";
String username = "root";
String password = "yourpassword";
5. Configure Tomcat Server
Install Apache Tomcat (preferably version 9 or 10).

In Eclipse, go to Servers tab → New → Server → select Tomcat → configure Tomcat installation directory.

Add your project to the server.

6. Run the Project
Right-click the project → Run As → Run on Server.

Open your browser and navigate to:

bash
Copy
Edit
http://localhost:8080/your-project-name/
7. Login Credentials (Sample)
User Login:
Username: testuser
Password: testpassword

Admin Login:
Username: admin
Password: adminpassword

(You can also create new users from the registration page.)



📚 Documentation
Project Structure
/src/ - Java Servlets and Backend Code

/WebContent/ - HTML, JSP files, and CSS

/database/ - SQL files to create tables

/lib/ - External libraries (like MySQL Connector JAR)

Website Flow
Home Page: Displays available products.

User Login/Registration: Allows users to register and log in.

Product Browsing: Users can view products and add them to cart.

Cart Management: View and update the cart before placing an order.

Order Placement: Confirm and place the order.

Order History: View past orders from the user account.

Admin Dashboard: Admin can add, edit, and delete products.

Database Design
Tables Used:

users - Stores user information (id, name, email, password)

products - Stores product details (id, name, price, description, image)

orders - Stores order information (order id, user id, date, total)

order_items - Stores individual items inside an order (order id, product id, quantity)

(Optional: You can add a small ER Diagram if you want to look more professional.)

Important URLs (Servlets and JSPs)

URL	Purpose
/login.jsp	User login page
/register.jsp	User registration page
/home.jsp	Home page showing products
/cart.jsp	Shopping cart page
/admin/login.jsp	Admin login page
/admin/dashboard.jsp	Admin dashboard
