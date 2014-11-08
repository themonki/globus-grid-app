<?php

/**
 * Clase que representa la tabla crt_cert y que contendrá los datos encapsulados
 *
 * @author Edgar Moncada
 */
class Cert {

    /**
     * El id del certificado. Tipo integer.
     */
    private $id;
    /**
     * El id del usuario. Tipo integer.
     */
    private $idUser;

    /**
     * El serial del certificado. Tipo string.
     */
    private $serial;

    /**
     * El issue del certificado. Tipo string.
     */
    private $issue;
    
    /**
     * El keyPass del certificado. Tipo varchar.
     */
    private $keyPass;

    /**
     * El keyPath del certificado. Tipo varchar.
     */
    private $keyPath;

    /**
     * El certPath del certificado. Tipo string.
     */
    private $certPath;

    /**
     * El proxyPath del certificado. Tipo string.
     */
    private $proxyPath;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->id = 0;
        $this->serial = '';
        $this->issue = '';
        $this->keyPass = '';
        $this->keyPath = '';
        $this->certPath = '';
        $this->proxyPath = '';
    }

    /**
     * Retorna el valor del atributo id
     * @return integer
     */
    function getId() {
        return $this->id;
    }

    /**
     * Asigna un valor al atributo id
     * @param integer $value
     */
    function setId($value) {
        $this->id = $value;
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

    /**
     * Retorna el valor del atributo serial
     * @return varchar
     */
    function getSerial() {
        return $this->serial;
    }

    /**
     * Asigna un valor al atributo serial
     * @param varchar $value
     */
    function setSerial($value) {
        $this->serial = $value;
    }

    /**
     * Retorna el valor del atributo issue
     * @return varchar
     */
    function getIssue() {
        return $this->issue;
    }

    /**
     * Asigna un valor al atributo issue
     * @param varchar $value
     */
    function setIssue($value) {
        $this->issue = $value;
    }
    
    /**
     * Retorna el valor del atributo keyPass
     * @return varchar
     */
    function getKeyPass() {
        return $this->keyPass;
    }

    /**
     * Asigna un valor al atributo keyPass
     * @param varchar $value
     */
    function setKeyPass($value) {
        $this->keyPass = $value;
    }

    /**
     * Retorna el valor del atributo keyPath
     * @return varchar
     */
    function getKeyPath() {
        return $this->keyPath;
    }

    /**
     * Asigna un valor al atributo keyPath
     * @param varchar $value
     */
    function setKeyPath($value) {
        $this->keyPath = $value;
    }

    /**
     * Retorna el valor del atributo certPath
     * @return varchar
     */
    function getCertPath() {
        return $this->certPath;
    }

    /**
     * Asigna un valor al atributo certPath
     * @param varchar $value
     */
    function setCertPath($value) {
        $this->certPath = $value;
    }

    /**
     * Retorna el valor del atributo proxyPath
     * @return varchar
     */
    function getProxyPath() {
        return $this->proxyPath;
    }

    /**
     * Asigna un valor al atributo proxyPath
     * @param varchar $value
     */
    function setProxyPath($value) {
        $this->proxyPath = $value;
    }

}

?>
