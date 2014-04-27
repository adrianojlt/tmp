<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 

<script type="text/javascript">
    
    // -- array para guardar os registos de boletins de baixa
    var boletinsBaixa = new Array();
    var contadorBoletinsBaixa = 0;
    
    // -- array para guardar os registos de items baixa
    var itemsBaixa = new Array();
    var contadorItemsBaixa = 0;
    
    function selectBaixa(){
        document.x.action="edicaoBaixasUtente.do?event=selectBaixa";
        document.x.submit();
    }
    
    function seleccionaItemBaixa(t,rownum){
        highlightRowComAnulados(t, rownum, itemsBaixa);
    }
    
    function seleccionaBoletimBaixa(t,rownum){
        highlightRowComAnulados(t, rownum, boletinsBaixa);
    }
    
    function maintainCheck(checkBox) {
            checkBox.checked = !checkBox.checked;
    }
    
    /*
    function subtractDate(date1, date2) {
    
            var dateObject1 = Date.parseString (date1,"dd-MM-yyyy");
            var dateObject2 = Date.parseString (date2,"dd-MM-yyyy");
            
            var one_day=1000*60*60*24;
            
            var diffData = Math.ceil((dateObject1.getTime()-dateObject2.getTime())/(one_day));
           
            return diffData + 1;
    }
    */
    
    function enableButton (button, item) {
        button.className = 'submitButton';
        button.removeAttribute("disabled");
    }
    
    function disableButton (button) { 
        button.className = 'submitButton buttonDisabled';
        button.setAttribute("disabled","disabled");
    }
    
    // -- disable ou enable de butão consuante pode alterar de Progorração para Inicial ou Inicial para Progorração
    // -- alteração do texto do butão consuante a accção (Progorração para Inicial ou Inicial para Progorração)
    function contextoOpcaoAlterar(itemSeleccionado, itemPossivelAlterarIP, itemPossivelAlterarPI, itemPossivelAlterar){
        for(i=0; i < itemsBaixa.length ; i++){
            // -- identificar item baixa seleccionado
            if( i == (itemSeleccionado-1) ){
                // -- se o item baixa estiver anulado ou for manual faz disable ao butão
                if( ( itemsBaixa[i][3] == 'S' || itemsBaixa[i][2] == 'M' )){
                    setEnabledOrDisabledButtons(new Array("event_alterarItemBaixa"), true);
                    setLabelButaoAlterar("Alterar Tipo Registo");
                    document.getElementById("alterarTipoRegisto").value = "";
                } else {
                    setEnabledOrDisabledButtons(new Array("event_alterarItemBaixa"), false);
                    // -- atribuir label ao butao consuante se pode alterar de Inicial para Progorração ou Progorração para Inicial
                    if(itemsBaixa[i][2] == 'P' && itemsBaixa[i][0] == itemPossivelAlterarPI && itemsBaixa[i][0] == itemPossivelAlterar){
                        setLabelButaoAlterar("Alterar p/ Inicial");
                        document.getElementById("alterarTipoRegisto").value = "I";
                    } else if(itemsBaixa[i][2] == 'I' && itemsBaixa[i][0] == itemPossivelAlterarIP && itemsBaixa[i][0] == itemPossivelAlterar){
                        setLabelButaoAlterar("Alterar p/ Progorração");
                        document.getElementById("alterarTipoRegisto").value = "P";
                    } else if(itemsBaixa[i][2] == 'A'){
                        setEnabledOrDisabledButtons(new Array("event_alterarItemBaixa"), true);
                        setLabelButaoAlterar("Alterar Tipo Registo");
                        document.getElementById("alterarTipoRegisto").value = "";
                    } else {
                        setEnabledOrDisabledButtons(new Array("event_alterarItemBaixa"), true);
                        setLabelButaoAlterar("Alterar Tipo Registo");
                        document.getElementById("alterarTipoRegisto").value = "";
                    }
                }
            }
        }
    }
    
    // -- disable ou enable de butão consuante pode alterar Item Baixa
    // -- nota: apenas pode alterar tipos Inicial ou Progorração, uma alta não pode ser alterada
    function contextoOpcaoAlterarItem(itemSeleccionado){
        for(i=0; i < itemsBaixa.length ; i++){
            // -- identificar item baixa seleccionado
            if( i == (itemSeleccionado-1) ){
                // -- se o item baixa estiver anulado faz disable ao butão
                if( itemsBaixa[i][3] == 'S'){
                    setEnabledOrDisabledButtons(new Array("event_alterar"), true);
                } else {
                    // -- apenas pode alterar registos do tipo 'I' - Inicial ou 'P' - Progorração 
                    if(itemsBaixa[i][2] == 'I' || itemsBaixa[i][2] == 'P'){
                        setEnabledOrDisabledButtons(new Array("event_alterar"), false); 
                    } else {
                        setEnabledOrDisabledButtons(new Array("event_alterar"), true);
                    }
                }
            }
        }
    }
    
    function setLabelButaoAlterar(descricao){
        var button = document.getElementById("event_alterarItemBaixa");
        if (button != null){
            button.value = descricao;
        }
    }
    
    function alterarItemBaixa(){
        // -- identificar boletim de baixa seleccionada
        var dataInicio = document.getElementById('itemBaixadp-dinicio').value;
        var dataTermo = document.getElementById('itemBaixadp-dtermo').value;
        var idBaixaSel = document.getElementById("idSelectedBaixa").value;
        var entidade = "";
        
        for(i=0; i < boletinsBaixa.length ; i++){
            if(boletinsBaixa[i][0] == idBaixaSel){
                 entidade = boletinsBaixa[i][4]; 
            }
        }
        // caso se trate de uma alteração de porrogação para inicial apenas permito a alteração caso o nº de dias
        // do item final de inicial esteja segundo as regras permitidas ou seja = ou inferior a 12 dias p/ seg social.
        var id = document.getElementById("IdItemBaixa").value;
        for(i=0; i < itemsBaixa.length ; i++){
            // -- identificar item baixa seleccionado
            if( itemsBaixa[i][0] == id ){
                if(itemsBaixa[i][4] > 12 && itemsBaixa[i][2] == 'P' && entidade == 'ERES'){
                    alert('A Baixa não pode ser alterado para Inicial. O número de dias excede o permitido.');
                    return false;
                }
            } else if(itemsBaixa[i][2] == 'I' && entidade == 'EPUB'){
                alert('A Baixa não pode ser alterado para Porrogação. A entidade do utente não permite este tipo de operação.');
                return false;
            }
        }
    
        var x = confirm("O Item Baixa seleccionado de " + dataInicio + " a " + dataTermo + " será alterado. Confirma? ");
        if(x){
            return true;
        } else {
            return false;
        }
    }
    
    function anularItemBaixa(){
        var x = confirm("O Item Baixa seleccionado será anulado. Confirma? ");
        if(x){
            return true;
        } else {
            return false;
        }
    }
    
    
