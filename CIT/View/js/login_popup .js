function alterainput() {
    document.getElementById("user").value="";
    document.getElementById("user").style.color='#333333';

    alert('pass');
    document.getElementById("pass").style.type="password";
    document.getElementById("pass").style.color='#333333';
    document.getElementById("pass").InnerHTML='block';
}

function valida_login() {
    if(true) {
        document.getElementById("login_popup_content2").style.display="block";
        document.getElementById("error_msg").style.display="none";
    } else {
        document.getElementById("login_popup_content2").style.display="none";
        document.getElementById("error_msg").style.display="block";
   }   
}