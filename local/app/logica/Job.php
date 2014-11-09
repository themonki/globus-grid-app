<?php

session_start();
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
include_once( PWD_CONTROLADOR . '/utils/DateManager.php' );

/**
 * Clase que representa la tabla job_job y que contendrá los datos encapsulados
 *
 * @author Edgar Moncada
 */
class Job {

    /**
     * El id del job. Tipo integer.
     */
    private $id;

    /**
     * El id del usuario. Tipo integer.
     */
    private $idUser;

    /**
     * El name del job. Tipo string.
     */
    private $name;

    /**
     * El date del job. Tipo timestamp.
     */
    private $date;

    /**
     * El path del job. Tipo string.
     */
    private $path;

    /**
     * El contact dle job. Tipo string
     */
    private $contact;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->id = 0;
        $this->name = '';
        $this->date = '';
        $this->path = '';
        $this->contact = '';
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
     * Retorna el valor del atributo name
     * @return varchar
     */
    function getName() {
        return $this->name;
    }

    /**
     * Asigna un valor al atributo name
     * @param varchar $value
     */
    function setName($value) {
        $this->name = $value;
    }

    /**
     * Retorna el valor del atributo date
     * @return varchar
     */
    function getDate() {
        return $this->date;
    }

    /**
     * Asigna un valor al atributo date
     * @param varchar $value
     */
    function setDate($value = '') {
        $this->date = ($value == '' ? DateManager::get_Date() : DateManager::format_Date($value));
    }

    /**
     * Retorna el valor del atributo path
     * @return varchar
     */
    function getPath() {
        return $this->path;
    }

    /**
     * Asigna un valor al atributo path
     * @param varchar $value
     */
    function setPath($value) {
        $this->path = $value;
    }
    
    /**
     * Retorna el valor del atributo contact
     * @return varchar
     */
    function getContact() {
        return $this->contact;
    }

    /**
     * Asigna un valor al atributo contact
     * @param varchar $value
     */
    function setContact($value) {
        $this->contact = $value;
    }

}

?>
