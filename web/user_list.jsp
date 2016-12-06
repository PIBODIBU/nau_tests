<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User activeUser = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>

<html>
<head>
    <title>Користувачі</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
</head>
<body>

<style>
    body {
        width: 100%;
        max-width: 100%;
        background-color: #f9f9f9;
    }

    .page-content {
        width: 80%;
        margin: auto;
    }

    .mdl-data-table {
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        margin: 24px auto auto;
    }
</style>

<%ArrayList<User> users = ((ArrayList<User>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_USER));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Користувачі</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>
    </header>

    <%
        if (activeUser.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
    %>
    <jsp:include page="/jsp/drawer_student.jsp"/>
    <%
    } else if (activeUser.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
    %>
    <jsp:include page="/jsp/drawer_root.jsp"/>
    <%
        }
    %>

    <main class="mdl-layout__content">
        <div class="page-content">
            <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
                <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric">Ім'я</th>
                    <th class="mdl-data-table__cell--non-numeric">Email</th>
                    <th class="mdl-data-table__cell--non-numeric">Рівень доступу</th>
                </tr>
                </thead>

                <%
                    for (User user : users) {
                %>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getUserRole().getDescription()%>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </main>
</div>
</body>
</html>
