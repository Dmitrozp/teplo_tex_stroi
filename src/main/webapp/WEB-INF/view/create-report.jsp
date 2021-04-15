<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Сохранение отчета о заявке</title>
</head>
<body>

<h1> Создать отчет о заявке</h1>
<br>
<form:form action="saveReport" modelAttribute="report">
    <form:hidden path="id"/>
    <form:hidden path="order.id"/>
    Описание : <form:input path="description" size="100" maxlength="100"/>
    <br>
    <input type="submit" value="Сохранить">
</form:form>

</body>
</html>
