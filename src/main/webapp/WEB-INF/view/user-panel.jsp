<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Мой кабинет с заявками</title>
    <style type="text/css">
        img.logo {
            padding-left: 20px;
            padding-top: 5px;

        }
        strong.logo{
            font-size: xx-large;
            padding-left: 0px;
            padding-top: 20px;
            color: white;
        }
        p{}
        .p-head {
            font-size: 30px;
            padding-right: 30px;
            margin: 0px;
            color: white;
        }
        .p-text {
            font-size: 20px;
            padding-right: 30px;
            margin: 0px;
            color: white;
        }
        .p-warning {
            font-size: 20px;
            padding-right: 30px;
            margin: 0px;
            color: red;
        }
        table{}
        .table-order{
            width: 100%;
            font-size: medium;
            font-family: Arial;
            text-align: center;
        }
        .table-head{
            width: 100%;
            border-width: 0;
        }
        .table-order-tr-head{
            background:Khaki;
            align-content: center;
        }
        .table-order-tr-row{
            background:LightCyan;
            align-content: center;
        }
        h2 {
            padding-left: 30px;
            padding-right: 30px;
        }
        h2.head {
            padding-left: 30px;
            padding-right: 30px;
            color: white;
        }
        ul {
            font-size: 16px;
            padding-left: 70px;
            padding-right: 30px;
        }
        input{}
        .order {
            background: -moz-linear-gradient(#f3f4d0, #e2e921, #f4f3d0);
            background: -webkit-gradient(linear, 0 0, 0  100%, from(#f4f3d0), to(#f2f4d0), color-stop(0.5, #eae719));
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00BBD6', endColorstr='#EBFFFF');
            padding: 3px 7px;
            color: #333;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            border: 1px solid #666;
            font-size: large;
            width:150px
        }
        .navigation {
            background: -moz-linear-gradient(#f3f4d0, #e2e921, #f4f3d0);
            background: -webkit-gradient(linear, 0 0, 0  100%, from(#f4f3d0), to(#f2f4d0), color-stop(0.5, #eae719));
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00BBD6', endColorstr='#EBFFFF');
            padding: 3px 7px;
            color: #333;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            border: 1px solid #666;
            font-size: large;
            padding-right: 10px;
            padding-left: 10px;
        }
        form{}
        .head{
            margin: 0px;
        }
    </style>
</head>
<body>
<table class="table-head" background="${pageContext.request.contextPath}/img/backgroundtable.jpg">
    <tr>
        <td valign="top" width="50%">
            <table>
                <td width="60"><img class="logo" width="60%" src="${pageContext.request.contextPath}/img/logo2.png"/></td>
                <td><a href="https://teplo-tex-stroi.com/"><strong class="logo">ТеплоТехСтрой</strong></a></td>
            </table>

            <h2 class="head" align="center"><strong>Последнии новости и обновления.</strong></h2>
        </td>
        <td>
            <table border="0" width="100%" align="center">
                <td align="right"><p class="p-head" >Ваш профиль:  ${user.userDetails.name} ${user.userDetails.lastName}</p></td>
                <td align="right" >
                    <form  class="head" align="right" method="LINK" action="/logout">
                    <input class="navigation" type="submit" value="Выйти">
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
                <font color="red">
                    <p class="p-warning" align="right">У Вас задолжность по оплате за </p>
                    <p class="p-warning" align="right">выполненные заявки, оплатите пожалуйста!</p>
                </font>
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
                            <input class="navigation" type="submit" value="Кабинет для менеджера">
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form method="LINK" align="right" action="/order">
                        <input class="navigation" type="submit" value="Взять заявку" >
                        </form>
                    </security:authorize>
                </td>
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN','SUPER_USER')">
                        <form method="LINK" align="right" action="/order/archive">
                        <input class="navigation" type="submit" value="Архив заявок" >
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
                <td>
                    <table>
                        <tr height="10">
                            <td></td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order"  type="button" align="100%" value="Комментарий"
                                       onclick = "window.location.href = '${createReport}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" align="100%" value="В работу"
                                       onclick = "window.location.href = '${executingOrder}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" align="100%" value="Отменить"
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
                <td >
                    <table>
                        <tr height="10">
                            <td></td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" value="Комментарий"
                                onclick = "window.location.href = '${createReport}'"/>
                            </td>
                        </tr>
                        <tr height="15" align="center">
                            <td>
                                <input class="order" type="button" value="Выполнить"
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
