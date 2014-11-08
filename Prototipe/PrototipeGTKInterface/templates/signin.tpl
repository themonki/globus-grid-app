<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="{SITE_PROTOTIPE}/css/styleLogin.css" />
        <link rel="stylesheet" href="{SITE_PROTOTIPE}/css/styleMessages.css" />
    </head>
    <body>
        <div class="center">
            <form id="formSignin" name="formSignin" class="formLogin" action ="" method="POST">            
                <h2>Iniciar Sesión</h2>
                <input name="username" type="text" class="text-field" placeholder="Correo"
                       required="true" />
                <input name="password" type="password" class="text-field" placeholder="Contraseña"
                       required="true" />
                <input type="submit" value="Ingresar" class="button" />
                <div class="{msgshow}">{msg}</div>
            </form>
        </div>

    </body>
</html>