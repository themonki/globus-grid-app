<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 */
/**
 * Cleare session cookies
 */
session_start();
include_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
?>
<!doctype html>
<html>
    <head>
        <script src="<?php echo SITE_APP . "/js/"; ?>scripts.js" type="text/javascript"></script> 
    </head>
    <body>
        <?php
        if (session_destroy()) {
            ?>
            <?php            
            header("Location: " .SITE_WEB . "/login/signin.php");
        }
        ?>
    </body>
</html>



