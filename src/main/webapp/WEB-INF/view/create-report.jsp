<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Комментарий к заявке</title>
</head>
<body>
<font size="5" face="Courier New" >
Оставить комментарий к заявке
</font>
<br>
<br>
<h3>Опишите подробно : </h3>
<form:form action="saveReport" modelAttribute="report">
    <form:hidden path="id"/>
    <form:hidden path="order.id"/>
    <form:textarea path="description" cols="50" rows="6" />
    <br>
    <br>
    <br>

    <input type="submit" value="Сохранить" />
</form:form>

</body>
</html>
