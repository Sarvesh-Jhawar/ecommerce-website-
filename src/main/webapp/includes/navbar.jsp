<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">E-Shopping Cart</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item active">
          <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="cart.jsp">Cart <span class="badge badge-danger">${cart_list.size()}</span></a>
        </li>
        <% if (auth != null) { %>
          <!-- Display User Info Box -->
          
          <li class="nav-item">
            <a class="nav-link" href="orders.jsp">Orders</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="user.jsp">My Info</a>
          </li>
          <li class="nav-item ml-auto">
            <a class="nav-link" href="log-out">LogOut</a>
          </li>
        <% } else { %>
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="register.jsp">SignUp/Register</a>
          </li>
        <% } %>
        <li class="nav-item">
                <a class="nav-link" href="about-me.jsp">About Me</a>
            </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Custom CSS for the user info box -->
<style>
  .user-box {
    display: inline-block;
    padding: 5px 10px;
    background-color: #f8f9fa;
    border-radius: 25px;
    font-weight: bold;
    font-size: 1rem;
    color: #007bff;
    border: 1px solid #007bff;
  }

  .user-box span {
    color: #007bff;
  }
</style>
