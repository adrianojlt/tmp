<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<html>
  <head>

    <title>Pesquisa de Familiar CITv3</title>

    <style type="text/css" media="Screen"> 
        body {
            height: 600px;
        }
    </style>

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

    <script type="text/javascript">

        //$(document).ready( function(){limparFamiliarSeleccionado(); });
        
        function enableButton(button) { 
            button.className = 'subCont spms-toolbar-button right';
            button.removeAttribute("disabled");
        }
        
        function disableButton(button) { 
            button.className = 'subCont buttonDisabled spms-toolbar-button right';
            button.addAttribute("disabled");
        }
        
        function selecionar(){

            //if ( $('.highlight').length == 0 ) return; 
            if ( $('.buttonDisabled').length == 1 ) return; 

            var outroParentesco = document.getElementById('OutroGrauParentesco').value.trim();
            var parentescoSelectedIndex = document.getElementById("selectParentesco").selectedIndex;
            var parentescoId = document.getElementById("selectParentesco").options[parentescoSelectedIndex].value; // parentescoArray[0];
            var parentescoDesc = document.getElementById("selectParentesco").options[parentescoSelectedIndex].text;  // document.parentescoArray[1];

            if (parentescoId == 0) {
                //alert('Por favor, indique o grau de Parentesco.');
                $.spmsDialog('warning', { title: '', message: 'Por favor, indique o grau de Parentesco.'});
                document.getElementById("selectParentesco").focus();
                return false;
            }
            
            if (parentescoId == '<%= request.getSession(false).getAttribute("GitidOutroGrauParentesco") %>' && outroParentesco == "" ) {
                //alert('Por favor, indique que outro Parentesco.');
                $.spmsDialog('warning', { title: 'Aviso', message: 'Por favor, indique que outro Parentesco.'});
                document.getElementById('OutroGrauParentesco').focus();
                return false;
            }
            
            opener.document.getElementById('inputFamiliarSelected').value = document.getElementById('hiddenSeleccionaFamilia').value;
            opener.document.getElementById('inputFamiliarNome').value = document.getElementById('hiddenNomeFamiliar').value;
            opener.document.getElementById('nomeFamiliar').innerHTML = document.getElementById('hiddenNomeFamiliar').value;
            opener.document.getElementById('inputFamiliarDtaNasc').value = document.getElementById('hiddenDtaNascFamiliar').value;
            opener.document.getElementById('dtaNascFamiliar').innerHTML = document.getElementById('hiddenDtaNascFamiliar').value;
            opener.document.getElementById('inputFamiliarId').value = document.getElementById('hiddenIdFamiliar').value;
            opener.document.getElementById('inputFamiliarNiss').value = document.getElementById('hiddenNissFamiliar').value;
            opener.document.getElementById('nissFamiliar').innerHTML = document.getElementById('hiddenNissFamiliar').value;
            
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
            
            self.close();
            return true;
        }
        
        function preencheCampos() {
            document.getElementById('hiddenSeleccionaFamilia').value = opener.document.getElementById('inputFamiliarSelected').value;
            if (document.getElementById('hiddenSeleccionaFamilia').value == 'selected') {
                enableButton(document.getElementById('event_seleccionaAgregado'));
            }
            document.getElementById('hiddenIdFamiliar').value = opener.document.getElementById('inputFamiliarId').value;
            document.getElementById('hiddenNomeFamiliar').value = opener.document.getElementById('inputFamiliarNome').value;
            document.getElementById('textNomeFamiliar').value = opener.document.getElementById('inputFamiliarNome').value;
            
            document.getElementById('hiddenDtaNascFamiliar').value = opener.document.getElementById('inputFamiliarDtaNasc').value;
            document.getElementById('textDtaNascFamiliar').value = opener.document.getElementById('inputFamiliarDtaNasc').value;
            
            document.getElementById('hiddenNissFamiliar').value = opener.document.getElementById('inputFamiliarNiss').value;
            document.getElementById('textNissFamiliar').value = opener.document.getElementById('inputFamiliarNiss').value;
            
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
            } else if (metodoProcura == 'divPesquisaInsercaoManual') {
               document.getElementById("divPesquisaAgregadoFamiliar").style.display = "none"; 
               document.getElementById("divPesquisaUtenteCentral").style.display = "none"; 
               document.getElementById("divPesquisaInsercaoManual").style.display = "";
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

            //if ( dateBeforeToday(data) ) {}

            return Date.isValid(data,'dd-MM-yyyy');
        }
        
        //Verifica se a data fornecida é anterior à data actual. Se sim, retorna true.
        function dateBeforeToday(date) {

            //gDate = date;

            var dataH = new Date();
            var diaHoje = dataH.getUTCDate();
            var mesHoje = dataH.getMonth() + 1; // +1 porque os meses começam em 0

            if( mesHoje < 10 ){
                mesHoje = '0' + mesHoje;
            }

            var anoHoje = dataH.getFullYear();
            var dataHoje = diaHoje + '-' + mesHoje + '-' + anoHoje;
            
            var dateObject1 = Date.parseString (date,"dd-MM-yyyy");
            var dateObject2 = Date.parseString (dataHoje,"d-MM-yyyy");
            
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
                $.spmsDialog('warning', { title: 'Aviso', message: 'Data introduzida inválida!'});
                campoData.value='';
            }else if(!dateBeforeToday(campoData.value)){
                //alert('Insira uma data inferior ou igual à de hoje!');
                $.spmsDialog('warning', { title: 'Aviso', message: 'Insira uma data inferior ou igual à de hoje!'});
                campoData.value='';
            }
        }

        function populateDivPesquisaUtenteHTML() {

             if (request.readyState == 4) { 
                  if (request.status == 200) { 
                     text = request.responseText;
                     
                     if(text == '-1'){
                        //alert("Erro ao obter valores.");
                        $.spmsDialog('error', { title: 'Erro', message: 'Erro ao obter valores.'});
                        return true;
                     } else {
                        document.getElementById('divPesquisaUtente').innerHTML = text;
                        document.getElementById("divPesquisaUtenteForm").style.display = "none";
                        document.getElementById("divPesquisaUtente").style.display = "";
                     }
                  }
                } else {
                    var div = document.getElementById('divPesquisaUtente');
                    div.innerHTML = '<img src="../imagens_cit_v3/ajax-loader.gif" alt="Loading..." />';
                    div.style.display = "block";
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
                        $.spmsDialog('error', { title: 'Erro', message: 'Erro ao validar niss.'});
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
                        $.spmsDialog('error', { title: 'Erro', message: 'Erro ao validar NISS.'});
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
            // validar se nome está preenchido, caso contrário aljavascript ignore char inside string  erta para valor obrigatório
        var manualNome = document.getElementById('manualNome');
           var nomeNormalfamiliar = document.getElementById('nomeNormalfamiliar');
           var nomeUtenteOrigem=opener.document.getElementById('hiddenNomeInfoUtente').value;
            if(manualNome.value.trim().length==0){
                //alert("O campo 'Nome' é de preenchimento obrigatório.");
                $.spmsDialog('warning', { title: 'Aviso', message: "O campo 'Nome' é de preenchimento obrigatório."});
                return false;
            } else {
            
                // validar se data de nascimento esta preenchida quando NISS não é preenchido
                if(document.getElementById('manualDtaNasc').value.trim().length==0 && document.getElementById('manualNiss').value.trim().length==0){
                    //alert("O campo 'Data Nasc.' é de preenchimento obrigatório caso não seja preenchidoo NISS.");
                    $.spmsDialog('warning', { title: 'Aviso', message: "O campo 'Data Nasc.' é de preenchimento obrigatório caso não seja preenchidoo NISS."});
                    return false;
                }
            
                // validar se nome de utente em sessao é diferente de nome de utente de familiar manual inserido               
                var nomeUtenteSessao = '${bindings.InformacaoUtente.Nomenormalizado}';

                if(nomeUtenteOrigem.trim() == nomeNormalfamiliar.value.trim()) {

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
        
        function limparFamiliarSeleccionado(){
             document.getElementById('hiddenNomeFamiliar').value = '';
             document.getElementById('textNomeFamiliar').value = '';
             document.getElementById('hiddenSeleccionaFamilia').value = '';
             document.getElementById('hiddenIdFamiliar').value = '';
             document.getElementById('hiddenDtaNascFamiliar').value = '';
             document.getElementById('textDtaNascFamiliar').value = '';
             document.getElementById('hiddenNissFamiliar').value = '';
             document.getElementById('textNissFamiliar').value = '';
             document.getElementById('selectParentesco').value = '0';
             document.getElementById('OutroGrauParentesco').value = '';
             document.getElementById('textNissImpedido').value = '';
             document.getElementById('hiddenNissImpedido').value = '';
             $('.highlight').removeClass('highlight');
             cleanPopUpFamiliarSeleccionado(opener);
             disableButton(document.getElementById('event_seleccionaAgregado'));
        }
        
        function controlAst(){
            if(document.getElementById('manualDtaNasc').value != '' || document.getElementById('manualNiss').value != ''){
                ast_data_nasc.style.visibility = "hidden";
                ast_niss.style.visibility = "hidden";
            }
            else{
                ast_data_nasc.style.visibility = "visible";
                ast_niss.style.visibility = "visible";
            }
        }
        
    </script>
    <%-- <jsp:include page="/com/head.jsp" flush="true"/> --%>

    <link href="../css_cit_v3/spms-grid.css" rel="stylesheet" type="text/css" />
    <link href="../css_cit_v3/spms-theme.css" rel="stylesheet" type="text/css" />

    <style type="text/css" media="Screen"> 
        body { margin: 0; margin-bottom: 25px; font: 14px "arial"; background-color: #e8e8e8; }
        .spms { width: 100%; }
        ul.tabnav li { width: 25%; } /* 100/4=25 */
    </style>

    <script type="text/javascript" src="../js_cit_v3/tabnavigation.js"></script>  

  </head>

<body onload="preencheCampos(); splash(false);">

    <%--
    <jsp:include page="/com/lovHeader.jsp" flush="true">
        <jsp:param name="pTitleLov" value="Pesquisar Familiar Doente"/>
    </jsp:include> 
    --%>
  
  <form method="POST" onsubmit="splash(true);" action="">
  <!--<fieldset></fieldset>-->
    
    <div class="spms">

        <div class="header">Pesquisar familiar doente</div>

        <div class="row message" style="display: none;">
            <img alt=""  title="Deverá preencher o NISS do progenitor impedido de prestar assistência, se o beneficiário for o avô/avó ou equiparado do familiar doente."  style="padding-left:2px;padding-right:2px;padding-top:1 px; margin-top: 4px;" src="../imagens_cit_v3/warning.png" align="top" />
            <span></span>
        </div>


        <div class="container">

            <div class="row">
                <div class="col-1"><div class="subtitle">IDENTIFICAÇÃO DO FAMILIAR DOENTE</div></div>
            </div>

            <div class="row">

                <div class="col-3-4"> 
                    <div class="labelfield">Nome</div> 
                    <input class="inputfield newinput" id="textNomeFamiliar" name="textNomeFamiliar" value="${param['textNomeFamiliar']}" disabled style=""/>
                    <input id="hiddenNomeFamiliar" name="hiddenNomeFamiliar" value="${param['hiddenNomeFamiliar']}" type="hidden" />          
                    <input type="hidden" class="inputTextFour" name="nomeNormalfamiliar" id="nomeNormalfamiliar" value="${param['nomeNormalfamiliar']}" maxlength="100" />
                    <input type="hidden" name="hiddenSeleccionaFamilia" id="hiddenSeleccionaFamilia" value=""/>
                    <input type="hidden" name="hiddenIdFamiliar" id="hiddenIdFamiliar" value=""/>
                </div>

                <div class="col-1-4" style="*width: 22%;"> 
                    <div class="labelfield">Data Nascimento</div> 
                    <input class="inputfield newinput" id="textDtaNascFamiliar" name="textDtaNascFamiliar" value="${param.hiddenDtaNascFamiliar}" disabled /> 
                    <input  id="hiddenDtaNascFamiliar" name="hiddenDtaNascFamiliar" value="${param.hiddenDtaNascFamiliar}" type="hidden"/>
                </div>

            </div>

            <div class="row">

                <div class="col-1-5" style="width: 15%;"> 
                    <div class="labelfield">NISS</div> 
                    <input class="inputfield newinput" id="textNissFamiliar" name="textNissFamiliar" value="${param['hiddenNissFamiliar']}" disabled />
                    <input  id="hiddenNissFamiliar" name="hiddenNissFamiliar" value="${param['hiddenNissFamiliar']}" type="hidden"/>      
                </div>

                 <div class="col-1-5" style=""> 
                    <div class="labelfield">NISS fam. impedido</div> 
                    <input class="inputfield newinput" name="textNissImpedido" id="textNissImpedido" style="width: 80%; float: left; margin-right: 5px;" value="" disabled />
                    <input type="hidden" name="hiddenNissImpedido" id="hiddenNissImpedido" value=""/>
                    <img alt=""  title="Deverá preencher o NISS do progenitor impedido de prestar assistência, se o beneficiário for o avô/avó ou equiparado do familiar doente."  style="padding-left:2px;padding-right:2px;padding-top:1px;margin-top: 4px;" src="../imagens_cit_v3/info.png" align="top" />
                </div>

                <div class="col-1-4" style="width: 40%;" > 
                    <div class="labelfield">Parentesco
                        <span style="color:#cc3333">*</span>
                    </div> 
                    <!--<div class="displayfield">pai</div>-->
                    <select class="selectfield" id="selectParentesco" name="selectParentesco" onchange="verificaSeEOutroGrauParentesco();"> 

                        <option value="0"> <c:out value="Seleccione um parentesco com o beneficiário"/> </option>
                        <c:forEach var="RowListaCodigosGenericosPARE" items="${bindings.ListaCodigosGenericos1.rangeSet}">
                            <option value="<c:out value="${RowListaCodigosGenericosPARE[\'Id\']}"/>">
                                <c:out value="${RowListaCodigosGenericosPARE[\'Descricao\']}"/>
                            </option>
                        </c:forEach>

                    </select>
                </div>

                <div class="col-1-4" style="*width: 19%;">
                    <div class="labelfield">.</div> 
                    <div id="divOutroGrauParentesco1" style="display:none;" >
                        <input type="text" class="inputfield" name="OutroGrauParentesco" id="OutroGrauParentesco" value="" maxlength="100"/>
                    </div> 
                </div>

            </div>

            <div id="tabcontainer" class="tabcontainer">
                <ul class="tabnav">
                  <li><a href="#" onclick="escondeErro();" class="active">Agregado familiar</a></li>
                  <li><a href="#" onclick="escondeErro();" class="inactive">Pesquisa utente</a></li>
                  <li><a href="#" onclick="escondeErro();" class="inactive">Inserção manual</a></li>
                  <li style="*width: 24%;"><a href="#" onclick="escondeErro();" class="inactive">NISS familiar impedido</a></li>
                </ul>
            </div>

            <div class="border" style="*width: 98%;"></div>

            <script type="text/javascript">
                var idUtenteSessao = '<% out.print(request.getAttribute("idUtenteSessao")); %>';
            </script>

            <div id="mensagem" style="display:none;"></div>

            <!-- AGREGADO FAMILIAR --> 
            <div id="" class="tabcontent active">

                <div class="row">
                    <div class="col-1">
                        <div class="subtitle">IDENTIFICAÇÃO DO FAMILIAR DOENTE</div>
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
                <tr class="${trClassAgregado}" onClick="if (idUtenteSessao != <c:out value="${RowListaAgregadoFamiliar[\'IduIdentUtId\']}"/>) {highlightRow(this,${lineListaAgregadoFamiliar.count}); enableButton(document.getElementById('event_seleccionaAgregado')); document.getElementById('hiddenDtaNascFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'DtaNasc\']}"/>'; document.getElementById('textDtaNascFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'DtaNasc\']}"/>'; document.getElementById('hiddenNomeFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'NomeNormalizado\']}"/>'; document.getElementById('textNomeFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'NomeNormalizado\']}"/>'; document.getElementById('hiddenNissFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'Niss\']}"/>'; document.getElementById('textNissFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'Niss\']}"/>'; document.getElementById('hiddenIdFamiliar').value = '<c:out value="${RowListaAgregadoFamiliar[\'IduIdentUtId\']}"/>'; document.getElementById('hiddenSeleccionaFamilia').value = 'selected'; } else { $.spmsDialog('warning', { title:'title', message: 'Não pode seleccionar o mesmo utente para quem está a emitir baixa!'}); }">

                    
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
            <div class="tabcontent inactive">

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
                          <input type="text" class="inputfield" id="pesquisaUtenteNir" name="pesquisaUtenteNir" value=""/>
                        </div>
                        <div class="col-3-4" style="*width: 71%;">
                          <div class="labelfield">Nome</div> 
                          <input type="text" class="inputfield" id="pesquisaUtenteNome" name="pesquisaUtenteNome" value=""/>
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
                          <div class="labelfield">NISS</div> 
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

           

            <!-- INSERÇÃO MANUAL --> 
            <div id="" class="tabcontent inactive">


                <div class="row">
                    <div class="col-1">
                        <div class="subtitle">INSERÇÃO MANUAL</div>
                    </div>
                </div>

                <div id="divEsperaInsercaoManual" style="display: none;"></div> 

                <div class="row">
                    <div class="col-1-1" style="*width: 98%;">
                        <div class="labelfield">Nome</div> 
                        <input type="text" class="inputTextFour" name="manualNome" id="manualNome" value="${param['manualNome']}" onchange="" maxlength="100" />
                    </div>
                </div>
                 <div class="row">
                    <div class="col-1-4">
                        <div class="labelfield">Data de nasc.
                            <span id="ast_data_nasc" style="color:#cc3333">*</span>
                        </div> 
                        <input type="text" id="manualDtaNasc" name="manualDtaNasc" value="${param['manualDtaNasc']}" onchange="verificarData(this);controlAst()"class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency"onkeypress="valData(this,event);"onkeyup="valData(this,event);"onblur="valData(this,event);controlAst()"maxlength="10" style="width: 80%; margin-right: 5px;" />
                    </div>
                    <div class="col-1-4">
                        <div class="labelfield">NISS
                            <span id="ast_niss" style="color:#cc3333">*</span>
                        </div> 
                        <input type="text" class="inputTextTwo" name="manualNiss" id="manualNiss" onkeyup="controlAst()" onkeypress="controlAst()" onchange="controlAst()" onBlur="controlAst()" value="${param['manualNiss']}" maxlength="30"/>
                    </div>
                    <div class="col-1-6">
                        <div class="labelfield"></div> 
                        <input type="button" class="spms-button" id="event_passaUtente" name="event_passaUtente" onclick="validaValoresUtenteManual();" value="Inserir Utente" 
                        style="width: 100px;"/> 
                    </div>
                    <div class="col-1-4">
                        <div class="tfill"></div>
                    </div>
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
                        <input type="text" class="inputfield" name="famNissImpedido" id="famNissImpedido" value=""/>
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

        <div class="fixed-footer">
            <input type="button" class="spms-toolbar-button right" value="Cancelar" 
            onclick="closePopUp();"/>

            <input type="button" class="spms-toolbar-button right" value="Selecionar" disabled 
            onclick="selecionar();" id="event_seleccionaAgregado" name="event_seleccionaAgregado" style="" />

            <input type="button" class="spms-toolbar-button right" value="Limpar" 
            onclick="limparFamiliarSeleccionado();" />
        </div>
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
            document.getElementById('hiddenNomeFamiliar').value = document.getElementById('manualNome').value.toUpperCase().replace("'","");
            document.getElementById('nomeNormalfamiliar').value = document.getElementById('manualNome').value.toUpperCase().replace("'","");
            document.getElementById('textNomeFamiliar').value = document.getElementById('nomeNormalfamiliar').value;
            document.getElementById('hiddenDtaNascFamiliar').value = document.getElementById('manualDtaNasc').value;
            document.getElementById('textDtaNascFamiliar').value = document.getElementById('manualDtaNasc').value;
            document.getElementById('hiddenNissFamiliar').value = document.getElementById('manualNiss').value;  
            document.getElementById('textNissFamiliar').value = document.getElementById('manualNiss').value;
            enableButton(document.getElementById('event_seleccionaAgregado'));
            //alert('Utente inserido com sucesso.');
            $.spmsDialog('warning', { title: 'Aviso', message: 'Utente inserido com sucesso.'});
        }
        
        if(document.body.innerHTML.indexOf('Utente inserido com sucesso.')>=0 && document.body.innerHTML.indexOf('Utente inserido com sucesso.')<5000){
            passarUtenteManual();
        }
  </script>
  
  </body>



</html>