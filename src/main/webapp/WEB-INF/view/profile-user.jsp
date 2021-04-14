<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Кабинет</title>
</head>
<body>
<table border="0">
    <tr>
        <th align="left">
            <img width=100% src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th>
            <font size="5" face="Courier New" >
                <p align="right"> Привет:${user.name} ${user.lastName} </p>
                <p align="right">     ${user.loginName}</p>
                <form method="LINK" action="http://134.249.133.144:8080/order">
                    <input type="submit" value="Все заявки">
                </form>
            </font>
        </th>
    </tr>
</table>

<br>
<font size="7" face="Courier New" >Мои заявки на утепление</font>
<br>
<br>
<font size="4" face="Courier New" >

    <table width="100%">
        <tr col span="2" style="background:Khaki" align="center">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Количество комнат</th>
            <th>Город</th>
            <th>Телефон</th>
            <th>Площадь утепления</th>
            <th>Примечание</th>
            <th></th>
        </tr>

        <c:forEach var="orders" items="${orders}" >

            <tr col style="background-color:LightCyan" align="center">
                <td>${orders.date}</td>
                <td>${orders.customerName}</td>
                <td>${orders.address}</td>
                <td>${orders.countRooms}</td>
                <td>${orders.city}</td>
                <td>${orders.phoneNumber}</td>
                <td>${orders.squareArea}</td>
                <td>${orders.notes}</td>
            </tr>
        </c:forEach>
    </table>
</font>>

</body>
</html>
