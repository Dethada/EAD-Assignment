/*
Validates change password form
*/
$('#changepw').submit(function(ev) {
    ev.preventDefault(); // to stop the form from submitting
    if ($('#pw1').val() !== $('#pw2').val()) {
        $('#pw2').addClass("is-invalid");
    } else {
        this.submit(); // If all the validations succeeded
    }
});