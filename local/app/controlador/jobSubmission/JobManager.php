<?php

/**
 * Clase encargada del manejo de los job manager que llamara a los scripts que 
 * permiten acceder a los comandos de globus.
 *
 * @author Edgar Moncada
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_LOGICA . '/Job.php' );
include_once( PWD_LOGICA . '/User.php' );
set_include_path(get_include_path() . PATH_SEPARATOR . PWD_PHPSECLIB);
include_once('Net/SSH2.php');
define('NET_SSH2_LOGGING', NET_SSH2_LOG_COMPLEX);

class JobManager {

    /**
     *
     * El nombre del archivo que cargara las variables de entorno con los parametros 
     * adecuados. Tipo string.
     */
    private $file_script_env = "/inicializar-variables.sh";

    /**
     *
     * El nombre del archivo que se encarga de enviar los jobs. Tipo string.
     */
    private $file_script_send_job = "/send-job.sh";

    /**
     *
     * El nombre del archivo que se encarga de cancelar los jobs. Tipo string.
     */
    private $file_script_cancel_job = "/cancel-job.sh";

    /**
     *
     * El nombre del archivo que se encarga de consultar el estado de los jobs. Tipo string.
     */
    private $file_script_status_job = "/status-job.sh";

    /**
     *
     * El nombre del archivo que se encarga de revisar los jobs (RSL). Tipo string.
     */
    private $file_script_parse_job = "/parse-job.sh";

    /**
     *
     * El nombre de usuario dentro del servidor. Tipo string.
     */
    private $user_system;

    /**
     *
     * El pass de la llave encriptada, en este caso igual al nombre de usuaro. 
     * Tipo string.
     */
    private $pass_key_cert;

    /**
     *
     * El nombre del host a donde se conecta por medio de PHPSECLIB.
     */
    private $hostConnect = "mg";

    /**
     *
     * La conexión establecida en el servidor para el usuario.
     */
    private $sshConection = NULL;

    /**
     *
     * El script que cargara las variables de entorno con los parametros 
     * adecuados. Tipo string.
     */
    private $script_env;

    /**
     *
     * El script que se encarga de enviar los jobs. Tipo string.
     */
    private $script_send_job;

    /**
     *
     * El script que se encarga de cancelar los jobs. Tipo string.
     */
    private $script_cancel_job;

    /**
     *
     * El script que se encarga de consultar el estado de los jobs. Tipo string.
     */
    private $script_status_job;

    /**
     *
     * El script que se encarga de revisar los jobs (RSL). Tipo string.
     */
    private $script_parse_job;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $cert = unserialize($_SESSION['cert']);
        $user = unserialize($_SESSION['user']);
        $this->pass_key_cert = $cert->getKeyPass();
        $this->user_system = $user->getUserSystem();
        $this->script_env = 'source ' . PWD_BASH_SCRIPTS . $this->file_script_env . ' ' .
                '-k ' . $cert->getKeyPath() . ' -o ' . $cert->getProxyPath() . '. -c ' . $cert->getCertPath() . '';
        $this->script_send_job = PWD_BASH_SCRIPTS . $this->file_script_send_job . ' -p ' . $this->pass_key_cert . ' ';
        $this->script_cancel_job = PWD_BASH_SCRIPTS . $this->file_script_cancel_job . ' -p ' . $this->pass_key_cert . ' ';
        $this->script_status_job = PWD_BASH_SCRIPTS . $this->file_script_status_job . ' -p ' . $this->pass_key_cert . ' ';
        $this->script_parse_job = PWD_BASH_SCRIPTS . $this->file_script_parse_job . ' -p ' . $this->pass_key_cert . ' ';
    }

    private function conection_phpseclib() {
        $this->sshConection = new Net_SSH2($this->hostConnect);
        if (!$this->sshConection->login($this->pass_key_cert, $this->user_system)) {
            $this->sshConection = NULL;
            exit('Login Failed');
        }
    }

    private function disconection_phpseclib() {
        if (!is_null($this->sshConection)) {
            $this->sshConection->disconnect();
        }
    }

    function exe_send_job($rsl_file, $jobmanager = NULL) {
        $comand = $this->script_env;
        $comand .= ';';
        $comand .= $this->script_send_job . '-f ' . $rsl_file;
        if (!is_null($jobmanager)) {
            $comand .= ' -j ' . $jobmanager;
        }
        $this->conection_phpseclib();
        $output = $this->sshConection->exec($comand);
        $this->disconection_phpseclib();
        return $output;
    }

    function exe_status_job($string_contact) {
        $comand = $this->script_env;
        $comand .= ';';
        $comand .= $this->script_status_job . '-s ' . $string_contact;
        $this->conection_phpseclib();
        $output = $this->sshConection->exec($comand);
        $this->disconection_phpseclib();
        return $output;
    }

    function exe_cancel_job($string_contact) {
        $comand = $this->script_env;
        $comand .= ';';
        $comand .= $this->script_cancel_job . '-s ' . $string_contact;
        $this->conection_phpseclib();
        $output = $this->sshConection->exec($comand);
        $this->disconection_phpseclib();
        return $output;
    }

    function exe_parse_job($rsl_file, $jobmanager = NULL) {
        $comand = $this->script_env;
        $comand .= ';';
        $comand .= $this->script_parse_job . '-f ' . $rsl_file;
        if (!is_null($jobmanager)) {
            $comand .= ' -j ' . $jobmanager;
        }
        $this->conection_phpseclib();
        $output = $this->sshConection->exec($comand);
        $this->disconection_phpseclib();
        return $output;
    }

}

?>
