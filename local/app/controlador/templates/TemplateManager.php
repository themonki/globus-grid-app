<?php
/**
 * Creación y uso de plantillas o templates en PHP
 * @author Maikel
 * @link http://www.cristalab.com/tutoriales/creacion-y-uso-de-plantillas-o-templates-en-php-c132l/
 */
require_once( $_SERVER['DOCUMENT_ROOT'] . '/app/controlador/config.php' );
/**
 * Clase que permite manejar las plantillas y asignarle los valores que se 
 * .
 */
class TemplateManager {

    private $templates_path = PWD_TEMPLEATE;
    private $templates_extension = '.tpl';
    private $tpl_file;
    private $vars;
    private $template_file;
    private $mihtml;
    private $fd;

    /**
     * Constructor por defecto.
     */
    function __construct() {
        
    }
    /**
     * Función que indica la plantilla a seleccionar.
     * @param string $template_file
     */
    function plantilla($template_file) {
        $this->tpl_file = $this->templates_path ."/". $template_file . $this->templates_extension;
    }
    /**
     * Asigna un array de variables que reemplazan a las demás.
     * @param array $vars
     */
    function asigna_variables($vars) {
        $this->vars = (empty($this->vars)) ? $vars : $this->vars . $vars;
    }
    /**
     * Método encargado de devolver el contenido a mostrarse.
     * @return String con la plantilla a mostrar.
     */
    function muestra() {
        if (!($this->fd = @fopen($this->tpl_file, 'r'))) {
            sostenedor_error('Error al abrir la plantilla ' . $this->tpl_file);
        } else {
            $this->template_file = fread($this->fd, filesize($this->tpl_file));
            fclose($this->fd);
            $this->mihtml = $this->template_file;
            $this->mihtml = str_replace("'", "\'", $this->mihtml);
            $this->mihtml = preg_replace('#\{([a-z0-9\-_]*?)\}#is', "' . $\\1 . '", $this->mihtml); //reemplaza los {variable} por $variable
            reset($this->vars);
            while (list($key, $val) = each($this->vars)) {
                $$key = $val;
            }
            eval("\$this->mihtml = '$this->mihtml';");
            reset($this->vars);
            while (list($key, $val) = each($this->vars)) {
                unset($$key);
            }
            $this->mihtml = str_replace("\'", "'", $this->mihtml);
            return $this->mihtml;
        }
    }
}
/**
 * Función para imprimir paginas de error.
 * @param String $error el mensaje de error.
 * @return String con el contenido a mostrar.
 */
function sostenedor_error($error) {
        $miplantilla = new TemplateManager();
        $miplantilla->plantilla("error");
        $miplantilla->asigna_variables(array(
            'ERROR' => $error)
        );
        return $miplantilla->muestra();
    }

?>
