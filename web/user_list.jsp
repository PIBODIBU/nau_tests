<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Group" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User activeUser = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));
    ArrayList<Group> groups = ((ArrayList<Group>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_GROUP));
    ArrayList<Group> chooseGroups = ((ArrayList<Group>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_GROUP_CHOOSE));
    ArrayList<User> users = ((ArrayList<User>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_USER));
%>

<html>
<head>
    <title>Користувачі</title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab-menu.css" rel="stylesheet">
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
        margin: auto;
        padding-bottom: 24px;
    }

    .mdl-data-table {
        margin: auto;
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
        margin: 0 8px 0 0;
        position: relative;
    }

    .table-wrapper--full-width {
        margin: 0;
        padding: 0 0 16px 0;
    }

    .mdl-menu__container {
        /*max-height: 150px;
        overflow-x: hidden;
        overflow-y: auto;*/
    }

    .tool-btn {
        margin: 16px 8px;
    }

    .tool-btn--group-chooser {
    }

    .mdl-grid {
        padding: 0;
        margin: 0;
    }

    .mdl-cell {
        padding: 0;
    }

    .mdl-grid--tools-wrapper {
        margin-top: 24px;
        padding: 24px;
    }

    .mdl-grid--tools-wrapper-first {

    }

    .mdl-tools--title {
        margin: 0;
        padding: 0;
    }

    .mdl-grid--tools-content {
        margin-top: 8px;
    }
</style>

<script type="text/javascript">
    function printUsers() {
        var form = document.getElementById("form-students");
        var inputAction = document.createElement("input");
        var inputsChooseGroups = document.getElementsByName("<%=Parameter.PARAM_GROUP_CHOOSE_ID%>");

        inputAction.name = "action";
        inputAction.value = "print_students";
        inputAction.type = "hidden";

        for (var i = 0; i < inputsChooseGroups.length; i++) {
            form.appendChild(inputsChooseGroups[i]);
        }

        form.action = "/users";
        form.method = "post";
        form.appendChild(inputAction);
        form.submit();
    }

    function onStudentRandomizePasswords() {
        var form = document.getElementById("form-students");
        var inputsChooseGroups = document.getElementsByName("<%=Parameter.PARAM_GROUP_CHOOSE_ID%>");
        var inputAction = document.createElement("input");

        inputAction.name = "action";
        inputAction.value = "action_randomize_pass";
        inputAction.type = "hidden";

        for (var i = 0; i < inputsChooseGroups.length; i++) {
            form.appendChild(inputsChooseGroups[i]);
        }

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

        var inputsChooseGroups = document.getElementsByName("<%=Parameter.PARAM_GROUP_CHOOSE_ID%>");

        for (var i = 0; i < inputsChooseGroups.length; i++) {
            form.appendChild(inputsChooseGroups[i]);
        }

        form.action = "/users";
        form.method = "post";
        form.appendChild(inputAction);
        form.submit();
    }

    function addStudent() {
        window.location = "/register";
    }

    function onGroupAdded(groupId) {
        var inputGroupId = document.createElement("input");
        var form = document.getElementById('form-students-groups-chips');
        var duplicated = false;
        var inputsChooseGroups = document.getElementsByName("<%=Parameter.PARAM_GROUP_CHOOSE_ID%>");

        for (var i = 0; i < inputsChooseGroups.length; i++) {
            if (inputsChooseGroups[i].value == groupId) {
                duplicated = true;
            }
        }

        if (!duplicated) {
            inputGroupId.name = '<%=Parameter.PARAM_GROUP_CHOOSE_ID%>';
            inputGroupId.value = groupId;
            inputGroupId.type = 'hidden';
            form.appendChild(inputGroupId);
        }

        form.method = 'get';
        form.submit();
    }

    function onGroupChipDelete(chipLayoutId, deletedGroupId) {
        var inputsChooseGroups = document.getElementsByName("<%=Parameter.PARAM_GROUP_CHOOSE_ID%>");
        var form = document.getElementById('form-students-groups-chips');

        for (var i = 0; i < inputsChooseGroups.length; i++) {
            if (inputsChooseGroups[i].value == deletedGroupId) {
                $('#' + inputsChooseGroups[i].id).remove();
            }
        }

        $('#' + chipLayoutId).remove();

        form.method = 'get';
        form.submit();
    }
