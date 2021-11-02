<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Комментарий к заявке</title>
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
                        <form  align="right" method="LINK" action="/manager">
                            <input class="navigation" type="submit" value="для менеджера">
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form method="LINK" align="right" action="/order">
                            <input class="navigation" type="submit" value="взять заявку" >
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
    <form:form action="saveReport" class="ui-form" modelAttribute="report">
        <h2 align="center">Оставить комментарий к заявке</h2>
        <form:hidden path="id"/>
        <form:hidden path="order.id"/>
        <div class="form-row">
        <form:textarea path="description" cols="50" rows="10" />
        </div>
        <p><input type="submit" value="Сохранить" /></p>
    </form:form>
</div>
</body>
</html>
