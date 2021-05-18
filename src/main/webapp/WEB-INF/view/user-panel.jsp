<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Кабинет</title>
</head>
<body>
<table border="0" width="100%">
    <tr>
        <th align="left">
            <img  src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th>
            <font size="4" face="Courier New" >
                <p align="right">Привет  ${user.userDetails.name} ${user.userDetails.lastName} Ваш город: ${user.userDetails.city} </p>
                <p align="right">Логин: ${user.loginName}</p>
                <p align="right">Баланс: ${user.userDetails.balance} грн</p>
                <p align="right">Макс. заявок: <b style="color: #ff3300">${user.userDetails.maxCountOrders} </b>
                    Заявок в работе: <b style="color: #ff0000">${user.userDetails.currentCountOrders}</b></p>
                <p align="right">Макс. отмен заявок : <b style="color: #ff0000">${user.userDetails.maxCountCanceledOrders} </b>
                    Отмененных заявок : <b style="color: #ff0000">${user.userDetails.currentCanceledCountOrders}</b></p>
                <p align="right">Выполненные заявки : <b style="color: #1aff00">${user.userDetails.currentComplededCountOrders} </b>
                </p>

                <form method="LINK" align="right" action="/order">
                    <input  type="submit" value="<<  Взять заявку  >>" style="width: 150px; height: 30px;">
                </form>
            </font>
        </th>
    </tr>
</table>

<br>
<font size="7" face="Courier New" >Мои заявки на утепление в работе</font>
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

        <c:forEach var="ordersInWork" items="${ordersInWork}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>
            <c:url var="completedOrder" value="/order/createCompletedOrder" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>
            <c:url var="canceledOrder" value="/order/createCanceledOrder" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${ordersInWork.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersInWork.orderDetails.customerName}</td>
                <td>${ordersInWork.orderDetails.address}</td>
                <td>${ordersInWork.orderDetails.countRooms}</td>
                <td>${ordersInWork.orderDetails.city}</td>
                <td>${ordersInWork.orderDetails.phoneNumber}</td>
                <td>${ordersInWork.orderDetails.squareArea}</td>
                <td align="left">
                    <table border="0">
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                    <c:forEach var="report" items="${ordersInWork.reports}">
                        <tr>
                            <td align="center">
                                <fmt:parseDate value="${report.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                               var="parsedDateTime" type="both" />
                                <br>
                                <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                                <br>
                                <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                            </td>
                <td>
                    <br>${report.description}</td>
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
        <c:if test="${countOrdersInWork < 1}">
        <p>У Вас еще нет заявок в работе! Что бы взять заявку, перейдите по кнопке "Взять заявку"<p>
        </c:if>
    </font>
</font>


<br>
<font size="7" face="Courier New" >Архив моих заявок</font>
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

        <c:forEach var="ordersInArchive" items="${ordersInArchive}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${ordersInArchive.id}"/>
            </c:url>
            <c:url var="completedOrder" value="/order/createCompletedOrder" >
                <c:param name="orderId" value="${ordersInArchive.id}"/>
            </c:url>
            <c:url var="canceledOrder" value="/order/createCanceledOrder" >
                <c:param name="orderId" value="${ordersInArchive.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${ordersInArchive.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersInArchive.orderDetails.customerName}</td>
                <td>${ordersInArchive.orderDetails.address}</td>
                <td>${ordersInArchive.orderDetails.countRooms}</td>
                <td>${ordersInArchive.orderDetails.city}</td>
                <td>${ordersInArchive.orderDetails.phoneNumber}</td>
                <td>${ordersInArchive.orderDetails.squareArea}</td>
                <td align="left">
                    <table border="0">
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${ordersInArchive.reports}">
                            <tr>
                                <td align="center">
                                    <fmt:parseDate value="${report.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                   var="parsedDateTime" type="both" />
                                    <br>
                                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                                    <br>
                                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                                </td>
                                <td>
                                    <br>${report.description}
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
                <td col style="background-color:white" align="center">
                </td>
            </tr>
        </c:forEach>
    </table>
    <font size="4" face="Courier New" >
        <c:if test="${countOrdersInArchive < 1}">
        <p>У Вас еще нет заявок в работе! Что бы взять заявку, перейдите по кнопке "Взять заявку"<p>
        </c:if>
    </font>
</font>

</body>
</html>
