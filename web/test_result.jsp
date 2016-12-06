<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page import="ua.edu.nau.model.User" %>

<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>
<%Test test = ((Test) request.getAttribute(Attribute.ATTR_TEST_MODEL));%>
<%Integer answersCount = (Integer) request.getAttribute(Attribute.ATTR_ANSWERS_COUNT);%>
<%Integer correctAnswersCount = (Integer) request.getAttribute(Attribute.ATTR_CORRECT_ANSWERS_COUNT);%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/body_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/timer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">
</head>

<body>

<style>
    .mdl-card {
        width: 80%;
        min-width: 80%;
        max-width: 80%;
        margin: 24px auto auto;
    }

    .page-content {
        padding-bottom: 24px;
    }

    .mdl-card__title {
        background: #2196F3;
        color: #ffffff;
    }
</style>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title"><%=test.getName()%></span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>
    </header>

    <%
        if (user.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
    %>
    <jsp:include page="/jsp/drawer_student.jsp"/>
    <%
    } else if (user.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
    %>
    <jsp:include page="/jsp/drawer_root.jsp"/>
    <%
        }
    %>

    <main class="mdl-layout__content">
        <div class="page-content">
            <div class="card-square mdl-card mdl-shadow--8dp">
                <div class="mdl-card__title mdl-card--expand card-info-title-main">
                    <h2 class="mdl-card__title-text">Результат
                    </h2>
                </div>

                <div class="mdl-card__supporting-text">
                    <h6><%=correctAnswersCount%> <%=correctAnswersCount == 1 ? "правильна відповідь" : "правильних відповідей"%>
                        з <%=answersCount%>
                    </h6>
                </div>
            </div>
    </main>
</div>
</body>
</html>