function alterainputuser() {
    document.getElementById("error_msg").style.display = "none";
    document.getElementById("user").style.color = "#333333";
    if(document.getElementById("user").value == "UTILIZADOR") {
        document.getElementById("user").value = "";    
    }
}

function verificartextouser() {
    if(document.getElementById("user").value == "") {
        document.getElementById("user").value = "UTILIZADOR";
        document.getElementById("user").style.color = "#cccccc";
    }
}

function alterainputpass() {
    //document.getElementById("pass").style.border = "1px solid #ffffff";
    var pass = document.getElementById("pass");
    var error_msg = document.getElementById("error_msg");
    pass.style.color = "#333333";
    error_msg.style.display = "none";
    if( pass.value == "SENHA" ) {
        pass.value = "";
        pass.type = "password";
    }
}

function verificartextopass() {
    if(document.getElementById("pass").value == "") {
        document.getElementById("pass").type = "text";
        document.getElementById("pass").value = "SENHA";
        document.getElementById("pass").style.color = "#cccccc";
    }
}

function valida_login() {

    var avancarbutton = document.getElementById("avancarbutton");

    if ( avancarbutton !== undefined && avancarbutton !== null ) {
        avancarbutton.style.backgroundColor = "#cccccc";
        avancarbutton.disabled = true;
        $("#login_popup_content2").slideDown("slow");
        $("#login_popup_content3").slideDown("slow"); 
    }

}

function inic_login() {
/*
    document.getElementById("avancarbutton").style.backgroundColor = "#438DBC";
    document.getElementById("avancarbutton").disabled = false;
    $("#login_popup_content2").slideUp("slow");
    $("#login_popup_content3").slideUp("slow"); 
    */
}