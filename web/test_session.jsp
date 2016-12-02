<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.helper.constant.RoleCode" %>
<%@ page import="ua.edu.nau.model.*" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.omg.CORBA.DynAnyPackage.InvalidValue" %>

<!DOCTYPE HTML>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%User user = ((User) request.getAttribute(Attribute.ATTR_USER_MODEL));%>
<%Test test = ((Test) request.getAttribute(Attribute.ATTR_TEST_MODEL));%>
<%TestSession testSession = ((TestSession) request.getAttribute(Attribute.ATTR_TEST_SESSION_MODEL));%>

<html>
<head>
    <title><%=test.getName()%>
    </title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.2.1/material.blue-red.min.css"/>
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <script defer src="https://code.getmdl.io/1.2.1/material.min.js"></script>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/body_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/timer.css" rel="stylesheet">
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
</style>

<%
    //    testSession.getStartTime().getHours()

    String mins = "20";
    if (mins == null) mins = "30";

    String secs = "10";
    if (secs == null) secs = "1";
%>

<script type="text/javascript">
    <!--
    var mins = <%=mins%>; // write mins to javascript
    var secs = <%=secs%>; // write secs to javascript
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
        /*document.forma.mins.value = mins;
         document.forma.secs.value = secs;*/

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

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title"><%=test.getName()%></span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
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
    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link navigation__sub-link"
               href="${pageContext.request.contextPath}/tests/sessions">Активні
                тести</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>
    <%
    } else {
    %>
    <div class="mdl-layout__drawer">
        <span class="mdl-layout-title">NAUTests</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/me">Моя сторінка</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/users">Користувачі</a>
            <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/tests">Тести</a>
            <a class="mdl-navigation__link navigation__sub-link" href="${pageContext.request.contextPath}/me/tests">Мої
                тести</a>
            <a class="mdl-navigation__link navigation__sub-link"
               href="${pageContext.request.contextPath}/tests/sessions">Активні
                тести</a>
            <div class="mdl-card__actions mdl-card--border">
                <a class="mdl-navigation__link" href="${pageContext.request.contextPath}/logout">Вихід</a>
            </div>
        </nav>
    </div>
    <%
        }
    %>

    <main class="mdl-layout__content">
        <div class="page-content">

            Test was started: <%=testSession.getStartTime().toString()%>
            <br/>
            Test time: <%=test.getTime()%>
            <br/>
            <%
                Date dateDeadLine = new Date(testSession.getStartTime().getTime() + test.getTime().getTime());
                Date now = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss:S");
                String deadLine = dateFormat.format(dateDeadLine);

                Boolean hasDeadLineCome = dateDeadLine.before(now);
            %>
            Now: <%=now.toString()%>
            <br/>
            Deadline: <%=deadLine%>
            <br/>
            Has Deadline come: <%=hasDeadLineCome%>

            <%
                int questionCounter = 1;
                for (Question question : test.getQuestions()) {
            %>
            <div class="card-square mdl-card mdl-shadow--8dp">
                <p class="mdl-typography--subhead">
                    <%=questionCounter%>. <%=question.getText()%>
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
                                   value="2">
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
</div>
</body>
</html>