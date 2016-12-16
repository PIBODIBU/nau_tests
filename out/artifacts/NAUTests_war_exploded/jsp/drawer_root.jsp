<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = (User) request.getAttribute(Attribute.ATTR_USER_MODEL);%>

<div class="mdl-layout__drawer">
    <div style="height: 150px; background-color: #2196F3; margin: 0; position: relative"
         class="mdl-shadow--2dp">
        <div class="mdl-layout__drawer-head-text-wrapper">
            <h6 class="mdl-layout__drawer-title">
                <%=user.getName()%>
            </h6>

            <h7 class="mdl-layout__drawer-subtitle">
                <%=user.getEmail()%>
            </h7>
        </div>
    </div>

    <nav class="mdl-navigation">
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">
            <i class="material-icons">person</i>&nbsp;&nbsp;&nbsp;Моя сторінка
        </a>

        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">
            <i class="material-icons">group</i>&nbsp;&nbsp;&nbsp;Користувачі
        </a>

        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">
            <i class="material-icons">playlist_add_check</i>&nbsp;&nbsp;&nbsp;Тести
        </a>

        <a class="mdl-navigation__link navigation__sub-link" href="${pageContext.request.contextPath}/me/tests">
            <i class="material-icons">arrow_drop_down</i> Мої тести
        </a>

        <a class="mdl-navigation__link navigation__sub-link"
           href="${pageContext.request.contextPath}/tests/sessions">
            <i class="material-icons">arrow_drop_down</i> Активні тести
        </a>

        <hr style="margin: 0"/>

        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">
            <i class="material-icons">exit_to_app</i>&nbsp;&nbsp;&nbsp;Вихід
        </a>
    </nav>
</div>