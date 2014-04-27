

function enterApplication(){
    if(document.escolhaPerfil.csaudeEscolhido.value.length>0){
        document.getElementById('idEvent').value = 'addPerfil';
        document.escolhaPerfil.submit();
    } else {
        alert("Tem que seleccionar um perfil.");
    }
}


//Página selecção de perfil -OEM
 function atribuiSeleccaoPerfil(csaude,perfil){
         document.escolhaPerfil.csaudeEscolhido.value = csaude;
         document.escolhaPerfil.perfilEscolhido.value = perfil;
         if(document.escolhaPerfil.csaudeEscolhido.value.length>0){
                 document.getElementById('idEvent').value = 'addPerfil';
                 splash(true);
                 document.escolhaPerfil.submit();
          } else {
                  alert("Tem que seleccionar um perfil.");
         }            
}
                   
                   
//Página selecção de perfil -WL                 
function selectPerfil(){
    var perfilEntidade= document.getElementById('cbPerfil').value;
    if(perfilEntidade != ""){
        var perfEntArray = perfilEntidade.split(";");
        var csaude = perfEntArray[0];
        var perfil  = perfEntArray[1];
        document.getElementById('csaudeEscolhido').value = csaude;
        document.getElementById('perfilEscolhido').value = perfil;}
    else {
        document.getElementById('csaudeEscolhido').value = "";
        document.getElementById('perfilEscolhido').value = "";}
    } 