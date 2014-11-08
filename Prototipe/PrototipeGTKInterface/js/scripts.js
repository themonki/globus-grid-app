/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*https://developer.mozilla.org/en-US/docs/JavaScript_crypto*/
//alert ("scripts");



function validatePattern(form, obj){
    form.passwordConfirmation.setCustomValidity("");
    if(obj.validity.patternMismatch){
        obj.setCustomValidity('La contraseña debe contener \nal menos 6 caracteres e \nincluir mayúsculas, minúsculas \ny números');
    }else {
        obj.setCustomValidity("");
    }    
    if(obj.checkValidity() && form.passwordNew == obj){
    //        form.passwordConfirmation.pattern = obj.value;
    }else if (form.passwordConfirmation == obj && form.passwordNew.value != obj.value  ){
        form.passwordConfirmation.setCustomValidity("Las Contraseñas no coinciden");
    }else{
        form.passwordConfirmation.setCustomValidity("");
    }
}