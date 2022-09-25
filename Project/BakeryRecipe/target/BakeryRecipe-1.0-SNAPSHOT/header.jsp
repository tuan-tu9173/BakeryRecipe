<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="assets/css/header.css">
<script src="assets/js/header.js"></script>
<header class="header-container header">
    <div class="header-left col-sm-12 col-md-6 p-0">
        <a class="header-logo col-md-3 p-0" href="./home.html">
            <img class="w-75 mx-auto" src="assets/public/800250px1@2x.png" alt="">
        </a>
        <nav class="header-links col-md col p-0 ">
            <a class="header-link col p-md-0 p-2 border-0 active" href="./home.jsp">Home</a>
            <a class="header-link col p-md-0 p-2 border-0" href="./community.jsp">Community</a>
            <a class="header-link col p-md-0 p-2 border-0" href="./saved.jsp">Saved</a>
            <a class="header-link col p-md-0 p-2 border-0" href="./shopping.jsp">Shopping</a>
        </nav>
    </div>
    <div class="header-right col-sm-12 col-md px-2 justify-content-md-center">
        <div class="searchbar col-md col px-3 px-md-0">
            <i class="searchbar-icon fa-solid fa-magnifying-glass"></i>
            <input class="searchbar-input col p-0" type="text" placeholder="Search" name="searchbar">
        </div>
        <i class="header-notification fa-solid fa-bell"></i>
        <a href="login.html" class="header-button" data-type="register">
            <div class="header-button-detail p-0">Sign up / Sign in</div>
        </a>
    </div>
</header>