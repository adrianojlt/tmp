    // Inicio de Funções de Identificação
    // metodo para submeter um form abdicando de usar botões do tipo submit e usar do tipo button
    function submitFormulario(a){
        document.getElementById("idEvent").value = a;
        splash(true);
        document.getElementById("forma").submit();
        return true;
    }
    
    function seleccionarUtente(rowUtente, obito){

        if ( obito === 'S' ) return;
        document.getElementById("rowNumberSelected").value=rowUtente;
        submitFormulario('selectUtente');
    }
    
    function cleartext(){
        document.getElementById("nSNS").value = "";
        document.getElementById("idadeDe").value = "";
        document.getElementById("nomes").value = "";
        document.getElementById("idadeA").value = "";
        document.getElementById("dataNasc").value = "";
        document.getElementById("pNiss").value = "";
        document.getElementById("paisNat").value = "";
        document.getElementById("nOP").value = "";
        document.getElementById("paisNac").value = "";
        document.getElementById("idDistrito").value = "";
        document.getElementById("idConcelho").value = "";
        document.getElementById("idFreguesia").value = "";
        document.getElementById("pPesquisaEfectuada").value = "";
        document.getElementById("pPesquisaTipoEfectuada").value = "";
        
        submitFormulario('limpar');
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
        if(document.getElementById("nomeDistrito")&&document.getElementById("nomeDistrito").value.length==0){
            document.getElementById("idDistrito").value = '';
        }
        if(document.getElementById("nomeConcelho")&&document.getElementById("nomeConcelho").value.length==0){
            document.getElementById("idConcelho").value = '';
        }
        if(document.getElementById("nomeFreguesia")&&document.getElementById("nomeFreguesia").value.length==0){
            document.getElementById("idFreguesia").value = '';
        }
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
                $.spmsDialog('warning', { title: 'title', message: 'Data inválida (' + obj.value + '). Introduza uma data no formato \'dd-MM-yyyy\'.\n'});
                if(obj.focus()){
                    obj.focus();
                }
                return false;
            } 
            
            // -- valida se a data nao e superior a data actual
            if(compareDates(obj.value,"dd-MM-yyyy",formatDate(new Date(), "dd-MM-yyyy"),"dd-MM-yyyy") == 1){
                //alert('Data de Nascimento superior à data actual.\n');
                $.spmsDialog('error', { title: '', message: 'Data de Nascimento superior à data actual.\n'});

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
   
    function colocaLimiteIdadeDefeito(o){
        var objDataDe  = document.getElementById("idadeDe");
        var objDataAte = document.getElementById("idadeA");
        
        if(o = 'idadeAte'){
            if(parseInt(objDataAte.value) < parseInt(objDataDe.value)){
                //alert("Atenção: 'Idade a' não pode ser inferior que a 'Idade de'. ");
                $.spmsDialog('warning', { title: 'Idade', message: 'Atenção: \'Idade a\' não pode ser inferior que a \'Idade de\'. '});
                objDataAte.value = 100;
            } else if(objDataDe.value.length==0){
                objDataDe.value = 0;
            }
        }
        
        if(o = 'idadeDe'){
            if(parseInt(objDataDe.value) > parseInt(objDataAte.value)){
              //alert("Atenção: 'Idade de' não pode ser superior que a 'Idade a'. ");
              $.spmsDialog('warning', { title: 'Idade', message: 'Atenção: \'Idade de\' não pode ser superior que a \'Idade a\'. '});
              objDataDe.value = 0;
            } else if(objDataAte.value.length==0){
              objDataAte.value = 100;
            }
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
            document.getElementById("pPesquisaAvancada").value = "false"; 
        }
        return true;
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
    
    // -- funcao para desabilitar filtro de pesquisa
    function desabilita() {
        document.getElementById("pDesabilita").value = 'true';
        // -- funcao em igif.js para desabilitar um array de elementos
        setEnabledOrDisabled(myArray0, true);
    }
    
    //-- array de obitos, para guardar registos de utentes marcados como obitos 
    //-- por forma a que as opçoes sejam disponibilizadas com base nesta informação, ou seja se obito não possibilita seleccionar e editar utente.
    var obitos = new Array();
    var contadorObitos = 0;
    
    // array de atributos de form de pesquisa para enable ou disable
    var myArray0 = new Array();
    myArray0[0] = "nSNS";
    myArray0[1] = "nOP";
    myArray0[2] = "nomes";
    myArray0[3] = "apelidos";
    myArray0[4] = "idadeDe";
    myArray0[5] = "idadeA";
    myArray0[6] = "dataNasc";
    myArray0[7] = "nomeDistrito";
    myArray0[8] = "nomeConcelho";
    myArray0[9] = "nomeFreguesia";
    myArray0[10] = "pNiss";
    
    function onloadFirstTime(){
        document.getElementById("pPesquisaEfectuada").value = 'true';
        if (document.getElementById("pPesquisaEfectuada").value.length <= 0 ){
            document.getElementById("pPesquisaEfectuada").value = 'false';
            document.getElementById("pPesquisaAvancada").value = 'false';
        }
        posicionaPesquisaAvancSimp();
    }
    
    function disponibilizaOpcoes(){
        //setEnabledOrDisabledButtons(new Array('selectUtente','editUtente', 'consultarUtente'), false);
        setEnabledOrDisabledButtons(new Array('selectUtente','editUtente'), false);
        // se utente seleccionado esta marcado como óbito faz disable da opção de seleccionar e editar
        var registos = document.getElementsByName("selID");
        for (var j = 0 ; j < registos.length ; j++) {
            if(registos[j].checked){
                // verificar se registos está marcado como óbito
                for (var i = 0 ; i < obitos.length ; i++) {
                    if(registos[j].value == obitos[i]){
                        // é obito (n deixa seleccionar nem editar, apenas deixa editar)
                        setEnabledOrDisabledButtons(new Array('selectUtente','editUtente'), true);
                        break;
                    }
                }
            }
        }
    }
    
    function pesquisaavancada() {
        if(document.getElementById("checkavancada").checked == true) {
            document.getElementById("pesquisaavancada").style.display="inline-table";  
            document.getElementById("pPesquisaAvancada").value="true";
        } else {
            document.getElementById("pesquisaavancada").style.display="none";
            document.getElementById("pPesquisaAvancada").value="false"
        }
    }
    
     function cleanCombo(comboId){
        var combo = document.getElementById(comboId);
        if(combo){
            combo.innerHTML = '';
        }
    }
    
     function getFreguesias(){
        var idConcelho = $('#idConcelho>option:selected').val();
        cleanCombo('idFreguesia');
        if(idConcelho && idConcelho.length>0){
            httpRequest("GET", "../com/ajaxServices.do?event=GetDistConcFregParaCombos&pIdPaiCodHier="+idConcelho, false, populateFreguesias);
        }
    }
    
     function getConcelhos(){
        var idDistrito = $('#idDistrito>option:selected').val();
        cleanCombo('idConcelho');
        cleanCombo('idFreguesia');
        if(idDistrito && idDistrito.length>0){
            httpRequest("GET", "../com/ajaxServices.do?event=GetDistConcFregParaCombos&pIdPaiCodHier="+idDistrito, false, populateConcelhos);
        }
    }
    
     function populateConcelhos(){
        if (request.readyState == 4) { 
          if (request.status == 200) { 
             text = request.responseText;
             if(text == '-1'){
                //alert("Erro ao obter valores.");
                $.spmsDialog('error', { title: '', message: 'Erro ao obter valores.'});
                return true;
             } else {
                var comboCampo = document.getElementById('idConcelho');
                var idConcelho="${param.idConcelho}".trim();
                
                var optn = document.createElement("OPTION");
                optn.text = "";
                optn.value = "";
                comboCampo.options.add(optn);
                
                var returnElements = text.split(";");     
                for(var j=0 ; j < returnElements.length ; j++){
                   var colunas = returnElements[j].split("|");
                   if(colunas.length>1){
                       optn = document.createElement("OPTION");
                       optn.text = colunas[1];
                       optn.value = colunas[0];
                       if(idConcelho && idConcelho==colunas[0]){optn.selected="selected"}
                       comboCampo.options.add(optn);
                   }   
                }
               
             }
          }
        }
    }
    
      function populateFreguesias(){
        if (request.readyState == 4) { 
          if (request.status == 200) { 
             text = request.responseText;
             if(text == '-1'){
                //alert("Erro ao obter valores.");
                $.spmsDialog('error', { title: '', message: 'Erro ao obter valores.'});
                return true;
             } else {
                var comboCampo = document.getElementById('idFreguesia');
                var idFreguesia = "${param.idFreguesia}".trim();
                var optn = document.createElement("OPTION");
                optn.text = "";
                optn.value = "";
                var callfreguesiasCorresp = false;
                comboCampo.options.add(optn);
                
                var returnElements = text.split(";");     
                for(var j=0 ; j < returnElements.length ; j++){
                   var colunas = returnElements[j].split("|");
                   if(colunas.length>1){
                       optn = document.createElement("OPTION");
                       optn.text = colunas[1];
                       optn.value = colunas[0];
                       if(idFreguesia && idFreguesia==colunas[0]){optn.selected="selected"}
                       comboCampo.options.add(optn);
                   }   
                }
               
             }
          }
        }
    }
    
    function onLoadConcFreguesias(idDistrito, idConcelho, idFreguesia){
        
       if(idDistrito && idDistrito.trim().length>0){
            httpRequest("GET", "../com/ajaxServices.do?event=GetDistConcFregParaCombos&pIdPaiCodHier="+idDistrito.trim(), false, populateConcelhos);
            
             if(idConcelho && idConcelho.trim().length>0){
                   httpRequest("GET", "../com/ajaxServices.do?event=GetDistConcFregParaCombos&pIdPaiCodHier="+idConcelho.trim(), false, populateFreguesias);
            }    
        }
    }
    
    