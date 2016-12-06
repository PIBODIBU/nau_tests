<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ua.edu.nau.helper.TimeFormatter" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));
%>

<html>
<head>
    <title>Мої тести</title>

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

    .card-square {
        width: 100%;
        max-width: 100%;
        margin-top: 16px;
    }

    .mdl-card__title {
        padding-left: 16px;
        padding-bottom: 8px;
        color: #ffffff;
        background-color: #2196F3;
    }

    .mdl-card__supporting-text {
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }
</style>

<%ArrayList<Test> tests = ((ArrayList<Test>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_TEST));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Мої тести</span>
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
            <div class="mdl-grid">
                <%
                    for (Test test : tests) {
                %>
                <div class="mdl-cell mdl-cell--6-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text"><%=test.getName()%>
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=test.getDescription()%>
                            <br/>
                            Час виконання
                            <%=TimeFormatter.dateToHumanMinutes(test.getTime())%>
                        </div>

                        <div class="mdl-card__actions mdl-card--border">
                            <form action="${pageContext.request.contextPath}/test/info" method="post">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>" value="<%=test.getId()%>">
                                <button class="mdl-button mdl-js-button mdl-button--primary"
                                        style="float: left;"
                                        type="submit">
                                    Детальніше
                                </button>
                            </form>

                            <form action="${pageContext.request.contextPath}/tests/sessions" method="post">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>" value="<%=test.getId()%>">
                                <button class="mdl-button mdl-js-button mdl-button--primary"
                                        type="submit">
                                    Розпочати
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/tests/add">
            <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored"
                    id="fab-test-add">
                <i class="material-icons">add</i>
            </button>
        </a>
    </main>

    <div class="mdl-tooltip mdl-tooltip--left" data-mdl-for="fab-test-add">
        Додати тест
    </div>
</div>
</body>
</html>