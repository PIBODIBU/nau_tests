<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.TimeFormatter" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));
%>

<html>
<head>
    <title>Тести</title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/resources/css/my_page_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/drawer_style.css" rel="stylesheet">
</head>
<body>

<style>
    body {
        width: 100%;
        max-width: 100%;
        background-color: #f9f9f9;
    }

    .page-content {
        width: 100%;
        padding-bottom: 24px;
    }

    .card-square {
        width: 100%;
        max-width: 100%;
        margin-top: 16px;
    }

    .mdl-card__title {
        height: 150px;
        min-height: 150px;
        max-height: 150px;
        padding-left: 16px;
        padding-bottom: 8px;
        color: #ffffff;
        background-color: #2196F3;
    }

    @media screen
    and (max-device-width: 1000px)
    and (max-device-height: 1200px) {
        .page-content {
            width: 100%;
            min-width: 100%;
            margin: 0;
            padding-bottom: 24px;
        }

        .mdl-grid {
            width: 95%;
            min-width: 95%;
        }

        .card-square {
            width: 100%;
            max-width: 100%;
            margin-top: 16px;
        }
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }

    h6 {
        margin: 16px 0 0 0;
    }
</style>

<%ArrayList<Test> tests = ((ArrayList<Test>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_TEST));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Тести</span>
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
                <div class="mdl-cell mdl-cell--6-col mdl-cell--4-col-tablet">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text"><%=test.getName()%>
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=test.getDescription()%>

                            <h6>
                                Час виконання
                                <%=TimeFormatter.dateToHumanMinutes(test.getTime())%>
                            </h6>
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
