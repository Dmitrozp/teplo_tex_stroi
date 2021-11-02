<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
 <title>Панель управления заявками для менеджера</title>
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
 <form:form action="" class="ui-form" modelAttribute="">
  <h2 align="center">Произошла ошибка!</h2>
  <p>${status} ${error}</p>
  <p>${message}</p>
  <p>либо обратитесь к администратору 099 201 93 93</p>
  <br>
  <br>
  <button type="button" name="back" onclick="history.back()">вернуться назад</button>
 </form:form>
</div>
</body>
</html>
