<?php

require_once( $_SERVER['DOCUMENT_ROOT'] . '/PrototipeGTKInterface/controlador/config.php' );
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/Job.php' );

/**
 * Clase encargada de consultar, insertar y actualizar la tabla job_job de la 
 * base de datos.
 *
 * @author Edgar Moncada
 */
class ModelJob {

    /**
     * @var Fachada 
     */
    private $fachada;

    /**
     * Nombre de la tabla.
     * @var string.
     */
    private $tablename = "job_job";
    private $col1 = "job_id";
    private $col2 = "usr_id";
    private $col3 = "job_name";
    private $col4 = "job_date";
    private $col5 = "job_path";
    private $col6 = "job_contact";

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->fachada = new Fachada();
    }

    /**
     * Método para instertar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insert($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . "DEFAULT" . ", "
                . "" . $obj->getIdUser() . ", "
                . "'" . $obj->getName() . "', "
                . "'" . $obj->getDate() . "', "
                . "'" . $obj->getPath() . "', "
                . "'" . $obj->getContact() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla job_job con el id dado.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return Job el objeto que corresponde con la consulta.
     */
    function insertId($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getId() . ", "
                . "" . $obj->getIdUser() . ", "
                . "'" . $obj->getName() . "', "
                . "'" . $obj->getDate() . "', "
                . "'" . $obj->getPath() . "', "
                . "'" . $obj->getContact() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para actualizar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function updateById($obj) {
        $sql = "UPDATE " . $this->tablename . " SET "
                . $this->col2 . " = " . $obj->getIdUser() . ", "
                . $this->col3 . " = '" . $obj->getName() . "', "
                . $this->col4 . " = '" . $obj->getDate() . "', "
                . $this->col5 . " = '" . $obj->getDate() . "', "
                . $this->col4 . " = '" . $obj->getContact() . "' "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_update_pg($sql);
        return $result;
    }

    /**
     * Método para borrar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function deleteById($obj) {
        $sql = "DELETE FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_delete_pg($sql);
        return $result;
    }

    /**
     * Método que devuelve el siguiente id de la secuencia.
     * 
     * @return \Job con el id
     */
    function selectNextId() {
        $sql = "SELECT nextval(('job_job_job_id_seq'::text)::regclass);";

        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Job();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[0]);
        }
        return $objTmp;
    }

    /**
     * Método para consultar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return Job el objeto que corresponde con la consulta.
     */
    function selectById($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Job();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            break;
        }
        return $objTmp;
    }

    /**
     * Método para consultar todos los registros en la tabla job_job.
     * @return array con los objetos Job correspondientes.
     */
    function select() {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Job();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

    /**
     * Método para consultar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return Job el objeto que corresponde con la consulta.
     */
    function selectByName($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col3 . " = '" . $obj->getName() . "'"
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Job();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

    /**
     * Método para consultar los registros en la tabla job_job que correspondan
     * con el usr_id.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return array con los objetos Job correspondientes.
     */
    function selectByIdUser($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdUser() . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Job();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

    /**
     * Método para consultar en la tabla job_job.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return Job el objeto que corresponde con la consulta.
     */
    function selectByNameIdUser($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdUser() . " AND "
                . "" . $this->col3 . " = '" . $obj->getName() . "'"
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Job();
        while ($row = pg_fetch_array($result)) {
             $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            break;
        }
        return $objTmp;
    }
    
    /**
     * Método para consultar los registros en la tabla job_job que correspondan
     * con el usr_id.
     * @param Job $obj de la logica con los datos encapsulados.
     * @return array con los objetos Job correspondientes.
     */
    function selectByIdUserOrderByDate($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdUser() . " "
                . "ORDER BY " .$this->col4 . " DESC"
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Job();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setName($row[$this->col3]);
            $objTmp->setDate($row[$this->col4]);
            $objTmp->setPath($row[$this->col5]);
            $objTmp->setContact($row[$this->col6]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

}

?>
