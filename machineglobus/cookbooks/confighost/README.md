Edgar Andrés Moncada

 Estas recetas permiten crear una infraestructura usando maquinas de ubuntu o de
 redhat en el que se envia automaticamente la configuracion de las ips que 
 pueden ser asignadas de manera dinamica. 
 
 Es necesario iniciar los esclavos y luego  iniciar el master.
 
 Es necesario conocer el ip de la maquina donde se corren las recetas, además
 del usuario y la contraseña, o por lo menos del servidor donde se guardará
 temporalmente las ips asignadas de las maquinas. Ver el archivo de Vagrantfile.
 
 Es necesario configurar adecuadamente los atributos que se encuentran en 
 cookbooks/confighost/attributes/default.rb
 
 Actualización:
==============
 
 Se empleara el uso de las carpetas compartidas para transferir los archivos 
 necesarios, por lo que ya no sería necesario conocer los datos de la maquina, 
 pero se deja la opción si en algún momento se requiera adicionar.
 
 Para ello es necesario indicar en el Vagrantfile una variable global:
 USE_SHARE_FOLDER = true
 Y enviar una variable use_share_folder => USE_SHARE_FOLDER a cada node-
 
 El path de la carpeta por defecto que crea vagrant se puede encontrar en:
 cookbooks/confighost/attributes/share-folder.rb
