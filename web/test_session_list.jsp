<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.model.TestSession" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Мої тести</title>

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

    .mdl-card__supporting-text {
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }
</style>

<%ArrayList<TestSession> testSessions = ((ArrayList<TestSession>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION));%>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Тести</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/test/sessions">Мої тести</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content">
            <div class="mdl-grid">
                <%
                    for (TestSession testSession : testSessions) {
                %>
                <div class="mdl-cell mdl-cell--6-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand" style="
                                padding-bottom: 8px;
                                padding-left: 16px;
                                color: #ffffff;
                                background-color: <%=testSession.getDone()?"#F44336":"#2196F3"%>;">
                            <h2 class="mdl-card__title-text"><%=testSession.getTest().getName()%>
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=testSession.getTest().getDescription()%>
                        </div>

                        <div class="mdl-card__actions mdl-card--border">
                            <form action="${pageContext.request.contextPath}/test/info" method="post">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>"
                                       value="<%=testSession.getId()%>">
                                <button class="mdl-button mdl-js-button mdl-button--primary"
                                        type="submit">
                                    Детальніше
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

        <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
            <i class="material-icons">add</i>
        </button>
    </main>
</div>
</body>
</html>