</script>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Користувачі</span>
            <div class="mdl-layout-spacer"></div>
        </div>

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
            <div class="mdl-grid">
                <div class="mdl-cell mdl-cell--4-col">
                    <div class="chips-wrapper">
                        <div class="mdl-grid mdl-shadow--8dp mdl-grid--tools-wrapper-first">
                            <button id="fab-choose-group"
                                    class="mdl-button mdl-js-button mdl-button--icon mdl-color-text--grey-500 tool-btn tool-btn--group-chooser"
                                    type="button">
                                <i class="material-icons">supervisor_account</i>
                            </button>
                            <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
                                for="fab-choose-group">
                                <%
                                    for (Group group : groups) {
                                %>
                                <li class="mdl-menu__item"
                                    onclick="onGroupAdded('<%=group.getId()%>')"><%=group.getName()%>
                                </li>
                                <%
                                    }
                                %>
                            </ul>

                            <button id="tool-btn-print-students"
                                    class="mdl-button mdl-js-button mdl-button--icon mdl-color-text--grey-500 tool-btn tool-btn--group-chooser"
                                    type="button"
                                    onclick="printUsers()">
                                <i class="material-icons">print</i>
                            </button>

                            <button id="tool-btn-delete-students"
                                    class="mdl-button mdl-js-button mdl-button--icon mdl-color-text--grey-500 tool-btn tool-btn--group-chooser"
                                    type="button"
                                    onclick="onStudentDelete()">
                                <i class="material-icons">delete</i>
                            </button>

                            <button id="tool-btn-randomize-passwords"
                                    class="mdl-button mdl-js-button mdl-button--icon mdl-color-text--grey-500 tool-btn tool-btn--group-chooser"
                                    type="button"
                                    onclick="onStudentRandomizePasswords()">
                                <i class="material-icons">cached</i>
                            </button>

                            <div class="mdl-tooltip"
                                 data-mdl-for="fab-choose-group">
                                Обрати групу
                            </div>
                            <div class="mdl-tooltip"
                                 data-mdl-for="tool-btn-print-students">
                                Роздрукувати логіни та паролі
                            </div>
                            <div class="mdl-tooltip"
                                 data-mdl-for="tool-btn-delete-students">
                                Видалити
                            </div>
                            <div class="mdl-tooltip"
                                 data-mdl-for="tool-btn-randomize-passwords">
                                Оновити паролі
                            </div>

                            <button id="demo-menu-lower-right"
                                    style="position: absolute; right: 16px; top: 16px;"
                                    class="mdl-button mdl-js-button mdl-button--icon mdl-color-text--grey-500">
                                <i class="material-icons">more_vert</i>
                            </button>

                            <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect"
                                for="demo-menu-lower-right">
                                <li class="mdl-menu__item">Some Action</li>
                                <li class="mdl-menu__item">Another Action</li>
                                <li disabled class="mdl-menu__item">Disabled Action</li>
                                <li class="mdl-menu__item">Yet Another Action</li>
                            </ul>
                        </div>

                        <div class="mdl-grid mdl-shadow--4dp mdl-grid--tools-wrapper">
                            <h5 class="mdl-tools--title">Пошук</h5>

                            <form style="width: 100%; margin-top: 8px; text-align: center"
                                  action="${pageContext.request.contextPath}/users" method="post">
                                <input type="hidden" name="action" value="student_search">
                                <div style="width: 100%"
                                     class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="text"
                                           name="<%=Parameter.PARAM_STUDENT_BOOK_NUMBER%>" id="sample3">
                                    <label class="mdl-textfield__label" for="sample3">Введіть номер залікової книжки
                                    </label>
                                </div>
                            </form>
                        </div>

                        <div class="mdl-grid mdl-shadow--4dp mdl-grid--tools-wrapper">
                            <div class="mdl-grid">
                                <div class="mdl-cell mdl-cell--12-col">
                                    <h5 class="mdl-tools--title">Обрані групи</h5>
                                </div>

                                <form id="form-students-groups-chips">
                                    <div class="mdl-grid--tools-content">
                                        <%
                                            if (chooseGroups != null) {
                                                for (Group group : chooseGroups) {
                                        %>
                                        <input id="input-group-selected-<%=group.getId()%>"
                                               type="hidden" name="<%=Parameter.PARAM_GROUP_CHOOSE_ID%>"
                                               value="<%=group.getId()%>">
                                        <span id="span-chip-student-delete-<%=group.getId()%>"
                                              class="mdl-chip mdl-chip--deletable">
                                        <span class="mdl-chip__text"><%=group.getName()%></span>
                                        <button type="button"
                                                class="mdl-chip__action"
                                                onclick="onGroupChipDelete('span-chip-student-delete-<%=group.getId()%>',
                                                        '<%=group.getId()%>')">
                                            <i class="material-icons">cancel</i>
                                        </button>
                                    </span>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mdl-cell mdl-cell--8-col">
                    <form id="form-students" action="${pageContext.request.contextPath}/users" method="post">
                        <div class="table-wrapper--full-width">
                            <table id="table-students"
                                   class="mdl-data-table mdl-js-data-table mdl-shadow--4dp mdl-data-table--full-width">
                                <thead>
                                <tr>
                                    <th style="width: 1%;">
                                        <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
                                               for="checkbox-header-students">
                                            <input type="checkbox"
                                                   id="checkbox-header-students"
                                                   name="students-header"
                                                   class="mdl-checkbox__input"/>
                                        </label>
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
                                        <label id="checkbox-table-students"
                                               class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect mdl-data-table__select"
                                               for="checkbox-<%=user.getId()%>">
                                            <input type="checkbox"
                                                   id="checkbox-<%=user.getId()%>"
                                                   name="students"
                                                   value="<%=user.getId()%>"
                                                   class="mdl-checkbox__input"/>
                                        </label>
                                    </td>
                                    <td style="width: 30px"><%=user.getId()%>
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
                </div>
            </div>
        </section>

        <section class="mdl-layout__tab-panel" id="fixed-tab-2">
            <div class="page-content" style="padding-top: 8px;">
                <div class="table-wrapper--full-width">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--4dp mdl-data-table--full-width">
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
            <div class="page-content" style="padding-top: 8px;">
                <div class="table-wrapper--full-width">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--4dp mdl-data-table--full-width">
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
            <div class="page-content" style="padding-top: 8px;">
                <div class="table-wrapper--full-width">
                    <table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--4dp mdl-data-table--full-width">
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

<script>
    var table = document.getElementById('table-students');
    var headerCheckbox = table.querySelector('thead .mdl-data-table__select input');
    var boxes = table.querySelectorAll('tbody .mdl-data-table__select');

    var headerCheckHandler = function (event) {
        if (event.target.checked) {
            for (var i = 0, length = boxes.length; i < length; i++) {
                boxes[i].MaterialCheckbox.check();
            }
        } else {
            for (var i = 0, length = boxes.length; i < length; i++) {
                boxes[i].MaterialCheckbox.uncheck();
            }
        }
    };
    headerCheckbox.addEventListener('change', headerCheckHandler);
</script>

</body>
</html>