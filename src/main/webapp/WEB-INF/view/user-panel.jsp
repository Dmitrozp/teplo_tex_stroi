<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Мой кабинет с заявками</title>
    <style>
        <%@include file="css/my.css" %>
    </style>
</head>
<body>

<table class="table-head">
    <tr>
        <td valign="top" width="50%">
            <table>
                <td class="logo"><img class="logo"/></td>
                <td><a class="a-logo" href="https://teplo-tex-stroi.com/"><strong class="logo">ТеплоТехСтрой</strong></a></td>
            </table>
            <p></p>
            <h2 class="head" align="center"><strong>новости и обновления</strong></h2>
            <div class="news-head">
                <c:forEach var="news" items="${news}">
                    <table>
                        <td>
                            <p class="p-news">
                                <fmt:parseDate value="${news.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                               var="parsedDateTime" type="both" />
                                <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                            </p>
                        </td>
                        <td>
                            <a class="a-news" href="/newsItem?newsId=${news.id}">${news.title}</a>

                        </td>
                    </table>
                </c:forEach>
                <br>
                <a class="a-news" href="/news"><p align="center">Все новости</p></a>
            </div>
        </td>
        <td>
            <table border="0" width="100%" align="center">
                <td align="right"><p class="p-head" >Ваш профиль:  ${user.userDetails.name} ${user.userDetails.lastName}</p></td>
                <td align="right" >
                    <form  class="head" align="right" method="LINK" action="/logout">
                    <input class="navigation" type="submit" value="выйти">
                    </form></td>
            </table>
            <br>
            <br>
            <p class="p-text" align="right">
                Логин:<strong>  ${user.loginName}</strong>
                Ваш город:<strong> ${user.userDetails.city} </strong></p>
            <p class="p-text" align="right">
                На сегодня баланс:<strong>  ${user.userDetails.balance} </strong>грн</p>
            <c:if test="${user.userDetails.balance*-1 > user.userDetails.maxCrediteBalance}">
                    <p class="p-warning" align="right">У Вас задолжность по оплате за </p>
                    <p class="p-warning" align="right">выполненные заявки, оплатите пожалуйста!</p>
            </c:if>

            <p class="p-text" align="right">
                Заявок в работе: <strong> ${user.userDetails.currentCountOrders}</strong></p>
            <p class="p-text" align="right">
                Заявки в исполнении: <strong> ${countOrdersExecuting}</strong></p>
            <p class="p-text" align="right">
                Отмененных заявок : <strong> ${user.userDetails.currentCanceledCountOrders}</strong></p>
            <p class="p-text" align="right">Выполненные заявки: <strong> ${user.userDetails.currentComplededCountOrders} </strong></p>
            <br>
            <table border="0" align="right">
                <td>
                    <security:authorize access="hasAnyRole('ADMIN', 'MANAGER', 'SUPER_MANAGER','SUPER_USER')">
                        <form  align="right" method="LINK" action="/manager">
                            <input class="navigation" type="submit" value="для менеджера">
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form method="LINK" align="right" action="/order">
                        <input class="navigation" type="submit" value="главная" >
                        </form>
                    </security:authorize>
                </td>
                <td>
                        <form align="right" method="LINK" action="/profile">
                            <input class="navigation-action" type="submit" value="кабинет с заявками" >
                        </form>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form method="LINK" align="right" action="/order/archive">
                        <input class="navigation" type="submit" value="архив заявок" >
                        </form>
                    </security:authorize>
                </td>
            </table>
            <br>
            <br>
            <br>
        </td>
    </tr>
</table>
<br>
<h1 align="center">Заявки в работе:</h1>
<br>
<table class="table-order">
        <tr class="table-order-tr-head">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th >Количество комнат</th>
            <th >Город</th>
            <th>Телефон</th>
            <th>Площадь</th>
            <th>Комментарии</th>
            <th>Навигация</th>
        </tr>

        <c:forEach var="ordersInWork" items="${ordersInWork}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>
            <c:url var="executingOrder" value="/order/createExecutingOrder" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>
            <c:url var="canceledOrder" value="/order/createCanceledOrder" >
                <c:param name="orderId" value="${ordersInWork.id}"/>
            </c:url>

            <tr class="table-order-tr-row">
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
                            <td>
                                <fmt:parseDate value="${report.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                               var="parsedDateTime" type="both" />
                                <br>
                                <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                                <br>
                                <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                            </td>
                            <td>
                                <br>
                                <br>
                                    ${report.description}
                                <br>
                                <br>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                </td>
                <td align="center">
                    <table>
                        <tr height="10">
                            <td></td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order"  type="button" align="100%" value="комментарий"
                                       onclick = "window.location.href = '${createReport}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" align="100%" value="в исполнение"
                                       onclick = "window.location.href = '${executingOrder}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" align="100%" value="отменить"
                                       onclick = "window.location.href = '${canceledOrder}'"/>
                            </td>
                        </tr>
                        <tr height="10">
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${countOrdersInWork < 1}">
        <p class="p-warning">У Вас еще нет заявок в работе! Что бы взять заявку, перейдите по кнопке "Взять заявку"<p>
    </c:if>
<br>
<h1 align="center">Заявки которые уже в исполнении мастерами:</h1>
<br>
<table class="table-order">
        <tr class="table-order-tr-head">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Номер договора</th>
            <th>Площадь</th>
            <th>Сумма по договору</th>
            <th>Дата окончания работ</th>
            <th>Телефон</th>
            <th>Комментарий</th>
            <th>Навигация</th>
        </tr>

        <c:forEach var="ordersExecuting" items="${ordersExecuting}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${ordersExecuting.id}"/>
            </c:url>
            <c:url var="completedOrder" value="/order/createCompletedOrder" >
                <c:param name="orderId" value="${ordersExecuting.id}"/>
            </c:url>

            <tr class="table-order-tr-row">
                <td>
                    <fmt:parseDate value="${ordersExecuting.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersExecuting.orderDetails.customerName}</td>
                <td>${ordersExecuting.orderDetails.address}</td>
                <td>${ordersExecuting.nameContract}</td>
                <td>${ordersExecuting.orderDetails.squareArea}</td>
                <td>${ordersExecuting.summOfContract}</td>
                <td>${ordersExecuting.dateFinished}</td>
                <td>${ordersExecuting.orderDetails.phoneNumber}</td>
                <td align="left">
                    <table border="0">
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${ordersExecuting.reports}">
                            <tr align="center">
                                <td align="center">
                                    <fmt:parseDate value="${report.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                   var="parsedDateTime" type="both" />
                                    <br>
                                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                                    <br>
                                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                                </td>
                                <td>
                                    <br>
                                    <br>
                                        ${report.description}
                                    <br>
                                    <br>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
                <td align="center">
                    <table>
                        <tr height="10">
                            <td></td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" value="комментарий"
                                onclick = "window.location.href = '${createReport}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" value="закрыть"
                                       onclick = "window.location.href = '${completedOrder}'"/>
                            </td>
                        </tr>
                        <tr height="10">
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${countOrdersExecuting < 1}">
        <p class="p-warning">У Вас еще нет исполняемых заявок!<p>
    </c:if>
</body>
</html>
