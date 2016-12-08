<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="mdl-layout__drawer" style="border: 0;">
    <div style="height: 150px; background-color: #2196F3; margin: 0;">
        <%--<span class="mdl-layout-title">NAUTests</span>--%>
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