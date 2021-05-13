<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <!DOCTYPE html>
<html lang="en">
<body>
Произошла ошибка! ${status} ${error}
<br>
${message}

<br>
${m}
<br>
<button type="button" name="back" onclick="history.back()">вернуться назад</button>

</body>
</html>
