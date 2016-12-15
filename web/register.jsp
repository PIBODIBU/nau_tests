<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Group" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Institute" %>
<%@ page import="ua.edu.nau.model.UniversityStructure.Department" %>
<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<Group> groups = ((ArrayList<Group>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_GROUP));
    ArrayList<Institute> institutes = ((ArrayList<Institute>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_INSTITUTE));
    ArrayList<Department> departments = ((ArrayList<Department>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_DEPARTMENT));
%>

<html>
<head>
    <title>Вхід</title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link rel="stylesheet" href="https://cdn.rawgit.com/CreativeIT/getmdl-select/master/getmdl-select.min.css">
    <script defer src="https://cdn.rawgit.com/CreativeIT/getmdl-select/master/getmdl-select.min.js"></script>
</head>
<body>

<style>
    body {
        width: 100%;
        max-width: 100%;
    }

    .mdl-layout__content {
        background-color: #f9f9f9;
    }

    .toolbar_row-1 {
        height: 200px;
        text-align: center;
    }

    .page-content {
        margin: -100px auto auto;
        width: 60%;
        min-width: 60%;
        padding-bottom: 24px;
    }

    @media screen
    and (max-device-width: 500px)
    and (max-device-height: 800px) {
        .page-content {
            margin: -100px auto auto;
            width: 90%;
            min-width: 90%;
            padding-bottom: 24px;
        }

        .toolbar_row-2 {
            padding: 0;
        }

        .toolbar_row-1 {
            height: 200px;
            text-align: center;
            padding: 0;
        }
    }

    table {
        margin: auto;
    }

    .card-square {
        margin: 36px auto auto;
        width: 100%;
        min-width: 100%;
        padding-bottom: 16px;
    }

    .mdl-button {
        width: 150px;
        min-width: 150px;
    }

    .mdl-card__actions {
        text-align: center;
    }

    .mdl-card__title {
        margin: auto;
        text-align: center;
        display: inline-block
    }

    .icon-account {
        margin: auto;
        font-size: 100px;
    }

    .mdl-textfield {
        width: 80%;
        min-width: 80%;
        display: block;
        margin: auto;
    }

    .mdl-checkbox {
        display: block;
        margin-left: 10%;
    }

    .text-fields-wrapper {
        width: 100%;
        min-width: 100%;
        display: inline-block;
        margin: 0 auto;
        overflow: hidden;
    }

    .toolbar-title {
        width: 100%;
        min-width: 100%;
    }

    #btn_register {
        width: 200px;
    }

    .mdl-menu__container {
        overflow-y: auto !important;
        overflow-x: hidden !important;
        height: 200px !important;
    }
</style>

<script>
    function onInstituteSelected(instituteId) {
        var inputGroupId = document.getElementById('input-institute');
        inputGroupId.value = instituteId;
    }

    function onDepartmentSelected(departmentId) {
        var inputGroupId = document.getElementById('input-department');
        inputGroupId.value = departmentId;
    }

    function onGroupSelected(groupId, groupName) {
        $('#group-name').val(groupName);
        $('#group-name-label').html("");

        var inputGroupId = document.getElementById('input-group');
        inputGroupId.value = groupId;
    }
</script>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row toolbar_row-1">
            <h2 class="toolbar-title">
                <img src="${pageContext.request.contextPath}/images/drawer_logo.png"
                     style="height: 100px; margin-bottom: 36px;"/>
            </h2>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>

        <div class="mdl-layout__header-row toolbar_row-2">
            <div class="page-content">
                <div class="card-square mdl-card mdl-shadow--8dp">
                    <div class="mdl-card__title mdl-card--expand">
                        <i class="material-icons mdl-color-text--blue-500 icon-account">account_circle</i>
                        <h1 class="mdl-card__title-text" style="display: block;">Реєстрація</h1>
                    </div>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="mdl-card__supporting-text">
                            <div class="text-fields-wrapper">
                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="text"
                                           name="<%=Parameter.PARAM_NAME%>"
                                           id="name">
                                    <label class="mdl-textfield__label" for="name">Ім'я та прізвище</label>
                                </div>

                                <%--<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height">--%>
                                <%--<input type="hidden" id="input-institute" name="<%=Parameter.PARAM_INSTITUTE_ID%>"--%>
                                <%--value="<%=institutes.get(0).getId()%>">--%>

                                <%--<input class="mdl-textfield__input" id="institute-name" name="country"--%>
                                <%--value="<%=institutes.get(0).getName()%>"--%>
                                <%--type="text" readonly tabIndex="-1"/>--%>

                                <%--<label class="mdl-textfield__label" for="institute-name">Інститут</label>--%>
                                <%--<ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="institute-name">--%>
                                <%--<%--%>
                                <%--for (Institute institute : institutes) {--%>
                                <%--%>--%>
                                <%--<li class="mdl-menu__item"--%>
                                <%--onclick="onInstituteSelected('<%=institute.getId()%>')"><%=institute.getShortName()%>--%>
                                <%--</li>--%>
                                <%--<%--%>
                                <%--}--%>
                                <%--%>--%>
                                <%--</ul>--%>
                                <%--</div>--%>
                                <%--<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height">--%>
                                <%--<input type="hidden" id="input-department" name="<%=Parameter.PARAM_DEPARTMENT_ID%>"--%>
                                <%--value="<%=departments.get(0).getId()%>">--%>

                                <%--<input class="mdl-textfield__input" id="department-name" name="country"--%>
                                <%--value="<%=departments.get(0).getName()%>"--%>
                                <%--type="text" readonly tabIndex="-1"/>--%>

                                <%--<label class="mdl-textfield__label" for="department-name">Кафедра</label>--%>
                                <%--<ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="department-name">--%>
                                <%--<%--%>
                                <%--for (Department department : departments) {--%>
                                <%--%>--%>
                                <%--<li class="mdl-menu__item"--%>
                                <%--onclick="onDepartmentSelected('<%=department.getId()%>')"><%=department.getShortName()%>--%>
                                <%--</li>--%>
                                <%--<%--%>
                                <%--}--%>
                                <%--%>--%>
                                <%--</ul>--%>
                                <%--</div>--%>

                                <input type="hidden" id="input-group" name="<%=Parameter.PARAM_GROUP_ID%>"
                                       value="<%=groups.get(0).getId()%>">

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" id="group-name"
                                           type="text" readonly tabIndex="-1"/>
                                    <label id="group-name-label" class="mdl-textfield__label"
                                           for="group-name">Група</label>

                                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="group-name">
                                        <%
                                            for (Group group : groups) {
                                        %>
                                        <li class="mdl-menu__item"
                                            onclick="onGroupSelected('<%=group.getId()%>','<%=group.getName()%>')"><%=group.getName()%>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="text"
                                           name="<%=Parameter.PARAM_EMAIL%>"
                                           id="email">
                                    <label class="mdl-textfield__label" for="email">Email</label>
                                </div>

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="text"
                                           name="<%=Parameter.PARAM_USERNAME%>"
                                           id="username">
                                    <label class="mdl-textfield__label" for="username">Номер залікової книжки</label>
                                </div>

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="password"
                                           name="<%=Parameter.PARAM_PASSWORD%>"
                                           id="password">
                                    <label class="mdl-textfield__label" for="password">Пароль</label>
                                </div>
                            </div>
                        </div>

                        <div class="mdl-card__actions">
                            <button id="btn_register"
                                    type="submit"
                                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect">
                                Зареєструватися
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </header>

    <main class="mdl-layout__content">
    </main>
</div>
</body>
</html>