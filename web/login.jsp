<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
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

<style>
    body {
        width: 100%;
        max-width: 100%;
    }

    .page-content {
        margin: auto;
    }

    table {
        margin: auto;
    }
</style>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">Вхід</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
                <a class="mdl-navigation__link" href="">Link</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">Вхід</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="">Link</a>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="page-content">
            <form action="${pageContext.request.contextPath}/login" method="post">
                <table>
                    <tr>
                        <td>
                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label"
                                 style="float: left">
                                <input class="mdl-textfield__input" type="text" name="<%=Parameter.PARAM_USERNAME%>"
                                       id="username">
                                <label class="mdl-textfield__label" for="username">Логін</label>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <input class="mdl-textfield__input" type="password" name="<%=Parameter.PARAM_PASSWORD%>"
                                       id="password">
                                <label class="mdl-textfield__label" for="password">Пароль</label>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <button type="submit"
                                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">
                                Увійти
                            </button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </main>
</div>
</body>
</html>