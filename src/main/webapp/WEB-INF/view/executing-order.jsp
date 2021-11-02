<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Добавление заявки в исполнение</title>
    <style>
        <%@include file="css/my.css" %>
        <%@include file="css/form.css" %>
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
                        <form  align="right" method="LINK" action="/order/createNewOrder">
                            <input class="navigation" type="submit" value="создать заявку">
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
    <div align="center">
        <form:form action="saveExecutingOrder" class="ui-form" modelAttribute="order">
            <h2 align="center">${user.userDetails.name}, вы добавляете заявку в исполнение!</h2>
            <table>
                <tr>
                    <td align="left">Заявка : ${order.id}</td>
                    <td align="right">Дата : ${order.date}</td>
                </tr>
                <tr>
                    <td align="left">Заказчик : ${order.orderDetails.customerName}</td>
                    <td align="right">Адрес : ${order.orderDetails.address}</td>
                </tr>
                <tr>
                    <td align="left">Телефон : ${order.orderDetails.phoneNumber}</td>
                    <td align="right">Город : ${order.orderDetails.city}</td>
                </tr>
            </table>
            <h2 align="center">Введите данный об исполняемой заявке:</h2>
            <div align="left">
            <form:hidden path="id"/>
            <p><b>Введите № договора :</b><br>
                >><form:input type="text" size="20" path="nameContract"/> *
            </p>
            <p><b>Введите адрес по договору :</b><br>
                >><form:input type="text" size="20" path="orderDetails.address"/> *
            </p>
            <p><b>Введите полную сумму оплаты по договору :</b><br>
                >><form:input type="number" size="20" path="summOfContract"/> * только цифры
            </p>
            <p><b>Введите площадь утепления :</b><br>
                >><form:input type="number" size="20" path="orderDetails.squareAreaFromReport"/> * только цифры
            </p>
            <p><b>Введите ориентировочную дату окончания работ :</b><br>
                >><form:input type="text" size="20" path="dateFinished"/> * пример: 2021-04-30
            </p>
                * поля не могут быть пустыми
            </div>
            <p><input type="submit" value="Сохранить" /></p>
        </form:form>
    </div>
</body>
</html>
