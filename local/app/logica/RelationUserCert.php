<?php

/**
 * Clase que representa la tabla ruc_relationusercert y que contendrá los datos 
 * encapsulados
 *
 * @author Edgar Moncada
 * @deprecated Es una relacion de 1 - N.
 */
class RelationUserCert {

    /**
     * El id del certificado. Tipo integer.
     */
    private $idCert;

    /**
     * El id del usuario. Tipo integer.
     */
    private $idUser;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->idCert = 0;
        $this->idUser = 0;
    }

    /**
     * Retorna el valor del atributo idCert
     * @return integer
     */
    function getIdCert() {
        return $this->idCert;
    }

    /**
     * Asigna un valor al atributo idCert
     * @param integer $value
     */
    function setIdCert($value) {
        $this->idCert = $value;
    }

    /**
     * Retorna el valor del atributo idUser
     * @return integer
     */
    function getIdUser() {
        return $this->idUser;
    }

    /**
     * Asigna un valor al atributo idUser
     * @param integer $value
     */
    function setIdUser($value) {
        $this->idUser = $value;
    }

}

?>
