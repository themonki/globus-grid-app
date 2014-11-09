<?php
/**
 * PHP Simpe Login
 * @author Resalat Haque
 * @link http://www.w3bees.com/2013/02/php-simple-log-in-example.html
 * 
 * Funciónes para controlar la session y acceso a las paginas.
 * @author Edgar Moncada - Modificaciones
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_MODEL . '/ModelUser.php' );
include_once( PWD_MODEL . '/ModelCert.php' );
//include_once( PWD_MODEL . '/ModelRelationUserCert.php' );
include_once( PWD_LOGICA . '/User.php' );
include_once( PWD_LOGICA . '/Cert.php' );
//include_once( PWD_LOGICA . '/RelationUserCert.php' );

/**
 * Función que sera la encargada de saber si la sessión ya tiene asiganos los 
 * valores del usuario y si aun existe en la base de datos.
 * @return true si se conecta correctamente.
 */
function is_logged_in() {
    /**
     * Checks session is user logged in or not
     */
    if (isset($_SESSION['user']) && unserialize($_SESSION['user'])->getId() !== 0) {//tengo el usuario
        if (valid_login(unserialize($_SESSION['user']))) {//el usuario es valido
            /**
             * Checks if users is owner of the certificate
             */
            if (isset($_SESSION['cert']) && unserialize($_SESSION['cert'])->getId() !== 0) {//tengo el certificado
                if (hasValidCert() && valid_cert(unserialize($_SESSION['cert']))) {//elcertificado es valido y corresponde al usuario
                    return true;
                } else {
                    session_destroy();
                    header("Location: " . SITE_WEB . "/login/signin.php?value=3");
                    exit;
                }
            } else {
                if (hasValidCert()) {//aún no se ha elegido un certificado y este es valido?
                    $cert = new Cert();
                    $cert->setIssue($_SERVER['SSL_CLIENT_I_DN']);
                    $cert->setSerial($_SERVER['SSL_CLIENT_M_SERIAL']);
                    $cert->setIdUser(unserialize($_SESSION['user'])->getId());
                    if (valid_cert($cert)) {//correponde el certificado al usuario?
                        setting_Session(NULL, $cert);
                        return true;
                    }
                }
                session_destroy();
                header("Location: " . SITE_WEB . "/login/signin.php?value=3");
                exit;
            }
        } else {
            session_destroy();
            header("Location: " . SITE_WEB . "/login/signin.php");
            exit;
        }
    } else {
        header("Location: " . SITE_WEB . "/login/signin.php");
        exit;
    }
}

/**
 * Función que ingresa comprueba si en la session se tiene un usuario 
 * y si estos datos estan bien en la base de datos.
 * @param User $user el usuario a validar con email y password y status true.
 * @return boolean true si la validacion del usuario es correcta
 */
function valid_login($user) {
    /**
     * Cheque username and password is it match or not. If match return true 
     * else flase
     */
    $modelUser = new ModelUser();
    $userFind = $modelUser->selectByEmailPasswordActivate($user);
    if (isset($userFind) && $userFind->getId() != 0) {
        return true;
    } else {
        return false;
    }
}

/**
 * Función que dado el usuario con el username (email) agregara a la session los
 * valores necesarios.
 * @param User $user el usuario con el email a buscar
 * @param Cert $cert el certificado del usuario con el id del usuario, issue y 
 * el serial a buscar
 * @return boolea true si se hace correctamente.
 */
function setting_Session($user, $cert) {
    if (isset($user) && $user != NULL) {
        $modelUser = new ModelUser();
        $userSession = $modelUser->selectByEmail($user);
        $_SESSION['user'] = serialize($userSession);
    }
    if (isset($cert) && $cert != NULL) {
        $modelCert = new ModelCert();
        $certSession = $modelCert->selectBySerialIssueIdUser($cert);
        $_SESSION['cert'] = serialize($certSession);
    }

    return true;
}

/**
 * Válida el certificado, que se encuentra en $_SERVER, corresponda a el usuario
 * en el sistema.
 * @deprecated es una relación 1 - N
 * @param User $user el usuario con id
 * @param Cert $cert el certificado del usuario con el issue y el serial 
 * @return boolean true si el certificado seleccionado corresponde al usuario.
 */
function valid_cert_user($user, $cert) {
    $modelCert = new ModelCert();
    $certResult = $modelCert->selectBySerialIssue($cert);

    if (isset($user) && $user->getId() != 0 && isset($certResult) && $certResult->getId() != 0) {
        $relationUserCert = new RelationUserCert();
        $relationUserCert->setIdUser($user->getId());
        $relationUserCert->setIdCert($certResult->getId());

        $modelRelationCert = new ModelRelationUserCert();
        $relationUserCertResult = $modelRelationCert->selectById($relationUserCert);

        if (isset($relationUserCertResult) && $relationUserCertResult->getIdUser() != 0
                && $relationUserCertResult->getIdCert() != 0) {
            return true;
        }
    }

    //aun no selecciona un certificado
    return false;
}

/**
 * Válida el certificado, que se encuentra en $_SERVER, corresponda a el usuario
 * en el sistema.
 * @param Cert $cert el certificado del usuario con el issue y el serial 
 * @return boolean true si el certificado seleccionado corresponde al usuario.
 */
function valid_cert($cert) {
    $modelCert = new ModelCert();
    $certResult = $modelCert->selectBySerialIssueIdUser($cert);

    if (isset($certResult) && $certResult->getId() != 0) {
        return true;
    }
    return false;
}

/**
 * Determines if the browser provided a valid SSL client certificate
 *
 * @return boolean True if the client cert is there and is valid
 * http://cweiske.de/tagebuch/ssl-client-certificates.htm
 */
function hasValidCert() {
    if (!isset($_SERVER['SSL_CLIENT_M_SERIAL'])
            || !isset($_SERVER['SSL_CLIENT_V_END'])
            || !isset($_SERVER['SSL_CLIENT_VERIFY'])
            || $_SERVER['SSL_CLIENT_VERIFY'] !== 'SUCCESS'
            || !isset($_SERVER['SSL_CLIENT_I_DN'])
    ) {
        return false;
    }

    if ($_SERVER['SSL_CLIENT_V_REMAIN'] <= 0) {
        return false;
    }

    return true;
}

?>
