<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Заявка в исполнении</title>
</head>
<body>
<font size="4" face="Courier New">
    <p><b>${user.userDetails.name}, вы добавляете заявку в работу!</b></p>
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
<h3>Введите данный об исполняемой заявке: </h3>
<form:form action="saveExecutingOrder" modelAttribute="order">
    <form:hidden path = "id" />

    <p><b>Введите № договора :</b><br>
        >><form:input type="text" size="20" path="nameContract"/> * поле не может быть пустым
    </p>

    <p><b>Введите адрес по договору :</b><br>
        >><form:input type="text" size="20" path="orderDetails.address"/> * поле не может быть пустым
    </p>


    <p><b>Введите полную сумму оплаты по договору :</b><br>
        >><form:input type="number" size="20" path="summOfContract"/> * только цифры и поле не может быть пустым
    </p>

    <p><b>Введите площадь утепления :</b><br>
    >><form:input type="number" size="20" path="orderDetails.squareAreaFromReport"/> * только цифры и поле не может быть пустым
    </p>

    <p><b>Введите ориентировочную дату окончания работ :</b><br>
        >><form:input type="text" size="20" path="dateFinished"/> * пример: 2021-04-30  и поле не может быть пустым
    </p>


    <br>
    <p><input type="submit" value="<<  Сохранить  >>" /></p>
</form:form>

</body>
</html>
