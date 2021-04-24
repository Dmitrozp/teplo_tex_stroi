<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Отмена заявки</title>
</head>
<body>
<font size="4" face="Courier New" >
    <p>${user.name}, вы хотите отменить заявку!</p>
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
<h3>Причина отмены заявки: </h3>
<form:form action="saveCanceledOrder" modelAttribute="report">
    <form:hidden path="order.id"/>
    <form:textarea path="description" style="width: 300px; height: 300px;" />
    <br>
    <br>
    <br>
    <input type="submit" value="Сохранить" />
</form:form>

</body>
</html>