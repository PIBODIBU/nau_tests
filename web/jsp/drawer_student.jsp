<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="mdl-layout__drawer">
    <span class="mdl-layout-title">NAUTests</span>
    <nav class="mdl-navigation">
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
        <a class="mdl-navigation__link navigation__sub-link"
           href="${pageContext.request.contextPath}/tests/sessions">Активні
            тести</a>
        <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
    </nav>
</div>