
// FUNCOES PARA A PESQUISA UTENTE
// ################################################################

    // ## /////////////////////////////////////// ##
    // ## -- funcoes gestao filtro de pesquisa -- ##
    // ## /////////////////////////////////////// ##
    
    // -- funcao para desabilitar filtro de pesquisa
    function desabilita() {
        document.getElementById("pDesabilita").value = 'true';
        // -- funcao em igif.js para desabilitar um array de elementos
        setEnabledOrDisabled(myArray0, true);
    }
    
    // -- funcao para abilitar filtro de pesquisa
    function abilita(){
        setEnabledOrDisabled(myArray0, false);
    }
        
    function limpa(opt){
        if(opt == 'P'){
            // -- limpar filtro de pesquisa
            resetValores(new Array("nSNS","nOP","nomes","apelidos","idadeDe","idadeA","dataNasc","paisNatDesc","paisNacDesc","pPaisNatDesc","pPaisNacDesc",
                                   "pPaisNatId","pPaisNacId","idDistrito","nomeDistrito","idConcelho","nomeConcelho","idFreguesia","nomeFreguesia"));
        } else if(opt == 'distrito'){
            resetValores(new Array("nomeDistrito","idDistrito","nomeConcelho","idConcelho","nomeFreguesia","idFreguesia")); 
        } else if(opt == 'concelho'){
            resetValores(new Array("nomeConcelho","idConcelho","nomeFreguesia","idFreguesia"));
        } else if(opt == 'freguesia'){
            resetValores(new Array("nomeFreguesia","idFreguesia"));
        } else if(opt == 'paisNat'){
            resetValores(new Array("paisNat"));
            // -- verifica se efectua expand ou collapse do distrito, concelho e freguesia
            controlaPaisNat();
        } else if(opt == 'paisNac'){
            resetValores(new Array("paisNac"));
        } else if(opt == 'evento'){
             resetValores(new Array("nSNS","nOP","nomes","apelidos","idadeDe","idadeA","dataNasc","paisNatDesc","paisNacDesc","pPaisNatDesc","pPaisNacDesc",
                               "pPaisNatId","pPaisNacId","idDistrito","nomeDistrito","idConcelho","nomeConcelho","idFreguesia","nomeFreguesia","pNiss","idPaisNat","idPaisNac"));
        }
        return true;
    }
    
    // -- funcao para validar dados introduzidos no filtro de pesquisa
    function validaFiltroPesquisa() {
        // -- validar data de nascimento caso tenha sido introduzida
        var obj = document.getElementById("dataNasc");
        if(obj.value.length>0){
                    
            // -- validar formato
            var date = getDateFromFormat(obj.value,"dd-MM-yyyy"); // funcao em igif.js
            if (date==0) { 
                //alert("Data inválida (" + obj.value + "). Introduza uma data no formato 'dd-MM-yyyy'.\n");
                $.spmsDialog('error', { title: 'Data inválida', message: 'Data inválida (" + obj.value + "). Introduza uma data no formato \'dd-MM-yyyy\'.'});
                if(obj.focus()){
                    obj.focus();
                }
                return false;
            } 
            
            // -- valida se a data nao e superior a data actual
            if(compareDates(obj.value,"dd-MM-yyyy",formatDate(new Date(), "dd-MM-yyyy"),"dd-MM-yyyy") == 1){
                //alert('Data de Nascimento superior à data actual.\n');
                $.spmsDialog('warning', { title: 'Aviso', message: 'Data de Nascimento superior à data actual.'});
                if(obj.focus()){
                    obj.focus();
                }
                return false;
            }
            
            // -- validar se esta entre o intervalo de datas caso o intervalo de datas tenha sido preenchido
            var objDataDe  = document.getElementById("idadeDe");
            var objDataAte = document.getElementById("idadeA");
            if(objDataDe.value.length>0 && objDataAte.value.length>0){
                
            }
            
        }
        atribuiValores();
        return true;
    }
    
    function atribuiValores(){
        // -- informar que foi requerida uma pesquisa
        document.getElementById("pPesquisaEfectuada").value = "true";
        
        document.getElementById('pPesquisaTipoEfectuada').value = document.getElementById('pPesquisaAvancada').value;
        if (document.getElementById('pPesquisaTipoEfectuada').value=='true'){
        
            if(document.getElementById("pPaisNatId") && document.getElementById('paisNat')){
                document.getElementById("pPaisNatId").value = document.getElementById('paisNat').value;
            }
            
            if(document.getElementById("pPaisNacId") && document.getElementById('paisNac')){
                document.getElementById("pPaisNacId").value = document.getElementById('paisNac').value;
            }
            
            if(document.getElementById("pPaisNatDesc") && document.getElementById('paisNat')){
                document.getElementById("pPaisNatDesc").value = document.getElementById('paisNat').options[document.getElementById('paisNat').selectedIndex].label
            }
            
            if(document.getElementById("pPaisNacDesc") && document.getElementById('paisNac')){
                document.getElementById("pPaisNacDesc").value = document.getElementById('paisNac').options[document.getElementById('paisNac').selectedIndex].label
            }
        }
        
        // -- ao efectuar a pesquisa caso as descricoes de distrito, concelho e freguesia
        // -- estejam a vazio limpa id's
        if(document.getElementById("nomeDistrito").value.length==0){
            document.getElementById("idDistrito").value = '';
        }
        if(document.getElementById("nomeConcelho").value.length==0){
            document.getElementById("idConcelho").value = '';
        }
        if(document.getElementById("nomeFreguesia").value.length==0){
            document.getElementById("idFreguesia").value = '';
        }
    }
    
    function changePropmptPesquisa(){
        if(document.getElementById("pPesquisaEfectuada").value != 'false'){
            if( document.getElementById("pPesquisaAvancada").value == 'true' ){
                document.getElementById("pesquisa_avancada").value='Pesquisa Avançada';
                document.getElementById("pPesquisaAvancada").value = "false";
            } else if(document.getElementById("pPesquisaAvancada").value == 'false' ) {
                // *** comentado
                // setEnableOrDisableDistConcFreg('');
                document.getElementById("pesquisa_avancada").value='Pesquisa Simples';
                document.getElementById("pPesquisaAvancada").value = "true";
            } else {
                document.getElementById("pesquisa_avancada").value='Pesquisa Avançada';
                document.getElementById("pPesquisaAvancada").value = "false";
            }
        } else {
            document.getElementById("pPesquisaEfectuada").value = 'false';
        }
        posicionaPesquisaAvancSimp();
        return true;
    }
    // ## -- fim funcoes gestao filtro de pesquisa -- ##
    
    function colocaLimiteIdadeDefeito(o){
        var objDataDe  = document.getElementById("idadeDe");
        var objDataAte = document.getElementById("idadeA");
        
        if(o = 'idadeAte'){
            if(parseInt(objDataAte.value) < parseInt(objDataDe.value)){
                //alert("Atenção: 'Idade a' não pode ser inferior que a 'Idade de'. ");
                $.spmsDialog('warning', { title: 'Atenção', message: 'Atenção: \'Idade a\' não pode ser inferior que a \'Idade de\'. '});
                objDataAte.value = 100;
            } else if(objDataDe.value.length==0){
                objDataDe.value = 0;
            }
        }
        
        if(o = 'idadeDe'){
            if(parseInt(objDataDe.value) > parseInt(objDataAte.value)){
                //alert("Atenção: 'Idade de' não pode ser superior que a 'Idade a'. ");
                $.spmsDialog('warning', { title: 'Atenção\', message: \'Idade de\' não pode ser superior que a \'Idade a\'. '});
                objDataDe.value = 0;
            } else if(objDataAte.value.length==0){
              objDataAte.value = 100;
            }
        }
        
    }
    
    // -- caso o pais seleccionado seja diferente de Portugal não mostra Distrito, Concelho e Freguesia
    // -- nota: necessário por o descritivo do pais em propriedades
    function controlaPaisNat(){
        if(document.getElementById("paisNat")){
            var obj = document.getElementById("paisNat");
            var value = obj.options[obj.selectedIndex].title;
            if(value.startsWith('PT')){
                expandRow('pqAvanc5');
                expandRow('pqAvanc6');
                expandRow('pqAvanc7');
            } else {
                collapseRow('pqAvanc5');
                collapseRow('pqAvanc6');
                collapseRow('pqAvanc7');
                // -- limpa valores de distrito, concelho e freguesia
                resetValores(new Array("nomeDistrito","idistrito","nomeConcelho","idConcelho","nomeFreguesia","idFreguesia"));
            }
        }  
   }  
   
   
   function podeAbrirPopUp(lov){
        if(lov == 'concelho' && document.getElementById("idDistrito").value.length == 0 ){
            return false;
        } else if (lov == 'freguesia' && document.getElementById("idConcelho").value.length == 0){
            return false;
        } else { 
            return true;
        }
    }
   
   function posicionaPesquisaAvancSimp(){
        if(document.getElementById("pPesquisaAvancada").value == 'true'){
            // -- pesquisa avancada
            expandRow('pqAvanc0');
            expandRow('pqAvanc1');
            expandRow('pqAvanc2');
            expandRow('pqAvanc3');
            expandRow('pqAvanc4');
            expandRow('pqAvanc5');
            expandRow('pqAvanc6');
            expandRow('pqAvanc7');
            document.getElementById("pesquisa_avancada").value='Pesquisa Simples';
            document.getElementById("pPesquisaAvancada").value = "true";
        } else if(document.getElementById("pPesquisaAvancada").value == 'false') {
            // -- pesquisa simples
            collapseRow('pqAvanc0');
            collapseRow('pqAvanc1');
            collapseRow('pqAvanc2');
            collapseRow('pqAvanc3');
            collapseRow('pqAvanc4');
            collapseRow('pqAvanc5');
            collapseRow('pqAvanc6');
            collapseRow('pqAvanc7');
            document.getElementById("pesquisa_avancada").value='Pesquisa Avançada';
            document.getElementById("pPesquisaAvancada").value = "false";
        } else {
            // -- pesquisa simples
            collapseRow('pqAvanc0');
            collapseRow('pqAvanc1');
            collapseRow('pqAvanc2');
            collapseRow('pqAvanc3');
            collapseRow('pqAvanc4');
            collapseRow('pqAvanc5');
            collapseRow('pqAvanc6');
            collapseRow('pqAvanc7');            
            document.getElementById("pesquisa_avancada").value='Pesquisa Avançada';
            document.getElementById("pPesquisaAvancada").value = "false"; 
        }
        return true;
    }
    
     function setActionOnEvent(action,actionTipo){
        document.getElementById("idEvent").value=action;
        document.getElementById("idEventTipo").value=actionTipo;
        if (actionTipo == 'DIST'){
            document.crossConc.click();  
        }else if (actionTipo == 'CONC'){
            document.crossFreg.click();  
        }         
        
        // -- limpar valores de id's caso o nome esteja a vazio (distritos, concelhos e freguesias)
        if(document.getElementById("nomeDistrito").value.length==0)
            document.getElementById("idDistrito").value = '';
        if(document.getElementById("nomeConcelho").value.length==0)
            document.getElementById("idConcelho").value = '';
        if(document.getElementById("nomeFreguesia").value.length==0)
            document.getElementById("idFreguesia").value = '';
        document.forma.submit();
        return true;
    }
   // FIM DE FUNCOES PARA A PESQUISA UTENTE
   // ################################################################
   
    
    
    
    
    function chamaLovCodHier(element,elementPai,valorCampo,modo,bloco){   
    
        if (!document.getElementById('nome'+element).getAttribute('readonly')){
            if(modo!='true'){
                var nome = '';
                var paiId = '';
                
                if ( InStr( element, 'Distrito' ) >= 0 ) {
                    nome = 'Distrito';
                } else if ( InStr( element, 'Concelho' ) >= 0 ) {
                    nome = 'Concelho';
                    paiId = document.getElementById('id'+elementPai).value;
                } else if ( InStr( element, 'Freguesia' ) >= 0 ) {
                    nome = 'Freguesia';
                    paiId = document.getElementById('id'+elementPai).value;
                }
                popUpCodHierLovLOV('id'+element,'nome'+element,paiId,nome,nome+'s',valorCampo,bloco);
            } 
        }
    }
    
    // -- funcao para chamar lov de distritos, concelhos e freguesia da pesquisa de familia
    function chamaLovCodHierFamilia(element,elementPai,valorCampo,bloco){   
        var nome = '';
        var paiId = '';
        if ( InStr( element, 'Distrito' ) >= 0 ) {
            nome = 'Distrito';
        } else if ( InStr( element, 'Concelho' ) >= 0 ) {
            nome = 'Concelho';
            paiId = document.getElementById('idFam'+elementPai).value;
        } else if ( InStr( element, 'Freguesia' ) >= 0 ) {
            nome = 'Freguesia';
            paiId = document.getElementById('idFam'+elementPai).value;
        }
        popUpCodHierLovLOV('idFam'+element,'nomeFam'+element,paiId,nome,nome+'s',valorCampo,bloco);
    }
    
    // -- funcao para chamar lov de distritos, concelhos e freguesia da pesquisa de utente
    function chamaLovCodHierPesquisaUtente(element,elementPai,valorCampo){    
        var nome = '';
        var paiId = '';
        if ( InStr( element, 'Distrito' ) >= 0 ) {
            nome = 'Distrito';
        } else if ( InStr( element, 'Concelho' ) >= 0 ) {
            nome = 'Concelho';
            paiId = document.getElementById('id'+elementPai).value;
        } else if ( InStr( element, 'Freguesia' ) >= 0 ) {
            nome = 'Freguesia';
            paiId = document.getElementById('id'+elementPai).value;
        }
        popUpCodHierLovLOV('id'+element,'nome'+element,paiId,nome,nome+'s',valorCampo,''); 
    }
    
    // -- funcao para chamar lov de distritos, concelhos e freguesia da pesquisa de utente
    function chamaLovCodHierCorrespondencia(element,elementPai,valorCampo){    
        var nome = '';
        var paiId = '';
        if ( InStr( element, 'Distrito' ) >= 0 ) {
            nome = 'Distrito';
        } else if ( InStr( element, 'Concelho' ) >= 0 ) {
            nome = 'Concelho';
            paiId = document.getElementById('idCorresp'+elementPai).value;
        } else if ( InStr( element, 'Freguesia' ) >= 0 ) {
            nome = 'Freguesia';
            paiId = document.getElementById('idCorresp'+elementPai).value;
        }
        popUpCodHierLovLOV('idCorresp'+element,'nomeCorresp'+element,paiId,nome,nome+'s',valorCampo,''); 
    }
    
    // -- funcao para chamar lov de distritos, concelhos e freguesia na edicao de utente - pesquisa de familias
    /*
    function chamaLovCodHierPesquisaFamilias(element,elementPai,valorCampo){    
        alert(element);
        alert(elementPai);
        alert(valorCampo);
        
        var nome = '';
        var paiId = '';
        if ( InStr( element, 'Distrito' ) >= 0 ) {
            nome = 'Distrito';
        } else if ( InStr( element, 'Concelho' ) >= 0 ) {
            nome = 'Concelho';
            paiId = document.getElementById('id'+elementPai).value;
        } else if ( InStr( element, 'Freguesia' ) >= 0 ) {
            nome = 'Freguesia';
            paiId = document.getElementById('id'+elementPai).value;
        }
        popUpCodHierLovLOV('id'+element,'nome'+element,paiId,nome,nome+'s',valorCampo,''); 
    }
    */
    
    function setProps(nomeCampo,state)
    {
        document.getElementById('id'+nomeCampo).value = '';
        document.getElementById('nome'+nomeCampo).value = '';
        if ( state == 'disabled' ) {
            document.getElementById('nome'+nomeCampo).className = document.getElementById('nome'+nomeCampo).className + ' disabled';
            document.getElementById('nome'+nomeCampo).setAttribute('readOnly','readOnly');
        } else {
            if ( document.getElementById('nome'+nomeCampo).className.indexOf(' ') > 0 ) {
                document.getElementById('nome'+nomeCampo).className = document.getElementById('nome'+nomeCampo).className.substring(0,document.getElementById('nome'+nomeCampo).className.indexOf(' '));
            }
            document.getElementById('nome'+nomeCampo).removeAttribute('readOnly');
        }
    }
    
    function limpaCodLov(paramId,paramCod,paramDesc,paramOutro1,paramOutro2)
    {
        if ( paramOutro1 == null ) {
            paramOutro1 = '';
        }
        if ( paramOutro2 == null ) {
            paramOutro2 = '';
        }
        if ( paramId != '' && document.getElementById(paramId)) {
            document.getElementById(paramId).value = '';
        }
        if ( paramCod != '' && document.getElementById(paramCod)) {
            document.getElementById(paramCod).value = '';
        }
        if ( paramDesc != '' && document.getElementById(paramDesc)) {
            document.getElementById(paramDesc).value = '';
        }
        if ( paramOutro1 != '' && document.getElementById(paramOutro1)) {
            document.getElementById(paramOutro1).value = '';
        }
        if ( paramOutro2 != '' && document.getElementById(paramOutro2)) {
            document.getElementById(paramOutro2).value = '';
        }
    }
    
    function navegaTab(tabNum,numTabs,readOnly){
        document.getElementById('numTab').value = tabNum;
        navigateTab(tabNum,numTabs);
    }
    
    
    function preencheValorCampo(idCampo,valorRequest,valorBinding){   
        if ( valorRequest.length>0 ){
            document.getElementById(idCampo).value = valorRequest;
        } else {
            document.getElementById(idCampo).value = valorBinding;
        }
        return;
    }
    
    /*
    function preencheValorCampo(idCampo,valorRequest,valorBinding){   
        if ( (valorRequest.length>0 && gravou=='N') || lovAutomatica=='S' ){
            document.getElementById(idCampo).value = valorRequest;
        } else {
            document.getElementById(idCampo).value = valorBinding;
        }
        return;
    }
    */
    
    // -- funcao para validar datas introduzidas
    function validarData(idCampoData) {            
        var obj = document.getElementById(idCampoData);
        if(obj.value.length>0){
            var date = getDateFromFormat(obj.value,"dd-MM-yyyy"); // funcao em igif.js
            if (date==0) { 
                //alert("Data invalida (" + obj.value + "). Introduza uma data no formato 'dd-MM-yyyy'.\n");
                $.spmsDialog('error', { title: 'Data invalida', message: 'Data invalida (" + obj.value + "). Introduza uma data no formato \'dd-MM-yyyy\'.'});
                if(obj.type != "hidden") obj.focus();
                return false;
            }
        }
        return true;
    }
    
    function disabledAll(){
            var imgs = document.getElementsByTagName('img');  
            if (imgs){
                for (var j = 0; j < imgs.length; ++j) {
                    if (
                       (imgs[j].id != 'popupLovEntidade' && imgs[j].id != 'crossEntidadesId') 
                        && (imgs[j].id.length > 0)){
                            document.getElementById(imgs[j].id).className='';
                            document.getElementById(imgs[j].id).onclick='return true;';
                            document.getElementById(imgs[j].id).style.cursor='';
                    }
                }
            }
            var radios = document.getElementsByTagName('input'); 
            if (radios){
                for (var j = 0; j < radios.length; ++j) {
                    if (radios[j].type == 'radio' && 
                        radios[j].name == 'sexo' ){
                        var radiosDis = new Array("sexoF","sexoM","sexoI");
                        setEnabledOrDisabled(radiosDis, true);
                    }else if (radios[j].id.length >0){
                        if (radios[j].id == 'dataNasc'){
                            document.getElementById(radios[j].id).className='inputTextOne disabled';
                        }
                    }
                }            
            }       
    }
    
    
    
    function openLovWithEnter(object,paramLov){
        if(getKeyCodeValue(this)==13){
            document.getElementById(paramLov).click();
            setfocus(object);
            return true;
        }    
    }
    
    function callFunctionButtons(param){
        document.getElementById('idEvent').value = param;
        document.edicaoUtente.submit();        
    }
        
    function checkValDistConFregSelected(distVal,concVal,crossDist,CrossCon){
    
        if (distVal.length==0){
            if(document.getElementById(crossDist)){
                document.getElementById(crossDist).click();
                return;
            }
        }
        
        if (concVal.length==0){
            if(document.getElementById(CrossCon)){
                document.getElementById(CrossCon).click();
                return;
            }
        }
    
    }

    //Added to disable and enable popups an crosses of dist conc freg
    function checkAtributeReadOnly(param1){

        var LovText = '';
        var CrossText = '';
        var cursorText  = 'pointer';
        
        if (document.getElementById(param1)){
            if (document.getElementById(param1).getAttribute('readonly')){
                if (param1=='nomeConcelho'){
                    LovText   ='popUpConcelho';
                    CrossText = 'crossregUmicId';
                }else if(param1=='nomeFreguesia'){
                    LovText   ='popUpFreguesia';
                    CrossText = 'crossFreguesia';                
                }else if(param1=='nomeCorrespConcelho'){
                    LovText   ='popUpConcelhoCorresp';
                    CrossText = 'crossconcelhoCorrespId';                
                }else if(param1=='nomeCorrespFreguesia'){
                    LovText   ='popUpFreguesiaCorresp';
                    CrossText = 'crossCorrespConcelho';                
                }else if(param1=='nomePFamConcelho'){
                    LovText   ='popUpConcelhoPFam';
                    CrossText = 'crossConcelhoPFam';                
                }else if(param1=='nomePFamFreguesia'){
                    LovText   ='popUpFreguesiaPFam';
                    CrossText = 'crossFreguesiaPFam';                
                }
                
                if(document.getElementById(LovText)){
                    document.getElementById(LovText).src="../img/application_side_list_disable.gif";
                    document.getElementById(LovText).style.cursor ='';
                }
                
                if(document.getElementById(CrossText)){
                    document.getElementById(CrossText).src = "../img/cross_disabled.gif";
                    document.getElementById(CrossText).style.cursor ='';              
                }
            }else{
                if (param1=='nomeConcelho'){
                    LovText   ='popUpConcelho';
                    CrossText = 'crossregUmicId';
                    }else if(param1=='nomeFreguesia'){
                    LovText   ='popUpFreguesia';
                    CrossText = 'crossFreguesia'; 
                }else if(param1=='nomeCorrespConcelho'){
                    LovText   ='popUpConcelhoCorresp';
                    CrossText = 'crossconcelhoCorrespId'; 
                }else if(param1=='nomeCorrespFreguesia'){
                    LovText   ='popUpFreguesiaCorresp';
                    CrossText = 'crossCorrespConcelho';                
                }else if(param1=='nomePFamConcelho'){
                    LovText   ='popUpConcelhoPFam';
                    CrossText = 'crossConcelhoPFam';     
                 }else if(param1=='nomePFamFreguesia'){
                    LovText   ='popUpFreguesiaPFam';
                    CrossText = 'crossFreguesiaPFam';
                }            
                
                if(document.getElementById(LovText)){
                    document.getElementById(LovText).src="../img/application_side_list.gif";
                    document.getElementById(LovText).style.cursor=cursorText;
                }
                
                if(document.getElementById(CrossText)){
                    document.getElementById(CrossText).src = "../img/cross.gif";
                    document.getElementById(CrossText).style.cursor=cursorText;  
                }
                                    
            
            }
        }       
    }
    
