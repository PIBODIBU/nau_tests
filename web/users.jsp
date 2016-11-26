<%@ page import="ua.edu.nau.model.User" %><%--
  Created by IntelliJ IDEA.
  User: simple
  Date: 11/25/16
  Time: 9:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%User user = ((User) request.getAttribute("user"));%>

<h2>User</h2>
<p>Id: <%=user.getId()%>
</p>
<p>Name: <%=user.getName()%>
</p>
<p>Username: <%=user.getUsername()%>
</p>
<p>Password: <%=user.getPassword()%>
</p>
<p>Email: <%=user.getEmail()%>
</p>

<h2>User.UserRole</h2>
<p>Role id: <%=user.getUserRole().getRoleId()%>
</p>
<p>Role code: <%=user.getUserRole().getRoleCode()%>
</p>
<p>Description: <%=user.getUserRole().getDescription()%>
</p>
</body>
</html>
