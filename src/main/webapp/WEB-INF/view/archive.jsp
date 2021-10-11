<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Архив моих заявок</title>
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
                    <security:authorize access="hasAnyRole('ADMIN', 'MANAGER', 'SUPER_MANAGER')">
                        <form  align="right" method="LINK" action="/manager">
                            <input class="navigation" type="submit" value="Кабинет для менеджера" style="width: 250px; height: 30px;">
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
                        <form method="LINK" align="right" action="/profile">
                        <input class="navigation" type="submit" value="Мои завки">
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
<h1 align="center">Архив заявок.</h1>
<br>
<h2 align="left">Выполненые заявки:</h2>
    <table class="table-order">
        <tr class="table-order-tr-head">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Количество комнат</th>
            <th>Город</th>
            <th>Телефон</th>
            <th>Площадь</th>
            <th>Комментарии</th>
            <th>Навигация</th>
        </tr>

        <c:forEach var="ordersCompletedInArchive" items="${ordersCompletedInArchive}" >

            <c:url var="createReport" value="/order/createReport" >
                <c:param name="orderId" value="${ordersCompletedInArchive.id}"/>
            </c:url>
            <c:url var="executingOrder" value="/order/createExecutingOrder" >
                <c:param name="orderId" value="${ordersCompletedInArchive.id}"/>
            </c:url>

            <tr class="table-order-tr-row">
                <td>
                    <fmt:parseDate value="${ordersCompletedInArchive.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersCompletedInArchive.orderDetails.customerName}</td>
                <td>${ordersCompletedInArchive.orderDetails.address}</td>
                <td>${ordersCompletedInArchive.orderDetails.countRooms}</td>
                <td>${ordersCompletedInArchive.orderDetails.city}</td>
                <td>${ordersCompletedInArchive.orderDetails.phoneNumber}</td>
                <td>${ordersCompletedInArchive.orderDetails.squareArea}</td>
                <td align="left">
                    <table border="0">
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${ordersCompletedInArchive.reports}">
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
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN')">
                        <table>
                            <tr></tr>
                            <tr align="center">
                                <th>
                                    <input class="order" type="button" value="Комментарий"
                                           onclick = "window.location.href = '${createReport}'"/>
                                </th>
                            </tr>
                            <tr align="center">
                                <th>
                                    <input class="order" type="button" value="В работу"
                                           onclick = "window.location.href = '${executingOrder}'"/>
                                </th>
                            </tr>
                            <tr></tr>
                        </table>
                    </security:authorize>
                </td>
            </tr>
        </c:forEach>
    </table>
        <c:if test="${countCompletedInArchive < 1}">
        <p class="p-warning">У Вас еще нет выполненых заявок!</p>
        </c:if>
<h2 align="left">Отмененные заявки:</h2>
<table class="table-order">
        <tr class="table-order-tr-head">
            <th>Дата заявки</th>
            <th>Имя заказчика</th>
            <th>Адрес</th>
            <th>Количество комнат</th>
            <th>Город</th>
            <th>Телефон</th>
            <th>Площадь</th>
            <th>Комментарии</th>
            <th>Навигация</th>

        </tr>

        <c:forEach var="ordersCanceledInArchive" items="${ordersCanceledInArchive}" >

            <c:url var="createReportForCanceledOrder" value="/order/createReport" >
                <c:param name="orderId" value="${ordersCanceledInArchive.id}"/>
            </c:url>
            <c:url var="executingOrderForCanceledOrder" value="/order/createExecutingOrder" >
                <c:param name="orderId" value="${ordersCanceledInArchive.id}"/>
            </c:url>

            <tr class="table-order-tr-row">
                <td>
                    <fmt:parseDate value="${ordersCanceledInArchive.date}" pattern="yyyy-MM-dd'T'HH:mm:ss"
                                   var="parsedDateTime" type="both" />

                    <fmt:formatDate value="${parsedDateTime}" pattern="dd.MM.yyyy" />
                    <br>
                    <fmt:formatDate value="${parsedDateTime}" pattern="HH:mm" />
                </td>
                <td>${ordersCanceledInArchive.orderDetails.customerName}</td>
                <td>${ordersCanceledInArchive.orderDetails.address}</td>
                <td>${ordersCanceledInArchive.orderDetails.countRooms}</td>
                <td>${ordersCanceledInArchive.orderDetails.city}</td>
                <td>${ordersCanceledInArchive.orderDetails.phoneNumber}</td>
                <td>${ordersCanceledInArchive.orderDetails.squareArea}</td>
                <td align="left">
                    <table border="0">
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        <c:forEach var="report" items="${ordersCanceledInArchive.reports}">
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
                <td>
                    <security:authorize access="hasAnyRole('USER', 'ADMIN')">
                        <table>
                            <tr></tr>
                            <tr align="center">
                                <th>
                                    <input class="order" type="button" value="Комментарий"
                                           onclick = "window.location.href = '${createReportForCanceledOrder}'"/>
                                </th>
                            </tr>
                            <tr align="center">
                                <th>
                                    <input class="order" type="button" value="В работу"
                                           onclick = "window.location.href = '${executingOrderForCanceledOrder}'"/>
                                </th>
                            </tr>
                            <tr></tr>
                        </table>
                    </security:authorize>
                </td>
            </tr>
        </c:forEach>
    </table>
        <c:if test="${countCanceledInArchive < 1}">
        <p class="p-warning">У Вас еще нет выполненых заявок!<p>
        </c:if>
</body>
</html>
