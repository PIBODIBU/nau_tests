<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Group" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User activeUser = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>
<%ArrayList<Group> groups = ((ArrayList<Group>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_GROUP));%>

<html>
<head>
    <title>Користувачі</title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab-menu.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/mdl-selectfield/mdl-selectfield.min.css">
    <script src="${pageContext.request.contextPath}/js/mdl-selectfield/mdl-selectfield.min.js"></script>
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
        padding-bottom: 24px;
    }

    .mdl-data-table {
        margin: 24px auto;
    }

    .mdl-button--fab {
        position: relative;
    }

    .mdl-button--fab-menu {
        right: 0;
        bottom: 0;
    }

    .chips-wrapper {
        width: 100%;
        padding: 16px;
    }
</style>

<%ArrayList<User> users = ((ArrayList<User>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_USER));%>

<script type="text/javascript">
    function printUsers() {
        var form = document.getElementById("form-students");
        var inputAction = document.createElement("input");

        inputAction.name = "action";
        inputAction.value = "print_students";
        inputAction.type = "hidden";

        form.action = "/users";
        form.method = "post";
        form.appendChild(inputAction);
        form.submit();
    }

    function onStudentRandomizePasswords() {
        var form = document.getElementById("form-students");
        var inputAction = document.createElement("input");

        inputAction.name = "action";
        inputAction.value = "action_randomize_pass";
        inputAction.type = "hidden";

        form.action = "/users";
        form.method = "post";
        form.appendChild(inputAction);
        form.submit();
    }

    function onStudentDelete() {
        var form = document.getElementById("form-students");
        var inputAction = document.createElement("input");

        inputAction.name = "action";
        inputAction.value = "action_delete_students";
        inputAction.type = "hidden";

        form.action = "/users";
        form.method = "post";
        form.appendChild(inputAction);
        form.submit();
    }

    function addStudent() {
        window.location = "/register";
    }

    function onGroupChanged(groupId) {
        var inputGroupId = document.createElement("input");
        var form = document.getElementById('form-students');

        inputGroupId.name = '<%=Parameter.PARAM_GROUP_ID%>';
        inputGroupId.value = groupId;
        inputGroupId.type = 'hidden';

        form.appendChild(inputGroupId);
        form.method = 'get';
        form.submit();
    }
