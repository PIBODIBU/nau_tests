<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Boolean isCredentialsBad = false;

    if (request.getAttribute(Attribute.ATTR_BAD_LOGIN_OR_PASSWORD) != null) {
        isCredentialsBad = ((Boolean) request.getAttribute(Attribute.ATTR_BAD_LOGIN_OR_PASSWORD));
    }
%>

<html>
<head>
    <title>Вхід</title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>
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
</style>

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
                        <h1 class="mdl-card__title-text" style="display: block;">Вхід</h1>
                    </div>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mdl-card__supporting-text">
                            <div class="text-fields-wrapper">
                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label  <%=isCredentialsBad?"is-invalid":""%>">
                                    <input class="mdl-textfield__input"
                                           type="text"
                                           autocomplete="off"
                                           name="<%=Parameter.PARAM_USERNAME%>"
                                           id="username">
                                    <label class="mdl-textfield__label" for="username">Логін</label>
                                </div>

                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label <%=isCredentialsBad?"is-invalid":""%>">
                                    <input class="mdl-textfield__input"
                                           type="password"
                                           autocomplete="off"
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

    <main class="mdl-layout__content">
    </main>
</div>
</body>
</html>