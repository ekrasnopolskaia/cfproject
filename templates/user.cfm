<!doctype html>
<html lang="ru">
<head>
    <title>Sign in</title>
<style type="text/css">
div {
    background-color: #BAFDC1;
    width: 400px; 
    padding: 5px;
    padding-right: 20px; 
    border: solid 1px black; 
    position: absolute;
    top: 50%;
    left: 50%;
    margin-right: -50%;
    transform: translate(-50%, -50%);
    line-height: 2;
}
</style>
</head>
<body>
<table>
  <form method="post">
    <div>
  <center>
	<legend><b>Вход в систему</b></legend>
	<p><input name="login" maxlength="25" size="40" placeholder="Ваше имя" ></p>
	<p><input type = "password" name="password" placeholder="Ваш пароль" maxlength="25" size="40" ></p>
	<p><input type="submit" value="Войти"></p>
	<a href="">Восстановление пароля</a><br>
	<a href="">Регистрация</a>
  </center>
</div>
	</form>
</table>
</body>