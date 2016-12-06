<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.TestSession" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));
    ArrayList<TestSession> testSessions = ((ArrayList<TestSession>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION));
    Boolean redirectToSessionPage = ((Boolean) request.getAttribute(Attribute.ATTR_SESSION_REDIRECT_TO_PAGE));
    Integer redirectSessionId = ((Integer) request.getAttribute(Attribute.ATTR_SESSION_REDIRECT_ID));
    Integer redirectTestId = ((Integer) request.getAttribute(Attribute.ATTR_TEST_ID));
%>

<html>
<head>
    <title>Активні тести</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>

    <link href="${pageContext.request.contextPath}/css/my_page_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
</head>
<body onload="checkRedirect()">

<script type="text/javascript">
    function checkRedirect() {
        var form = document.getElementById("form-redirect");
        form.submit();
    }
</script>

<%
    if (redirectToSessionPage) {
%>
<form id="form-redirect" action="${pageContext.request.contextPath}/tests/sessions/start" method="post">
    <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>"
           value="<%=redirectTestId%>">
    <input type="hidden" name="<%=Parameter.PARAM_TEST_SESSION_ID%>"
           value="<%=redirectSessionId%>">
</form>
<%
    }
%>

<style>
    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }

    .mdl-card__actions {
        display: table;
    }

    .text-result {
        display: table-cell;
        vertical-align: middle;
        text-align: right;
        margin-right: 16px;
    }
</style>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Активні тести</span>
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
                    for (TestSession testSession : testSessions) {
                %>
                <div class="mdl-cell mdl-cell--6-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <%
                            if (testSession.getDone()) {
                        %>
                        <div class="mdl-card__title mdl-card--expand" style="
                                padding-bottom: 8px;
                                padding-left: 16px;
                                color: #ffffff;
                                background-color: #F44336;">
                            <h2 class="mdl-card__title-text"><%=testSession.getTest().getName()%>
                            </h2>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="mdl-card__title mdl-card--expand" style="
                                padding-bottom: 8px;
                                padding-left: 16px;
                                color: #ffffff;
                                background-color: #2196F3;">
                            <h2 class="mdl-card__title-text"><%=testSession.getTest().getName()%>
                            </h2>
                        </div>
                        <%
                            }
                        %>

                        <div class="mdl-card__supporting-text">
                            <%=testSession.getTest().getDescription()%>
                        </div>

                        <div class="mdl-card__actions mdl-card--border">
                            <form action="${pageContext.request.contextPath}/test/info" method="post">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>"
                                       value="<%=testSession.getTest().getId()%>">
                                <button class="mdl-button mdl-js-button mdl-button--primary"
                                        style="float: left"
                                        type="submit">
                                    Детальніше
                                </button>
                            </form>

                            <%
                                if (!testSession.getDone()) {
                            %>
                            <form action="${pageContext.request.contextPath}/tests/sessions/start" method="post">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>"
                                       value="<%=testSession.getTest().getId()%>">
                                <input type="hidden" name="<%=Parameter.PARAM_TEST_SESSION_ID%>"
                                       value="<%=testSession.getId()%>">
                                <button class="mdl-button mdl-js-button mdl-button--primary"
                                        type="submit">
                                    Продовжити
                                </button>
                            </form>
                            <%
                            } else {
                            %>
                            <p class="mdl-typography--subhead-color-contrast text-result">
                                Результат
                                <%=testSession.getCorrectAnswers()%> / <%=testSession.getTest().getQuestions().size()%>
                            </p>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <%if (user.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {%>
        <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
            <i class="material-icons">add</i>
        </button>
        <%
            }
        %>
    </main>
</div>
</body>
</html>