// função para expande/collapse de areas de agregação de informação
 // nota (IMPORTANTE!): esta função é usada noutras paginas da identificação
 function collapseExpandArea(r, param, img){
    collapseExpandRow(r);
    if (document.getElementById(r)){
        if(document.getElementById(param)){
            document.getElementById(param).value = "display:" + document.getElementById(r).style.display + ";";
        }
        
        if(document.getElementById(img)){
            if(document.getElementById(img).src.indexOf("nolines_minus.gif")>0){
                document.getElementById(img).src = '../img/nolines_plus.gif';
            } else {
                document.getElementById(img).src = '../img/nolines_minus.gif';
            }
        }
    }
 }
 
 // para escolhas de nacionalidades e naturalidades guarda input 
 // com valores escolhidos para posterior controlo
 function selectNacNat(tipo){
    if(tipo == 'NAC'){
       var objNac = document.getElementById("paisNac");
       var valueNac = objNac.options[objNac.selectedIndex].title;  
       document.getElementById('pCodNac').value = valueNac.substring(0,2);
    }
    if(tipo == 'NAT'){
        var objNat = document.getElementById("paisNat");
        var valueNat = objNat.options[objNat.selectedIndex].title;
        document.getElementById('pCodNat').value = valueNat.substring(0,2);
    }
    contextualizaFormNatNac();
 }
 
 function contextualizaFormNatNac(){
    var valueNac = document.getElementById('pCodNac').value;
    var valueNat = document.getElementById('pCodNat').value;
    if(valueNat == 'PT' || ( valueNat == 'XX' && valueNac == 'PT' ) ){
        expandRow('naturalidadePort');
        collapseRow('naturalidadeEst');
    } else {
        expandRow('naturalidadeEst');
        collapseRow('naturalidadePort');
    }
 }
 
 // -- funcao para esconder ou mostrar td de nº documento de identificacao
 // -- se foi fornecido documento mostra, caso contrario oculta
 function mostraEscondeDocId(){
    if(document.getElementById("idTipoId")){
        var obj = document.getElementById("idTipoId");
        if(obj){
            var value = obj.options[obj.selectedIndex].title;
            if( ( value.startsWith('N') || value.length==0 )&& document.getElementById("nDocId")){
                document.getElementById("nDocId").style.display = "none";
            } else {
                document.getElementById("nDocId").style.display = "";
            }
            document.getElementById("codTipoId").value = value.charAt(0);
        }
    }  
 }
 
 // função para invocar gravação dos dados do utente
 // Nota (IMPORTANTE!): os campos nome, sexo, dt. nascimento, nacionalidade e naturalidade são de preenchimento obrigatório. 
 //                     para nascidos a bordo : obrigar a preencher 'Distrito, Concelho e Freguesia' se Nacionalidade Portuguesa
 //                                             obrigar a preencher 'Região, Cidade e Localidade' se Nacionalidade Não Portuguesa
 function gravarDadosUtente(event){
    
    if(event != 'CC'){
        
        var naoEscolhidoSexo = true;
        if(document.getElementById("sexoF").checked || document.getElementById("sexoM").checked ){
            naoEscolhidoSexo = false;
        }
        
        
        // validar obrigatórios
        if( document.getElementById("nomes").value.length == 0 || 
            naoEscolhidoSexo || 
            document.getElementById("dataNasc").value.length == 0 || 
            document.getElementById("paisNac").value.length == 0 || 
            document.getElementById("paisNat").value.length == 0
            ){
            //alert("Os campos 'Nome', 'Sexo', 'Data Nascimento', 'País Nac.' e 'País Nat.' são de preenchimento obrigatório.");
            $.spmsDialog('warning', { title: 'Aviso', message: 'Os campos \'Nome\', \'Sexo\', \'Data Nascimento\', \'País Nac.\' e \'País Nat.\' são de preenchimento obrigatório.'});
            return false;
        }
        
        // ao alterar os dados do utente apenas pode alterar o nome em dois nomes (alterar ou acrescentar)
        if(event == 'GravarDadosUtente'){
            
            var numDiff = 0;
            var nomesOriginal = registoDadosUtente[0].trim().split(" ");
            var nomesAlterado = document.getElementById("nomes").value.trim().split(" ");
            
            numDiff = Math.abs(nomesAlterado.length - nomesOriginal.length);
            
            // percorrer nomes originais para verificar se estão continos nos alterados
            // caso não estejam existem alterações
            for(var i = 0; i < nomesOriginal.length ; i++){
                var existe = false; 
                for(var j = 0; j < nomesAlterado.length ; j++){
                    if(nomesOriginal[i] == nomesAlterado[j]){
                        existe = true;
                    }
                }
                if(!existe){
                    numDiff = numDiff + 1;
                } 
            }
            if(numDiff > 2){
                //alert("O nome do utente não pode ser totalmente alterado. Apenas podem ser modificados 2 nomes (Acrescentados ou Alterados).");
                $.spmsDialog('warning', { title: 'Nome Utente', message: 'O nome do utente não pode ser totalmente alterado. Apenas podem ser modificados 2 nomes (Acrescentados ou Alterados).'});
                return false;
            }
            
        }
        
        // para 'Nascidos a Bordo' 
        // obrigar a preencher 'Distrito, Concelho e Freguesia' se Nacionalidade Portuguesa (* retirado a 27-05-2009 - CRF20081112.doc ponto 3.1)
        // obrigar a preencher 'Região, Cidade e Localidade' se Nacionalidade Não Portuguesa e Não Nascido a Bordo (* retirado a 27-05-2009 - CRF20081112.doc ponto 3.1)
        var valueNac = document.getElementById('pCodNac').value;
        var valueNat = document.getElementById('pCodNat').value;
        
        if(valueNat == 'XX'){
            if(valueNac == 'PT'){
                // * retirado a 27-05-2009 - CRF20081112.doc ponto 3.1
                /*
                if( document.getElementById("idDistrito").value.length == 0 ||
                    document.getElementById("idConcelho").value.length == 0 ||
                    document.getElementById("idFreguesia").value.length == 0){
                    alert("Os campos 'Distrito', 'Concelho' e 'Freguesia' são de preenchimento obrigatório para a Naturalidade 'Nascido a Bordo'.");
                    return false;
                } 
                */
            } else {
                // * retirado a 27-05-2009 - CRF20081112.doc ponto 3.1
                /*
                if( document.getElementById("nomeRegiao").value.length == 0 ||
                    document.getElementById("nomeCidade").value.length == 0 ||
                    document.getElementById("nomeLocalidade").value.length == 0){
                    alert("Os campos 'Região', 'Cidade' e 'Localidade' são de preenchimento obrigatório para a Naturalidade 'Nascido a Bordo'.");
                    return false;
                } 
                */
            }
        }
        
        // * acrescentado a 27-05-2009 - CRF20081112.doc ponto 3.1
        if(valueNat == 'PT'){
            if( document.getElementById("idDistrito").value.length == 0 ||
                document.getElementById("idConcelho").value.length == 0 ||
                document.getElementById("idFreguesia").value.length == 0){
                //alert("Os campos 'Distrito', 'Concelho' e 'Freguesia' são de preenchimento obrigatório para a Naturalidade 'Portugal'.");
                $.spmsDialog('warning', { title: 'Campos', message: "Os campos 'Distrito', 'Concelho' e 'Freguesia' são de preenchimento obrigatório para a Naturalidade 'Portugal'."});
                return false;
            } 
        }
        
    } else if(event == 'CC'){
        event = 'GravarDadosUtente';
    }
    
    var obj = document.getElementById("idTipoId");
    if( !obj.options[obj.selectedIndex].title.startsWith('N')){
    
        if(document.getElementById("numId").value.length == 0){
            //alert("O Número de Documento de Identificação é de preenchimento obrigatório.");
            $.spmsDialog('warning', { title: 'Numero de Documento', message: 'O Número de Documento de Identificação é de preenchimento obrigatório.'});
            return false;
        }
        
        if(document.getElementById("numId").value.length > 13){
            //alert("O Número de Documento de Identificação apenas suporta tamanho até 13 caracteres.");
            $.spmsDialog('warning', { title: 'Numero de Documento', message: 'O Número de Documento de Identificação apenas suporta tamanho até 13 caracteres.'});
            return false;
        }
    } else {
        objNumId = document.getElementById("numId");
        if(objNumId){
            objNumId.value = "";
        }
    }
        
    //var x = confirm("Tem a certeza que deseja guardar os dados do utente?");
    var x = false;
    $.spmsDialog( 'confirm', { title: 'Tem a certeza?', message: "Tem a certeza que deseja guardar os dados do utente?", callback: function() { x = true; } });

    if(x){
        document.getElementById('idEvent').value = event; 
        splash(true); 
        document.forms[0].submit();
        return true;
    }
    return false;
 } 
 
