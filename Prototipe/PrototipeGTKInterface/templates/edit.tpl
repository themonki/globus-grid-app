<div class="forms" >
    <h1>Editar datos básicos</h1>
    <form class="formBorder" id="formEdit" name="formEdit" action ="" method="POST">
        <div class="field">
            <div class="{MESSAGE_CLASS}">
                {MESSAGE}
            </div>
        </div>
        <div class="field"> 
            <label class="label" for="email">
                Correo Electrónico:
            </label>
            <input class="text-field" name="email" id="email" value="{EMAIL}" required disabled
                   type="email" maxlength="200"
                   title="Confirme su contraseña debe ser igual a la anterior."
                   alt="Confirme su contraseña debe ser igual a la anterior."
                   />
        </div>
        <div class="field"> 
            <label class="label" for="name">
                Nombre: 
            </label>
            <input class="text-field" name="name" id="name" value="{NAME}" required 
                   maxlength="200" pattern="([0-9A-Za-záÁéÉíÍóÓúÚñÑÇç]+\\s*)+[ ]*"
                   title="Indique su nombre. Solo puede contener caracteres alfanuméricos y espacios." 
                   alt="Indique su nombre. Solo puede contener caracteres alfanuméricos y espacios."
                   placeholder="Indique su nombre."
                   />
        </div>
        <span class="noField" >
            <label class="label" >
                Si no desea editar su contraseña deje en blanco:
            </label>
        </span>
        <div class="field" for="passwordNew">
            <label class="label">
                Contraseña Nueva: 
            </label> 
            <input class="text-field" type="password" name="passwordNew" id="passwordNew" onkeyup="validatePattern(form, this);"
                   maxlength="15" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])\w{6,}"
                   title="Indique su contraseña. Esta debe ser de minimo 6 y máximo 15 caracteres. Debe incluir minúsculas, mayúsculas y números." 
                   alt="Indique su contraseña. Esta debe ser de minimo 6 y máximo 15 caracteres. Debe incluir minúsculas, mayúsculas y números."
                   placeholder="Contraseña."
                   />
        </div>
        <div class="field" for="passwordConfirmation"> 
            <label class="label">
                Confirmar Contraseña Nueva:
            </label>
            <input class="text-field" type="password" name="passwordConfirmation" id="passwordConfirmation" onkeyup="validatePattern(form, this);"
                   maxlength="15" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])\w{6,}"
                   title="Confirme su contraseña debe ser igual a la anterior."
                   alt="Confirme su contraseña debe ser igual a la anterior."
                   placeholder="Confirme la contraseña."
                   />
        </div>
        <input class="button" type="submit" value="Actualizar"/>
    </form>
</div>
