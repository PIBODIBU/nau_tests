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

    .mdl-card > p {
        padding: 24px 24px 0;
        margin-bottom: 0;
    }

    .mdl-card > ul {
        padding: 0;
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
    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link navigation__sub-link"
               href="${pageContext.request.contextPath}/tests/sessions">Активні
                тести</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>
    <%
    } else {
    %>
    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link navigation__sub-link" href="${pageContext.request.contextPath}/me/tests">Мої
                тести</a>
            <a class="mdl-navigation__link navigation__sub-link"
               href="${pageContext.request.contextPath}/tests/sessions">Активні
                тести</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>
    <%
        }
    %>

    <main class="mdl-layout__content">
        <div class="page-content">
            <%=correctAnswersCount%> / <%=answersCount%>
        </div>
    </main>
</div>
</body>
</html>