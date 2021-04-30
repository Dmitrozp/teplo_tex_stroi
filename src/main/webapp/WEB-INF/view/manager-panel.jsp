<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Панель управления заявками для менеджера</title>
</head>
<body>
<table border="0">
    <tr>
        <th align="left">
            <img width=100% src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th width="50%">
            <font size="4" face="Courier New" >
                <form  align="right" method="LINK" action="/logout">
                    <input type="submit" value="<< Выйти >>" style="width: 250px; height: 30px;">
                </form>
                <p align="right"><b>Панель менеджера</b></p>
                <p align="right">Привет  ${user.userDetails.name} ${user.userDetails.lastName} Ваш город: ${user.userDetails.city} </p>
                <p align="right">Логин: ${user.loginName}</p>
                <p align="right">Баланс: ${user.userDetails.balance} грн</p>
            </font>
        </th>
    </tr>
</table>

<br>
<font size="7" face="Courier New" >Новые заявки которые нужно утвердить в работу</font>
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
            <th width="100">Примечание</th>
        </tr>

        <c:forEach var="newOrders" items="${newOrders}" >

            <c:url var="sendOrderInWork" value="/manager/sendOrderInWork" >
                <c:param name="orderId" value="${newOrders.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${newOrders.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${newOrders.orderDetails.customerName}</td>
                <td>${newOrders.orderDetails.address}</td>
                <td>${newOrders.orderDetails.countRooms}</td>
                <td>${newOrders.orderDetails.city}</td>
                <td>${newOrders.orderDetails.phoneNumber}</td>
                <td>${newOrders.orderDetails.squareArea}</td>
                <td align="left">${newOrders.orderDetails.notes}</td>
                <td col style="background-color:white" align="center">
                    <input type="button" value="Отправить заявку в работу"
                           onclick = "window.location.href = '${sendOrderInWork}'"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <font size="4" face="Courier New" >
        <c:if test="${countNewOrders < 1}">
        <p>У Вас еще нет заявок! <p>
        </c:if>
    </font>
</font>

<br>
<font size="6" face="Courier New" >Отмененные заявки, по которым нужно проверить причину отмены</font>
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

        <c:forEach var="canceledOrders" items="${canceledOrders}" >

            <c:url var="sendOrderInWork" value="/manager/sendOrderInWork" >
                <c:param name="orderId" value="${canceledOrders.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${canceledOrders.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${canceledOrders.orderDetails.customerName}</td>
                <td>${canceledOrders.orderDetails.address}</td>
                <td>${canceledOrders.orderDetails.countRooms}</td>
                <td>${canceledOrders.orderDetails.city}</td>
                <td>${canceledOrders.orderDetails.phoneNumber}</td>
                <td>${canceledOrders.orderDetails.squareArea}</td>
                <td align="left">
                    <table>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${canceledOrders.reports}">
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
                    <input type="button" value="Отправить заявку в работу"
                           onclick = "window.location.href = '${sendOrderInWork}'"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <font size="4" face="Courier New" >
        <c:if test="${countCanceledOrders < 1}">
        <p>У Вас еще нет отменненых заявок! <p>
        </c:if>
    </font>
</font>

<br>
<font size="6" face="Courier New" >Выполненные заявки, по которым нужно проверить оплату</font>
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

        <c:forEach var="completedOrders" items="${completedOrders}" >

            <c:url var="sendOrderInWork" value="/manager/sendOrderInWork" >
                <c:param name="orderId" value="${completedOrders.id}"/>
            </c:url>

            <tr col style="background-color:LightCyan" align="center">
                <td>
                    <fmt:parseDate value="${completedOrders.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${completedOrders.orderDetails.customerName}</td>
                <td>${completedOrders.orderDetails.address}</td>
                <td>${completedOrders.orderDetails.countRooms}</td>
                <td>${completedOrders.orderDetails.city}</td>
                <td>${completedOrders.orderDetails.phoneNumber}</td>
                <td>${completedOrders.orderDetails.squareArea}</td>
                <td align="left">
                    <table>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${completedOrders.reports}">
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
                    <input type="button" value="Отправить заявку в работу"
                           onclick = "window.location.href = '${sendOrderInWork}'"/>
                </td>
            </tr>
        </c:forEach>
    </table>
    <font size="4" face="Courier New" >
        <c:if test="${countCompletedOrders < 1}">
        <p>У Вас еще нет выполненных заявок! <p>
        </c:if>
    </font>
</font>

</body>
</html>
