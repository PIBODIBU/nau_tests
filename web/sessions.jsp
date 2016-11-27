<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.model.Session" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Сесії</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.deep_purple-amber.min.css"/>
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

<%ArrayList<Session> sessions = ((ArrayList<Session>) request.getAttribute("sessions"));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Сесії</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Сесії</span>
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
                    <th class=" mdl-data-table__cell--non-numeric">User id</th>
                </tr>
                </thead>
                <tbody>

                <%
                    for (Session session1 : sessions) {
                %>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><%=session1.getSessionId()%>
                    <td class="mdl-data-table__cell--non-numeric"><%=session1.getUser().getId()%>
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
</body>
</html>
