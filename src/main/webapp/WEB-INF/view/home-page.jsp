<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <title>ТеплоТехСтрой - база заявок.</title>
    <style>
        p {
            font-size: 16px;
            padding-left: 60px;
            padding-right: 30px;
        }
        h2 {
            padding-left: 30px;
            padding-right: 30px;
        }
        ul {
            font-size: 16px;
            padding-left: 70px;
            padding-right: 30px;
        }
    </style>
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
        p.head {
            font-size: 20px;
            padding-right: 30px;
            color: white;
        }
        p.warning {
            font-size: 20px;
            padding-right: 30px;
            color: red;
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
        input.order {
            background: -moz-linear-gradient(#D0ECF4, #e0ffff, #D0ECF4);
            background: -webkit-gradient(linear, 0 0, 0  100%, from(#D0ECF4), to(#D0ECF4), color-stop(0.5, #e0ffff));
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
        input.navigation {
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
    </style>
</head>
<body>
<table border="0" height="100" width="100%" background="${pageContext.request.contextPath}/img/backgroundtable.jpg">
    <tr>
        <td valign="center">
            <table>
                <td width="60"><img class="logo" width="60%" src="${pageContext.request.contextPath}/img/logo2.png"/></td>
                <td><a href="https://teplo-tex-stroi.com/"><strong class="logo">ТеплоТехСтрой</strong></a></td>
            </table>

        </td>
        <td>
            <table border="0" align="right">
                <td><h2 class="head" align="right">Ваш профиль:  ${user.userDetails.name} ${user.userDetails.lastName}</h2></td>
                <td align="right" >
                    <form  align="right" method="LINK" action="/order">
                    <input class="navigation" type="submit" value="Войти">
                    </form>
                </td>
                <td align="right" >
                    <form  align="right" method="LINK" action="/logout">
                    <input class="navigation" type="submit" value="Выйти">
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
    <br>
    <h2 dir="ltr" style="padding-left: 30px;"><strong>Добрый день.</strong></h2>
    <p><br />Оказываем информационные и маркетинговые услуги по привлечению клиентов на утепление фасадом квартир и частных домом.</p>
    <p>Есть база реальных заявок на утепление фасада квартир и частных домов пенопластом и минватой, отделка и ремонт фасада.</p>
    <p>Сотрудничаем со строительными бригадами и частными мастерами.</p>
    <p>Что бы получить доступ к списку заявок нужно <a href="/order">ВОЙТИ.</a></p>
    <p>Для получения логина и пароля, обращаться по тел. 066 201 93 93 или в viber</p></p>

    <h2><br /><strong>Преимущества работы с нами:</strong></h2>
<ul>
        <li>маркетинг и рекламу мы берем на себя.</li>
        <li>консультацию клиентов оказываем мы.</li>
        <li>вы получаете готового клиента который хочет утеплить фасад, от Вас требуется только приехать на замер, сделать смету согласно прайсу компании, подписать договор на выполнение работ, качественно и в срок выполнить заказ.</li>
        <li>после заключения договора и завоза материалов получаете от клиента предоплату в размере 50%, оставшиеся 50% суммы после выполнения работа.</li>
        <li>нам оплачиваете за заявку только после получения полной оплаты от клиента, для строительных бригад 10% от суммы заказа, для частных мастеров 15% от суммы заказа.</li>
    </ul>

    <h2><strong>Сколько вы зарабатываете на заявке:</strong></h2>
    <p>Пример:</p>
    <p>на заявке по утеплению квартиры 25м<sup>2</sup> пенопластом 100мм М35, стоимость 1м<sup>2</sup> - 850грн для клиента<br />материала - 250грн/м<sup>2</sup><br />
        наши услуги составляют 10% - 85грн, 15% - 128грн<br />
        строительная бригад заработает за 1м<sup>2</sup> : 850грн - 250грн - 85грн = итого 515грн/м<sup>2</sup><br />
        частный мастер заработает за 1м<sup>2</sup> : 850грн - 250грн - 128грн = итого 472грн/м<sup>2</sup></p>
    <p><strong>Итого</strong> за 25м<sup>2</sup> утепления фасада квартиры <br />бригада зарабатывает 12 875грн<br />частный мастер 11 800 грн</p>

    <h2><strong>Требование к подрядчикам:</strong></h2>
    <ul>
        <li>наличие ЧП</li>
        <li>наличие всего инструмента и снаряжения</li>
        <li>разрешительных документов на высотные работы</li>
    </ul>
</font>
</body>
</html>
