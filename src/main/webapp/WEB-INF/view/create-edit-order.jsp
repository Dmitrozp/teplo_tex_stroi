<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Создание и редактирование заказа на утепление</title>
    <p> Заказ на утепление</p>

    <form:form action="saveEditedOrder" modelAttribute="order">
        <form:hidden path="id"/>
        <p>Имя заказчика: </p>
        <form:input path="orderDetails.customerName"/>
        <br>
        <p>Телефон заказчика: </p>
        <form:input path="orderDetails.phoneNumber"/>
        <br>
        <p>Город заказчика: </p>
        <form:input path="orderDetails.city"/>
        <br>
        <p>Адрес заказчика: </p>
        <form:input path="orderDetails.address"/>
        <br>
        <p>Площадь утепления: </p>
        <form:input path="orderDetails.squareArea"/>
        <br>
        <p>Количество комнат: </p>
        <form:input path="orderDetails.countRooms"/>
        <br>
        <p>Примечание: </p>
        <form:input path="orderDetails.notes"/>
        <br>
        <input type="submit" value="<<  Сохранить  >>">

    </form:form>
</head>
<body>

</body>
</html>
