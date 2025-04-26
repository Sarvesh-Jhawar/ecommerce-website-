<%@ page import="cn.techtutorial.model.User"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
   <div class="container">
     <a class="navbar-brand" href="admin-dashboard.jsp">E-Shopping Cart</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
       <span class="navbar-toggler-icon"></span>
     </button>

     <div class="collapse navbar-collapse" id="navbarSupportedContent">
       <ul class="navbar-nav ml-auto">
         <% 
           User auth = (User) session.getAttribute("auth"); 
           if (auth != null && "admin".equalsIgnoreCase(auth.getRole())) { 
         %>
           <!-- Admin specific options -->
           <li class="nav-item active">
             <a class="nav-link" href="admin-dashboard.jsp">Admin Dashboard <span class="sr-only">(current)</span></a>
           </li>
           
           <li class="nav-item">
             <a class="nav-link" href="manage-users.jsp">Manage Users</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="upload_product.jsp">Add Product</a>
           </li>
           <li class="nav-item ml-auto">
             <a class="nav-link" href="log-out">LogOut</a>
           </li>
         <% } else { %>
           <!-- If not logged in as admin -->
           <li class="nav-item">
             <a class="nav-link" href="login.jsp">Login</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="register.jsp">SignUp/Register</a>
           </li>
         <% } %>
       </ul>
     </div>
   </div>
 </nav>
