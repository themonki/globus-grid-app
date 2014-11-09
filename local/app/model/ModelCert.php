<?php

require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_FACHADA . '/Fachada.php' );
include_once( PWD_LOGICA . '/Cert.php' );

/**
 * Clase encargada de consultar, insertar y actualizar la tabla crt_cert de la 
 * base de datos.
 *
 * @author Edgar Moncada
 */
class ModelCert {

    /**
     * @var Fachada 
     */
    private $fachada;

    /**
     * Nombre de la tabla.
     * @var string.
     */
    private $tablename = "crt_cert";
    private $col1 = "crt_id";
    private $col2 = "usr_id";
    private $col3 = "crt_serial";
    private $col4 = "crt_issue";
    private $col5 = "crt_keypass";
    private $col6 = "crt_keypath";
    private $col7 = "crt_certpath";
    private $col8 = "crt_proxypath";

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->fachada = new Fachada();
    }

    /**
     * Método para instertar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function insert($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . "DEFAULT" . ", "
                . "" . $obj->getIdUser() . ", "
                . "'" . $obj->getSerial() . "', "
                . "'" . $obj->getIssue() . "', "
                . "'" . $obj->getKeyPass() . "', "
                . "'" . $obj->getKeyPath() . "', "
                . "'" . $obj->getCertPath() . "', "
                . "'" . $obj->getProxyPath() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para instertar en la tabla crt_cert con el id dado.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return Cert el objeto que corresponde con la consulta.
     */
    function insertId($obj) {
        $sql = "INSERT INTO " . $this->tablename . " "
                . "VALUES ("
                . "" . $obj->getId() . ", "
                . "" . $obj->getIdUser() . ", "
                . "'" . $obj->getSerial() . "', "
                . "'" . $obj->getIssue() . "', "
                . "'" . $obj->getKeyPass() . "', "
                . "'" . $obj->getKeyPath() . "', "
                . "'" . $obj->getCertPath() . "', "
                . "'" . $obj->getProxyPath() . "'"
                . ");";
        $result = $this->fachada->db_insert_pg($sql);
        return $result;
    }

    /**
     * Método para actualizar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return int el numero de filas afectadas o -1 si no se realiza 
     * correctamente.
     */
    function updateById($obj) {
        $sql = "UPDATE " . $this->tablename . " SET "
                . $this->col2 . " = " . $obj->getIdUser() . ", "
                . $this->col3 . " = '" . $obj->getSerial() . "', "
                . $this->col4 . " = '" . $obj->getIssue() . "', "
                . $this->col5 . " = '" . $obj->getKeyPass() . "', "
                . $this->col6 . " = '" . $obj->getKeyPath() . "', "
                . $this->col7 . " = '" . $obj->getCertPath() . "', "
                . $this->col8 . " = '" . $obj->getProxyPath() . "' "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_update_pg($sql);
        return $result;
    }

    /**
     * Método para borrar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
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
     * @return \Cert con el id
     */
    function selectNextId() {
        $sql = "SELECT nextval(('crt_cert_crt_id_seq'::text)::regclass);";

        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[0]);
        }
        return $objTmp;
    }

    /**
     * Método para consultar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return Cert el objeto que corresponde con la consulta.
     */
    function selectById($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . ", "
                . $this->col7 . ", "
                . $this->col8 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col1 . " = " . $obj->getId() . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setSerial($row[$this->col3]);
            $objTmp->setIssue($row[$this->col4]);
            $objTmp->setKeyPass($row[$this->col5]);
            $objTmp->setKeyPath($row[$this->col6]);
            $objTmp->setCertPath($row[$this->col7]);
            $objTmp->setProxyPath($row[$this->col8]);
            break;
        }
        return $objTmp;
    }

    /**
     * Método para consultar todos los registros en la tabla crt_cert.
     * @return array con los objetos Cert correspondientes.
     */
    function select() {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . ", "
                . $this->col7 . ", "
                . $this->col8 . " "
                . "FROM " . $this->tablename . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Cert();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setSerial($row[$this->col3]);
            $objTmp->setIssue($row[$this->col4]);
            $objTmp->setKeyPass($row[$this->col5]);
            $objTmp->setKeyPath($row[$this->col6]);
            $objTmp->setCertPath($row[$this->col7]);
            $objTmp->setProxyPath($row[$this->col8]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

    /**
     * Método para consultar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return Cert el objeto que corresponde con la consulta.
     */
    function selectBySerialIssue($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . ", "
                . $this->col7 . ", "
                . $this->col8 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col3 . " = '" . $obj->getSerial() . "' AND "
                . "" . $this->col4 . " = '" . $obj->getIssue() . "'"
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setSerial($row[$this->col3]);
            $objTmp->setIssue($row[$this->col4]);
            $objTmp->setKeyPass($row[$this->col5]);
            $objTmp->setKeyPath($row[$this->col6]);
            $objTmp->setCertPath($row[$this->col7]);
            $objTmp->setProxyPath($row[$this->col8]);
            break;
        }
        return $objTmp;
    }

    /**
     * Método para consultar los registros en la tabla crt_cert que correspondan
     * con el usr_id.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return array con los objetos Cert correspondientes.
     */
    function selectByIdUser($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . ", "
                . $this->col7 . ", "
                . $this->col8 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdUser() . ""
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objArray = array();

        while ($row = pg_fetch_array($result)) {
            $objTmp = new Cert();
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setSerial($row[$this->col3]);
            $objTmp->setIssue($row[$this->col4]);
            $objTmp->setKeyPass($row[$this->col5]);
            $objTmp->setKeyPath($row[$this->col6]);
            $objTmp->setCertPath($row[$this->col7]);
            $objTmp->setProxyPath($row[$this->col8]);
            $objArray[] = $objTmp;
        }
        return $objArray;
    }

    /**
     * Método para consultar en la tabla crt_cert.
     * @param Cert $obj de la logica con los datos encapsulados.
     * @return Cert el objeto que corresponde con la consulta.
     */
    function selectBySerialIssueIdUser($obj) {
        $sql = "SELECT "
                . $this->col1 . ", "
                . $this->col2 . ", "
                . $this->col3 . ", "
                . $this->col4 . ", "
                . $this->col5 . ", "
                . $this->col6 . ", "
                . $this->col7 . ", "
                . $this->col8 . " "
                . "FROM " . $this->tablename . " "
                . "WHERE " . $this->col2 . " = " . $obj->getIdUser() . " AND "
                . "" . $this->col3 . " = '" . $obj->getSerial() . "' AND "
                . "" . $this->col4 . " = '" . $obj->getIssue() . "'"
                . ";";
        $result = $this->fachada->db_query_select_pg($sql);
        $objTmp = new Cert();
        while ($row = pg_fetch_array($result)) {
            $objTmp->setId($row[$this->col1]);
            $objTmp->setIdUser($row[$this->col2]);
            $objTmp->setSerial($row[$this->col3]);
            $objTmp->setIssue($row[$this->col4]);
            $objTmp->setKeyPass($row[$this->col5]);
            $objTmp->setKeyPath($row[$this->col6]);
            $objTmp->setCertPath($row[$this->col7]);
            $objTmp->setProxyPath($row[$this->col8]);
            break;
        }
        return $objTmp;
    }

}

?>
