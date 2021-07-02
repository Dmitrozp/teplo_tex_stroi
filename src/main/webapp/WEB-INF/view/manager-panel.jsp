<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Панель управления заявками для менеджера</title>
</head>
<body>
<table border="0" width="100%">
    <tr>
        <th align="left">
            <img src="${pageContext.request.contextPath}/img/logo1.jpg"/>
        </th>
        <th>
            <font size="4" face="Courier New" >
                <form  align="right" method="LINK" action="/logout">
                    <input type="submit" value="<< Выйти >>" style="width: 250px; height: 30px;">
                </form>
                <p align="right"><b>Панель менеджера</b></p>
                <p align="right">Привет  ${user.userDetails.name} ${user.userDetails.lastName} Ваш город: ${user.userDetails.city} </p>
                <p align="right">Логин: ${user.loginName}</p>
                <p align="right">Баланс: ${user.userDetails.balance} грн</p>
                <security:authorize access="hasAnyRole('ADMIN', 'MANAGER', 'SUPER_MANAGER')">
                    <form  align="right" method="LINK" action="/profile">
                        <input type="submit" value="<< Кабинет с моими заявками >>" style="width: 250px; height: 30px;">
                    </form>
                    <form  align="right" method="LINK" action="/order">
                        <input type="submit" value="<< На главную >>" style="width: 250px; height: 30px;">
                    </form>
                    <form  align="right" method="LINK" action="/order/createNewOrder">
                        <input type="submit" value="<< Создать новую заявку >>" style="width: 250px; height: 30px;">
                    </form>

                </security:authorize>
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

            <c:url var="editOrder" value="/order/edit" >
                <c:param name="orderId" value="${newOrders.id}"/>
            </c:url>

            <c:url var="addOrder" value="/order/addOrder" >
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
                    <table>
                        <tr>
                            <th></th>
                        </tr>
                        <tr>
                            <td>
                                <br>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER', 'MANAGER', 'ADMIN')">
                                <input type="button" value="Отправить заявку в работу"
                                       onclick = "window.location.href = '${sendOrderInWork}'"/>
                                </security:authorize>
                                <p></p>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER','MANAGER', 'ADMIN')">
                                <input type="button" value="<<   Редактировать   >>"
                                       onclick = "window.location.href = '${editOrder}'"/>
                                </security:authorize>
                                <p></p>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER', 'ADMIN')">
                                <input type="button" value="<<   Взять заявку   >>"
                                       onclick = "window.location.href = '${addOrder}'"/>
                                </security:authorize>
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
        <c:if test="${countNewOrders < 1}">
        <p>У Вас еще нет заявок! <p>
        </c:if>
    </font>
</font>

<security:authorize access="hasAnyRole('SUPER_MANAGER', 'ADMIN')">
<br>
<font size="7" face="Courier New" >Заявки в работе </font>
<br>
<br>
<font size="4" face="Courier New" >

    <table width="100%">
        <tr col span="2" style="background:Khaki" align="center">
            <th>Дата заявки</th>
            <th>Исполнитель</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Количество комнат</th>
            <th>Город</th>
            <th>Телефон</th>
            <th>Площадь</th>
            <th>Примечание</th>
            <th>Отчеты</th>
        </tr>

        <c:forEach var="ordersInWork" items="${ordersInWork}" >

            <c:url var="sendOrderInWork" value="/manager/sendOrderInWork" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>

            <c:url var="editOrder" value="/order/edit" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>

            <c:url var="addOrder" value="/order/addOrder" >
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
                <td>${ordersInWork.userExecutor.loginName}</td>
                <td>${ordersInWork.orderDetails.customerName}</td>
                <td>${ordersInWork.orderDetails.address}</td>
                <td>${ordersInWork.orderDetails.countRooms}</td>
                <td>${ordersInWork.orderDetails.city}</td>
                <td>${ordersInWork.orderDetails.phoneNumber}</td>
                <td>${ordersInWork.orderDetails.squareArea}</td>
                <td align="left">${ordersInWork.orderDetails.notes}</td>
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
                <td col style="background-color:white" align="center">
                    <table>
                        <tr>
                            <th></th>
                        </tr>
                        <tr>
                            <td>
                                <br>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER', 'MANAGER', 'ADMIN')">
                                    <input type="button" value="Отправить заявку в работу"
                                           onclick = "window.location.href = '${sendOrderInWork}'"/>
                                </security:authorize>
                                <p></p>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER','MANAGER', 'ADMIN')">
                                    <input type="button" value="<<   Редактировать   >>"
                                           onclick = "window.location.href = '${editOrder}'"/>
                                </security:authorize>
                                <p></p>
                                <security:authorize access="hasAnyRole('SUPER_MANAGER', 'ADMIN')">
                                    <input type="button" value="<<   Взять заявку   >>"
                                           onclick = "window.location.href = '${addOrder}'"/>
                                </security:authorize>
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
        <p>Нет заявок в работе! <p>
        </c:if>
    </font>
</font>
</security:authorize>



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

            <c:url var="saveOrderInArchive" value="/order/saveOrderInArchive" >
                <c:param name="orderId" value="${canceledOrders.id}"/>
            </c:url>

            <c:url var="createReport" value="/order/createReport" >
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

                    <input type="button" value="<< Оставить отчет >>" style="width:150px"
                           onclick = "window.location.href = '${createReport}'"/>
                    <p></p>

                    <input type="button" value="<<  Забыть  >>"
                           onclick = "window.location.href = '${saveOrderInArchive}'"/>

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
