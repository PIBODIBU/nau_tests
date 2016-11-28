<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Вхід</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.deep_purple-amber.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>
</head>
<body>

<%User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>

<style>
    body {
        width: 100%;
        max-width: 100%;
    }

    .page-content {
        margin: auto;
    }
</style>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Моя сторінка</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Моя сторінка</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="">Link</a>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content">
            <table class="mdl-data-table mdl-js-data-table  mdl-shadow--2dp">
                <tr class="mdl-data-table__cell--non-numeric">
                    <td class="mdl-data-table__cell--non-numeric">Ідентифікатор</td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getId()%>
                    </td>
                </tr>

                <tr class="mdl-data-table__cell--non-numeric">
                    <td class="mdl-data-table__cell--non-numeric">Ім'я</td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getName()%>
                    </td>
                </tr>

                <tr class="mdl-data-table__cell--non-numeric">
                    <td class="mdl-data-table__cell--non-numeric">Логін</td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getUsername()%>
                    </td>
                </tr>

                <tr class="mdl-data-table__cell--non-numeric">
                    <td class="mdl-data-table__cell--non-numeric">Email</td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getEmail()%>
                    </td>
                </tr>

                <tr class="mdl-data-table__cell--non-numeric">
                    <td class="mdl-data-table__cell--non-numeric">Рівень доступу</td>
                    <td class="mdl-data-table__cell--non-numeric"><%=user.getUserRole().getDescription()%>
                    </td>
                </tr>
            </table>
        </div>
    </main>
</div>
</body>
</html>