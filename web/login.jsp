<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Вхід</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>
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
</style>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row toolbar_row-1">
            <h2 class="toolbar-title">NAUTests</h2>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>

        <div class="mdl-layout__header-row toolbar_row-2">
            <div class="page-content">
                <div class="card-square mdl-card mdl-shadow--8dp">
                    <div class="mdl-card__title mdl-card--expand">
                        <i class="material-icons mdl-color-text--blue-500 icon-account">account_circle</i>
                        <h1 class="mdl-card__title-text" style="display: block;">Вхід</h1>
                    </div>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mdl-card__supporting-text">
                            <div class="text-fields-wrapper">
                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="text"
                                           name="<%=Parameter.PARAM_USERNAME%>"
                                           id="username">
                                    <label class="mdl-textfield__label" for="username">Логін</label>
                                </div>

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                    <input class="mdl-textfield__input" type="password"
                                           name="<%=Parameter.PARAM_PASSWORD%>"
                                           id="password">
                                    <label class="mdl-textfield__label" for="password">Пароль</label>
                                </div>

                                <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="checkbox-2">
                                    <input type="checkbox" id="checkbox-2" class="mdl-checkbox__input">
                                    <span class="mdl-checkbox__label">Запам'ятати</span>
                                </label>
                            </div>
                        </div>

                        <div class="mdl-card__actions">
                            <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect"
                                    type="submit">
                                Увійти
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="">Link</a>
        </nav>
    </div>

    <main class="mdl-layout__content">
    </main>
</div>
</body>
</html>