<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Закрытие заявки</title>
</head>
<body>
<font size="4" face="Courier New" >
    <p>${user.name}, вы закрываете заявку, как выполненую!</p>
    <p>Ваш баланс: ${user.balance} грн</p>
</font>
<br>
<br>
<font size="4" face="Courier New" >
    <p>Заявка № ${order.id}</p>
    <p>Дата     : ${order.date}</p>
    <p>Заказчик : ${order.orderDetails.customerName}</p>
    <p>Адрес    : ${order.orderDetails.address}</p>
    <p>Город    : ${order.orderDetails.city}</p>
    <p>Телефон  : ${order.orderDetails.phoneNumber}</p>
</font>
<br>
<br>
<h3>Отчет о заявке </h3>
<form:form action="saveCompletedOrder" modelAttribute="order">
    <form:hidden path="id"/>
    <p>Введите площадь утепления :</p>>
    <form:input path="squareArea"/>
    <p>Введите сумму оплаты клиентом :</p>>
    <form:input path="sumOfPaymentCustomer"/>
    <br>
    <br>
    <br>
    <input type="submit" value="Сохранить" />
</form:form>

</body>
</html>
