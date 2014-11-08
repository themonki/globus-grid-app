<?php

/**
 * Clase que representa la tabla usr_user y que contendrá los datos encapsulados
 *
 * @author Edgar Moncada
 */
class User {

    /**
     * El id del usuario. Tipo integer.
     */
    private $id;

    /**
     * El email del usuario. Tipo string.
     */
    private $email;

    /**
     * El password del usuario. Tipo string.
     */
    private $password;

    /**
     * El status del usuario. Tipo bool.
     */
    private $status;

    /**
     * El name del usuario. Tipo string.
     */
    private $name;

    /**
     * El userSystem del usuario. Tipo string.
     */
    private $userSystem;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        $this->id = 0;
        $this->email = '';
        $this->password = '';
        $this->status = false;
        $this->name = '';
        $this->userSystem = '';
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
     * Retorna el valor del atributo email
     * @return varchar
     */
    function getEmail() {
        return $this->email;
    }

    /**
     * Asigna un valor al atributo email
     * @param varchar $value
     */
    function setEmail($value) {
        $this->email = $value;
    }

    /**
     * Retorna el valor del atributo password
     * @return varchar
     */
    function getPassword() {
        return $this->password;
    }

    /**
     * Asigna un valor al atributo password
     * @param varchar $value
     */
    function setPassword($value) {
        $this->password = $value;
    }

    /**
     * Retorna el valor del atributo status
     * @return bool
     */
    function getStatus() {
        return $this->status;
    }

    /**
     * Asigna un valor al atributo status
     * @param bool $value
     */
    function setStatus($value) {
        $this->status = $value;
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
     * Retorna el valor del atributo userSystem
     * @return varchar
     */
    function getUserSystem() {
        return $this->userSystem;
    }

    /**
     * Asigna un valor al atributo userSystem
     * @param varchar $value
     */
    function setUserSystem($value) {
        $this->userSystem = $value;
    }

}

?>
