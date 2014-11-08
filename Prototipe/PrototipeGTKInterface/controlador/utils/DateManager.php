<?php

/**
 * Clase encargada de el formato de las fechas.
 * http://www.php.net/manual/es/function.strftime.php
 * @author Edgar Moncada
 */
class DateManager {
    /**
     * Fecha y hora con formato simple y-m-d h:m:s
     * @var type string
     */

    const format_date_time_simple = "%Y-%m-%d %H:%M:%S";
//    const format_date_time_simple = "y-m-d g:i:s a";

    /**
     * Fecha con formato simple y-m-d
     * @var type string
     */
    const format_date_simple = "%Y-%m-%d";
//    const format_date_simple = "y-m-d";

    /**
     * Fecha con formato avanzado d de Mes de Y
     * @var type string
     */
    const format_date_advance = '%d de %B de %Y';

//    const format_date_advance = 'd \d\e F \d\e Y';
    /**
     * Fecha y hora con formato avanzado d de Mes de Y h:m:s AM/PM
     * @var type string
     */
    const format_date_time_advance = '%d de %B de %Y a las %l:%M:%S %p';

//    const format_date_time_advance = 'd \d\e F \d\e Y \a \l\a\s g:i:s a';

    /**
     * Metodo encargado de formatear una fecha
     * 
     * @param type $value el valor a formatear
     * @param type $format [optional] string con el formato a devolver por 
     * defecto la constante format_date_time_simple
     * @return type string Date formateado
     */
    public static function format_Date($value, $format = DateManager::format_date_time_simple) {
         $dateTime = '';
        if (strpos($format, '%p') !== false) {// si no soporta AM PM el servidor
            $time = strtotime($value);
            $dateTime = strftime($format, $time);
            if (!(strpos($dateTime, 'AM') !== false) || !(strpos($dateTime, 'PM') !== false)) {//sino contiene AM o PM
                $dateTime .= (($time % 86400) < 43200 ? 'AM' : 'PM');
            }
        } else {
            $dateTime = strftime($format, strtotime($value));
        }
        return $dateTime;
    }

    /**
     * Método encargado de devolver la fecha actual en el formato indicado
     * 
     * @param type $format [optional] string con el formato a devolver por 
     * defecto la constante format_date_time_simple
     * @return type string Date del servidor formateado
     */
    public static function get_Date($format = DateManager::format_date_time_simple) {
         $dateTime = '';
        if (strpos($format, '%p') !== false) {// si no soporta AM PM el servidor
            $dateTime = strftime($format);
            $time = strtotime($dateTime);
            if (!(strpos($dateTime, 'AM') !== false) || !(strpos($dateTime, 'PM') !== false)) {//sino contiene AM o PM
                $dateTime .= (($time % 86400) < 43200 ? 'AM' : 'PM');
            }
        } else {
            $dateTime = strftime($format);
        }
        return $dateTime;
    }

}

?>
