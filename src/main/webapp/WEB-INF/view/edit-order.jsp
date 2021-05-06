<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <p> Изменить заказ</p>

    <form:form action="saveEditedOrder" modelAttribute="order">
        <form:hidden path="id"/>
        <form:input path="orderDetails.customerName"/>
        <br>
        <form:input path="orderDetails.phoneNumber"/>
        <br>
        <form:input path="orderDetails.city"/>
        <br>
        <form:input path="orderDetails.address"/>
        <br>
        <form:input path="orderDetails.squareArea"/>
        <br>
        <form:input path="orderDetails.countRooms"/>
        <br>
        <input type="submit" value="<<  Сохранить  >>">

    </form:form>
</head>
<body>

</body>
</html>
