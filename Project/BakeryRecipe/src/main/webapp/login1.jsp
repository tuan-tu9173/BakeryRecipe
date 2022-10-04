<%-- 
    Document   : login1
    Created on : Oct 3, 2022, 8:36:01 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8" />
        <meta name="viewport" content="initial-scale=1, width=device-width" />
        <meta name="description" content="" />
        <link rel="icon" href="./assets/images/logo/logo1.png" type="image/x-icon">

        <title>Welcome to Bakery Recipe</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Gelasio:wght@400;500;700&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Abel:wght@400&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Beau Rivage:wght@400&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Arima Madurai:wght@800&display=swap"
            />
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Abhaya Libre:wght@700&display=swap"
            />
        <link href="assets/css/fontawesome-free-6.1.1-web/css/all.min.css" rel="stylesheet" type="text/css"/>
        <!--<script src="https://apis.google.com/js/platform.js" async defer></script>-->
        <!--<meta name="google-signin-client_id" content="243057477675-ti2g5mjdpfrnq5vsgqgdtj3ph3j4ert6">-->
        <!--<link href="assets/css/bootstrap-4.3.1.min.css" rel="stylesheet" type="text/css"/>-->
        <script src="assets/js/Jquery/jquery-core.js" ></script>
        <script src="https://accounts.google.com/gsi/client" async defer></script>
        <script src="assets/js/googleLogin.js"></script>
        <link rel="stylesheet" href="assets/css/login1.css" />
    </head>
    <body>
        <c:import url="header.jsp"/>
        <section class="section container-fluid row">
            <aside class="col-7">
            </aside>
            <aside class="col-5  mx-auto" id="login">
                <form class="login-form  mx-auto flex-column d-flex align-items-center" action="login" method="post">
                    <div class="join-bakeryrecipe-div col-10">WELCOME BACK<br> to <br>Bakery Recipe</div>
                    <div class="d-none" id="g_id_onload" data-client_id="243057477675-kt58mr9lav8eh6ti9bfrj8p782j7unkd.apps.googleusercontent.com" data-login_uri="BakeryRecipe/home.jsp" data-callback="handleCredentialResponse">
                    </div>
                    <div class="g_id_signin" data-type="icon" data-size="large" placeholder="Email" data-theme="filled_blue" data-text="sign_in_with" data-shape="circle" data-logo_alignment="left"><div class="S9gUrf-YoZ4jf" style="position: relative;"><div></div><iframe src="https://accounts.google.com/gsi/button?type=icon&amp;size=large&amp;theme=filled_blue&amp;text=sign_in_with&amp;shape=circle&amp;logo_alignment=left&amp;client_id=243057477675-kt58mr9lav8eh6ti9bfrj8p782j7unkd.apps.googleusercontent.com&amp;iframe_id=gsi_812950_790204&amp;as=MCsvGUZ%2Fo6jE5lvjeZjhzQ" id="gsi_812950_790204" title="Sign in with Google Button" style="display: block; position: relative; top: 0px; left: 0px; height: 44px; width: 64px; border: 0px; margin: -2px -12px;"></iframe></div></div>
                    <div class="input col-10 p-0">
                        <input class="email-input1 col " type="text"  required="" name="email">
                    </div>
                    <input class="password-input1 col-10" type="password" placeholder="Password" required="" name="password">
                    <div></div>
                    <div class="joining-bakeryrecipe-is-quick col-10">Forgot your password?</div>
                    <button class="submit-button col-10" type="submit" form="login">
                        <b class="login-b">LOGIN</b>
                    </button>
                    <div class="sign-up-button d-md-none col-10">
                        <b class="login-b">Don't have account? Sign up</b>
                    </div>
                </form>
            </aside>

        </section>
        <!--Google Login Dont Touch-->
        <form class="d-none" id="googleLogin" action="login" method="POST"></form>
        <script src="assets/js/login.js" type="text/javascript"></script>
    </body>

</html>