</script>
<%
    String sessionIdBaixa = (String)session.getAttribute("git.ad.idBaixa");
    if (sessionIdBaixa == null) { 
        sessionIdBaixa = "0"; 
    }
    
    Integer sessionIdItemBaixa = (Integer)session.getAttribute("git.ad.idItemBaixa");
    if (sessionIdItemBaixa == null) { 
        sessionIdItemBaixa = new Integer(0); 
    }
    
    Integer sessionNumBaixas = (Integer)session.getAttribute("git.ad.listaHistBaixasNumRows");
    if (sessionNumBaixas == null) { 
        sessionNumBaixas = new Integer(0); 
    }
    
    Integer sessionNumOperacoesLog = (Integer)session.getAttribute("git.ad.listaOperacoesLogNumRows");
    if (sessionNumOperacoesLog == null) { 
        sessionNumOperacoesLog = new Integer(0); 
    }
    
    Integer pagina = (Integer)session.getAttribute("nextRangeListaHistItemsBaixas");
    if (pagina == null) { 
        pagina = new Integer(0); 
    }
    
%>
                                
<c:set value="<%=sessionIdBaixa.toString()%>" var="sessionIdBaixaJsp" />
<c:set value="<%=sessionIdItemBaixa.toString()%>" var="sessionIdItemBaixaJsp" />
<c:set value="<%=pagina.toString()%>" var="pagina" />
<html>
 <head>
    <jsp:include page="/com/head.jsp" flush="true"/>
 </head>

  <body onload="selectFirstItem('radioIdBaixa');selectFirstItem('IdItemBaixa');validaNiss();">
  <jsp:include page="/com/header.jsp" flush="true">     
      <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/>
      <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/>
      <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
      <jsp:param name="pTitle" value="Certificados de Incapacidade Tempor&aacute;ria"/>
      <jsp:param name="pOrigem" value="Baixas"/>
  </jsp:include>
  <!-- DOWN -->
  <form method="POST" id="x" name="x" action="edicaoBaixasUtente.do">
      <input type="hidden" id="alterarTipoRegisto" name="alterarTipoRegisto" value=""/>
      <input type="hidden" id="IdItemBaixaAnularAltInicial" name="IdItemBaixaAnularAltInicial" value=""/>
      
      <!-- Detalhe de Item Baixa -->
      <input type="hidden" id="itemBaixaCodTiporegisto" name="hiddenCodTipoRegisto" value="" /> 
      <input type="hidden" id="itemBaixaselectClassDoenca" name="selectClassDoenca" value="" />
      <input type="hidden" id="itemBaixainputFamiliar" name="inputFamiliar" value="" />
      <input type="hidden" id="itemBaixaselectParentesco" name="selectParentesco" value="" />
      <input type="hidden" id="itemBaixadp-dinicio" name="dp-dinicio" value="" />
      <input type="hidden" id="itemBaixadp-dtermo" name="dp-dtermo" value="" />
      <input type="hidden" id="itemBaixadp-dias" name="dp-dias" value="" />
      <input type="hidden" id="itemBaixaincActProf" name="incActProf" value="" />
      <input type="hidden" id="itemBaixacuiIna" name="cuiIna" value="" />
      <input type="hidden" id="itemBaixainternamento" name="internamento" value="" />
      <input type="hidden" id="itemBaixaautorizacao" name="autorizacao" value="" />
      <input type="hidden" id="itemBaixajustificacao" name="justificacao" value="" />
      <input type="hidden" id="BaixaincActProf" name="incActProf" value="" />
      <input type="hidden" id="BaixacuiIna" name="cuiIna" value="" />
      <input type="hidden" id="Baixainternamento" name="internamento" value="" />
      <input type="hidden" id="Baixaautorizacao" name="autorizacao" value="" />
      <input type="hidden" id="Baixajustificacao" name="justificacao" value="" />
      
      <input type="hidden" id="buttonForm" name="buttonForm" value="Alterar"> 
      <input type="hidden" id="idSelectedBaixa" name="idSelectedBaixa" value="<c:out value="${sessionIdBaixaJsp}"/>" />
      
      <!-- master table page -->
      <table cellpadding="0" cellspacing="2" border="0" width="85%">
      <tr>
        <td>
          <h4>Hist&oacute;rico de Incapacidades Tempor&aacute;rias</h4>
        </td>
      </tr>
      
      <!-- Opcoes e Accoes sobre as baixas -->
      <tr id="trAreaBaixas"><td>
      
      
      <% 
      if (sessionNumBaixas.intValue() != 0) { %>
      
      <!-- Lista de Baixas do Utente -->
      <table cellpadding="0" cellspacing="0" border="0">
          <tr> 
          <td>
                <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                  <tr class="head">
                    <th class="selectionCol" nowrap>-</th>
                    <th class="colTextOne"   nowrap><c:out value="N.º Boletim"/></th>
                    <th class="colTextOne"   nowrap><c:out value="Data Início"/></th>
                    <th class="colTextOne"   nowrap><c:out value="Data Alta"/></th>
                    <th class="colTextOne"   nowrap><c:out value="Tipo Registo"/></th>
                    <th class="colTextTwo"   nowrap><c:out value="Centro Saúde"/></th>
                    <th class="colTextFour"  nowrap><c:out value="Médico"/></th>
                  </tr>
                    <c:forEach var="RowListaBaixas" items="${bindings.ListaHistBaixas.rangeSet}" varStatus="lineListaBaixas">
                    <script type="text/javascript">
                        boletinsBaixa[contadorBoletinsBaixa] = new Array(5);
                        boletinsBaixa[contadorBoletinsBaixa][0] = '<c:out value="${RowListaBaixas[\'Id\']}"/>';
                        boletinsBaixa[contadorBoletinsBaixa][1] = '<c:out value="${RowListaBaixas[\'Tiporegisto\']}"/>';
                        boletinsBaixa[contadorBoletinsBaixa][2] = '<c:out value="${RowListaBaixas[\'Codtiporegisto\']}"/>';
                        boletinsBaixa[contadorBoletinsBaixa][3] = '<c:out value="${RowListaBaixas[\'Estado\']}"/>';
                        boletinsBaixa[contadorBoletinsBaixa][4] = '<c:out value="${RowListaBaixas[\'Codigoentidadepub\']}"/>';
                        contadorBoletinsBaixa++;
                    </script>  
                    
                       <c:choose>
                              <c:when test="${RowListaBaixas[\'Id\'] == sessionIdBaixaJsp}">
                                    <c:choose>
                                        <c:when test="${RowListaBaixas['Estado'] == 'S'}">
                                            <tr class="highlightANULADO"> 
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="highlight"> 
                                        </c:otherwise>
                                    </c:choose>
                              </c:when>
                       <c:otherwise>
                       <c:choose>
                        <c:when test="${lineListaBaixas.count % 2 != 0}">
                            <c:choose>
                                <c:when test="${RowListaBaixas['Estado'] == 'S'}">
                                    <tr class="evenANULADO"> 
                                </c:when>
                                <c:otherwise>
                                    <tr class="even"> 
                                </c:otherwise>
                            </c:choose>
                        </c:when>   
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${RowListaBaixas['Estado'] == 'S'}">
                                    <tr class="oddANULADO"> 
                                </c:when>
                                <c:otherwise>
                                    <tr class="odd"> 
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                      </c:choose>
                      </c:otherwise>
                      </c:choose>
                      
                      <c:choose>
                          <c:when test="${RowListaBaixas[\'Id\'] == sessionIdBaixaJsp}">
                                <td class="selection" nowrap><input type="radio" id="radioIdBaixa" name="radioIdBaixa" title="Seleccionar Baixa" value="<c:out value="${RowListaBaixas[\'Id\']}"/>" checked="true" /></td>
                          </c:when>
                          <c:otherwise>
                             <td class="selection" nowrap><input type="radio" id="radioIdBaixa" name="radioIdBaixa" title="Seleccionar Baixa" value="<c:out value="${RowListaBaixas[\'Id\']}"/>" onClick="seleccionaBoletimBaixa(this,${lineListaBaixas.count}); selectBaixa();"/></td>
                          </c:otherwise>
                      </c:choose>
                      
                      <td class="numeric" nowrap><c:out value="${RowListaBaixas[\'NumBoletim\']}"/></td>
                      <td class="date"    nowrap><c:out value="${RowListaBaixas[\'DataInicioTotal\']}"/></td>
                      <td class="date"    nowrap><c:out value="${RowListaBaixas[\'Dataalta\']}"/> <c:if test="${RowListaBaixas[\'Dataalta\'] == null}"> <c:set var="idBaixaAberta" value="${RowListaBaixas[\'Id\']}"/></c:if> </td>
                      <td class="date"    nowrap><c:out value="${RowListaBaixas[\'Tiporegisto\']}"/></td>
                      <td class="date"    nowrap><c:out value="${RowListaBaixas[\'Entidade\']}"/></td>
                      <td class="text"    nowrap><c:out value="${RowListaBaixas[\'Profissional\']}"/></td>
                      <!--<td class="text"    nowrap><c:out value="${RowListaBaixas[\'Estado\']}"/></td>-->
                    </tr>
                  </c:forEach>
                </table>
               
                <table id="navigationTable" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td>
                        <jsp:include page="/com/navigationList.jsp" flush="false">
                          <jsp:param name="rangeBindingName" value="ListaHistBaixas"/>                      
                          <jsp:param name="listaNumRowsName" value="git.ad.listaHistBaixasNumRows"/>    
                          <jsp:param name="targetPageName" value="edicaoBaixasUtente.do"/>
                        </jsp:include> 
                     </td>
                  </tr>
                </table>
              
                <br><br>
            
            <!-- Opções sobre items baixa -->
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr><td>
                <input id="event_alterar" name="event_alterar" class="submitButton" type="submit" value="Alterar" onclick="this.form.action='../git/edicaoBaixa.do?gitad=S'; this.form.submit();"></input>
                <input id="event_alterarItemBaixa" name="event_alterarItemBaixa" class="submitButton" type="submit" value="Alterar Tipo Registo" onclick="alterarItemBaixa();"></input>
                <input id="event_anularItemBaixa" name="event_anularItemBaixa" class="submitButton buttonDisabled" type="button" value="Anular" onclick="popUpGITMotivoAnulacaoLOV(true);" disabled></input>
            </td></tr>
            </table>
            
            <br>
            
            <!-- ITEMS BAIXA -->
            <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                  <tr class="head">
                    <th>-</th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Tiporegisto\']}"/></th>
                    <th class="colTextTwo" nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Classdoenca\']}"/></th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Datainicio\']}"/></th>
                    <th nowrap>Dias</th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Datatermo\']}"/></th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Incapacitado\']}"/></th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Cuidadosinadiaveis\']}"/></th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Internamento\']}"/></th>
                    <th nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Autorizsaida\']}"/></th>
                    <th class="colTextTwo" nowrap><c:out value="Centro Saúde"/></th>
                    <th class="colTextTwo" nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Medico\']}"/></th>
                    <th class="colTextTwo" nowrap><c:out value="${bindings.ListaHistItemsBaixas.labels[\'Datacriacao\']}"/></th>
                    <!--<th class="colTextOne" nowrap><c:out value="Estado"/></th>-->
                  </tr>    
                 
                  <c:forEach var="RowListaItemsBaixas" items="${bindings.ListaHistItemsBaixas.rangeSet}" varStatus="lineListaItemsBaixas">
                  <script type="text/javascript">
                        itemsBaixa[contadorItemsBaixa] = new Array(5);
                        itemsBaixa[contadorItemsBaixa][0] = '<c:out value="${RowListaItemsBaixas[\'Id\']}"/>';
                        itemsBaixa[contadorItemsBaixa][1] = '<c:out value="${RowListaItemsBaixas[\'Tiporegisto\']}"/>';
                        itemsBaixa[contadorItemsBaixa][2] = '<c:out value="${RowListaItemsBaixas[\'Codigoitembaixa\']}"/>';
                        itemsBaixa[contadorItemsBaixa][3] = '<c:out value="${RowListaItemsBaixas[\'Estado\']}"/>';
                        itemsBaixa[contadorItemsBaixa][4] = '<c:out value="${RowListaItemsBaixas[\'Diasbaixa\']}"/>';
                        contadorItemsBaixa++;
                  </script>
                    
                    <c:choose>
                          <c:when test="${RowListaItemsBaixas[\'Id\'] == sessionIdItemBaixaJsp}">
                                <c:choose>
                                    <c:when test="${RowListaItemsBaixas['Estado'] == 'S'}">
                                        <tr class="highlightANULADO"> 
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="highlight"> 
                                    </c:otherwise>
                                </c:choose>
                          </c:when>
                    <c:otherwise>
                    <c:choose>
                    <c:when test="${lineListaItemsBaixas.count % 2 != 0}">
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas['Estado'] == 'S'}">
                                <tr class="evenANULADO"> 
                            </c:when>
                            <c:otherwise>
                                <tr class="even"> 
                            </c:otherwise>
                        </c:choose>
                     </c:when>   
                     <c:otherwise>
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas['Estado'] == 'S'}">
                                <tr class="oddANULADO"> 
                            </c:when>
                            <c:otherwise>
                                <tr class="odd"> 
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                    </c:choose>
                    </c:otherwise>
                    </c:choose>
                      
                    <td class="selection">
                        <input type="radio" name="IdItemBaixa" id="IdItemBaixa" title="Seleccionar Item Baixa" value="<c:out value="${RowListaItemsBaixas[\'Id\']}"/>" 
                                    <c:if test="${RowListaItemsBaixas[\'Id\'] == sessionIdItemBaixaJsp}">checked</c:if>
                                    onClick=" seleccionaItemBaixa(this,${lineListaItemsBaixas.count});
                                    
                                              contextoOpcaoAlterar(${lineListaItemsBaixas.count}, ${RowListaItemsBaixas['Itempossivelalterarip']}, ${RowListaItemsBaixas['Itempossivelalterarpi']}, ${RowListaItemsBaixas['Itempossivelalterartipo']}); 
                                              contextoOpcaoAlterarItem(${lineListaItemsBaixas.count}); 
                                              document.getElementById('IdItemBaixa').value = '<c:out value="${RowListaItemsBaixas[\'Id\']}"/>';
                                              document.getElementById('itemBaixaCodTiporegisto').value = '<c:out value="${RowListaItemsBaixas[\'Codigoitembaixa\']}"/>';
                                              document.getElementById('itemBaixaselectClassDoenca').value = '<c:out value="${RowListaItemsBaixas[\'Idclassdoenca\']}"/>';
                                              document.getElementById('itemBaixainputFamiliar').value = '<c:out value="${RowListaItemsBaixas[\'Nomefamiliar\']}"/>';
                                              document.getElementById('itemBaixaselectParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Idparentesco\']}"/>';
                                              document.getElementById('itemBaixadp-dinicio').value = '<c:out value="${RowListaItemsBaixas[\'Datainicio\']}"/>';
                                              document.getElementById('itemBaixadp-dtermo').value = '<c:out value="${RowListaItemsBaixas[\'Datatermo\']}"/>';
                                              document.getElementById('itemBaixadp-dias').value = '<c:out value="${RowListaItemsBaixas[\'Diasbaixa\']}"/>';
                                              document.getElementById('itemBaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';
                                              document.getElementById('itemBaixacuiIna').value = '<c:out value="${RowListaItemsBaixas[\'Cuidadosinadiaveis\']}"/>';
                                              document.getElementById('itemBaixainternamento').value = '<c:out value="${RowListaItemsBaixas[\'Internamento\']}"/>';
                                              document.getElementById('itemBaixaautorizacao').value = '<c:out value="${RowListaItemsBaixas[\'Autorizsaida\']}"/>';
                                              document.getElementById('itemBaixajustificacao').value = '<c:out value="${RowListaItemsBaixas[\'Justificacao\']}"/>';
                                            
                                              document.getElementById('BaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';
                                              document.getElementById('BaixacuiIna').value = '<c:out value="${RowListaItemsBaixas[\'Cuidadosinadiaveis\']}"/>';
                                              document.getElementById('Baixainternamento').value = '<c:out value="${RowListaItemsBaixas[\'Internamento\']}"/>';
                                              document.getElementById('Baixaautorizacao').value = '<c:out value="${RowListaItemsBaixas[\'Autorizsaida\']}"/>';
                                              document.getElementById('Baixajustificacao').value = '<c:out value="${RowListaItemsBaixas[\'Justificacao\']}"/>';
                                              
                                              document.getElementById('IdItemBaixaAnularAltInicial').value = '<c:out value="${RowListaItemsBaixas[\'Itemmanaanularalteracaoinicial\']}"/>';
                                             
                                              <%-- We cannot annul an ItemBaixa, unless it's the last one given by the Profissional --%> 
                                              <c:choose> 
                                                 <c:when test="${RowListaItemsBaixas[\'Id\'] == RowListaItemsBaixas[\'Itempossivelanular\']}">   
                                                    enableButton(document.getElementById('event_anularItemBaixa'),'${lineListaItemsBaixas.count}');
                                                 </c:when>
                                                 <c:otherwise>
                                                    disableButton(document.getElementById('event_anularItemBaixa')); 
                                                 </c:otherwise>
                                              </c:choose>
                                                            
                                    " />
                    </td>
                    <td class="text"><c:out value="${RowListaItemsBaixas[\'Tiporegisto\']}"/></td>
                    <td class="text"><c:out value="${RowListaItemsBaixas[\'Classdoenca\']}"/></td>
                    <td class="date"><c:out value="${RowListaItemsBaixas[\'Datainicio\']}"/></td>
                    <td class="numeric"><c:out value="${RowListaItemsBaixas[\'Datainicio\']}"/></td>
                    <td class="date"><c:out value="${RowListaItemsBaixas[\'Diasbaixa\']}"/></td>
                    <td class="text">
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas[\'Incapacitado\']=='S'}">   
                                <input type="checkbox" checked="checked" onclick="maintainCheck(this);" title="Incapacitado" />
                            </c:when>
                            <c:otherwise>
                                 <input type="checkbox" onclick="maintainCheck(this);" title="Incapacitado"/>
                            </c:otherwise>
                        </c:choose> 
                    </td>
                    <td class="text">
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas[\'Cuidadosinadiaveis\']=='S'}">   
                                <input type="checkbox" checked="checked" onclick="maintainCheck(this);" title="Cuidados Inadiáveis"/>
                            </c:when>
                            <c:otherwise>
                                 <input type="checkbox" onclick="maintainCheck(this);" title="Cuidados Inadiáveis"/>
                            </c:otherwise>
                        </c:choose> 
                    </td>
                    <td class="text">
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas[\'Internamento\']=='S'}">   
                                <input type="checkbox" checked="checked" onclick="maintainCheck(this);" title="Internamento"/>
                            </c:when>
                            <c:otherwise>
                                 <input type="checkbox" onclick="maintainCheck(this);" title="Internamento"/>
                            </c:otherwise>
                        </c:choose> 
                    </td>
                    <td class="text">
                        <c:choose>
                            <c:when test="${RowListaItemsBaixas[\'Autorizsaida\']=='S'}">   
                                <input type="checkbox" checked="checked" title="Autorização Saida: <c:out value="${RowListaItemsBaixas[\'Justificacao\']}"/>" onclick="maintainCheck(this);" />
                            </c:when>
                            <c:otherwise>
                                 <input type="checkbox" title="Autorização Saida: Não está autorizado a sair" onclick="maintainCheck(this);"/>
                            </c:otherwise>
                        </c:choose> 
                    </td>
                    <td class="date"><c:out value="${RowListaItemsBaixas[\'Entidade\']}"/></td>
                    <td class="text"><c:out value="${RowListaItemsBaixas[\'Medico\']}"/></td>
                    <td class="date"><c:out value="${RowListaItemsBaixas[\'Datacriacao\']}"/></td>
                  </tr>
                  
                  </c:forEach>
             
                </table>
                
                <table id="navigationTable" cellpadding="0" cellspacing="0" border="0">
                <tr><td>
                    <jsp:include page="/com/navigationList.jsp" flush="false">
                      <jsp:param name="rangeBindingName" value="ListaHistItemsBaixas"/>                      
                      <jsp:param name="listaNumRowsName" value="git.ad.listaHistItemsBaixasNumRows"/>    
                      <jsp:param name="targetPageName" value="edicaoBaixasUtente.do"/>
                    </jsp:include>
                </td></tr>
                </table>
                
                
                <!-- Lista Operacoes Especiais -->
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                      <td>
                        <h4>Log de Operações Especiais</h4>
                      </td>
                    </tr>
                </table>
                
                <% if (sessionNumOperacoesLog.intValue() != 0) { %>
                
                <c:forEach var="row" items="${bindings.ListaOperacoesLog.rangeSet}" varStatus="line">
                
                    <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0" width="100%">  
                      <c:if test="${line.count == 1}">  
                          <tr class="head">
                            <th nowrap><c:out value="${bindings.ListaOperacoesLog.labels[\'CreationDate\']}"/></th>
                            <th nowrap><c:out value="${bindings.ListaOperacoesLog.labels[\'SysCodGenericosId\']}"/></th>
                            <th nowrap><c:out value="${bindings.ListaOperacoesLog.labels[\'ProProfissidId\']}"/></th>
                            <th nowrap><c:out value="${bindings.ListaOperacoesLog.labels[\'SysEntidadesId\']}"/></th>
                            <th nowrap><c:out value="${bindings.ListaOperacoesLog.labels[\'ScgMotivoAnulacaoId\']}"/></th>
                          </tr>
                      </c:if>
                      <c:choose>
                        <c:when test="${line.count % 2 != 0}">
                            <tr class="even"> 
                        </c:when>   
                        <c:otherwise>
                            <tr class="odd">
                        </c:otherwise>
                      </c:choose>
                      <td class="date" nowrap><c:out value="${row[\'CreationDate\']}"/></td>
                      <td class="date" nowrap><c:out value="${row[\'Tipooperacao\']}"/></td>
                      <td class="date" nowrap><c:out value="${row[\'Nomeprofissional\']}"/></td>
                      <td class="date" nowrap><c:out value="${row[\'Desccentrosaude\']}"/></td>
                      <td class="date" nowrap><c:out value="${row[\'Motivoanulacao\']}"/></td>
                    </tr>
                    </table>
                    
                    <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0" width="100%">
                        <c:choose>
                        <c:when test="${line.count % 2 != 0}">
                            <tr class="even"> 
                        </c:when>   
                        <c:otherwise>
                            <tr class="odd">
                        </c:otherwise>
                        </c:choose>
                          <td class="date"><c:out value="${row[\'ComentarioAnulacao\']}"/></td>
                        </tr>
                    </table>
                </c:forEach>
                
               
               
                <table id="navigationTable" cellpadding="0" cellspacing="0" border="0">
                  <tr>
                    <td>
                        <jsp:include page="/com/navigationList.jsp" flush="false">
                          <jsp:param name="rangeBindingName" value="ListaOperacoesLog"/>                      
                          <jsp:param name="listaNumRowsName" value="git.ad.listaOperacoesLogNumRows"/>    
                          <jsp:param name="targetPageName" value="edicaoBaixasUtente.do"/>
                        </jsp:include> 
                     </td>
                  </tr>
                </table>
                
                <% // -- se a baixa não tem registos associados faz display de mensagem alusiva a isso mesmo
                } else {  %>
                  <i>Baixa sem operações especiais registadas.</i>
                <%} %>
                
            </td> 
          </tr>
      </table>
      
      <% // -- se o utente nao tem baixas nao mostra a area de baixas e de items baixa
        } else {  %>
         Este utente não tem baixas registadas
      <%} %>
      
      <!-- Legenda -->
      <% if (sessionNumBaixas != 0) { %>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr class="head"><td colspan="10"><br><br>
            <fieldset class="legendFieldSet">
            <legend class="legend">Legenda</legend>
            <table id="legendTable" width="1%" border="0" cellpadding="0" cellspacing="0">
                <tr><td nowrap><c:out value="I - Incapacidade para Actividade Profissional; C - Cuidados Inadidiáveis; T - Internamento; A - Autorização;"/></td></tr>
                <tr><td nowrap><font color="red"><c:out value="Registos a Vermelho"/></font><c:out value=" - Anulações;"/></td></tr>
        </table>
        </fieldset>
        </td></tr></table>
      <% } %>
      
      </td></tr></table>
  
  </form>
  </body>
  
  <!-- UP -->
</html>