function populateAgregadoFamilia(){
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            //alert("Erro ao obter valores.");
            $.spmsDialog('error', { title: 'Erro', message: 'Erro ao obter valores.'});
            return true;
         } else {
            document.getElementById('divDetalheAgregadoFamiliaTabColExp').innerHTML = text;    
            splash(false);
         }
      }
    }
}

function populateAgregadoFamiliaTabInscricao(){
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            //alert("Erro ao obter valores.");
            $.spmsDialog('error', { title: '', message: ''});
            return true;
         } else {
            opener.document.getElementById('divDetalheAgregadoFamiliaTabColExp').innerHTML = text;
         }
      }
    } else {
        opener.document.getElementById('divDetalheAgregadoFamiliaTabColExp').innerHTML = '<img src="../img/ajax-loader.gif" alt="Loading..." />';
        return true;
    }
}

function populateListaFamilia(){
    var text = "";
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            //alert("Erro ao obter valores.");
            $.spmsDialog('error', { title: 'Erro', message: 'Erro ao obter valores.'});
            return true;
         } else {
            document.getElementById('divResultadosPesquisaColExp').innerHTML = text;
         }
         splash(false);
      }
    }
}

function populateDetalheFamilia(){
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            //alert("Erro ao obter valores.");
            $.spmsDialog('error', { title: 'Erro', message: 'Erro ao obter valores.'});
            return true;
         } else {
             if(text.trim().length>0){
                 var returnElements = text.split("|");
                 // preencher detalhe de morada de família
                 document.getElementById("d_idFamilia").value = returnElements[0];
                 document.getElementById("d_nProcPFam").value = returnElements[18];
                 document.getElementById("d_idPFamVia").value = returnElements[13];
                 document.getElementById("d_ruaPFam").value = returnElements[1];
                 document.getElementById("d_portaPFam").value = returnElements[17];
                 document.getElementById("d_andarPFam").value = returnElements[2];
                 document.getElementById("d_lugarPFam").value = returnElements[16];
                 document.getElementById("d_localidadePFam").value = returnElements[14];
                 document.getElementById("idPFamDetDistrito").value = returnElements[7];
                 document.getElementById("nomePFamDetDistrito").value = returnElements[6];
                 document.getElementById("idPFamDetConcelho").value = returnElements[5];
                 document.getElementById("nomePFamDetConcelho").value = returnElements[4];
                 document.getElementById("idPFamDetFreguesia").value = returnElements[9];
                 document.getElementById("nomePFamDetFreguesia").value = returnElements[8];
                 document.getElementById("d_idCodPostalPFam").value = returnElements[10];
                 document.getElementById("d_codPostalPFam").value = returnElements[3];
                 document.getElementById("d_seqPostalPFam").value = returnElements[19];
                 document.getElementById("d_lugarPostalPFam").value = returnElements[15];
                 document.getElementById("d_cSaudeCod").value = returnElements[20];
                 document.getElementById("d_cSaudeDes").value = returnElements[21];
                 document.getElementById("d_moradaCompleta").value = returnElements[22];
                 document.getElementById("d_indicativoPFam").value = returnElements[23];
                 document.getElementById("d_telefonePFam").value = returnElements[24];
                 document.getElementById("d_descPFamVia").value = returnElements[25];
            }
         }
         splash(false);  
      }
    }
}

function populateGraus(){
    var text = "";
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            //alert("Erro ao obter valores.");
            $.spmsDialog('error', { title: 'Erro', message: 'Erro ao obter valores.'});
            return true;
         } else {
            // verificar origem do pedido para devolver graus parentesco para escolha correctamente
            if(document.getElementById('origemPedido').value == 'NF'){
                // nova inscrição
                opener.document.getElementById('pNovaInscrGrauParentesco').innerHTML = text;
                opener.expandRow('pNovaInscrGrauParentesco');
                window.close();
            } else if(document.getElementById('origemPedido').value == 'AF') {
                // alteração de família
                opener.document.getElementById('pAltInscrGrauParentesco').innerHTML = text;
                opener.expandRow('pAltInscrGrauParentesco');
                window.close();
            }
         }
         splash(false);
      }
    }
}
//////////////////////////////////////////// 
// obter agregado via ajax services (fim)
//////////////////////////////////////////// 

// metodo para submeter um form abdicando de usar botões do tipo submit e usar do tipo button
function submitFormulario(a){
    document.getElementById("idEvent").value = a;
    splash(true);
    document.forms[0].submit();
    return true;
}