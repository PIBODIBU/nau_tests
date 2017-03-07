<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.*" %>
<%@ page import="ua.edu.nau.helper.TimeFormatter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Test test = (Test) request.getAttribute(Attribute.ATTR_TEST_MODEL);
    User user = (User) request.getAttribute(Attribute.ATTR_USER_MODEL);
    ArrayList<TestSession> todayTestSessions =
            ((ArrayList<TestSession>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_TEST_SESSION_TODAY));
%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/resources/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/table.css" rel="stylesheet">
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
        margin: auto;
        padding-bottom: 24px;
    }

    .card-square {
        width: 100%;
        max-width: 100%;
        margin: auto;
    }

    .mdl-card__title {
        background-color: <%=test.getColor()%>;
        color: #ffffff;
        min-height: 150px;
    }

    .mdl-grid {
        padding: 0;
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        margin: auto;
    }

    .mdl-data-table {
        width: 100%;
        max-width: 100%;
        min-width: 100%;
        margin: 0;
        border-width: 0;
    }

    .mdl-card {
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
                <div class="mdl-cell mdl-cell--6-col mdl-cell--6-col-phone">
                    <div class="card-square mdl-card mdl-shadow--4dp">
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
                
                <div class="mdl-cell mdl-cell--3-col mdl-cell--6-col-phone">
                    <div class="card-square mdl-card mdl-shadow--4dp">
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

                <div class="mdl-cell mdl-cell--3-col mdl-cell--6-col-phone">
                    <div class="card-square mdl-card mdl-shadow--4dp">
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

                <div class="mdl-cell mdl-cell--12-col">
                    <div class="card-square mdl-card mdl-shadow--4dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text">Питання
                            </h2>
                        </div>

                        <ul class="list-icon mdl-list" style="display: inline-block">
                            <%
                                int questionCounter = 1;
                                int answerCounter = 0;
                                char[] alphabet = "абвгґдеєжзиіїйклмнопрстуфхцчшщьюя".toCharArray();

                                for (Question question : test.getQuestions()) {
                            %>
                            <li class="mdl-list__item" style="display: block">
                                <span class="mdl-list__item-primary-content" style="display: block">
                                    <%=questionCounter%>. <%=question.getText()%>
                                </span>

                                <ul class="list-icon mdl-list" style="display: block">
                                    <%
                                        for (Answer answer : question.getAnswers()) {
                                    %>
                                    <li class="mdl-list__item">
                                        <i class="material-icons mdl-list__item-icon"><%=answer.getCorrect() ? "done" : ""%>
                                        </i>
                                        <%=alphabet[answerCounter]%>) <%=answer.getText()%>
                                    </li>
                                    <%
                                            answerCounter++;
                                        }
                                    %>
                                </ul>
                            </li>
                            <%
                                    answerCounter = 0;
                                    questionCounter++;
                                }
                            %>
                        </ul>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--12-col">
                    <div class="card-square mdl-card mdl-shadow--4dp">
                        <div class="mdl-card__title mdl-card--expand">
                            <h2 class="mdl-card__title-text">Результати за сьогодні
                            </h2>
                        </div>

                        <div class="table-wrapper">
                            <table class="mdl-data-table mdl-js-data-table mdl-data-table_full-width">
                                <thead>
                                <tr>
                                    <th>№</th>
                                    <th class="mdl-data-table__cell--non-numeric">Учасник</th>
                                    <th class="mdl-data-table__cell--non-numeric">Назва</th>
                                    <th class="mdl-data-table__cell--non-numeric">Дата початку</th>
                                    <th class="mdl-data-table__cell--non-numeric">Дата закінчення</th>
                                    <th>Правильних відповідей</th>
                                    <th>К-ть питань</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    int counter = 1;

                                    for (TestSession testSession : todayTestSessions) {
                                %>
                                <tr>
                                    <td><%=counter%>
                                    </td>
                                    <td class="mdl-data-table__cell--non-numeric"><%=testSession.getUser().getName()%>
                                    <td class="mdl-data-table__cell--non-numeric"><%=testSession.getTest().getName()%>
                                    <td class="mdl-data-table__cell--non-numeric">
                                        <%=TimeFormatter.dateToHumanReadable(testSession.getStartTime())%>
                                    </td>
                                    <td class="mdl-data-table__cell--non-numeric">
                                        <%
                                            if (testSession.getEndTime() != null) {
                                                out.print(TimeFormatter.dateToHumanReadable(testSession.getEndTime()));
                                            } else {
                                                out.print("Не здав");
                                            }
                                        %>
                                    </td>
                                    <td><%=testSession.getCorrectAnswers()%>
                                    </td>
                                    <td><%=testSession.getTest().getQuestions().size()%>
                                    </td>
                                </tr>
                                <%
                                        counter++;
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>