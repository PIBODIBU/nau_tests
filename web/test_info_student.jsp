<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%Test test = (Test) request.getAttribute(Attribute.ATTR_TEST_MODEL);%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
</head>
<body>

<style>
    body {
        width: 100%;
        max-width: 100%;
        background: #f9f9f9;
    }

    .page-content {
        width: 90%;
        /*margin: 24px auto auto;*/
        margin: auto;
        padding-bottom: 24px;
    }

    .card-square {
        width: 100%;
        max-width: 100%;
        margin: auto;
    }

    .mdl-card__title {
        background-color: #2196F3;
        color: #ffffff;
        min-height: 150px;
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }

    .mdl-grid {
        padding: 0;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        margin: auto;
    }

    .mdl-card__actions {
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

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content">
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--6-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text">Опис
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <p class="mdl-typography--subhead"><%=test.getDescription()%>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text">Час виконання
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <p class="mdl-typography--subhead"><%=test.getTime().toString()%>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text">Власник
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <p class="mdl-typography--subhead"><%=test.getOwner().getName()%>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>