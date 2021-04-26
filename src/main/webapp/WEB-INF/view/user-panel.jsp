<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <th width="50%">
            <font size="4" face="Courier New" >
                <p align="right"> ${user.name} ${user.lastName} </p>
                <p align="right">Город: ${user.city} </p>
                <p align="right">Логин: ${user.loginName}</p>
                <p align="right">Баланс: ${user.balance} грн</p>
                <form method="LINK" align="right" action="/order">
                    <input  type="submit" value="<<  Взять заявку  >>" style="width: 150px; height: 30px;">
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
            <th>Площадь</th>
            <th width="100">Отчеты</th>
        </tr>

        <c:forEach var="orders" items="${orders}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${orders.id}"/>
            </c:url>
            <c:url var="completedOrder" value="/order/createCompletedOrder" >
                <c:param name="orderId" value="${orders.id}"/>
            </c:url>
            <c:url var="canceledOrder" value="/order/createCanceledOrder" >
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
                <td align="left">
                    <table>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                    <c:forEach var="report" items="${orders.reports}">
                        <tr>
                            <td>
                                <fmt:parseDate value="${report.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                               var="parsedDateTime" type="both" />

                                <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                                <br>
                                <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                            </td>
                <td>${report.description}</td>
                        </tr>
                </c:forEach>
                    </table>
                </td>
                <td col style="background-color:white" align="center">
                    <table>
                        <tr>
                            <th></th>
                        </tr>
                        <tr>
                            <td>
                                <br>
                                <input type="button" value="<< Оставить отчет >>" style="width:150px"
                                       onclick = "window.location.href = '${createReport}'"/>
                                <p></p>
                                <input type="button" value="<<     Выполнить    >> " style="width:150px"
                                       onclick = "window.location.href = '${completedOrder}'"/>
                                <p></p>
                                <input type="button" value="<<     Отменить     >>" style="width:150px"
                                       onclick = "window.location.href = '${canceledOrder}'"/>
                                <br>
                                <p> </p>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </c:forEach>
    </table>
    <font size="4" face="Courier New" >
        <c:if test="${countOrders < 1}">
        <p>У Вас еще нет заявок! Что бы взять заявку, перейдите по кнопке "Взять заявку"<p>
        </c:if>
    </font>
</font>

</body>
</html>
