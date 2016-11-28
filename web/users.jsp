<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Користувачі</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>
</head>
<body>

<style>
    body {
        width: 100%;
        max-width: 100%;
    }

    .page-content {
        width: 80%;
        margin: 24px auto auto;
    }

    table {
        width: 100%;
    }
</style>

<%ArrayList<User> users = ((ArrayList<User>) request.getAttribute("users"));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Користувачі</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>
    </header>
    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Користувачі</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="">Link</a>
        </nav>
    </div>
    <main class="mdl-layout__content">
        <div class="page-content">
            <table class="mdl-data-table mdl-js-data-table  mdl-shadow--2dp">
                <thead>
                <tr>
                    <th class=" mdl-data-table__cell--non-numeric">Id</th>
                    <th class=" mdl-data-table__cell--non-numeric">Name</th>
                    <th class=" mdl-data-table__cell--non-numeric">Username</th>
                    <th class=" mdl-data-table__cell--non-numeric">Password</th>
                    <th class=" mdl-data-table__cell--non-numeric">Email</th>
                </tr>
                </thead>
                <tbody>

                <%
                    for (User user : users) {
                %>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getId()%>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getUsername()%>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getPassword()%>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </main>
</div>

<%--<h2>User roles</h2>
<table>
    <tr>
        <th>Id</th>
        <th>Code</th>
        <th>Description</th>
    </tr>

    <%
        for (User user : users) {
    %>
    <tr>
        <td><%=user.getUserRole().getRoleId()%>
        </td>
        <td><%=user.getUserRole().getRoleCode()%>
        </td>
        <td><%=user.getUserRole().getDescription()%>
        </td>
    </tr>
    <%
        }
    %>
</table>--%>
</body>
</html>
