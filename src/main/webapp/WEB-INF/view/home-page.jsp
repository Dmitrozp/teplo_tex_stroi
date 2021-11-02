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
    <style>
        <%@include file="css/my.css" %>
    </style>
</head>
<body>
<table class="table-head">
    <tr>
        <td valign="center">
            <table>
                <<td class="logo"><img class="logo"/></td>
                <td><a class="a-logo" href="https://teplo-tex-stroi.com/"><strong class="logo">ТеплоТехСтрой</strong></a></td>
            </table>

        </td>
        <td>
            <table border="0" align="right">
                <td><h2 class="head" align="right">Ваш профиль:  ${user.userDetails.name} ${user.userDetails.lastName}</h2></td>
                <td align="right" >
                    <form  align="right" method="LINK" action="/order">
                    <input class="navigation" type="submit" value="войти">
                    </form>
                </td>
                <td align="right" >
                    <form  align="right" method="LINK" action="/logout">
                    <input class="navigation" type="submit" value="выйти">
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
    <p>Что бы получить доступ к списку заявок нужно <a href="/order">ВОЙТИ</a>, либо используйте для теста логин:test пароль:test</p>
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
