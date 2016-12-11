<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = (User) request.getAttribute(Attribute.ATTR_USER_MODEL);%>

<div class="mdl-layout__drawer">
    <div style="height: 150px; background-color: #2196F3; margin: 0; position: relative">
        <div class="mdl-layout__drawer-head-text-wrapper">
            <h5 class="mdl-layout__drawer-title">
                <%=user.getName()%>
            </h5>

            <h7 class="mdl-layout__drawer-subtitle">
                <%=user.getEmail()%>
            </h7>
        </div>
    </div>

    <nav class="mdl-navigation">
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
        <a class="mdl-navigation__link navigation__sub-link" href="${pageContext.request.contextPath}/me/tests">Мої
            тести</a>
        <a class="mdl-navigation__link navigation__sub-link"
           href="${pageContext.request.contextPath}/tests/sessions">Активні
            тести</a>
        <hr style="margin: 0"/>
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
    </nav>
</div>