<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<html>
  <head>
    <title>Pesquisar Beneficiário</title>

    <script type="text/javascript">
        
        function enableButton(button) { 
            button.className = 'submitButton spms-toolbar-button right';
            button.removeAttribute("disabled");
        }
        
        function disableButton(button) { 
            button.className = 'submitButton buttonDisabled spms-toolbar-button right';
            button.disabled=true;
        }
        
        function verificaSeleccao(){
            if(document.getElementById("mudarBeneficiario") && document.getElementById("mudarBeneficiario").value ){
                trocarBeneficinario();
            }else{
                selecionar();
            }
        }
        
        
        function selecionar(){
            //alert("${bindings.InformacaoUtente.Nomeutente}");
            var outroParentesco = document.getElementById('OutroGrauParentesco').value.trim();
            var parentescoSelectedIndex = document.getElementById("selectParentesco").selectedIndex;
            var parentescoId = document.getElementById("selectParentesco").options[parentescoSelectedIndex].value; // parentescoArray[0];
            var parentescoDesc = document.getElementById("selectParentesco").options[parentescoSelectedIndex].text;  // document.parentescoArray[1];
            var entRespIndex = document.getElementById("entResp").selectedIndex;
            var entRespId = document.getElementById("entResp").options[entRespIndex].value;
            var entRespText = document.getElementById("entResp").options[entRespIndex].text;

            if (parentescoId == 0) {
                //alert('Por favor, indique o grau de Parentesco.');
                $.spmsDialog('warning', { title: 'Aviso', message: 'Por favor, indique o grau de Parentesco.'});
                document.getElementById("selectParentesco").focus();
                return false;
            }
            
            if (parentescoId == '<%= request.getSession(false).getAttribute("GitidOutroGrauParentesco") %>' && outroParentesco == "" ) {
                //alert('Por favor, indique que outro Parentesco.');
                $.spmsDialog('warning', { title: 'Aviso', message: 'Por favor, indique que outro Parentesco.'});
                document.getElementById('OutroGrauParentesco').focus();
                return false;
            }
            
           
            //hiddenIdBenef
            opener.document.getElementById('inputFamiliarSelected').value = document.getElementById('hiddenSeleccionaFamilia').value;
            opener.document.getElementById('inputFamiliarNome').value =   opener.document.getElementById('hiddenNomeUtenteOriginal').value.replace("'","");
            opener.document.getElementById('nomeFamiliar').innerHTML =  opener.document.getElementById('hiddenNomeUtenteOriginal').value.replace("'","");
            opener.document.getElementById('inputFamiliarDtaNasc').value = opener.document.getElementById('hiddenInfoUtenteDtaNasc').value;
            opener.document.getElementById('dtaNascFamiliar').innerHTML = opener.document.getElementById('hiddenInfoUtenteDtaNasc').value;
            opener.document.getElementById('inputFamiliarId').value = opener.document.getElementById('idUtenteInfo').value;
            if(opener.document.getElementById('hiddenNissInfoUtente')){
                opener.document.getElementById('inputFamiliarNiss').value = opener.document.getElementById('hiddenNissInfoUtente').value;
                opener.document.getElementById('nissFamiliar').innerHTML = opener.document.getElementById('hiddenNissInfoUtente').value;
            }else{
                opener.document.getElementById('inputFamiliarNiss').value ='';
                opener.document.getElementById('nissFamiliar').innerHTML ='';
            }
            opener.document.getElementById('hiddenIdUtenteParaTrocar').value=document.getElementById('hiddenIdBenef').value;  
            opener.document.getElementById('hiddenSubmitIEntidadeResponsavel').value= document.getElementById("hiddenEntidadeBenef").value;
            opener.document.getElementById('hiddenIduHistEntUtID').value= document.getElementById("hiddenEntidadeBenefId").value; //id da entidade responsável - este é o campo que passa o id para a gravação da baixa
            opener.document.getElementById('hiddenBaixasIduHistEntUtID').value= document.getElementById("hiddenEntidadeBenefId").value; 
            opener.document.getElementById('entResp').value= document.getElementById("hiddenEntidadeBenef").value;
            opener.document.getElementById('hiddenNumBeneficiario').value= document.getElementById('textNissBenef').value;
            opener.document.getElementById('hiddenNumBeneficiario_form').value= document.getElementById('textNissBenef').value;
            //opener.changeSelectedEntidade(opener.document.getElementById('entResp'));
            
            opener.document.getElementById('inputFamiliarIdParentesco').value = parentescoId;
            opener.document.getElementById('inputFamiliarOutroParentesco').value = outroParentesco;
            //Seleccionar texto de parentesco a colocar na pagina pai
            if (outroParentesco != "") {
                opener.document.getElementById('parentescoFamiliar').innerHTML = outroParentesco;
                opener.document.getElementById('inputFamiliarOutroParentescoTexto').value = outroParentesco;               
            } else {
                opener.document.getElementById('parentescoFamiliar').innerHTML = parentescoDesc;
                opener.document.getElementById('inputFamiliarOutroParentescoTexto').value = parentescoDesc;
            }
            
            opener.document.getElementById('inputnissFamiliarImpedido').value = document.getElementById('hiddenNissImpedido').value;
            opener.document.getElementById('nissFamiliarImpedido').innerHTML = document.getElementById('hiddenNissImpedido').value;
            
             opener.document.getElementById('idIdentUt').value = document.getElementById('hiddenIdBenef').value;
             //e informar ao sistema se é EPUB ou ERES. O index de segurança social é -1
              if (document.getElementById('hiddenEntidadeBenef').value == '-1') {
                opener.document.getElementById('entidadePublica').value = 'ERES';
             } else {
                 opener.document.getElementById('entidadePublica').value = 'EPUB';
             }
             
            
              //Se tipo da doença for AM (assistência a menores de 10 anos) e o sistema for Seg Secial, passa a tipo de doença DM (Assiestência a Familiares)
            if (document.getElementById('hiddenEntidadeBenef').value == '-1' && 
                    (opener.hashTipoDoenca[opener.document.getElementById('selectClassDoenca').value]=='AM' ||
                    opener.hashTipoDoenca[opener.document.getElementById('selectClassDoenca').value]=='DF')) {
                //opener.document.getElementById('selectClassDoenca').value=opener.hashTipoDoenca.indexOf('DF');
                 opener.document.getElementById('isDFinput').value = "true";
                
            } 
            
            opener.document.getElementById('hiddenListaBaixas').value = 'actualizaEcran';
            window.opener.document.getElementById("formBaixa").submit();
            self.close();
            return true;
        }
        
        
        function preencheCampos() {
            document.getElementById('hiddenSeleccionaFamilia').value = opener.document.getElementById('inputFamiliarSelected').value;
            if (document.getElementById('hiddenSeleccionaFamilia').value == 'selected') {
                enableButton(document.getElementById('event_seleccionaAgregado'));
            }
            document.getElementById('hiddenIdBenef').value = opener.document.getElementById('inputFamiliarId').value;
            document.getElementById('hiddenNomeBenef').value = opener.document.getElementById('inputFamiliarNome').value;
            document.getElementById('textNomeBenef').value = opener.document.getElementById('inputFamiliarNome').value;
            
            document.getElementById('hiddenDtaNascBenef').value = opener.document.getElementById('inputFamiliarDtaNasc').value;
            document.getElementById('textDtaNascBenef').value = opener.document.getElementById('inputFamiliarDtaNasc').value;
            
            document.getElementById('hiddenNissBenef').value = opener.document.getElementById('inputFamiliarNiss').value;
            document.getElementById('textNissBenef').value = opener.document.getElementById('inputFamiliarNiss').value;
            
            document.getElementById('hiddenNissImpedido').value = opener.document.getElementById('inputnissFamiliarImpedido').value;
            document.getElementById('textNissImpedido').value = opener.document.getElementById('inputnissFamiliarImpedido').value;    
            
            var selectBoxParentesco = document.getElementById("selectParentesco");
            var parentescoId = opener.document.getElementById('inputFamiliarIdParentesco').value;
            for (var i=0; i < selectBoxParentesco.length; i++){
                if (selectBoxParentesco.options[i].value == parentescoId) {
                    selectBoxParentesco.options[i].selected = true;
                    var isOutroParentesco = verificaSeEOutroGrauParentesco();
                    if (isOutroParentesco) {
                        document.getElementById('OutroGrauParentesco').value = opener.document.getElementById('inputFamiliarOutroParentescoTexto').value;    
                    }
                }
            }
        }
        
        function closePopUp () {
            cleanPopUpFamiliarSeleccionado(opener);
            self.close();    
        }
        
        function verificaSeEOutroGrauParentesco(){
            var parentescoValue = document.getElementById("selectParentesco").value;
            var parentescoId    = parentescoValue;
            
            if( parentescoId =='<%= request.getSession(false).getAttribute("GitidOutroGrauParentesco") %>'){    
                document.getElementById("divOutroGrauParentesco1").style.display = "";
                return true;
            } else {
                document.getElementById("divOutroGrauParentesco1").style.display = "none";
                document.getElementById('OutroGrauParentesco').value = "";
                return false;
            }
        }
        
        function mudaMetodoProcura (metodoProcura) {
            if (metodoProcura == 'divPesquisaAgregadoFamiliar') {
               document.getElementById("divPesquisaAgregadoFamiliar").style.display = ""; 
               document.getElementById("divPesquisaUtenteCentral").style.display = "none"; 
               document.getElementById("divPesquisaInsercaoManual").style.display = "none"; 
               document.getElementById("divNissFamImpedido").style.display = "none";
            } else if (metodoProcura == 'divPesquisaUtenteCentral') {
               document.getElementById("divPesquisaAgregadoFamiliar").style.display = "none"; 
               document.getElementById("divPesquisaUtenteCentral").style.display = ""; 
               document.getElementById("divPesquisaInsercaoManual").style.display = "none"; 
               document.getElementById("divNissFamImpedido").style.display = "none";
            } else if (metodoProcura == 'divNissFamImpedido') {
               document.getElementById("divPesquisaAgregadoFamiliar").style.display = "none"; 
               document.getElementById("divPesquisaUtenteCentral").style.display = "none"; 
               document.getElementById("divPesquisaInsercaoManual").style.display = "none";
               document.getElementById("divNissFamImpedido").style.display = "";
            }
            escondeErro();
        }
        
        function procurarNovoUtente () {
            document.getElementById("divPesquisaUtente").style.display = "none"; 
            document.getElementById("divPesquisaUtenteForm").style.display = "";     
        }
        
        function passarNissFamImpedido () {
            document.getElementById('hiddenNissImpedido').value =  document.getElementById('famNissImpedido').value;
            document.getElementById('textNissImpedido').value =  document.getElementById('famNissImpedido').value;           
        }
        
        function checkDate(data){
            if (data == '') {
                return true;
            }
            return Date.isValid(data,'dd-MM-yyyy');
        }
        
        //Verifica se a data fornecida é anterior à data actual. Se sim, retorna true.
        function dateBeforeToday(date) {
            var dataH = new Date();
            var diaHoje = dataH.getUTCDate();
            var mesHoje = dataH.getMonth() + 1; // +1 porque os meses começam em 0

            if(mesHoje<10){
                mesHoje = '0' + mesHoje;
            }
            var anoHoje = dataH.getFullYear();
            var dataHoje = diaHoje + '-' + mesHoje + '-' + anoHoje;
            
            var dateObject1 = Date.parseString (date,"dd-MM-yyyy");
            var dateObject2 = Date.parseString (dataHoje,"dd-MM-yyyy");
            
            var one_day=1000*60*60*24;
            var diffData = Math.floor((dateObject1.getTime()-dateObject2.getTime())/(one_day));

            if(diffData>0){
                return false;
            }
            return true;
        }
        
        function verificarData(campoData){
            if (!checkDate(campoData.value)) {
                //alert('Data introduzida inválida!');
                $.spmsDialog('warning', { title: 'Data', message: 'Data introduzida inválida!'});
                campoData.value='';
            }else if(!dateBeforeToday(campoData.value)){
                //alert('Insira uma data inferior ou igual à de hoje!');
                $.spmsDialog('warning', { title: 'Data', message: 'Insira uma data inferior ou igual à de hoje!'});
                campoData.value='';
            }
        }

        function populateDivPesquisaUtenteHTML() {

             if (request.readyState == 4) { 
                  if (request.status == 200) { 
                     text = request.responseText;
                     
                     if(text == '-1'){
                        //alert("Erro ao obter valores.");
                        $.spmsDialog('warning', { title: 'Erro', message: 'Erro ao obter valores.'});
                        return true;
                     } else {
                        document.getElementById('divPesquisaUtente').innerHTML = text;
                        document.getElementById("divPesquisaUtenteForm").style.display = "none";
                        document.getElementById("divPesquisaUtente").style.display = "";
                     }
                  }
                } else {
                    document.getElementById('divPesquisaUtente').innerHTML = '<img src="../imagens_cit_v3/ajax-loader.gif" alt="Loading..." />';
                }
                 return true;
        }
        
        function populateDivPesquisaUtente() {
            var params = "";
            
            var nirUtente = document.getElementById('pesquisaUtenteNir');
            if (nirUtente.value != '') {
                params = params + '&pNirUtente=' + nirUtente.value;
            }
            var nomeUtente = document.getElementById('pesquisaUtenteNome');
            if (nomeUtente.value != '') {
                params = params + '&pNomeUtente=' + nomeUtente.value;
            }
            var dtaNascUtente = document.getElementById('pesquisaUtenteDtaNasc');
            if (dtaNascUtente.value != '') {
                params = params + '&pDtaNasc=' + dtaNascUtente.value;
            }
            var nissUtente = document.getElementById('pesquisaUtenteNiss');
            if (nissUtente.value != '') {
                params = params + '&pNiss=' + nissUtente.value;
            }
            
            params=params+"&pTipoPesq=Benef"
            
            if (params == '') {
                //alert("Por favor, introduza pelo menos um critério de pesquisa.");
                $.spmsDialog('warning', { title: 'Aviso', message: 'Por favor, introduza pelo menos um critério de pesquisa.'});
            } else {
                httpRequestSplashOption("GET", "../com/ajaxServices.do?event=GitPesquisaUtenteBaixaFamiliar"+params, true, populateDivPesquisaUtenteHTML, false);
            }
        }

        String.prototype.trim = function() {
            return this.replace(/^\s+|\s+$/g,"");
        }
        
        function validaNissImpedido() {
             if (request.readyState == 4) { 
                  if (request.status == 200) { 
                     text = request.responseText;
                     
                     if(text == '-1'){
                        //alert("Erro ao validar niss.");
                        $.spmsDialog('warning', { title: 'Aviso', message: "Erro ao validar niss."});
                        return true;
                     } else {
                        var div = document.getElementById('divEsperaNissFamiliarImpedido');
                        div.innerHTML = '';
                        div.style.display = "none";
                        if(text.trim()=='true'){
                            escondeErro();
                            passarNissFamImpedido();
                        } else {
                            mostraErro("NISS Inválido. Por favor, introduza um NISS válido.");
                            document.getElementById('famNissImpedido').focus();
                        }
                     }
                  }
               } else {
                    var div = document.getElementById('divEsperaNissFamiliarImpedido');
                    div.innerHTML = '<img src="../imagens_cit_v3/ajax-loader.gif" alt="Loading..." />';
                    div.style.display = "block";
               }
             return true;
        }
        
        function validaNiss() {
             if (request.readyState == 4) { 
                  if (request.status == 200) { 
                     text = request.responseText;
                     
                     if(text == '-1'){
                        //alert("Erro ao validar NISS.");
                        $.spmsDialog('warning', { title: 'Erro', message: 'Erro ao validar NISS.'});
                        return true;
                     } else {
                        var div = document.getElementById('divEsperaInsercaoManual');
                        div.innerHTML = '';
                        div.style.display = "none";
                        if(text.trim()=='true'){
                            escondeErro();
                            passarUtenteManual();
                        } else {
                            mostraErro("NISS Inválido. Por favor, introduza um NISS válido.");
                            document.getElementById('manualNiss').focus();
                        }
                     }
                  }
               } else {
                    var div = document.getElementById('divEsperaInsercaoManual');
                    div.innerHTML = '<img src="../imagens_cit_v3/ajax-loader.gif" alt="Loading..." />';
                    div.style.display = "block";
               }
             return true;
        }
        
        function actualizaComboEntidades() {
             if (request.readyState == 4) { 
                  if (request.status == 200) { 
                     text = request.responseText;
                     if(text == '-1'){
                        //alert("Erro ao obter entidades.");
                        $.spmsDialog('warning', { title: 'Erro', message: 'Erro ao obter entidades.'});
                        return true;
                     } else {
                        var tr = document.getElementById('trEntidades');
                        tr.innerHTML = '';
                        if(text.trim()!=''){
                           tr.innerHTML = text;
                        } 
                        document.getElementById('trEntidadesDummy').style.display='none';
                        retiraNumBenef(document.getElementById('entResp').value);
                        
                        adicionarWarning(document.getElementById('entResp'));
                       
                     }
                  }
               } else {
               }
             return true;
        }
        
        function adicionarWarning(selectObject){
             //adiciona msgs de warning manualmente uma vez que não é feito o refresh da página
             //só se o utente tiver mais que duas entidades activas
             if(selectObject.length>1){
                     var content = document.getElementById('contentDiv');
                     var divWarning =  document.createElement('div');
                     divWarning.setAttribute("id", "divWarning");
                     divWarning.innerHTML="<p class='msgParentCont'><span class='warningMessageLabel'>Atenção:<//span><//p><p class='msgChildCont'><span class='warningMessageText'>O utente tem mais do que uma entidade responsável válida para a emissão do CIT, por favor, confirme a entidade responsável selecionada.<//span><//p>"
                        
                     content.insertBefore(divWarning, content.firstChild);
                }
        }
        
        function escondeErro(){
            divErro = document.getElementById("mensagem");
            if(divErro){
                divErro.innerHTML = "";
                divErro.style.display = "none";
            }
        }
        
        function mostraErro(erro){
            divErro = document.getElementById("mensagem");
            if(divErro){
                divErro.innerHTML = "<table><tr><td style='color:red;'><b>Erro: <\/b>"+erro+"<\/td><\/tr><\/table>";
                divErro.style.display = "block";
            }
        }
        
        function validaValoresUtenteManual() {
            // validar se nome está preenchido, caso contrário alerta para valor obrigatório
             var manualNome = document.getElementById('manualNome');
             var nomeNormal = document.getElementById('nomeNormal');
            if(manualNome.value.trim().length==0){
                //alert("O campo 'Nome' é de preenchimento obrigatório.");
                $.spmsDialog('warning', { title: 'Aviso', message: 'O campo \'Nome\' é de preenchimento obrigatório.'});
                return false;
            } else {
            
                // validar se data de nascimento esta preenchida quando NISS não é preenchido
                if(document.getElementById('manualDtaNasc').value.trim().length==0 && document.getElementById('manualNiss').value.trim().length==0){
                    //alert("O campo 'Data Nasc.' é de preenchimento obrigatório caso não seja preenchidoo NISS.");
                    $.spmsDialog('warning', { title: 'Data', message: "O campo 'Data Nasc.' é de preenchimento obrigatório caso não seja preenchidoo NISS."});
                    return false;
                }
            
                // validar se nome de utente em sessao é diferente de nome de utente de familiar manual inserido               
                var nomeUtenteSessao = "${bindings.InformacaoUtente.Nomenormalizado}";
                
                if(nomeUtenteSessao.trim() == nomeNormal.value.trim()){

                    var answer = false;

                    $.spmsDialog( 'confirm', { 
                        title: 'Atenção', 
                        message: "Atenção: O nome do familiar doente é igual ao nome do beneficiário. Deseja gravar os dados?", 
                        callback: function() { answer = true; } 
                    });

                    if (!answer) return false;

                    //if(!confirm("Atenção: O nome do familiar doente é igual ao nome do beneficiário. Deseja gravar os dados?")){ return false; }
                }
            }
                        
            var niss = document.getElementById("manualNiss").value;
            var params = '&niss=' + niss;
            
            // se niss introduzido validar niss
            if(niss.trim().length>0){
                httpRequestSplashOption("GET", "../com/ajaxServices.do?event=validaNiss"+params, true, validaNiss, false);
            } else {
                passarUtenteManual();
            }
        }
        
        function validaValoresNissImpedido() {
                         
            var niss = document.getElementById("famNissImpedido").value;
            var params = '&niss=' + niss;
            
            // se niss introduzido validar niss
            if(niss!=''){
                httpRequestSplashOption("GET", "../com/ajaxServices.do?event=validaNiss"+params, true, validaNissImpedido, false);
            } else {
                //alert("O campo 'NISS' é de preenchimento obrigatório.");
                $.spmsDialog('warning', { title: 'Aviso', message: "O campo 'NISS' é de preenchimento obrigatório."});
                return false;
            }
        }
        
        
        function actualizaEntidades(idUtente) {
                         
            var params = '&idUtente=' + idUtente;
            var divWarning = document.getElementById("divWarning");
            if(divWarning){
                divWarning.innerHTML='';
            }
            
            // se niss introduzido validar niss
            if(idUtente!=''){
                httpRequestSplashOption("GET", "../com/ajaxServices.do?event=getEntidadesResponsaveis"+params, true, actualizaComboEntidades, false);
            } else {
                return false;
            }
        }
        
        function limparFamiliarSeleccionado(){
             document.getElementById('hiddenNomeBenef').value = '';
             document.getElementById('textNomeBenef').value = '';
             document.getElementById('hiddenSeleccionaFamilia').value = '';
             document.getElementById('hiddenIdBenef').value = '';
             document.getElementById('hiddenDtaNascBenef').value = '';
             document.getElementById('textDtaNascBenef').value = '';
             document.getElementById('hiddenNissBenef').value = '';
             document.getElementById('textNissBenef').value = '';
             document.getElementById('selectParentesco').value = '0';
             document.getElementById('OutroGrauParentesco').value = '';
             document.getElementById('textNissImpedido').value = '';
             document.getElementById('hiddenNissImpedido').value = '';
             document.getElementById('hiddenNumUtenteBenef').value = '';
             document.getElementById('numUtenteBenef').value = '';
             document.getElementById('hiddenEntidadeBenef').value = '';
             document.getElementById('hiddenEntidadeBenefId').value = '';
            
             document.getElementById('trEntidades').innerHTML = '';
             document.getElementById('trEntidadesDummy').style.display='block';

             $('.highlight').removeClass('highlight');
             
             var divWarning = document.getElementById("divWarning");
             if(divWarning){
                divWarning.innerHTML='';
             }
             
             cleanPopUpFamiliarSeleccionado(opener);
             disableButton(document.getElementById('event_seleccionaAgregado'));
        }
        
        function retiraNumBenef (EntidadeNumero){
            var res = EntidadeNumero.split(";");
            document.getElementById('hiddenNissBenef').value = res[1];
            document.getElementById('textNissBenef').value = res[1];
            document.getElementById('hiddenEntidadeBenef').value = res[0];
            document.getElementById('hiddenEntidadeBenefId').value = res[2];
        }

          
      
        
    </script>

    <%-- <jsp:include page="/com/head.jsp" flush="true"/> --%>

     <% String contextPath = request.getContextPath().replaceAll("/",""); %>
    <link rel="stylesheet" type="text/css" href="/<%=contextPath%>/css_cit_v3/datepicker.css" title="style"/>
    <link rel="stylesheet" type="text/css" href="/<%=contextPath%>/css_cit_v3/spmsDialog.css" title="style"/>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/spmsDialog.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/breadcrumb.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/highlight.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/date.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/datepicker.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/igif.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/xp_progress.js"></script>    
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/ajaxcore.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/popups.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/pesquisa.js"></script>
    <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/git.js"></script>

    <link href="../css_cit_v3/spms-grid.css" rel="stylesheet" type="text/css" />
    <link href="../css_cit_v3/spms-theme.css" rel="stylesheet" type="text/css" />

    <style type="text/css" media="Screen"> 
        body { margin: 0; margin-bottom: 25px; font: 12px "arial"; background-color: #e8e8e8; }
        .spms { width: 100%; }
        ul.tabnav li { width: 25%; } /* 100/4=25 */
    </style>

    <script type="text/javascript" src="../js_cit_v3/tabnavigation.js"></script>  

  </head>

<body onload="preencheCampos(); /*splash(false);*/">

    <%--
    <jsp:include page="/com/lovHeader.jsp" flush="true">
        <jsp:param name="pTitleLov" value="Pesquisar Beneficiário"/>
    </jsp:include> 
    --%>
  
<form method="POST" onsubmit="splash(true);" action="">

<input type="hidden" id="mudarBeneficiario" name="mudarBeneficiario" value="${param.mudarBeneficiario}"/>
<input type="hidden" name="hiddenBiFamiliar" id="hiddenBiBenef" value=""/>  
<input type="hidden" name="hiddenNirFamiliar" id="hiddenNirBenef" value=""/>  

<div class="spms" id="inputForm"> 

    <div class="header">Pesquisa de familiar</div>
    
    <div style="margin-left:20px">
        <jsp:include page="/com/error.jsp" flush="true"/>
    </div>

    <div class="fixed-footer">

        <input type="button" class="spms-toolbar-button right" value="Cancelar"onclick="closePopUp();"/>

        <input type="button" class="spms-toolbar-button right" value="Guardar" disabled onclick="verificaSeleccao();" id="event_seleccionaAgregado" name="event_seleccionaAgregado" style="" />

        <input type="button" class="spms-toolbar-button right" value="Limpar"onclick="limparFamiliarSeleccionado();" />

    </div>
  
    <!--
    <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
    <thead/>
    <tbody>
        <tr>
            <td>
            <input class="submitButton buttonDisabled" 
                   id="event_seleccionaAgregado" 
                   name="event_seleccionaAgregado" 
                   type="button"
                   onclick="verificaSeleccao();"
                   value="Seleccionar" disabled/>
            <input class="submitButton" type="button"  value="Limpar" onclick="limparFamiliarSeleccionado();"/>
            <input class="submitButton" type="button"  value="Cancelar" onclick="closePopUp();"/>
            </td>
        </tr>
    </tbody>
    </table>
    -->

    <div class="container">        

        <div class="row">
            <div class="col-1"><div class="subtitle">IDENTIFICAÇÃO DO BENEFICIÁRIO</div></div>
        </div>

        <div class="row">

            <div class="col-1-4"> 
                <div class="labelfield">Nº utente</div> 
                <input class="inputfield newinput" id="numUtenteBenef" name="numUtenteBenef" value="${param['numUtenteBenef']}" type="text" disabled /> 
                <input id="hiddenNumUtenteBenef" name="hiddenNumUtenteBenef" value="${param['hiddenNumUtente']}" type="hidden" />
            </div>

            <div class="col-3-4" style="*width: 22%;"> 
                <div class="labelfield">Nome</div> 
                <input class="inputfield newinput" id="textNomeBenef" name="textNomeBenef" value="${param['textNomeBenef']}" type="text" disabled /> 
                <input type="hidden" id="hiddenSeleccionaFamilia" name="hiddenSeleccionaFamilia" value=""/>
                <input type="hidden" id="hiddenIdBenef" name="hiddenIdBenef" value=""/>
                <input type="hidden" id="hiddenNomeBenef" name="hiddenNomeBenef" value="${param['hiddenNomeBenef']}" />          
            </div>

        </div>

        <div class="row">
            <div class="col-1-4"> 
                <div class="labelfield">Data de nascimento</div> 
                <input type="text" class="inputfield newinput" id="textDtaNascBenef" name="textDtaNascBenef" value="${param.hiddenDtaNascBenef}" disabled/>
                <input type="hidden" id="hiddenDtaNascBenef" name="hiddenDtaNascBenef" value="${param.hiddenDtaNascBenef}" />
            </div>
            <div class="col-2-4"> 
                <div class="labelfield">Entidade responsável</div> 
                <div id="trEntidades"></div>
                <!--<input class="inputfield newinput" id="" name="" value="" disabled /> -->
                <div id="trEntidadesDummy"><select class="selectfield inputChoiceFour" id="entRespDummy" name="entResp" disabled="disabled"> <option/> </select></div>
                 <input  id="hiddenEntidadeBenef" name="hiddenEntidadeBenef" value="${param['hiddenEntidadeBenef']}" type="hidden"/> 
                 <input  id="hiddenEntidadeBenefId" name="hiddenEntidadeBenefId" value="${param['hiddenEntidadeBenefId']}" type="hidden"/>
            </div>
            <div class="col-1-4"> 
                <div class="labelfield">Nº beneficiário</div> 
                <input type="text" class="inputfield newinput" id="textNissBenef" name="textNissBenef" value="${param['hiddenNissBenef']}" disabled maxlength="30"/> 
                <input type="hidden" id="hiddenNissBenef" name="hiddenNissBenef" value="${param['hiddenNissBenef']}" />      
            </div>
        </div>

        <div class="row">
            <div class="col-2-4"> 
                <div class="labelfield">Parentesco</div> 
                <select id="selectParentesco" class=" selectfield inputChoiceFour" name="selectParentesco" onchange="verificaSeEOutroGrauParentesco();">
                <option value="0"><c:out value="Seleccione um parentesco com o beneficiário"/></option>
                <c:forEach var="RowListaCodigosGenericosPARE" items="${bindings.ListaCodigosGenericos1.rangeSet}">
                <option value="<c:out value="${RowListaCodigosGenericosPARE[\'Id\']}"/>">
                <c:out value="${RowListaCodigosGenericosPARE[\'Descricao\']}"/>
                </option>
                </c:forEach>
                </select>
            </div>
            <div class="col-1-4"> 
                <div class="labelfield">.</div> 
                <div id="divOutroGrauParentesco1" style="display:none;" >
                    <input type="text" class="inputTextTwo" name="OutroGrauParentesco" id="OutroGrauParentesco" value="" maxlength="100"/>
                </div>
            </div>
            <div class="col-1-4"> 
                <div class="labelfield">NISS fam. impedido</div> 
                <input type="text" class="inputfield newinput" id="textNissImpedido" name="textNissImpedido" value="" maxlength="30" disabled style="width: 85%; float: left; margin-right: 5px;"/>
                <img alt=""  title="Deverá preencher o NISS do progenitor impedido de prestar assistência, se o beneficiário for o avô/avó ou equiparado do familiar doente."  style="padding-left:2px;padding-right:2px;padding-top:1px;margin-top: 4px;" src="../imagens_cit_v3/info.png" align="top" />
                <input type="hidden" name="hiddenNissImpedido" id="hiddenNissImpedido" value=""/>  
            </div>
        </div>

        <!-- TABS --> 
        <div id="tabcontainer" class="tabcontainer">
            <ul class="tabnav">
              <li><a href="#" onclick="escondeErro();" class="active">Agregado familiar</a></li>
              <li><a href="#" onclick="escondeErro();" class="inactive">Pesquisa utente</a></li>
              <li style="*width: 24%;"><a href="#" onclick="escondeErro();" class="inactive">NISS familiar impedido</a></li>
              <li><a href="#" onclick="escondeErro();" style="display: none;" class="inactive">Inserção utente</a></li>
            </ul>
        </div>

        <div class="border" style="*width: 98%;"></div>

        <div id="mensagem" style="display:none;"></div>

        <script type="text/javascript">
            var idUtenteSessao = '<% out.print(request.getAttribute("idUtenteSessao")); %>';
        </script>

        <!-- AGREGADO FAMILIAR --> 
        <div id="" class="tabcontent active">

            <div class="row">
                <div class="col-1">
                    <div class="subtitle">AGREGADO DO BENEFICIÁRIO</div>
                </div>
            </div>

            <div class="row">

                <table  id="readOnlyTable" class="spms-table" cellpadding="0" cellspacing="0" border="0">

                    <thead>
                        <tr class="head">
                            <th class="numeric">
                                <c:out value="${bindings.ListaAgregadoFamiliar.labels[\'Nutente\']}"/></th>
                            <th class="text">
                                <c:out value="${bindings.ListaAgregadoFamiliar.labels[\'NomeCompleto\']}"/>
                            </th>
                            <th class="date">
                                <c:out value="${bindings.ListaAgregadoFamiliar.labels[\'DtaNasc\']}"/>
                            </th>  
                            <th class="text last">NISS</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="RowListaAgregadoFamiliar" items="${bindings.ListaAgregadoFamiliar.rangeSet}" varStatus="lineListaAgregadoFamiliar">
                        <c:choose>
                            <c:when test="${lineListaAgregadoFamiliar.count % 2 != 0}">
                            <c:set var="trClassAgregado" value="even"/>
                            </c:when>   
                            <c:otherwise>
                            <c:set var="trClassAgregado" value="odd"/>
                            </c:otherwise>
                        </c:choose>

                            <tr class="${trClassAgregado}"onClick="
                                trClicked(
                                    this, 
                                    { 
                                        Nutente: '<c:out value="${RowListaAgregadoFamiliar[\'Nutente\']}"/>', 
                                        HasNutente: <c:out value="${not empty RowListaAgregadoFamiliar.Nutente}"/>, 
                                        DtaNasc: '<c:out value="${RowListaAgregadoFamiliar[\'DtaNasc\']}"/>', 
                                        NomeNormalizado: '<c:out value="${RowListaAgregadoFamiliar[\'NomeNormalizado\']}"/>', 
                                        NomeCompleto: '<c:out value="${RowListaAgregadoFamiliar[\'NomeCompleto\']}"/>', 
                                        Niss: '<c:out value="${RowListaAgregadoFamiliar[\'Niss\']}"/>', 
                                        IduIdentUtId: '<c:out value="${RowListaAgregadoFamiliar[\'IduIdentUtId\']}"/>',
                                        Numbenef: '<c:out value="${RowListaAgregadoFamiliar[\'Numbenef\']}"/>',
                                        Bi: '<c:out value="${RowListaAgregadoFamiliar[\'Bi\']}"/>',
                                        Count: ${lineListaAgregadoFamiliar.count}
                                    }
                                );">
                                <td class="numeric"><c:out value="${RowListaAgregadoFamiliar[\'Nutente\']}"/></td>
                                <td class="text"><c:out value="${RowListaAgregadoFamiliar[\'NomeCompleto\']}"/></td>
                                <td class="date"><c:out value="${RowListaAgregadoFamiliar[\'DtaNasc\']}"/></td>
                                <td class="text last"><c:out value="${RowListaAgregadoFamiliar[\'Niss\']}"/></td>

                            </tr>
                        </c:forEach>

                        <tr class="navigation">
                            <td colspan="5"></td>
                        </tr>

                    </tbody>
                </table>
            </div>

        </div>

        <!--  PESQUISA UTENTE --> 
        <div id="" class="tabcontent inactive">

            <div class="row">
                <div class="col-1">
                    <div class="subtitle">PESQUISA DE UTENTE</div>
                </div>
            </div>

            <div id="divPesquisaUtenteForm">

                <div class="row">
                    <div class="col-1-4">
                        <div class="labelfield">Nº utente</div> 
                        <!--<div class="inputfield" id="pesquisaUtenteNir"></div> -->
                        <input type="text" class="inputfield inputTextTwo" id="pesquisaUtenteNir" name="pesquisaUtenteNir" value=""/>
                        </div>
                        <div class="col-3-4" style="*width: 71%;">
                        <div class="labelfield">Nome</div> 
                        <input type="text" class="inputfield inputTextSix" id="pesquisaUtenteNome" name="pesquisaUtenteNome" value=""/>

                    </div>
                </div>

                <div class="row">
                    <div class="col-1-4">
                        <div class="labelfield">Data de nasc. </div> 
                            <input type="text"
                              id="pesquisaUtenteDtaNasc" name="pesquisaUtenteDtaNasc"
                              onchange="verificarData(this);"
                              class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" 
                              onkeypress="valData(this,event);" 
                              onkeyup="valData(this,event);" 
                              onblur="valData(this,event);"
                              maxlength="10" style="width: 80%; margin-right: 5px;" />
                        </div>
                    <div class="col-1-4">
                        <div class="labelfield inputTextTwo">NISS</div> 
                        <input type="text" class="inputfield" name="pesquisaUtenteNiss" id="pesquisaUtenteNiss" value=""/>
                    </div>
                    <div class="col-1-6">
                        <div class="labelfield"></div> 
                        <input type="button" class="spms-button" id="event_pesquisaUtente" name="event_pesquisaUtente" value="Pesquisa" onclick="populateDivPesquisaUtente();" style="width: 100px"></input>
                    </div>
                    <div class="col-1-4">
                        <div class="tfill"></div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div id="divPesquisaUtente" style="display: none;"> </div>
            </div>

        </div>


       <!-- NISS FAMILIAR IMPEDIDO --> 
        <div id="" class="tabcontent inactive">

            <div id="divEsperaNissFamiliarImpedido" style="display: none;"></div> 

            <div class="row">
                <div class="col-1">
                    <div class="subtitle">INFORMAÇÃO SOBRE FAMILIAR IMPEDIDO</div>
                </div>
            </div>

            <div class="row">

                <div class="col-1-4">
                    <div class="labelfield">NISS</div> 
                    <input type="text" class="inputfield inputTextTwo" name="famNissImpedido" id="famNissImpedido" value=""/>
                </div>

                <div class="col-1-6">
                    <div class="labelfield"></div> 
                    <input type="button" class="spms-button" onclick="validaValoresNissImpedido();" value="Inserir NISS" style="width: 100px;"></input>
                </div>

                <div class="col-1-4">
                    <div class="tfill"></div>
                </div>

            </div>

        </div>

    </div> <!-- #end .container -->

</div> <!-- #end .spms -->
  
  
</form> 
  
      <script type="text/javascript">
        
        function passarUtenteManual () {
            document.getElementById('hiddenIdFamiliar').value = '';
            document.getElementById('hiddenDtaNascFamiliar').value = '';
            document.getElementById('textDtaNascFamiliar').value = '';
            document.getElementById('hiddenNissFamiliar').value = '';
            document.getElementById('textNissFamiliar').value = '';
            document.getElementById('hiddenNomeFamiliar').value = '';
            document.getElementById('textNomeFamiliar').value = '';
            document.getElementById('hiddenSeleccionaFamilia').value = 'selected';    
            document.getElementById('hiddenNomeFamiliar').value = document.getElementById('manualNome').value.toUpperCase();
            document.getElementById('textNomeFamiliar').value = document.getElementById('manualNome').value.toUpperCase();
            document.getElementById('hiddenDtaNascFamiliar').value = document.getElementById('manualDtaNasc').value;
            document.getElementById('textDtaNascFamiliar').value = document.getElementById('manualDtaNasc').value;
            document.getElementById('hiddenNissFamiliar').value = document.getElementById('manualNiss').value;  
            document.getElementById('textNissFamiliar').value = document.getElementById('manualNiss').value;
            enableButton(document.getElementById('event_seleccionaAgregado'));
            //alert('Utente inserido com sucesso.');
            $.spmsDialog('warning', { title: 'Sucesso', message: 'Utente inserido com sucesso'});
        }
        
        if(document.body.innerHTML.indexOf('Utente inserido com sucesso.')>=0 && document.body.innerHTML.indexOf('Utente inserido com sucesso.')<5000){
            passarUtenteManual();
        }

        function trClicked(self, data) {

            /*
            Nutente: '<c:out value="${RowListaAgregadoFamiliar[\'Nutente\']}"/>', 
            HasNutente: <c:out value="${not empty RowListaAgregadoFamiliar.Nutente}"/>, 
            DtaNasc: '<c:out value="${RowListaAgregadoFamiliar[\'DtaNasc\']}"/>', 
            NomeNormalizado: '<c:out value="${RowListaAgregadoFamiliar[\'NomeNormalizado\']}"/>', 
            NomeCompleto: '<c:out value="${RowListaAgregadoFamiliar[\'NomeCompleto\']}"/>', 
            Niss: '<c:out value="${RowListaAgregadoFamiliar[\'Niss\']}"/>', 
            IduIdentUtId: '<c:out value="${RowListaAgregadoFamiliar[\'IduIdentUtId\']}"/>',
            Numbenef: '<c:out value="${RowListaAgregadoFamiliar[\'Numbenef\']}"/>',
            Bi: '<c:out value="${RowListaAgregadoFamiliar[\'Bi\']}"/>',
            Count: ${lineListaAgregadoFamiliar.count}
            */

            console.log( data.Niss );

            gData = data;


            //return;

            if ( isNaN(parseInt(data.Niss)) ) {

               $.spmsDialog('warning', 
                    { 
                        title: '', 
                        message: 'O beneficiário selecionado não possui NISS registado no RNU nem outro subsistema válido ativo, sem os quais não é possível emitir um CIT!'
                    }
                );  

               return;
            }

            if ( data.HasNutente ) {

                if ( idUtenteSessao != data.IduIdentUtId ) { 

                    if ( ( data.Niss != '' ) || ( data.Numbenef != '' ) ) {

                        highlightRow( self , data.Count ); 
                        enableButton(document.getElementById('event_seleccionaAgregado')); 

                        document.getElementById('hiddenNumUtenteBenef').value = data.Nutente; 
                        document.getElementById('numUtenteBenef').value = data.Nutente; 
                        document.getElementById('hiddenDtaNascBenef').value = data.DtaNasc; 
                        document.getElementById('textDtaNascBenef').value = data.DtaNasc; 
                        document.getElementById('hiddenNomeBenef').value = data.NomeNormalizado;
                        document.getElementById('textNomeBenef').value = data.NomeNormalizado; 
                        document.getElementById('hiddenNissBenef').value = data.Niss; 
                        document.getElementById('textNissBenef').value = data.Niss; 
                        document.getElementById('hiddenIdBenef').value = data.IduIdentUtId; 
                        document.getElementById('hiddenBiBenef').value = data.Bi; 
                        document.getElementById('hiddenNirBenef').value = data.Nutente; 
                        document.getElementById('hiddenSeleccionaFamilia').value = 'selected'; 
                        actualizaEntidades( data.IduIdentUtId ); 
                    } 
                    else { 
                        $.spmsDialog('warning', 
                            { 
                                title: '', 
                                message: 'O beneficiário selecionado não possui NISS registado no RNU nem outro subsistema válido ativo, sem os quais não é possível emitir um CIT!'
                            }
                        ); 
                    } 
                } 
                else { 
                    $.spmsDialog('warning', 
                        { 
                            title: 'Alerta', 
                            message: 'Não pode seleccionar o mesmo utente para quem está a emitir baixa!'
                        }
                    ); 
                } 
            } else { 
                $.spmsDialog('warning', 
                    { 
                        title: '', 
                        message: 'Não é possível emitir baixas para o beneficiário selecionado. Por favor, verifique os dados do utente no RNU.'
                    }
                ); 
            }
        }
  </script>
  
  </body>
</html>