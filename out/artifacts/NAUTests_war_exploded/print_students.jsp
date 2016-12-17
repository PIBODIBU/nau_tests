<!DOCTYPE HTML>

<%@ page import="ua.edu.nau.helper.constant.Attribute" %>
<%@ page import="ua.edu.nau.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title></title>

    <jsp:include page="/jsp/mdl_commons.jsp"/>

    <link href="${pageContext.request.contextPath}/css/drawer_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/table.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fab-menu.css" rel="stylesheet">
</head>
<body onload="printData()">

<%ArrayList<User> users = ((ArrayList<User>) request.getAttribute(Attribute.ATTR_ARRAY_LIST_USER));%>

<script type="text/javascript">
    function printData() {
        var win = window.open();
        self.focus();
        win.document.open();

        win.document.write('<html><body>');

        <%for(User user:users){%>
        win.document.write("<%=user.getName()%>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + "<%=user.getUsername()%>" + "&nbsp;&nbsp;&nbsp;&nbsp;" + "<%=user.getPassword()%>");
        win.document.write("<br/>");
        <%
        }
        %>
        win.document.write('</body></html>');

        win.document.close();
        win.print();
        win.close();

        document.location = "/users";
    }
</script>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--fixed-tabs">
    <header class="mdl-layout__header">
        <div class="mdl-layout__header-row">
            <span class="mdl-layout-title"></span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation mdl-layout--large-screen-only">
            </nav>
        </div>
    </header>
</div>
</body>
</html>