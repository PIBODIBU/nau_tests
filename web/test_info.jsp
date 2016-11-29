<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.Answer" %>
<%@ page import="ua.edu.nau.model.Question" %>
<%@ page import="ua.edu.nau.model.Test" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%Test test = (Test) request.getAttribute(Attribute.ATTR_TEST_MODEL);%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

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
        background: #f9f9f9;
    }

    .page-content {
        width: 80%;
        margin: 24px auto auto;
        padding-bottom: 24px;
    }

    .card-square {
        padding: 8px;
        width: 100%;
        max-width: 100%;
        margin-top: 16px;
    }

    .mdl-card__title {
        display: inline-block;
    }

    .mdl-card__title > p {
        display: block;
        margin-top: 16px;
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
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
        <span class="mdl-layout-title">Тести</span>
        <nav class="mdl-navigation">
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content">
            <div class="card-square mdl-card mdl-shadow--2dp">
                <div class="mdl-card__title mdl-card--expand">
                    <h2 class="mdl-card__title-text"><%=test.getName()%>
                    </h2>
                </div>

                <div class="mdl-card__supporting-text">
                    <p class="mdl-typography--subhead"><%=test.getDescription()%>
                    </p>
                    <p class="mdl-typography--subhead">Час виконання: <%=test.getTime().toString()%>
                    </p>
                </div>

                <ul class="list-icon mdl-list" style="display: inline-block">
                    <%
                        for (Question question : test.getQuestions()) {
                    %>
                    <li class="mdl-list__item" style="display: block">
                                <span class="mdl-list__item-primary-content" style="display: block">
                                    <%=question.getText()%>
                                </span>

                        <ul class="list-icon mdl-list" style="display: block">
                            <%
                                for (Answer answer : question.getAnswers()) {
                            %>
                            <li class="mdl-list__item">
                                <i class="material-icons mdl-list__item-icon"><%=answer.getCorrect() ? "done" : ""%>
                                </i>
                                <%=answer.getText()%>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>

        <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
            <i class="material-icons">edit</i>
        </button>
    </main>
</div>
</body>
</html>