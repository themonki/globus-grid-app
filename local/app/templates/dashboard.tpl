<div class="forms" >
    <h1>Enviar Job</h1>
    <p>Para enviar jobs seleccione un archivo con formato RSL y luego elija un 
        nombre para identificar el job y opcionalmente elija el servicio 
        jobmanager disponibles en el servidor.
    </p>
    <form class="formBorder {FILE_CLASS}" id="formUploadFile" name="formUploadFile" action ="" method="POST"
          enctype="multipart/form-data">
        <div class="field"> 
            <label class="label" for="fileRSL">
                Archivo RSL:
            </label>
            <input class="text-field" type="file" name="fileRSL" id="fileRSL" required
                   title="Elija un archivo con formato RSL"
                   alt="Elija un archivo con formato RSL"
                   />

        </div>
        <input class="button" type="submit" value="Cargar"/>
    </form>
    <form class="formBorder {JOB_CLASS}" id="formSendJob" name="formSendJob" action ="" method="POST">
        <input type="hidden" required name="nameFile" id="nameFile" value="{NAME_FILE}"/>
        <div class="field"> 
            <label class="label" for="nameJob">
                Nombre del Job:
            </label>
            <input class="text-field" type="text" name="nameJob" id="nameJob" required
                   maxlength="200" placeholder="ej: job de calulo de primos"
                   title="Elija un nombre que le permita identificar el job"
                   alt="Elija un nombre que le permita identificar el job"
                   />

        </div>
        <div class="field"> 
            <label class="label" for="selectJobManager">
                Job Manager (Opcional):
            </label>
            <select class="input-select" name="selectJobManager" id="selectJobManager"
                    title="Elija un job manager de los que se encuentran habilitados"
                    alt="lija un job manager de los que se encuentran habilitados"
                    >
                <option value="">Seleccionar</option>
                <option value="jobmanager">jobmanager</option>
            </select>

        </div>
        <input  class="button" type="submit" value="Enviar Job"/>
    </form>
    <div class="field">
        <div class="{MESSAGE_CLASS}">
            {MESSAGE}
        </div>
    </div>
    <form class="formBorder" id="formJobUser" name="formJobUser" action ="" method="POST">
        <div class="jobsUser">
            <h3>Jobs</h3>
            <p>A continuación se presentan los jobs que usted ha enviado 
                ordenados por la fecha de envío descendentemente. Puede 
                cancelar la ejecución de un job si este se encuentra activo.
            </p>
            <div class="CSSTableGenerator" >
                {TABLEJOBS}
            </div>
        </div>
    </form>
</div>

<script>
    $("#main-table").oneSimpleTablePagination({rowsPerPage: 5});
</script>