<?php

/**
 * Clase fachada que será utilizada para la conexión a la base de datos 
 * postgres.
 *
 * @author Edgar Moncada
 */
session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );

class Fachada {

    private $dbcon = null;

    /**
     * Función para obtener una conexión a la base de datos postgres.
     * @return resource conexión a la base de datos postgres.
     */
    public function db_connect_pg() {

        $this->dbcon = pg_connect("host=" . DB_HOST . " user=" . DB_USER . " password=" . DB_PASSWORD . " dbname=" . DB_NAME)
                or die('ERROR AL CONECTAR A LA BASE DE DATOS ' . pg_last_error());
        return $this->dbcon;
    }

    /**
     * Función para cerrar una conexión a la base de datos.
     * @return true si cerro la base de datos.
     */
    public function db_close_pg() {
        if (isset($this->dbcon)) {
            pg_close($this->dbcon);
            $this->dbcon = null;
            return true;
        }
        return false;
    }

    /**
     * Función que realiza consultas a la base de datos.
     * @param type $query String con la consulta a realizar
     * @return type el arreglo a manejar con el resultado, -1 si falla.
     */
    public function db_query_select_pg($query) {
        $this->db_connect_pg();
        $result = pg_query($this->dbcon, $query) or -1; //or die('ERROR AL CONSULTAR DATOS: ' . pg_last_error());
        $this->db_close_pg();
        return $result;
    }

    /**
     * Función que realiza insercciones a la base de datos.
     * @param type $query String con el insert a realizar
     * @return int el número de filas que se afectaron, -1 si algo falla.
     */
    public function db_insert_pg($query) {
        $this->db_connect_pg();
        $rows = 0;
        $result = pg_query($this->dbcon, $query) or false; //or die('ERROR AL INSERTAR DATOS: ' . pg_last_error());
        if (isset($result)) {
            $rows = pg_affected_rows($result);
        } else {

            $rows = -1;
        }
        $this->db_close_pg();
        return $rows;
    }

    /**
     * Función que realiza updates a la base de datos.
     * @param type $query String con el update a realizar
     * @return int el número de filas que se afectaron, -1 si algo falla.
     */
    public function db_update_pg($query) {
        $this->db_connect_pg();
        $rows = 0;
        $result = pg_query($this->dbcon, $query) or false; //or die('ERROR AL ACTUALIZAR DATOS: ' . pg_last_error());
        if (isset($result)) {
            $rows = pg_affected_rows($result);
        } else {
            $rows = -1;
        }
        $this->db_close_pg();
        return $rows;
    }

    /**
     * Función que realiza deletes a la base de datos.
     * @param type $query String con el delete a realizar
     * @return int el número de filas que se afectaron, -1 si algo falla.
     */
    public function db_delete_pg($query) {
        $this->db_connect_pg();
        $rows = 0;
        $result = pg_query($this->dbcon, $query) or false; //or die('ERROR AL BORRAR DATOS: ' . pg_last_error());
        if (isset($result)) {
            $rows = pg_affected_rows($result);
        } else {
            $rows = -1;
        }
        $this->db_close_pg();
        return $rows;
    }

}

?>
