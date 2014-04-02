<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <% 
           String contextPath = request.getContextPath().replaceAll("/","");
        %>
        <jsp:include page="/com/head.jsp" flush="true"/>       

        <!--
        <title></title>
        <script type="text/javascript" src="../js_cit_v3/pesquisa.js"></script>
        -->
    
        <!--
        <link rel="stylesheet" type="text/css" href="../css_cit_v3/cit_v3_base.css" title="style"/> 
        <link rel="stylesheet" type="text/css" href="../css_cit_v3/cit_v3_bread.css" title="style"/>
        <link rel="stylesheet" type="text/css" href="/<%=contextPath%>/css_cit_v3/datepicker.css" title="style"/>
        -->

        <!--<link href="../css_cit_v3/edicaoBaixa.css" rel="stylesheet" type="text/css" />-->

        <link href="../css_cit_v3/spms-grid.css" rel="stylesheet" type="text/css" />
        <link href="../css_cit_v3/spms-theme.css" rel="stylesheet" type="text/css" />

        <!--
        <script type="text/javascript" src="../js_cit_v3/breadcrumb.js"></script>  
        <script type="text/javascript" src="../js_cit_v3/igif.js"></script>  
        <script type="text/javascript" src="../js_cit_v3/jquery-1.2.2.pack.js"></script>  
        <script type="text/javascript" src="../js_cit_v3/ajaxcore.js"></script>
        <script type="text/javascript" src="../js_cit_v3/popups.js"></script>
        <script type="text/javascript" src="../js_cit_v3/highlight.js"></script>
        <script type="text/javascript" src="../js_cit_v3/git.js"></script>
        <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/date.js"></script>
        <script type="text/javascript" src="/<%=contextPath%>/js_cit_v3/datepicker.js"></script>
        -->

        <script type="text/javascript">
    
            var myArray1 = new Array();
            myArray1[0] = "parentescodisplay";
            myArray1[1] = "inputFamiliar";
            myArray1[2] = "OutroGrauParentesco";
     
            var myButtonsArray1 = new Array();
            myButtonsArray1[0] = "buttonPesquisaFamiliar";
     
            var hashTipoDoenca = new Array();
     
            function alterar(objecto){

                var inputJustificacao = document.getElementById('justificacao');
                inputJustificacao.value = inputJustificacao.value.trim();

                var idade = getIdade(document.getElementById('hiddenInfoUtenteDtaNasc').value);
                var msg = '';
        
                if ( idade < 18 ) { msg = 'Atenção: O utente é menor de 18 anos. Deseja gravar os dados?'; }
                else { msg = 'Os dados serão gravados. Deseja continuar?'; }

                $.spmsDialog( 'confirm', 
                    { 
                        title: 'Continuar?', 
                        message: msg, 
                        callback: function() { 
                            splash(true);
                            document.getElementById('hiddenListaBaixas').value = 'updateItemBaixa';
                            var incActProfObjCheck = document.getElementById("incActProf");
                            var incCuiInaObjCheck = document.getElementById("cuiIna");
                            incActProfObjCheck.disabled = false;
                            incCuiInaObjCheck.disabled = false;
                            objecto.submit();
                        } 
                    }
                );
            }
    
            function gravar(objecto){

                var inputJustificacao = document.getElementById('justificacao');
                inputJustificacao.value = inputJustificacao.value.trim();

                var idade = getIdade(document.getElementById('hiddenInfoUtenteDtaNasc').value);
            
                var msg = '';
                var menor = false;
                var naoFeminino = false;
             
                //Id do Codigo Doenca seleccionado
                var idCodigoDoenca = document.getElementById('selectClassDoenca').value;
                
                if(idade < 18){
                    menor = true;
                }
                if ((hashTipoDoenca[idCodigoDoenca] == 'RC' || hashTipoDoenca[idCodigoDoenca] == 'IG') && document.getElementById("hiddenInfoUtenteSexoUtente").value == 'M' ) {
                    naoFeminino = true;
                }
            
                if(menor && naoFeminino){
                    msg = 'Atenção: O utente é menor de 18 anos e não é do sexo feminino. Deseja gravar os dados?';
                } else if(menor){
                    msg = 'Atenção: O utente é menor de 18 anos. Deseja gravar os dados?';
                } else if(naoFeminino){
                    msg = 'Atenção: O utente não é do sexo feminino. Deseja gravar os dados?';
                } else{
                    msg = 'Os dados serão gravados. Deseja continuar?';
                }

                //if( confirm(msg) ) { genericAction(objecto); }
                //return;

                $.spmsDialog( 'confirm', 
                    { 
                        title: 'Continuar?', 
                        message: msg, 
                        callback: function() { genericAction(objecto); } 
                    }
                );
            }
         
            function verificaIntegracaoSam(perguntaAlteracao) {

                var isIntegraSam = document.getElementById("hiddenIsSam");
                var isPrimeiraVez = document.getElementById("hiddenIsPrimeiraVez");
                var isNovaBaixa = document.getElementById("novaBaixa");

                if( isIntegraSam && isPrimeiraVez )
                {
                    if( isIntegraSam.value && isIntegraSam.value == 'S'&& isPrimeiraVez.value && isPrimeiraVez.value=='S'&& perguntaAlteracao && isNovaBaixa && isNovaBaixa.value =="novaBaixa") {

                        $.spmsDialog( 'confirm', 
                            { 
                                title: 'Continuar?', 
                                message: "Pretende trocar o beneficiário para o qual vai ser emitido o CIT ?",
                                callback: function() { 
                                    splash(true);
                                    popUpGITAssistenciaFamiliarBeneficiario();
                                    splash(false);
                                } 
                            }
                        );
                    }
                    else {
                        if( isIntegraSam.value && isIntegraSam.value == 'S'&& isPrimeiraVez.value && isPrimeiraVez.value=='N'  ) {
                            actualizaDadosBaixas();
                        }
                    }
                }     
            }
          
            //param perguntaAlteracao - true/false serve para iondicar se deve ou não questiomatr acerca da alteração de utente    
            function verificaSeEAssFamilia(perguntaAlteracao){
                var incActProfObjCheck = document.getElementById("incActProf");
                var incCuiInaObjCheck = document.getElementById("cuiIna");        
                incActProfObjCheck.disabled = true;
                incCuiInaObjCheck.disabled = true;
                   
                var idSelectClassDoenca = document.getElementById("selectClassDoenca").value;
            
                var objIBG = document.getElementById("impBenefGra");
                objIBG.disabled = true;
                if(hashTipoDoenca[idSelectClassDoenca] == 'RC' || hashTipoDoenca[idSelectClassDoenca] == 'IG'){
                    objIBG.checked = true;
                } else {
                    objIBG.checked = false;
                }
            
                if(idSelectClassDoenca){
            
                    if(document.getElementById("selectClassDoenca").value=='<%= request.getSession(false).getAttribute("GitidDFAssistenciaFamiliar") %>'){    //Vai ter problemas por causa do DF dos da funçao publica                
                        // -- é familiar
                        setEnabledOrDisabled(myArray1, false);
                        setEnabledOrDisabledButtons(myButtonsArray1, false);                
                        expandRow("trFamiliar");
                        expandRow("trNissFamiliar");
                        expandRow("trDtNasc");
                   
                        if (document.getElementById('entidadePublica').value != 'EPUB') {
                            document.getElementById("checkBaixaManual").disabled = true;
                            document.getElementById("checkBaixaManual").checked = false;
                            document.getElementById("checkManualText").innerHTML = '';    
                        }             
                    
                        verificaIntegracaoSam(perguntaAlteracao);
                    
                    } else if(document.getElementById("selectClassDoenca").value=='<%= request.getSession(false).getAttribute("GitidAMAssistenciaFamiliar") %>'){    //Vai ter problemas por causa do DF dos da funçao publica
           
                        // é familiar
                        setEnabledOrDisabled(myArray1, false);
                        setEnabledOrDisabledButtons(myButtonsArray1, false);
                        expandRow("trFamiliar");
                        expandRow("trNissFamiliar");
                        expandRow("trDtNasc");
                    
                        if (document.getElementById('entidadePublica').value != 'EPUB') {
                            document.getElementById("checkBaixaManual").disabled = true;
                            document.getElementById("checkBaixaManual").checked = false;
                            document.getElementById("checkManualText").innerHTML = '';    
                        }
                          
                        verificaIntegracaoSam(perguntaAlteracao);
                            
                    } else {
                
                        // nao é familiar
                        setEnabledOrDisabled(myArray1, true);
                        setEnabledOrDisabledButtons(myButtonsArray1, true);
                        collapseRow("trFamiliar");
                        collapseRow("trNissFamiliar");
                        collapseRow("trDtNasc");
                    
                        // Limpa Familiar previamente seleccionado
                        cleanPopUpFamiliarSeleccionado(window);
                    
                        if (document.getElementById('entidadePublica').value != 'EPUB') {
                            document.getElementById("checkBaixaManual").disabled   = false;
                        }   
                    }
                
                    // Estes tipos de baixa também nao tem porrogações
                    if(hashTipoDoenca[idSelectClassDoenca] == 'DF' || hashTipoDoenca[idSelectClassDoenca] == 'RC' || hashTipoDoenca[idSelectClassDoenca] == 'IG') {
                        document.getElementById("checkBaixaManual").disabled = true;
                        document.getElementById("checkBaixaManual").checked = false;
                        document.getElementById("checkManualText").innerHTML = '';       
                    }
                }
            
                //Se estiver seleccionada a opção Cod Trabalho, ou gravidez de risco clínico, retira-se check de "Inc. Act. Prof." e de "Cuidados inadiáveis" 
                if((hashTipoDoenca[idSelectClassDoenca] == 'IG') || (hashTipoDoenca[idSelectClassDoenca] == 'RC')){
                    incActProfObjCheck.checked = false;
                    incCuiInaObjCheck.checked = false;
                }
            
                if(hashTipoDoenca[idSelectClassDoenca] == 'DF' || hashTipoDoenca[idSelectClassDoenca] == 'AM'  ){
                    incActProfObjCheck.checked = false;
                    incCuiInaObjCheck.checked = true;
                }
            
                if(hashTipoDoenca[idSelectClassDoenca] == 'DN' 
                    || hashTipoDoenca[idSelectClassDoenca] == 'DD' 
                    || hashTipoDoenca[idSelectClassDoenca] == 'T'
                    || hashTipoDoenca[idSelectClassDoenca] == 'DP'
                    || hashTipoDoenca[idSelectClassDoenca] == 'AT'
                    || hashTipoDoenca[idSelectClassDoenca] == 'DL')
                {
                    incActProfObjCheck.checked = true;
                    incCuiInaObjCheck.checked = false;
                }    
            }
         
            function isNumber(sText) {
                var ValidChars = "0123456789";
                var IsNumber=true;
                var Char;
     
                for (i = 0; i < sText.length && IsNumber == true; i++) { 
                    Char = sText.charAt(i); 
                    if (ValidChars.indexOf(Char) == -1) {
                        IsNumber = false;
                    }
                }
                return IsNumber;
            }
              
            //Used to access the parameters     
            function getParameter(name) {
                name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
                var regexS = "[\\?&]"+name+"=([^&#]*)";
                var regex = new RegExp( regexS );
                var results = regex.exec( window.location.href );
                if( results == null ) {
                    return "";
                } else {
                    return results[1];
                }
            }
    
            // Check if format of the date is valid, with 
            function checkDate(data){
                if (data == '') {
                    return true;
                }
                return Date.isValid(data,'dd-MM-yyyy');
            }
        
            function voltar(){
                var form = document.getElementById('formBaixa');
                //splash(true);
                if(document.getElementById('gitad').value == 'S'){ 
                    form.action='../git/edicaoBaixasUtente.do';
                } else {
                    form.action='../git/baixasUtente.do';
                }
                form.submit();
                return;
            }
        
            function genericAction (buttonPressed) {
                var incActProfObjCheck = document.getElementById("incActProf");
                var incCuiInaObjCheck = document.getElementById("cuiIna");
                incActProfObjCheck.disabled = false;
                incCuiInaObjCheck.disabled = false;
            
                if (buttonPressed.value == 'GRAVAR') {  //Inserir Baixa 
                    //Para a selecção da entidade responsavel, é necessario ir buscar o 
                    //valor que está seleccionado, para se manter seleccionado
                    document.getElementById('hiddenSubmitIEntidadeResponsavel').value = document.getElementById('hiddenIEntidadeResponsavel').value; 
                    document.getElementById('hiddenNumBeneficiario_form').value = document.getElementById('hiddenNumBeneficiario_form').value;
                    if(!document.getElementById('hiddenNumBeneficiario_form').value){
                        document.getElementById('hiddenNumBeneficiario_form').value = document.getElementById('hiddenNumBeneficiario').value;
                    }
                    //splash(true);
                    document.getElementById('hiddenListaBaixas').value='insertNewBaixa';
                    buttonPressed.form.submit();
                }
            }
        
            var dataInicioGlobal;
            var tipoRegisto;
         
            function changeSelectedEntidade (selectBox) {
                document.getElementById('numeroBeneficiario').innerHTML = numBenefArray[document.getElementById('entResp').value];
                //Actualiza numero beneficiario
                var numeroBeneficiarioField   = document.getElementById('hiddenNumBeneficiario');
                var numeroBeneficiarioFormField   = document.getElementById('hiddenNumBeneficiario_form');
                var entidadeResponsavelField  = document.getElementById('hiddenIEntidadeResponsavel');
                var histEntUtIdField          = document.getElementById('hiddenIduHistEntUtID');
                
                if (entidadeResponsavelField) {
                    entidadeResponsavelField.value  = document.getElementById('entResp').value;
                }
                if (histEntUtIdField) {
                    histEntUtIdField.value  = histEntUtArray[document.getElementById('entResp').value];
                }
                if (numeroBeneficiarioField) {
                    numeroBeneficiarioField.value   = numBenefArray[document.getElementById('entResp').value];
                }
    
                if (numeroBeneficiarioFormField) {
                    numeroBeneficiarioFormField.value   = numBenefArray[document.getElementById('entResp').value];
                }            
                /*
                //Caso estejamos numa pagina de emissao de baixa
                //temos que ter em atenção que caso um valor mude nesta select box
                //o item manual pode ou nao ser seleccionado. Um item de baixa
                //manual so pode existir numa baixa de segurança social
                var objcheckBaixaManual = document.getElementById('checkBaixaManual');
                if (objcheckBaixaManual) {
                    if (selectBox.value == '-1' ) { //Seg Social
                        document.getElementById('checkBaixaManual').disabled      = false;
                    } else {
                        document.getElementById('checkBaixaManual').disabled      = true;
                        document.getElementById('checkBaixaManual').checked       = false;
                        document.getElementById('checkManualText').innerHTML      = '';
                    }
                }
                */
                
            }
            
            function actualizaDadosBaixas(){
                //document.getElementById('hiddenCodTipoRegisto').value='<c:out value="${RowListaBaixas[\'Codtiporegisto\']}"/>';
                document.getElementById('hiddenLastItemDataTermo').value='<c:out value="${RowListaBaixas[\'DataTermo\']}"/>';
                document.getElementById('DataInicioTotal').value='<c:out value="${RowListaBaixas[\'DataInicioTotal\']}"/>';
            }    
        </script>
    </head>
    <body onload="splash(false); verificaSeEAssFamilia(false); dataInicioGlobal = document.getElementById('dp-dinicio').value;">
        <div id="outerContainer">
            <div class="center">
                <jsp:include page="/pub/breadcrumb.jsp" flush="true">     
                    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                </jsp:include>
                <jsp:include page="/com/splash.jsp" flush="true"/>
            </div>
            <div id ="formContainer" align ="left">
                <jsp:include page="/com/error.jsp" flush="true"/>
                <c:choose>
                    <c:when test="${param['opcaoSeleccionada'] == 'Nova Baixa'}">
                        <jsp:include page="/com/infoUtente.jsp" flush="true">
                            <jsp:param name="pDescricaoPagina" value="> NOVA BAIXA"/>
                        </jsp:include>                             
                    </c:when>
                    <c:when test="${param['opcaoSeleccionada'] == 'Alterar'}">
                        <jsp:include page="/com/infoUtente.jsp" flush="true">
                            <jsp:param name="pDescricaoPagina" value="> ALTERAR BAIXA"/>
                        </jsp:include>                            
                    </c:when>
                </c:choose>                
                <!-- DOWN -->
                <script type="text/javascript">
                     //Opens the information about the Utente
                   // changeSign(document.getElementById("infoUtenteButton"));
                    collapseExpandRow('infoUtente');
                </script>            
                <c:set var="numRowsListaEntidades" value='<%=session.getAttribute("infolistaEntidadesNumRows")%>' />    
                <form id="formBaixa" method="POST" action="../git/edicaoBaixa.do" onsubmit="splash(true);">
                    <p>
                        <input type="hidden" id="hiddenListaBaixas" name="event" value=""/>
                        <input type="hidden" id="gitad" name="gitad" value="${param.gitad}"/>
                        <input type="hidden" id="idIdentUt" name="iduIdentUt" value="${bindings.InformacaoUtente.Idutente}"/>              
                        <input type="hidden" id="gitad" name="gitad" value="${param.gitad}"/>              
                        <!-- Case this Utente as an open Baixa, we need to close it -->
                        <input type="hidden" id="IdbaixaAltaAberta" name="IdbaixaAltaAberta" value="<c:out value="${param.IdbaixaAltaAberta}"/>" />                          
                        <input type="hidden" id="hiddenNomeUtenteOriginal" name="hiddenNomeUtenteOriginal" value="${bindings.InformacaoUtente.Nomenormalizado}" /> 
                        <input type="hidden" id="DataInicioTotal" name="DataInicioTotal" value="<c:out value="${param.DataInicioTotal}"/>" /> 
                        <input type="hidden" id="hiddenLastItemDataTermo" name="hiddenLastItemDataTermo" value="<c:out value="${param.hiddenLastItemDataTermo}"/>" /> 
                        <input type="hidden" id="hiddenCodTipoRegisto" name="hiddenCodTipoRegisto" value="<c:out value="${param.hiddenCodTipoRegisto}"/>" />                     
                        <input type="hidden" id="hiddenNissUtente" name="hiddenNissUtente" value="<c:out value="${bindings.InformacaoUtente.Numssocial}"/>" /> 
                        <input type="hidden" id="hiddenNumBeneficiario_form" name="hiddenNumBeneficiario_form" value="<c:out value="${param.hiddenNumBeneficiario_form?param.hiddenNumBeneficiario_form:param.hiddenNumBeneficiario}"/>" />                      
                        <input type="hidden" id="hiddenIsSam" name="hiddenIsSam" value="${isSAMCall}" /> 
                        <input type="hidden" id="hiddenIsPrimeiraVez" name="hiddenIsPrimeiraVez" value="${primeiraEntrada}" />                         
                        <input type="hidden" id="hiddenIdUtenteParaTrocar" name="hiddenIdUtenteParaTrocar" value="" />
                        <input type="hidden" id="entRespParaTrocar" name="entRespParaTrocar" value="" />                             
                        <!-- Entidades Responsaveis -->
                        <input type="hidden" id="hiddenSubmitIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="<c:out value="${param.hiddenIEntidadeResponsavel}"/>" /> 
                        <input type="hidden" id="idEntidadeResponsavel" name="idEntidadeResponsavel" value="<c:out value="${param.idEntidadeResponsavel}"/>" /> 
                        <input type="hidden" id="entidadePublica" name="entidadePublica" value="<c:out value="${param.entidadePublica}"/>" />
                        <input type="hidden" id="hiddenBaixasIduHistEntUtID" name="hiddenIduHistEntUtID" value="<c:out value="${param.hiddenIduHistEntUtID}"/>" />
                        <script type="text/javascript">
                            //Entidades Responsaveis
                            if (document.getElementById("idEntidadeResponsavel").value == "" && document.getElementById("entResp")) {
                                document.getElementById("idEntidadeResponsavel").value = document.getElementById("entResp").value;
                            }                        
                        </script>
                        <input type="hidden" id="opcaoSeleccionada" name="opcaoSeleccionada" value="${param['opcaoSeleccionada']}"> 
                    </p>
                    <!-- Titulo -->
                    <c:choose>
                        <c:when test="${param['opcaoSeleccionada'] == 'Nova Baixa'}">
                            <div class="subTitle">Nova Baixa</div>
                            <input type="hidden" id="novaBaixa" name="novaBaixa" value="novaBaixa" /> 
                            <script type="text/javascript">
                                tipoRegisto = 'I';
                            </script>                     
                        </c:when>
                        <c:when test="${param['opcaoSeleccionada'] == 'Alterar'}">
                            <div class="subTitle">Alterar Baixa</div>
                            <input type="hidden" id="novaBaixa" name="novaBaixa" value="alterarBaixa" /> 
                            <script type="text/javascript">
                                tipoRegisto = 'A';
                                // Se é alterar baixa, temos que colocar no menu das entidades
                                // a entidade que está inserida na baixa, e nao a que está seleccionada na lista
                                if ('${param.IdEntidadePublica}' == '') {
                                    //É Segurança social
                                    document.getElementById('entResp').value = '-1';
                                } else {
                                    document.getElementById('entResp').value = '${param.IdEntidadePublica}';
                                }
                                document.getElementById('hiddenIEntidadeResponsavel').value = document.getElementById('entResp').value;
                                document.getElementById('hiddenIduHistEntUtID').value = histEntUtArray[document.getElementById('entResp').value];
                                document.getElementById('numeroBeneficiario').innerHTML = numBenefArray[document.getElementById('entResp').value];
                                document.getElementById('hiddenNumBeneficiario').value = numBenefArray[document.getElementById('entResp').value];
                                document.getElementById('hiddenNumBeneficiario_form').value = numBenefArray[document.getElementById('entResp').value];
                            </script>
                        </c:when>
                    </c:choose>
                    <div class="spms"> 
                        <div class="container" style="width: 98%; margin: 0; background-color: #dfdfdf;">
                            <input type="hidden" id="isDFinput" name = "isDFInput" value="${param.isDFInput}"/>
                            <c:set var="flagDisabledDoenca" value="true"/> 
                            <div class="row">
                                <!-- CHECKBOX CLASSIFICACAO DE DOENCA -->
                                <div class="col-1-4" style="width: 21%;"> 
                                    <div class="labelfield">Classificação de doença</div> 
                                    <c:choose>
                                        <c:when test="${param['opcaoSeleccionada'] == 'Alterar' && param['hiddenCodTipoRegisto'] == 'P'}">
                                            <c:forEach var="RowListaCodigosGenericos" items="${bindings.ListaCodigosGenericos.rangeSet}">
                                                <c:if test="${RowListaCodigosGenericos[\'Id\'] == param['selectClassDoenca']  }">
                                                    <input type="text" class="inputTextFour" value="<c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>" disabled />
                                                    <input type="hidden" name="selectClassDoenca" id="selectClassDoenca" value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>" />
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <select id="selectClassDoenca" class="selectfield" name="selectClassDoenca" onchange="verificaSeEAssFamilia(true) ;">
                                                <c:forEach var="RowListaCodigosGenericos" items="${bindings.ListaCodigosGenericos.rangeSet}">
                                                    <script type="text/javascript">
                                                        hashTipoDoenca[<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>] = '<c:out value="${RowListaCodigosGenericos[\'Codigo\']}"/>'; 
                                                    </script>
                                                    <c:choose>
                                                        <c:when test="${RowListaCodigosGenericos[\'Codigo\'] == 'DF'}">     
                                                            <c:choose>
                                                                <c:when test="${RowListaCodigosGenericos[\'Id\'] == param['selectClassDoenca'] or param.isDFInput}">
                                                                    <c:set var="flagDisabledDoenca" value="false"/>
                                                                    <option selected value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                        <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                                    </option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                        <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                                    </option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${RowListaCodigosGenericos[\'Codigo\'] == 'DN' && param['selectClassDoenca'] == ''}"> <%-- Default is Doenca Natural only if selectClassDoenca is not defined (form submission to change range on the table of the bottom of the page --%>
                                                                    <option selected onClick="verificaSeEAssFamilia(false);" value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                        <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                                    </option>
                                                                </c:when>
                                                                <c:when test="${RowListaCodigosGenericos[\'Id\'] == param['selectClassDoenca']}">
                                                                    <option selected onClick="verificaSeEAssFamilia(false);" value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                        <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                                    </option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option onClick="verificaSeEAssFamilia(false);" value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                        <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                                    </option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </select>
                                        </c:otherwise>
                                    </c:choose>            
                                    <!-- #END CHECKBOX CLASSIFICACAO DE DOENCA -->
                                </div> 
                                <div class="col-1-4" style="width: 17%; line-height:23px"> 
                                    <div class="labelfield"></div> 
                                    <input type="button" id="buttonPesquisaFamiliar" class="spms-button" style="width: 100%" name="buttonPesquisaFamiliar" onclick="/*splash(true);*/popUpGITAssistenciaFamiliar();" value="Pesquisar Familiar Doente" disabled/>
                                </div>
                                <div class="col-1-8" style="width:13%;line-height:24px"> 
                                    <div class="labelfield"></div> 
                                    <div id="trIncActProf" class="checkboxfield">
                                        <c:choose>
                                            <c:when test="${param['incActProf'] == 'on' || param['incActProf'] == 'S'}">
                                                <input style="margin-top:4px" id="incActProf" name="incActProf" type="checkbox" class="" checked><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Inc. Act. Prof</span></input>
                                            </c:when>
                                            <c:otherwise>
                                                <input style="margin-top:4px" id="incActProf" name="incActProf" type="checkbox" class=""><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Inc. Act. Prof</span></input>
                                            </c:otherwise>
                                        </c:choose>
                                        <!--<input type="checkbox" class=""> Inc. Act. Prof </input>-->
                                    </div>
                                </div>
                                <div class="col-1-6" style="width:18%;line-height:24px"> 
                                    <div class="labelfield"></div> 
                                    <div id="trCuiIna" class="checkboxfield">
                                        <c:choose>
                                            <c:when test="${param['cuiIna'] == 'on' || param['cuiIna'] == 'S'}">
                                                <input style="margin-top:4px" id="cuiIna" name="cuiIna" type="checkbox" class="" checked><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Cuidados inadiáveis</span></input>
                                            </c:when>
                                            <c:otherwise>
                                                <input style="margin-top:4px" id="cuiIna" name="cuiIna" type="checkbox" class=""><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Cuidados inadiáveis</span></input>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-1-6" style="float: left;width:18%;line-height:24px"> 
                                    <div class="labelfield"></div> 
                                    <div id="trImpBenefGra" class="checkboxfield">
                                        <input style="margin-top:4px" id="impBenefGra" name="impBenefGra" type="checkbox" class=""><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Imp. Benef. Grávidas</span></input>
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="trFamiliar" style="display:none; *width: 90%;">
                                <div class="col-2-6" style="*width: 20%;"> 
                                    <div class="labelfield">Familiar doente
                                        <span style="color:#cc3333">*</span>
                                    </div> 
                                    <div class="inputfield">
                                        <div id="nomeFamiliar" style="width:500px;"></div>
                                        <input id="inputFamiliarNome" type="hidden" name="inputFamiliarNome" value="${param['inputFamiliarNome']}" />
                                        <input id="inputFamiliarSelected" type="hidden" name="inputFamiliarSelected" value="${param['inputFamiliarSelected']}" />
                                        <input id="inputFamiliarId" type="hidden" name="inputFamiliarId" value="${param['inputFamiliarId']}" />
                                        <script type="text/javascript"> 
                                            var nomeFamiliar = document.getElementById('inputFamiliarNome'); 
                                            document.getElementById('nomeFamiliar').innerHTML = "<span style='white-space = nowrap;'>"+nomeFamiliar.value+"<//span>"; 
                                        </script>
                                    </div> 
                                </div>
                                <div class="col-1-6"> 
                                    <div class="labelfield">Data nascimento
                                        <span style="color:#cc3333">*</span>
                                    </div> 
                                    <div class="inputfield">
                                        <div id="dtaNascFamiliar"></div>
                                        <input id="inputFamiliarDtaNasc" type="hidden" name="inputFamiliarDtaNasc" value="${param['inputFamiliarDtaNasc']}" class="inputTextTwo" />
                                        <script type="text/javascript"> 
                                            var nomeFamiliar = document.getElementById('inputFamiliarDtaNasc'); 
                                            document.getElementById('dtaNascFamiliar').innerHTML = nomeFamiliar.value; 
                                        </script>
                                    </div>
                                </div>    
                                <div class="col-1-6"> 
                                    <div class="labelfield">Parentesco</div> 
                                    <div class="inputfield">                
                                        <div id="parentescoFamiliar"></div>                             
                                        <input id="inputFamiliarIdParentesco" type="hidden" name="inputFamiliarIdParentesco" value="${param['inputFamiliarIdParentesco']}" />
                                        <input id="inputFamiliarOutroParentesco" type="hidden" name="inputFamiliarOutroParentesco" value="${param['inputFamiliarOutroParentesco']}" />
                                        <input id="inputFamiliarOutroParentescoTexto" type="hidden" name="inputFamiliarOutroParentescoTexto" value="${param['inputFamiliarOutroParentescoTexto']}" />                             
                                        <script type="text/javascript">
                                            var nomeFamiliar = document.getElementById('inputFamiliarOutroParentescoTexto');
                                            document.getElementById('parentescoFamiliar').innerHTML = nomeFamiliar.value;
                                        </script>                             
                                        <c:if test="${param['opcaoSeleccionada'] == 'Alterar'}">
                                            <script type="text/javascript">
                                                if ("<c:out value="${param['inputFamiliarOutroParentescoTexto']}"/>" != "") {
                                                    document.getElementById('parentescoFamiliar').innerHTML = "<c:out value="${param['inputFamiliarOutroParentescoTexto']}"/>";
                                                } else {
                                                    document.getElementById('parentescoFamiliar').innerHTML = "<c:out value="${param['itemBaixainputFamiliarGrauParentesco']}"/>";
                                                }
                                            </script>
                                        </c:if>  
                                    </div> 
                                </div>
                                <div class="col-1-6"> 
                                    <div class="labelfield">NISS familiar doente
                                        <span style="color:#cc3333">*</span>
                                    </div> 
                                    <div class="inputfield">
                                        <div id="nissFamiliar"></div>
                                        <input id="inputFamiliarNiss" type="hidden" name="inputFamiliarNiss" value="${param['inputFamiliarNiss']}" />  
                                        <script type="text/javascript">
                                            var nissFamiliar = document.getElementById('inputFamiliarNiss');
                                            document.getElementById('nissFamiliar').innerHTML = nissFamiliar.value;
                                        </script>
                                    </div> 
                                </div>
                                <div class="col-1-6"> 
                                    <div class="labelfield">NISS familiar impedido</div> 
                                    <div class="inputfield" style="width: 80%; float: left;">
                                        <div id="nissFamiliarImpedido" style="display: inline;"></div>
                                        <input type="hidden" name="inputnissFamiliarImpedido" id="inputnissFamiliarImpedido" value="${param['inputnissFamiliarImpedido']}" />    
                                        <script type="text/javascript">
                                            var nissFamiliar = document.getElementById('inputnissFamiliarImpedido');
                                            document.getElementById('nissFamiliarImpedido').innerHTML = nissFamiliar.value;
                                        </script>        
                                    </div> 
                                    <img alt=""  title="Deverá preencher o NISS do progenitor impedido de prestar assistência, se o beneficiário for o avô/avó ou equiparado do familiar doente."  style="padding-left:2px;padding-right:2px;padding-top:1 px; margin-top: 4px;" src="../imagens_cit_v3/info.png" align="top" />
                                </div> 
                            </div>
                            <div class="row" style="*width: 80%;">
                                <div class="col-1-4"> 
                                    <!-- <div class="labelfield"></div> -->
                                    <div id="divCheckManualCheckAlterar" class="checkboxfield">
                                        <input id="checkBaixaManual" name="checkBaixaManual" type="checkbox" <c:if test="${param['checkBaixaManual'] == 'on' || param['checkBaixaManual'] == 'S'}">checked</c:if> <c:if test="${param['entidadePublica'] == 'EPUB'}">disabled</c:if>
                                               onclick="javascript: if (document.getElementById('checkManualText').innerHTML != '') document.getElementById('checkManualText').innerHTML = ''; else {dataInicioManual = addDaysToDateFormat(getElementById('dp-dinicio').value,-1); dataTermoManual = addDaysToDateFormat(getElementById('dp-dinicio').value,-1); document.getElementById('checkManualText').innerHTML = 'Item Baixa Manual de ' + dataInicioManual + ' a ' + dataTermoManual ; }">
                                            Baixa Inicial Manual 
                                        </input>
                                    </div> 
                                </div> 
                                <div class="col-4-6" id="divCheckManualTextAlterar" style="float: left;"> 
                                    <!-- <div class="tfill"></div>--> 
                                    <div id="checkManualText" style="color: red; padding-top: 5px"></div>                                    
                                    <%-- Se for para alterar, nao se pode mexer nos items de baixa Manual --%>
                                    <c:if test="${param['opcaoSeleccionada'] == 'Alterar'}">
                                        <script type="text/javascript">
                                            document.getElementById("divCheckManualTextAlterar").style.display = "none";
                                            document.getElementById("divCheckManualCheckAlterar").style.display = "none";
                                            //document.getElementById("divCheckManualLabelAlterar").style.display = "none";
                                        </script>
                                    </c:if>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-1-6"> 
                                    <div class="labelfield">Data de início
                                        <span style="color:#cc3333">*</span>
                                    </div> 
                                    <!--<div class="inputfield"> </div> -->            
                                    <input type="text" id="dp-dinicio" name="dp-dinicio" style="width: 80%; margin-right: 3px;" onBlur="javascript:controlDataInicio(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" onchange="if (document.getElementById('checkManualText').innerHTML != '') {dataInicioManual = addDaysToDateFormat(document.getElementById('dp-dinicio').value,-1); dataTermoManual = addDaysToDateFormat(document.getElementById('dp-dinicio').value,-1); document.getElementById('checkManualText').innerHTML = 'Item Baixa de Manual ' + dataInicioManual + ' a ' + dataTermoManual ; }"
                                          value="${param['dp-dinicio']}"   
                                          class=" inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" 
                                          maxlength="10" 
                                    <c:if test="${param['opcaoSeleccionada'] == 'Alterar' && param['hiddenCodTipoRegisto'] == 'P'}"> disabled </c:if> />
                                    <script type="text/javascript">
                                        if (document.getElementById('dp-dinicio').value.length == 0) {
                                            var myDate=new Date();
                                            var myDias=(myDate.getDate()).toString();
                                            if (myDias.length == 1) { myDias = '0' + myDias; }
                                            var myMes = (myDate.getMonth()+1).toString();
                                            if (myMes.length == 1) { myMes = '0' + myMes; }
                                            document.getElementById('dp-dinicio').value = myDias + '-' + myMes + '-' + myDate.getFullYear();
                                        }                                        
                                        if(document.getElementById("checkBaixaManual").checked){                                             
                                            dataInicioManual = addDaysToDateFormat(document.getElementById('dp-dinicio').value,-1); 
                                            dataTermoManual = addDaysToDateFormat(document.getElementById('dp-dinicio').value,-1); 
                                            document.getElementById('checkManualText').innerHTML = 'Item Baixa Manual de ' + dataInicioManual + ' a ' + dataTermoManual ;
                                        }                                   
                                    </script>
                                    <c:if test="${param['opcaoSeleccionada'] == 'Alterar' && param['hiddenCodTipoRegisto'] == 'P'}">  
                                        <input type="hidden" name="dp-dinicio" id="dp-dinicio" value="${param['dp-dinicio']}"  />
                                    </c:if>
                                </div>
                                <div class="col-1-8" style="width: 10%;"> 
                                    <div class="labelfield">Nº de dias
                                        <c:if test="${param['opcaoSeleccionada'] == 'Nova Baixa'}">
                                            <span id="ast_num_dias" style="color:#cc3333">*</span>
                                        </c:if>
                                        <c:if test="${param['opcaoSeleccionada'] == 'Alterar'}">
                                            <span id="ast_num_dias" style="color:#cc3333;visibility:hidden">*</span>
                                        </c:if>
                                    </div> 
                                    <input type="text" id="dp-dias" name="dp-dias" onkeypress="keyCheck(event,document.getElementById('dp-dtermo'));"  onBlur="controlNrDias(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" value="${param['dp-dias']}"></input>
                                </div>
                                <div class="col-1-6"> 
                                    <div class="labelfield">Data de termo
                                        <c:if test="${param['opcaoSeleccionada'] == 'Nova Baixa'}">
                                            <span id="ast_data_termo" style="color:#cc3333">*</span>
                                        </c:if>
                                        <c:if test="${param['opcaoSeleccionada'] == 'Alterar'}">
                                            <span id="ast_data_termo" style="color:#cc3333;visibility:hidden">*</span>
                                        </c:if>
                                    </div>
                                    <input id="dp-dtermo" class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" style="width: 80%; margin-right: 3px;" type="text" onBlur="javascript:controlDataFim(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" maxlength="10" value="${param['dp-dtermo']}" name="dp-dtermo" />
                                    <input type="hidden" id="old-dp-dtermo" name="old-dp-dtermo" value="${param['dp-dtermo']}" maxlength="10" />
                                    <input type="hidden" id="old-dp-dinicio" name="old-dp-dinicio" value="${param['dp-dinicio']}" />
                                </div>
                                <div class="col-1-8"> 
                                    <div class="labelfield"></div> 
                                    <div class="checkboxfield" style="line-height:23px">
                                        <c:choose>
                                            <c:when test="${param['internamento'] == 'on' || param['internamento'] == 'S'}">
                                                <input style="margin-top:4px" type="radio" id="internamento" class="pesquisacheckbox" name="internamento" checked onclick="document.getElementById('cirurgiaAmbulatorio').checked=false;"><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Internamento</span></input>
                                            </c:when>
                                            <c:otherwise>
                                                <input style="margin-top:4px" id="internamento" class="pesquisacheckbox" name="internamento" type="radio" onclick="document.getElementById('cirurgiaAmbulatorio').checked=false;"><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Internamento</span></input>
                                            </c:otherwise>
                                        </c:choose> 
                                        <!--<input type="checkbox" class=""> Internamento </input>-->
                                    </div>

                                </div>    
                                <div class="col-1-6" style="width: 20%"> 
                                    <div class="labelfield"></div>             
                                    <div class="checkboxfield" style="line-height:23px">
                                        <c:choose>
                                            <c:when test="${param['cirurgiaAmbulatorio'] == 'on' || param['cirurgiaAmbulatorio'] == 'S'}">
                                                <input style="margin-top:4px" id="cirurgiaAmbulatorio" class="pesquisacheckbox" name="cirurgiaAmbulatorio" type="radio" checked onclick="document.getElementById('internamento').checked=false;"><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Cirurgia ambulatório</span></input>
                                            </c:when>
                                            <c:otherwise>   
                                                <input style="margin-top:4px" id="cirurgiaAmbulatorio" class="pesquisacheckbox" name="cirurgiaAmbulatorio" type="radio" onclick="document.getElementById('internamento').checked=false;"><span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Cirurgia ambulatório</span></input>
                                            </c:otherwise>
                                        </c:choose>
                                        <!--<input type="checkbox" class="" disabled> Cirugia ambulatório </input>-->
                                    </div>
                                </div>
                                <div class="col-1-8"> 
                                    <div class="tfill"></div> 
                                </div>
                            </div>
                            <div class="row" style="*width: 100%;"> 
                                <div class="col-1-6" style="width: 21%;"> 
                                    <div class="labelfield"></div> 
                                    <div class="checkboxfield" style="width: 70%; float:left;line-height:18px">
                                        <c:choose>
                                            <c:when test="${param['autorizacao'] == 'on' || param['autorizacao'] == 'S' }">
                                                <input style="margin-top:1px" id="autorizacao" name="autorizacao" type="checkbox" checked
                                                        onclick=" if (this.checked == true) {
                                                                    if (document.getElementById('justificacao').value == 'Não está autorizado a sair')
                                                                        document.getElementById('justificacao').value = '';
                                                                  } else {
                                                                    document.getElementById('justificacao').value = 'Não está autorizado a sair';
                                                                  } "               
                                                >
                                                    <span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Autorização de saida</span>
                                                </input>
                                            </c:when>
                                            <c:otherwise>
                                                <input style="margin-top:1px" id="autorizacao" name="autorizacao" type="checkbox"
                                                    onclick=" 
                                                               if (this.checked == true) {
                                                                  if (document.getElementById('justificacao').value == 'Não está autorizado a sair')
                                                                      document.getElementById('justificacao').value = '';
                                                               } else {
                                                                  document.getElementById('justificacao').value = 'Não está autorizado a sair';
                                                               } "                      
                                                >
                                                    <span style="padding-left: 5px;vertical-align: top;font-size: 14px;">Autorização de saida</span>
                                                </input>
                                            </c:otherwise>
                                        </c:choose>
                                        <!-- <input type="checkbox" class=""> Autorização de saida </input> -->
                                    </div>
                                    <img alt="" title="Nos casos de incapacidade por doença, ao selecionar esta opção é obrigatório preencher a Justificação da necessidade de ausência do beneficiário do domicílio no horário estabelecido. O doente só pode ausentar-se do domicílio para tratamento. Em casos devidamente fundamentados o médico pode autorizar a ausência no período das 11 às 15h e das 18 às 21h."  style="padding-left:7px;padding-right:2px;padding-top:1 px; margin-top: 5px;" src="../imagens_cit_v3/info.png" align="top" />
                                </div>
                                <div class="col-4-5" style="width: 79%;*width: 76%"> 
                                    <div class="labelfield">Justificação</div> 
                                    <!-- <div class="displayfield"></div> -->
                                    <!--<input type="text" class="" value="Autorização de saida"></input>-->
                                    <c:choose>
                                        <c:when test="${param['autorizacao'] == 'on' || param['autorizacao'] == 'S'}">
                                            <input type="text" id="justificacao" class="inputTextEight" value="${param['justificacao']}" name="justificacao" maxlength="100" onblur="
                                                                                                                                                                                        if(this.value.length>0 && this.value != 'Não está autorizado a sair'){
                                                                                                                                                                                            document.getElementById('autorizacao').checked = true;
                                                                                                                                                                                        } else {
                                                                                                                                                                                            document.getElementById('autorizacao').checked = false;
                                                                                                                                                                                        }
                                            "/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" id="justificacao" class="inputTextEight" value="Não está autorizado a sair" name="justificacao"  maxlength="100" onblur="
                                                                                                                                                                                        if(this.value.length>0 && this.value != 'Não está autorizado a sair'){
                                                                                                                                                                                            document.getElementById('autorizacao').checked = true;
                                                                                                                                                                                        } else {
                                                                                                                                                                                            document.getElementById('autorizacao').checked = false;
                                                                                                                                                                                        }
                                            "/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div> <!-- #END .container -->
                        <div class="footer" style="width: 98%; margin: 0; height: 25px;">
                            <!--<input class="spms-toolbar-button left" type="button" value="GRAVAR" />-->
                            <c:choose>
                                <c:when test="${param['opcaoSeleccionada'] == 'Alterar'}">
                                    <input class="spms-toolbar-button left" type="button" value="GRAVAR" name="event" onclick="alterar(this.form);" style="width: 75px; text-indent: 0px; padding: 0px; font-size: 12px;"/>       
                                    <input type="hidden" id="idSelectedBaixa" name="idSelectedBaixa" value="<c:out value="${param['idSelectedBaixa']}"/>" />    
                                    <input type="hidden" id="IdItemBaixa" name="IdItemBaixa" value="<c:out value="${param['IdItemBaixa']}"/>" />
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${numRowsListaEntidades == 0}">
                                            <input class="spms-toolbar-button buttonDisabled left" type="button" value="GRAVAR" name="event" id="saveBtn" style="width: 75px; text-indent: 0px; padding: 0px; font-size: 12px;" disabled />       
                                        </c:when>
                                        <c:otherwise>
                                            <input class="spms-toolbar-button left" type="button" value="GRAVAR" name="event" id="saveBtn" onclick="gravar(this);" style="width: 75px; text-indent: 0px; padding: 0px; font-size: 12px;"/>       
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                            <input class="spms-toolbar-button left" type="button" value="CANCELAR" onclick="voltar();" style="width: 75px; text-indent: 0px; padding: 0px; font-size: 12px;"/>
                        </div>
                    </div><!-- #END .spms -->
                    <c:choose>
                        <c:when test="${bindings.ListaBaixas.estimatedRowCount > 0}" >
                            <div class="row">
                                <div class="col-1" style="width: 98%; padding: 0px; padding-top: 15px; float: none;">
                                    <table id="readOnlyTable" class="spms-table" cellpadding="0" cellspacing="0" border="0" >
                                        <thead>
                                            <tr class="head">
                                                <th class="numeric">N.º Boletim</th>
                                                <th class="text">Tipo Registo</th>
                                                <th class="date">Dt. Início</th>
                                                <th class="date">Dt. Termo</th>
                                                <th class="text">Unidade Saúde</th>
                                                <th class="text last">Médico</th>
                                            </tr>
                                        </thead>
                                        <tbody>      
                                            <c:forEach var="RowListaBaixas" items="${bindings.ListaBaixas.rangeSet}" varStatus="lineListaBaixas"> 
                                                <tr class="
                                                    <c:choose>
                                                        <c:when test="${lineListaBaixas.count % 2 != 0}">
                                                            even  
                                                        </c:when> 
                                                        <c:otherwise>
                                                            odd
                                                        </c:otherwise>
                                                    </c:choose> 
                                                ">
                                                    <td class="numeric"><c:out value="${RowListaBaixas[\'NumBoletim\']}"/></td>
                                                    <td class="text"><c:out value="${RowListaBaixas[\'Tiporegisto\']}"/></td>
                                                    <td class="date"><c:out value="${RowListaBaixas[\'DataInicio\']}"/></td>
                                                    <td class="date"><c:out value="${RowListaBaixas[\'DataTermo\']}"/></td>
                                                    <td class="text"><c:out value="${RowListaBaixas[\'Entidade\']}"/></td>
                                                    <td class="text last"><c:out value="${RowListaBaixas[\'Profissional\']}"/></td>
                                                </tr>
                                            </c:forEach>
                                            <!--
                                            <tr class="navigation">
                                                <td  colspan="6">
                                                    <jsp:include page="/com/navigationList.jsp" flush="true">
                                                        <jsp:param name="rangeBindingName" value="ListaBaixas"/>                      
                                                        <jsp:param name="listaNumRowsName" value="git.listaBaixasNumRows"/>    
                                                        <jsp:param name="targetPageName" value="baixasUtente.do"/>
                                                    </jsp:include> 
                                                </td>
                                            </tr>
                                            -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </form>       
                <!-- Para entidades públicas ocultar check -->
                <script type="text/javascript">
                    var tipoEntidadeEscolhida = document.getElementById('entidadePublica').value;
                    if(tipoEntidadeEscolhida == 'EPUB'){
                        collapseRow("trImpBenefGra");
                        collapseRow("trImpBenefGraLabel");
                        collapseRow("trCirAmb");
                    }
                </script>
                <!-- UP -->
            </div>
            <div id="footer">
                <div id="divButtonTablePesquisaUtente">
                    <form method="POST" action="" id="formGetNewUtente" style="padding:0;margin:0;" onsubmit="">                        
                        <span style="white-space: nowrap;">
                            <input type="hidden" id="hiddenGetNewUtenteContext" name="hiddenGetNewUtenteContext" value='<%=request.getServletPath().split("/",3)[1]%>' /> 
                            <input type="hidden" id="hiddenGetNewUtentePage" name="hiddenGetNewUtentePage" value='<%=request.getServletPath().split("/",3)[2]%>' /> 
                            <button class="button_emitir" type="cubmit" id="buttonGetNewUtente" value="Nova&nbsp;&nbsp;Pesquisa" onclick="return novaPesquisaUtente(); ">Nova Pesquisa</button>                                    
                            <%
                                String req = request.getRequestURI();
                                if (req.indexOf("mig/")  > 1 || req.indexOf("admin/")  > 1){
                            %>
                            <input id="infoUtenteButtonRetirar" title="retirar utente de sessão" class="submitButton" type="button" value="Retirar Utente Sessão" onclick="return retirarUtenteSessao(); "/>
                            <%
                                }
                            %>                        
                        </span>                            
                    </form>
                </div>           
            </div>
       </div>
       <jsp:include page="/com/footer.jsp" flush="true"/>    
    </body>
</html>