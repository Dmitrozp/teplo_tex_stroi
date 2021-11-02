<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Главная страница ТеплоТехСтрой</title>
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
                    <security:authorize access="hasAnyRole('ADMIN', 'MANAGER', 'SUPER_MANAGER')">
                        <form  align="right" method="LINK" action="/manager">
                            <input class="navigation" type="submit" value="для менеджера">
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <form method="LINK" align="right" action="/order">
                        <input class="navigation-action" type="submit" value="главная" >
                    </form>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form align="right" method="LINK" action="/profile">
                            <input class="navigation" type="submit" value="кабинет с заявками">
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <form method="LINK" align="right" action="/order/archive">
                        <input class="navigation" type="submit" value="архив заявок" >
                    </form>
                </td>
            </table>
            <br>
            <br>
            <br>
        </td>
    </tr>
</table>
    <br>
<h1 align="center">Заявки на утепление квартир и домов по Украине</h1>
<table class="table-order">
    <tr class="table-order-tr-head">
        <th>Дата заявки</th>
        <th>Имя заказчика</th>
        <th>Адрес</th>
        <th>Количество комнат</th>
        <th>Город</th>
        <th>Телефон</th>
        <th>Площадь утепления</th>
        <th>Примечание</th>
        <th>Навигация</th>
    </tr>

    <c:forEach var="orders" items="${orders}" >

        <c:url var="addOrder" value="/order/addOrder" >
            <c:param name="orderId" value="${orders.id}"/>
        </c:url>

        <tr class="table-order-tr-row">
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
            <td>${orders.orderDetails.notes}</td>
            <td>
                <input class="order" type="button" value="взять заявку"
                onclick = "window.location.href = '${addOrder}'"/>
            </td>
        </tr>
    </c:forEach>
</table>
<security:authorize access="hasAnyRole('SUPER_USER')">
    <br>
<h1 align="center">Заявки которые не попали еще в общий список, который видят все </h1>
    <br>
<table class="table-order">
        <tr class="table-order-tr-head">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Количество комнат</th>
            <th>Город</th>
            <th>Телефон</th>
            <th>Площадь утепления</th>
            <th>Примечание</th>
            <th>Навигация</th>
        </tr>

        <c:forEach var="ordersNotVerified" items="${ordersNotVerified}" >

            <c:url var="addOrderNotVerified" value="/order/addOrder" >
                <c:param name="orderId" value="${ordersNotVerified.id}"/>
            </c:url>

            <tr class="table-order-tr-row">
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
                <td>
                    <table>
                        <tr height="10">
                            <td></td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" value="взять заявку"
                                       onclick = "window.location.href = '${addOrderNotVerified}'"/>
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
</security:authorize>
</body>
</html>