</script>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--fixed-tabs">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Користувачі</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>

        <!-- Tabs -->
        <div class="mdl-layout__tab-bar mdl-js-ripple-effect">
            <a href="#fixed-tab-1" class="mdl-layout__tab is-active">Студенти</a>
            <a href="#fixed-tab-2" class="mdl-layout__tab">Адміністратори</a>
            <a href="#fixed-tab-3" class="mdl-layout__tab">Модератори</a>
            <a href="#fixed-tab-4" class="mdl-layout__tab">Root</a>
        </div>
    </header>

    <%
        if (activeUser.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
    %>
    <jsp:include page="/jsp/drawer_student.jsp"/>
    <%
    } else if (activeUser.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
    %>
    <jsp:include page="/jsp/drawer_root.jsp"/>
    <%
        }
    %>

    <main class="mdl-layout__content">
        <section class="mdl-layout__tab-panel is-active" id="fixed-tab-1">

            <%--<div class="chips-wrapper"></div>--%>

            <form id="form-students" action="${pageContext.request.contextPath}/users" method="post">
                <div class="table-wrapper--full-width">
                    <table class="mdl-data-table mdl-js-data-table mdl-shadow--4dp mdl-data-table--full-width">
                        <thead>
                        <tr>
                            <th style="width: 1%;">
                                <button id="fab-choose-group"
                                        class="mdl-button mdl-js-button mdl-button--icon"
                                        type="button">
                                    <i class="material-icons">supervisor_account</i>
                                </button>

                                <div class="mdl-tooltip" data-mdl-for="fab-choose-group">
                                    Обрати групу
                                </div>

                                <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                                    for="fab-choose-group">
                                    <%
                                        for (Group group : groups) {
                                    %>
                                    <li class="mdl-menu__item"
                                        onclick="onGroupChanged('<%=group.getId()%>')"><%=group.getName()%>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </th>
                            <th>ID</th>
                            <th class="mdl-data-table__cell--non-numeric">Ім'я</th>
                            <th class="mdl-data-table__cell--non-numeric">Група</th>
                            <th class="mdl-data-table__cell--non-numeric">Заліковка</th>
                            <th class="mdl-data-table__cell--non-numeric">Пароль</th>
                            <th class="mdl-data-table__cell--non-numeric">Email</th>
                        </tr>
                        </thead>

                        <%
                            for (User user : users) {
                                if (user.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
                        %>
                        <tr>
                            <td>
                                <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
                                       for="checkbox-<%=user.getId()%>">
                                    <input type="checkbox"
                                           id="checkbox-<%=user.getId()%>"
                                           name="students"
                                           value="<%=user.getId()%>"
                                           class="mdl-checkbox__input"/>
                                </label>
                            </td>
                            <td><%=user.getId()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getGroup().getName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getUsername()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getPassword()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>

                <div class="mdl-button--fab-menu">
                    <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored mdl-button--fab-menu-item"
                            id="button-print"
                            type="button"
                            onclick="printUsers()">
                        <i class="material-icons">print</i>
                    </button>
                    <div class="mdl-tooltip mdl-tooltip--left"
                         data-mdl-for="button-print">
                        Роздрукувати паролі
                    </div>

                    <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored mdl-button--fab-menu-item"
                            id="button-randomize-pass"
                            type="button"
                            onclick="onStudentRandomizePasswords()">
                        <i class="material-icons">cached</i>
                    </button>
                    <div class="mdl-tooltip mdl-tooltip--left"
                         data-mdl-for="button-randomize-pass">
                        Рандомізувати пароль
                    </div>

                    <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored mdl-button--fab-menu-item"
                            id="button-delete_students"
                            type="button"
                            onclick="onStudentDelete()">
                        <i class="material-icons">delete</i>
                    </button>
                    <div class="mdl-tooltip mdl-tooltip--left"
                         data-mdl-for="button-delete_students">
                        Видалити
                    </div>

                    <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored mdl-button--fab-menu-item"
                            id="button-add_student"
                            type="button"
                            onclick="addStudent()">
                        <i class="material-icons">add</i>
                    </button>
                    <div class="mdl-tooltip mdl-tooltip--left"
                         data-mdl-for="button-add_student">
                        Додати студента
                    </div>
                </div>
            </form>
        </section>
        <section class="mdl-layout__tab-panel" id="fixed-tab-2">
            <div class="page-content">
                <div class="table-wrapper">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--8dp">
                        <thead>
                        <tr>
                            <th class="mdl-data-table__cell--non-numeric">Ім'я</th>
                            <th class="mdl-data-table__cell--non-numeric">Email</th>
                            <th class="mdl-data-table__cell--non-numeric">Рівень доступу</th>
                        </tr>
                        </thead>

                        <%
                            for (User user : users) {
                                if (user.getUserRole().getRoleCode().equals(RoleCode.ADMIN)) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getUserRole().getDescription()%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </section>
        <section class="mdl-layout__tab-panel" id="fixed-tab-3">
            <div class="page-content">
                <div class="table-wrapper">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--8dp">
                        <thead>
                        <tr>
                            <th class="mdl-data-table__cell--non-numeric">Ім'я</th>
                            <th class="mdl-data-table__cell--non-numeric">Email</th>
                            <th class="mdl-data-table__cell--non-numeric">Рівень доступу</th>
                        </tr>
                        </thead>

                        <%
                            for (User user : users) {
                                if (user.getUserRole().getRoleCode().equals(RoleCode.MODERATOR)) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getUserRole().getDescription()%>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </section>
        <section class="mdl-layout__tab-panel" id="fixed-tab-4">
            <div class="page-content">
                <div class="table-wrapper">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--8dp">
                        <thead>
                        <tr>
                            <th class="mdl-data-table__cell--non-numeric">Ім'я</th>
                            <th class="mdl-data-table__cell--non-numeric">Email</th>
                            <th class="mdl-data-table__cell--non-numeric">Рівень доступу</th>
                        </tr>
                        </thead>

                        <%
                            for (User user : users) {
                                if (user.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
                                    if (!user.getName().equals("God")) {
                        %>
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><%=user.getUserRole().getDescription()%>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </section>
    </main>
</div>
</body>
</html>
