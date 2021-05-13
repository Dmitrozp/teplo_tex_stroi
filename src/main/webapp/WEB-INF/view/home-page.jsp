<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>.
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="0" width="100%">
    <tr>
        <th align="left">
            <img src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th>
            <font size="5" face="Courier New" >
                <p align="right"> Привет: гость </p>
                <form method="LINK" action="/order" align="right">
                    <input style="width:200px" type="submit" value="<< Войти >>"/>
                </form>
            </font>
            <font size="4" face="Courier New" align="right">
                <p>Для получения логина и пароля,</p>
                <p>обращаться в viber 066 201 93 93</p>
            </font>
        </th>
    </tr>
</table>
<br>
<font size="7" face="Courier New" >Заявки на утепление квартир и домов по Украине</font>
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
        </tr>

        <c:forEach var="orders" items="${orders}" >

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
            </tr>
        </c:forEach>
    </table>
</font>
</body>
</html>
