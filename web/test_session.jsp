<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.Parameter" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>
<%Test test = ((Test) request.getAttribute(Attribute.ATTR_TEST_MODEL));%>
<%TestSession testSession = ((TestSession) request.getAttribute(Attribute.ATTR_TEST_SESSION_MODEL));%>
<%ArrayList<Question> questions = ((ArrayList<Question>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_QUESTION));%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/body_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/timer.css" rel="stylesheet">
    <%--<link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">--%>
</head>

<body onload="timer()">

<style>
    .mdl-card {
        width: 80%;
        min-width: 80%;
        max-width: 80%;
        margin: 24px auto auto;
    }

    .page-content {
        padding-bottom: 24px;
    }

    .mdl-card > p {
        padding: 24px 24px 0;
        margin-bottom: 0;
    }

    .mdl-card > ul {
        padding: 0;
    }

    .mdl-button--fab {
        position: fixed;
        right: 36px;
        bottom: 36px;
        z-index: 999;
    }
</style>

<%
    Date dateDeadLine = new Date(testSession.getStartTime().getTime() + test.getTime().getTime());
    Date now = new Date();
    Date remainTime = new Date(dateDeadLine.getTime() - now.getTime());
    Calendar calendar = Calendar.getInstance();
    calendar.setTime(remainTime);

    String minutes = String.valueOf(calendar.get(Calendar.MINUTE));
    String seconds = String.valueOf(calendar.get(Calendar.SECOND));
%>

<script type="text/javascript">
    <!--
    var mins = <%=minutes%>; // write minutes to javascript
    var secs = <%=seconds%>; // write seconds to javascript
    function timer() {
// tic tac
        if (--secs == -1) {
            secs = 59;
            --mins;
        }

// leading zero? formatting
        if (secs < 10) secs = "0" + secs;
        if (mins < 10) mins = "0" + parseInt(mins, 10);

// display
        document.getElementById("div-minutes").innerHTML = mins;
        document.getElementById("div-seconds").innerHTML = secs;

// continue?
        if (secs == 0 && mins == 0) // time over
        {
            document.forma.ok.disabled = true;
            document.formb.results.style.display = "block";
        }
        else // call timer() recursively every 1000 ms == 1 sec
        {
            window.setTimeout("timer()", 1000);
        }
    }
    //-->
</script>

<form method="post" action="${pageContext.request.contextPath}/tests/validator">
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
        <header class="mdl-layout__header">
            <div class="mdl-layout__header-row">
                <span class="mdl-layout-title"><%=test.getName()%></span>
                <div class="mdl-layout-spacer"></div>
                <nav class="mdl-navigation">
                    <h6>Залишилося часу:&nbsp;</h6>
                    <h6 id="div-minutes"></h6>
                    <h6>:</h6>
                    <h6 id="div-seconds"></h6>
                </nav>
            </div>
        </header>

        <%
            if (user.getUserRole().getRoleCode().equals(RoleCode.STUDENT)) {
        %>
        <jsp:include page="/jsp/drawer_student.jsp"/>
        <%
        } else if (user.getUserRole().getRoleCode().equals(RoleCode.ROOT)) {
        %>
        <jsp:include page="/jsp/drawer_root.jsp"/>
        <%
            }
        %>

        <main class="mdl-layout__content">
            <div class="page-content">
                <input type="hidden" name="<%=Parameter.PARAM_TEST_ID%>" value="<%=test.getId()%>"/>
                <input type="hidden" name="<%=Parameter.PARAM_TEST_SESSION_ID%>" value="<%=testSession.getId()%>"/>

                <%
                    int questionCounter = 1;
                    for (Question question : questions) {
                %>
                <div class="card-square mdl-card mdl-shadow--8dp">
                    <p class="mdl-typography--subhead">
                        <%=questionCounter%>. <%=question.getText()%>
                        <img src="<%=question.getImgUrl() == null ? "" :question.getImgUrl()%>"/>
                    </p>

                    <ul class="list-icon mdl-list" style="display: block">
                        <%
                            for (Answer answer : question.getAnswers()) {
                        %>
                        <li class="mdl-list__item">
                            <label class="mdl-radio mdl-js-radio mdl-js-ripple-effect"
                                   for="option-<%=answer.getId()%>">
                                <input type="radio" id="option-<%=answer.getId()%>" class="mdl-radio__button"
                                       name="<%=question.getId()%>"
                                       value="<%=answer.getId()%>">
                                <span class="mdl-radio__label"><%=answer.getText()%></span>
                            </label>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                <%
                        questionCounter++;
                    }
                %>
            </div>
        </main>

        <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
            <i class="material-icons">done_all</i>
        </button>
    </div>
</form>

</body>
</html>