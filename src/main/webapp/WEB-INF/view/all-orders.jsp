<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<body>
<table border="0">
    <tr>
        <th align="left">
            <img width=100% src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th width="50%">
            <form  align="right" method="LINK" action="/logout">
                <input type="submit" value="<< Выйти >>" style="width: 250px; height: 30px;">
            </form>
            <font size="4" face="Courier New" >
                <p align="right">Привет  ${user.userDetails.name} ${user.userDetails.lastName} Ваш город: ${user.userDetails.city} </p>
                <p align="right">Логин: ${user.loginName}</p>

                <p align="right">Баланс: ${user.userDetails.balance} грн</p>
                <p align="right">Макс. заявок: <b style="color: #ff3300">${user.userDetails.maxCountOrders} </b>
                    Заявок в работе: <b style="color: #ff0000">${countOrders}</b></p>
                <p align="right">Макс. отмен заявок : <b style="color: #ff0000">${user.userDetails.maxCountCanceledOrders} </b>
                    Отмененных заявок : <b style="color: #ff0000">${user.userDetails.currentCanceledCountOrders}</b></p>

                <security:authorize access="hasAnyRole('ADMIN', 'MANAGER', 'SUPER_MANAGER')">
                <form  align="right" method="LINK" action="/manager">
                    <input type="submit" value="<< Кабинет для менеджера >>" style="width: 250px; height: 30px;">
                </form>
                </security:authorize>
<security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                <form  align="right" method="LINK" action="/profile">
                    <input type="submit" value="<< Кабинет с моими заявками >>" style="width: 250px; height: 30px;">
                </form>
</security:authorize>
            </font>
        </th>
    </tr>
</table>
<br>
<font size="6" face="Courier New" >Заявки на утепление квартир и домов по Украине</font>
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
        <th col style="background-color:white" align="center"></th>
    </tr>

    <c:forEach var="orders" items="${orders}" >

        <c:url var="addOrder" value="/order/addOrder" >
            <c:param name="orderId" value="${orders.id}"/>
        </c:url>

        <tr col style="background-color:LightCyan" align="center">
            <td>
                <fmt:parseDate value="${orders.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                               var="parsedDateTime" type="both" />

                <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                <br>
                <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
            </td>
            <td>${orders.orderDetails.customerName}</td>
            <td>${orders.orderDetails.address}</td>
            <td>${orders.orderDetails.countRooms}</td>
            <td>${orders.orderDetails.city}</td>
            <td>${orders.orderDetails.phoneNumber}</td>
            <td>${orders.orderDetails.squareArea}</td>
            <td col style="background-color:white" align="center">
                <input type="button" value="Взять заявку"
                onclick = "window.location.href = '${addOrder}'"/>
            </td>
        </tr>
    </c:forEach>
</table>
</font>
<security:authorize access="hasAnyRole('SUPER_USER')">
<font size="6" face="Courier New" >Заявки которые не попали еще в общий список, который видят все </font>
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
            <th col style="background-color:white" align="center"></th>
        </tr>

        <c:forEach var="ordersNotVerified" items="${ordersNotVerified}" >

            <c:url var="addOrderNotVerified" value="/order/addOrder" >
                <c:param name="orderId" value="${ordersNotVerified.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${ordersNotVerified.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersNotVerified.orderDetails.customerName}</td>
                <td>${ordersNotVerified.orderDetails.address}</td>
                <td>${ordersNotVerified.orderDetails.countRooms}</td>
                <td>${ordersNotVerified.orderDetails.city}</td>
                <td>${ordersNotVerified.orderDetails.phoneNumber}</td>
                <td>${ordersNotVerified.orderDetails.squareArea}</td>
                <td>${ordersNotVerified.orderDetails.notes}</td>

                <td col style="background-color:white" align="center">
                    <input type="button" value="Взять заявку"
                           onclick = "window.location.href = '${addOrderNotVerified}'"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</font>
</security:authorize>
</body>
</html>