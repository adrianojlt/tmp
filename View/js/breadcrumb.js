function submenu() {    
    if(document.getElementById("submenu").style.display=="block")
        document.getElementById("submenu").style.display="none";
    else
        document.getElementById("submenu").style.display="block";  
}

function submenu1() {
    document.getElementById("submenu").style.display="none";
    document.getElementById("changepass").style.display="block";
    document.getElementById("changecontent").style.display="block";
    document.getElementById("changepassheader").style.display="block";
    document.getElementById("backgroundPopup").style.display="block";
    document.getElementById("changepassfooter").style.display="block";    
}

function closediv() {
    document.getElementById("changepass").style.display="none";
    document.getElementById("changecontent").style.display="none";
    document.getElementById("changepassheader").style.display="none";
    document.getElementById("backgroundPopup").style.display="none";
    document.getElementById("sucess").style.display="none";
}

function verificapass() {
   // if (document.getElementByName("newpass") != document.getElementByName("confnewpass")) {
    //    document.getElementByName("confnewpass").style.boder-color="#ff0000";
   // } else {
        if(true) {
        /*
            document.getElementById("actualPassword").disabled = true;
            document.getElementById("newPassword").disabled = true;
            document.getElementById("confirmPassword").disabled = true;
            document.getElementById("cancelarbutton").disabled = true;
            document.getElementById("avancarbutton").disabled = true;
            */
            
            document.getElementById("sucess").style.display="block";
            window.setTimeout("closediv()", 5000);
        } else {
            document.getElementById("error_msg").style.display="block";
        }
   // }
}


function tooltip() {
    document.getElementById("tooltipmsg").style.display = "block";  
}

function exittooltip() {
    document.getElementById("tooltipmsg").style.display = "none";  
}