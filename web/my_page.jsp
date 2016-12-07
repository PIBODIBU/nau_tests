<%@ page import="ua.edu.nau.helper.TimeFormatter" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.TestSession" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>

<html>
<head>
    <title><%=user.getName()%>
    </title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/my_page_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">
                <i class="material-icons mdl-color-text--white icon-my-avatar">account_circle</i>
                <%=user.getName()%>
            </span>
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
                <div class="mdl-cell mdl-cell--12-col">
                    <p class="mdl-typography--display-1-color-contrast">Основна інформація</p>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-main">
                            <h2 class="mdl-card__title-text">Ім'я користувача
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getName()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-main">
                            <h2 class="mdl-card__title-text">Логін
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getUsername()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-main">
                            <h2 class="mdl-card__title-text">Email
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getEmail()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--12-col">
                    <p class="mdl-typography--display-1-color-contrast">Системна інформація</p>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-system">
                            <h2 class="mdl-card__title-text">Ідентифікатор користувача
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getId()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-system">
                            <h2 class="mdl-card__title-text">Рівень доступу
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getUserRole().getDescription()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-system">
                            <h2 class="mdl-card__title-text">Ідентифікатор рівня доступу
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getUserRole().getRoleId()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--3-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-system">
                            <h2 class="mdl-card__title-text">Код рівня доступу
                            </h2>
                        </div>

                        <div class="mdl-card__supporting-text">
                            <%=user.getUserRole().getRoleCode()%>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--12-col">
                    <p class="mdl-typography--display-1-color-contrast">Інформація про тести</p>
                </div>

                <div class="mdl-cell mdl-cell--12-col">
                    <div class="card-square mdl-card mdl-shadow--2dp">
                        <div class="mdl-card__title mdl-card--expand card-info-title-tests-done">
                            <h2 class="mdl-card__title-text">Завершені тести
                            </h2>
                        </div>

                        <table class="mdl-data-table mdl-js-data-table mdl-data-table_full-width">
                            <thead>
                            <tr>
                                <th>№</th>
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

                                for (TestSession testSession : user.getTestSessions()) {
                                    if (testSession.getDone()) {
                            %>
                            <tr>
                                <td><%=counter%>
                                </td>
                                <td class="mdl-data-table__cell--non-numeric"><%=testSession.getTest().getName()%>
                                <td class="mdl-data-table__cell--non-numeric">
                                    <%=TimeFormatter.dateToHumanReadable(testSession.getStartTime())%>
                                </td>
                                <td class="mdl-data-table__cell--non-numeric">
                                    <%=TimeFormatter.dateToHumanReadable(testSession.getEndTime())%>
                                </td>
                                <td><%=testSession.getCorrectAnswers()%>
                                </td>
                                <td><%=testSession.getTest().getQuestions().size()%>
                                </td>
                            </tr>
                            <%
                                        counter++;
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>