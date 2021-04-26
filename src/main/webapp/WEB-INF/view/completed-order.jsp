<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Закрытие заявки</title>
</head>
<body>
<font size="4" face="Courier New">
    <p><b>${user.name}, вы закрываете заявку, как выполненую!</b></p>
</font>
<br>
<br>
<font size="3" face="Courier New" >
    <p>Заявка   № ${order.id}</p>
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
    <p><b>Введите площадь утепления :</b><br>
    >><form:input type="text" size="20" path="squareArea"/></p>

    <p><b>Введите сумму оплаты клиентом :</b><br>
    >><form:input type="text" size="20" path="sumOfPaymentCustomer"/>
    </p>
    <br>
    <p><input type="submit" value="<<  Сохранить  >>" /></p>
</form:form>

</body>
</html>
