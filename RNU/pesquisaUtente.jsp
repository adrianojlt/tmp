<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title>pesquisa de utentes</title>
    <jsp:include page="/com/head.jsp" flush="true"/>
  </head>
<body onload="splash(false); onloadFirstTime(); ">

  <jsp:include page="/com/header.jsp" flush="true">     
    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
    <jsp:param name="pTitle" value="Manuten&ccedil;&atilde;o Utente"/>
  </jsp:include>

  <script type="text/javascript" charset="UTF-8" src="../js/identificacao.js"></script>
  <script type="text/javascript" charset="UTF-8" src="../js/pesquisaUtente.js"></script>

  <%-- TODO: rever a forma como se controla a entrada de edicão ou consulta --%>
  <%
    String pReadOnlyMode = "true";   
    if(session.getAttribute("idu.readOnlyMode")==null) {
        pReadOnlyMode = request.getParameter("pReadOnlyMode")==null ? "true" : (String)request.getParameter("pReadOnlyMode");
        session.setAttribute("idu.readOnlyMode",pReadOnlyMode);
    } else {
        pReadOnlyMode = (String)session.getAttribute("idu.readOnlyMode");
    }
  %>
  
  
<c:set var="pReadOnlyMode" value="<%=pReadOnlyMode%>"/>
  
  <script charset="UTF8" type="text/javascript">
    
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
    myArray0[11] = "pNif";
    myArray0[12] = "pNumDocIdent";
    myArray0[13] = "pTipoDocIdent";
    myArray0[13] = "pSexo";
    
    function onloadFirstTime(){
        document.getElementById("pPesquisaEfectuada").value = 'true';
        if (document.getElementById("pPesquisaEfectuada").value.length <= 0 ){
            document.getElementById("pPesquisaEfectuada").value = 'false';
            document.getElementById("pPesquisaAvancada").value = 'false';
        }
        posicionaPesquisaAvancSimp();
    }
    
    function isSelectedSexo(sel){
            if(sel == "true"){return "selected"}
    
    }
     
    
    function disponibilizaOpcoes(isSupervisor){

        var numeroUtentesEmPesquisa = document.getElementById('numeroUtentesEmPesquisa').value;

        if(numeroUtentesEmPesquisa > 1){
            setEnabledOrDisabledButtons(new Array('selectUtente','editUtente', 'consultarUtente', 'potDuplicado'), false);
        } else {
            setEnabledOrDisabledButtons(new Array('selectUtente','editUtente', 'consultarUtente'), false);
        }

        // se utente seleccionado esta marcado como óbito faz disable da opção de seleccionar e editar
        var registos = document.getElementsByName("selID");

        for (var j = 0 ; j < registos.length ; j++) {
            if(registos[j].checked){
                // verificar se registos está marcado como óbito
                for (var i = 0 ; i < obitos.length ; i++) {
                    if(registos[j].value == obitos[i]){
                        // é obito (n deixa seleccionar nem editar, apenas deixa consultar)
                        //26/11/2013 - Supervisores podem aceder á página de edição para alteração dos dados dos documentos
                        if(isSupervisor==true){
                            setEnabledOrDisabledButtons(new Array('selectUtente'), true);
                        }
                        else{
                            setEnabledOrDisabledButtons(new Array('selectUtente','editUtente'), true);
                        }
                        break;
                    }
                }
            }
        }
    }

    
  </script>
  <!-- DOWN -->
    <form id="forma" name="forma" action="pesquisaUtente.do" method="POST" onSubmit="splash(true);">
    <fieldset>
        <input type="hidden" id="pPesquisaAvancada" name="pPesquisaAvancada" value="${param.pPesquisaAvancada}">
        <input type="hidden" id="pPesquisaTipoEfectuada" name="pPesquisaTipoEfectuada" value="${param.pPesquisaTipoEfectuada}">
        <input type="hidden" id="pPesquisaEfectuada" name="pPesquisaEfectuada" value="${param.pPesquisaEfectuada}">
        <input type="hidden" id="pDesabilita" name="pDesabilita" value="false">
        <input type="hidden" id="pPaisNatDesc" name="pPaisNatDesc" value="${param.pPaisNatDesc}">
        <input type="hidden" id="pPaisNacDesc" name="pPaisNacDesc" value="${param.pPaisNacDesc}">
        <input type="hidden" id="pPaisNatId" name="pPaisNatId" value="${param.pPaisNatId}">
        <input type="hidden" id="pPaisNacId" name="pPaisNacId" value="${param.pPaisNacId}">
        <input type="hidden" id="idEvent" name="event" value=""/>
        <input type="hidden" id="idEventTipo" name="idEventTipo" value=""/>

        
        <input type="hidden" id="numeroUtentesEmPesquisa" name="numeroUtentesEmPesquisa" value="">
        
        <!-- inputs para seleção de linha-->
        <input type="hidden" id="hiddenSelectedId" name="hiddenSelectedId" value="">
        <input type="hidden" id="hiddenSelectedNumUtente" name="hiddenSelectedNumUtente" value=""> 
        <input type="hidden" id="hiddenSelectedNome" name="hiddenSelectedNome" value="">
        <input type="hidden" id="hiddenSelectedDtNasc" name="hiddenSelectedDtNasc" value="">
        <input type="hidden" id="hiddenSelectedMorada" name="hiddenSelectedMorada" value="">
        <input type="hidden" id="hiddenSelectedDocIdentif" name="hiddenSelectedDocIdentif" value="">
        <input type="hidden" id="hiddenSelectedCentroSaude" name="hiddenSelectedCentroSaude" value="">
    </fieldset>
        <h4>Pesquisa de Utente</h4>
        <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
            <tr>
                <td class="inputLabel">Nº Utente:</td>
                <td class="inputCell" colspan="3">
                    <input id="nSNS" name="nSNS" type="text" class="inputTextOne" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" value="${param.nSNS}"/>
                </td>
            </tr>
            <tr>
                <td class="inputLabel">Nome:</td>
                <td class="inputCell" colspan="3">
                        <input id="nomes" name="nomes" type="text" class="inputTextSix" value="${param.nomes}" maxlength="200" onkeypress="noSpecialCaracters(this);focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noSpecialCaracters(this);" onblur="noSpecialCaracters(this);" />
                </td>
            </tr>

            <tr>
                <td class="inputLabel">Idade de:</td>
                <td class="inputCell">
                    <span style="white-space:nowrap; vertical-align: bottom;">
                        <input id="idadeDe" name="idadeDe" type="text" class="inputTextZero" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeDe');" value="${param.idadeDe}" style="width: 25px;"/>
                        a
                        <input id="idadeA" name="idadeA" type="text" class="inputTextZero" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeAte');" value="${param.idadeA}" style="width: 25px;"/>
                        
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}">
                                 <img class="imgCursorNone" alt="Limpa" src="../img/cross_disabled.gif" />  
                            </c:when>                     
                            <c:otherwise>
                                <img class="img" alt="Limpa" id="crossIdadeDeA" src="../img/cross.gif" onclick="resetValores(new Array('idadeDe','idadeA'));" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                </td>
                <td class="inputLabel">Data Nascimento:</td>
                <td class="inputCell">
                    <c:choose>
                    <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && not empty param.pPesquisaTipoEfectuada }">
                        <input id="dataNasc" name="dataNasc" type="text" class="inputTextOne disabled" value="${param.dataNasc}" />   
                    </c:when>
                    <c:otherwise>
                        <input id="dataNasc" name="dataNasc" type="text" class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" maxlength="10" value="${param.dataNasc}" onkeypress="valData(this,event); focusObjectOnEnterPressed(event,'pesquisa'); " onkeyup="valData(this,event);" onblur="valData(this,event);"/>
                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
            </table>
            
            <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
                <tr id="pqAvanc0">
                    <td class="inputLabel">NISS:</td>
                    <td class="inputCell" colspan="2">
                        <input id="pNiss" name="pNiss" type="text" class="inputTextTwo" onkeyup="noAlpha(this);" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" value="${param.pNiss}" maxlength="100"/>
                    </td>
                </tr>
                <tr id="pqAvanc1">
                    <td class="inputLabel">NIF:</td>
                    <td class="inputCell" colspan="2">
                        <input id="pNif" name="pNif" type="text" class="inputTextTwo" onkeyup="noAlpha(this);" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" value="${param.pNif}" maxlength="100"/>
                    </td>
                </tr>
                <tr id="pqAvanc2">
                    <td class="inputLabel">Doc. Ident:</td>
                    <td class="inputCell" colspan="2">
                        <select id="pTipoDocIdent" name="pTipoDocIdent" class="inputChoiceTwo" onkeypress="focusObjectOnEnterPressed(event,'pesquisa');" onchange="document.getElementById('pCodTipoDocIdent').value = this.value;">
                            <option value="" title="" label=""/>
                            <c:forEach var="Row" items="${bindings.ListaCodigosGenericos1.rangeSet}" varStatus="lineListaCodigosGenericos">
                                <c:if test="${Row.TipocodigoCodtipo == 'TPBI'}">                            
                                    <c:choose>
                                        <c:when test="${empty param.pTipoDocIdent ? false : Row.Codigo==param.pTipoDocIdent }">
                                            <option value="${Row.Codigo}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}" selected><c:out value="${Row.Descricao}"/></option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${Row.Codigo}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                        
                            </c:forEach>
                        </select>
                        
                        <input type="hidden" id="pCodTipoDocIdent" name="pCodTipoDocIdent" value="${param.pCodTipoDocIdent}" />
                    </td>
                    <td class="inputCell" colspan="2">
                        <input id="pNumDocIdent" name="pNumDocIdent" type="text" class="inputTextOne" onkeypress="focusObjectOnEnterPressed(event,'pesquisa');" value="${param.pNumDocIdent}" maxlength="100" />
                    </td>
                </tr>
                
                
                <tr id="pqAvanc3">
                    <td class="inputLabel">Sexo:</td>
                    <td class="inputCell" colspan="2">
                           <select id="pSexo" name="pSexo" class="inputChoiceTwo" onkeypress="focusObjectOnEnterPressed(event,'pesquisa');" onchange="document.getElementById('pSexo').value = this.value;" >
                                <option value="" title="" label="" />
                                <option value="F" title="Feminino" label="Feminino" ${param.pSexo=='F'?'selected':''}>Feminino</option>
                                <option value="M" title="Masculino" label="Masculino"  ${param.pSexo=='M'?'selected':''} >Masculino</option>
                        </select>
                    </td>
                 </tr>
                    
                <!--
                <tr id="pqAvanc1">
                    <td class="inputLabel">N&ordm; Operacional:</td>
                    
                    <td class="inputCell" colspan="2">
                        <input id="nOP" name="nOP" type="text" class="inputTextTwo" onkeypress="noAlpha(this);" onkeyup="noAlpha(this);" value="${param.nOP}"/>
                    </td>
                </tr>
                -->
            </tbody>
            </table>
            
            <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
                <tr id="pqAvanc4">
                    <td class="inputLabel">Migrante?:</td>
                    <td class="inputCell" colspan="2">
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentes.currentRow}">
                                      <input id="pMigrante" name="pMigrante" type="checkbox" value="S" disabled="true"
                                            <c:if test="${param.pMigrante=='S'}"> checked </c:if> />
                            </c:when>                     
                            <c:otherwise>
                                     <input id="pMigrante" name="pMigrante" type="checkbox" value="S" 
                                            <c:if test="${param.pMigrante=='S'}"> checked </c:if> />
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
            </table>
            
            <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody> 
                <tr id="pqAvanc5">
                    <td class="inputLabel">Naturalidade:</td>
                    <td class="inputCell" colspan="2">&nbsp;</td>
                </tr>
                <tr id="pqAvanc6">
                    <td class="inputLabel">&nbsp;</td>
                    <td class="inputLabel">Pa&iacute;s:</td>
                    <td class="inputCell">
                    <span style="white-space:nowrap; vertical-align: bottom;">
                    <c:choose>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='true'}">
                            <input id="paisNatDesc" name="paisNatDesc" type="text" value="${param.pPaisNatDesc}" class="inputTextThree disabled" readonly/>
                        </c:when>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}"> 
                            <input id="paisNatDesc" name="paisNatDesc" type="text" value="" class="inputTextThree disabled" readonly/>
                        </c:when>                        
                        <c:otherwise>
                            <select id="paisNat" name="paisNat" class="inputChoiceThree" onchange="controlaPaisNat();" onkeypress="focusObjectOnEnterPressed(event,'pesquisa');" >
                                <option value="" label=""/>
                                <%-- caso nao tenha sido escolhida nenhuma opcao coloca portugal por defeito --%>
                                
                                <c:forEach var="Row" items="${bindings.ListaPaisesLov.rangeSet}" varStatus="lineListaPaisesLov">

                                    <c:set var="idPaisNat" value="${param.idPaisNat}"/>
                                    <c:choose>
                                        <c:when test="${ ( Row.Id == idPaisNat ) || ( Row.Codigo == 'PT' && idPaisNat == '' ) }">
                                            <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}" selected><c:out value="${Row.Descricao}"/></option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='true'}">
                            <img class="imgCursorNone" alt="Limpa"  src="../img/cross_disabled.gif" />
                        </c:when>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}"> 
                            <img class="imgCursorNone" alt="Limpa"  src="../img/cross_disabled.gif" />
                        </c:when>                        
                        <c:otherwise>
                            <img class="imgCursorNone" alt="Limpa"  name="crossPaisNat" id="crossPaisNat" src="../img/cross.gif" onclick="if(document.getElementById('pDesabilita').value!='true'){limpa('PaisNat');}" />
                        </c:otherwise>
                    </c:choose>
                    </span>
                    </td>
                </tr>
                
                
                <tr id="pqAvanc7">
                    <td class="inputCell">
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentesIterator.currentRow}">
                                <c:set var="entradaEmDistConcFreg" value="false"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="entradaEmDistConcFreg" value="true"/>
                            </c:otherwise>
                        </c:choose>
                        
                        <jsp:include page="/com/distConcFreg.jsp" flush="true">
                            <jsp:param name="pEditMode" value="${entradaEmDistConcFreg}"/>
                            
                            <jsp:param name="DistritoChaveId" value="Distrito"/>
                            <jsp:param name="idDistrito" value="idDistrito"/>
                            <jsp:param name="idDistritoValue" value="${param.idDistrito}"/>
                            <jsp:param name="nomeDistrito" value="nomeDistrito"/>
                            <jsp:param name="nomeDistritoValue" value="${param.nomeDistrito}"/>
                            
                            <jsp:param name="ConcelhoChaveId" value="Concelho"/>
                            <jsp:param name="idConcelho" value="idConcelho"/>
                            <jsp:param name="idConcelhoValue" value="${param.idConcelho}"/>
                            <jsp:param name="nomeConcelho" value="nomeConcelho"/>
                            <jsp:param name="nomeConcelhoValue" value="${param.nomeConcelho}"/>
                            
                            <jsp:param name="FreguesiaChaveId" value="Freguesia"/>
                            <jsp:param name="idFreguesia" value="idFreguesia"/>
                            <jsp:param name="idFreguesiaValue" value="${param.idFreguesia}"/>
                            <jsp:param name="nomeFreguesia" value="nomeFreguesia"/>
                            <jsp:param name="nomeFreguesiaValue" value="${param.nomeFreguesia}"/>
                        </jsp:include>
                    </td>
                </tr>
                
                <tr id="pqAvanc8">
                <td class="inputLabel">Nacionalidade:</td>
                <td class="inputCell" colspan="2">
                    <span style="white-space:nowrap; vertical-align: bottom;">
                    <c:choose>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='true'}">                    
                            <input id="paisNacDesc" name="paisNacDesc" type="text" value="${param.pPaisNacDesc}" style="width:205px;" class="inputTextThree disabled" readonly/>
                        </c:when>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}">                    
                            <input id="paisNacDesc" name="paisNacDesc" type="text" value="" class="inputTextThree disabled" style="width:209px;" readonly/>
                        </c:when>
                        <c:otherwise>
                              <select id="paisNac" name="paisNac" class="inputChoiceThree" style="width:209px;" onkeypress="focusObjectOnEnterPressed(event,'pesquisa');">
                                    <option value="" label=""/>
                                    <%-- caso nao tenha sido escolhida nenhuma opcao coloca portugal por defeito --%>
                                    <c:forEach var="Row" items="${bindings.ListaPaisesLov.rangeSet}" varStatus="lineListaPaisesLov">
                                        <c:set var="idPaisNac" value="${param.idPaisNac}"/>
                                        <c:choose>
                                            <c:when test="${ ( Row.Id == idPaisNac) || ( Row.Codigo == 'PT' && idPaisNac == '' ) }">
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}" selected><c:out value="${Row.Descricao}"/></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='true'}">                    
                            <img alt="Limpa" style="cursor:pointer;" src="../img/cross_disabled.gif" />
                        </c:when>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}">                    
                            <img alt="Limpa" style="cursor:pointer;" src="../img/cross_disabled.gif" />
                        </c:when>
                        <c:otherwise>
                            <img alt="Limpa" style="cursor:pointer;" name="crossPaisNac" id="crossPaisNac" src="../img/cross.gif" onclick="if(document.getElementById('pDesabilita').value!='true'){limpa('PaisNac'); }" />
                        </c:otherwise>
                    </c:choose>
                    </span>
                </td>
                </tr>
            </tbody>
            </table>    
            
            <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
                <thead/>
                <tbody>
                <tr>
                    <td>
                        <%-- 
                            nota: o botão para novo utente apenas estará disponível caso seja introduzido na pesquisa 
                            o nome (pelo menos dois nomes) e a data de nascimento.
                            
                            nota2: nas maternidades deve ser possivel consultar utentes e inscrever os recém-nascidos (perfil 380)
                        --%>
                        <c:choose>
                            <c:when test="${param.event=='search'  && not empty param.nomes && not empty param.dataNasc and sessionScope.pSessaoCodigoPerfil == 380}"> 
                              <input id="novo_utente" class="submitButton disabled" type="button" name="novoUtente" value="Novo Utente" onclick="abilita(); submitFormulario('novoUtente'); " disabled/>
                                <script type="text/javascript">setEnabledOrDisabledButtons(new Array('novo_utente'), false);</script>
                            </c:when>
                        
                            <c:when test="${param.event=='search' && pReadOnlyMode!='true' && not empty param.nomes && not empty param.dataNasc}"> 
                                <input id="novo_utente" class="submitButton disabled" type="button" name="novoUtente" value="Novo Utente" onclick="abilita(); submitFormulario('novoUtente'); " disabled/>
                                <script type="text/javascript">setEnabledOrDisabledButtons(new Array('novo_utente'), false);</script>
                            </c:when>
                          
                            <c:otherwise>
                                <input id="novo_utente" class="submitButton" type="button" name="" value="Novo Utente" disabled/>
                                <script type="text/javascript">setEnabledOrDisabledButtons(new Array('novo_utente'), true);</script>
                            </c:otherwise>
                        </c:choose>
                        
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentes.currentRow}">
                                <input id="pesquisa" class="submitButton" type="button" name="novaPesquisa" value="Nova Pesquisa" onclick="if(limpa('P')){ submitFormulario('novaPesquisa'); } "/>
                            </c:when>
                            <c:otherwise>
                                <input id="pesquisa" class="submitButton" type="button" name="search" value="Pesquisar" onclick="if(validaFiltroPesquisa()){ submitFormulario('search'); }"/>
                            </c:otherwise>
                        </c:choose>
                        
                        <input id="pesquisa_avancada" class="submitButton" type="button" name="pesquisaAvancada" value="${not empty param.bPesquisaAvancadaLabel?'Pesquisa Avan&ccedil;ada':param.bPesquisaAvancadaLabelbPesquisaAvancadaLabel}" onclick="changePropmptPesquisa();"/>
                    </td>
                </tr>
                </tbody>
            </table>
        
        <c:choose>
        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow}">
        <script type="text/javascript">
            document.getElementById('pTipoDocIdent').disabled = true;
            document.getElementById('pTipoDocIdent').className += ' disabled';
            document.getElementById('pSexo').disabled = true;
            document.getElementById('pSexo').className += ' disabled';
            desabilita(); 
            setEnabledOrDisabledButtons(new Array('pesquisa_avancada'), true);</script>
        <h4>Resultados Pesquisa</h4>
        
        <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
        <thead/>
        <tbody>
        <tr><td>

                <!--
                <input disabled id="teste" name="teste" class="submitButton" type="button" value="${sessionScope.pSessaoCodigoPerfil}" />
                -->

                <!--
                <input disabled id="teste" name="teste" class="submitButton" type="button" value="${pReadOnlyMode}" />
                -->

                <c:choose>
                <c:when test="${pReadOnlyMode!='true'}"> 
                        <c:choose>
                            <c:when test="${sessionScope.pSessaoCodigoPerfil == 376}" >
                                <input disabled id="consultarUtente" name="consultarUtente" class="submitButton buttonDisabled" type="button" value="Editar" onclick="submitFormulario('consultarUtenteHospital');"/> 
                            </c:when>
                             <c:otherwise>
                                        <!--<input disabled id="selectUtente" name="selectUtente" class="submitButton buttonDisabled" type="button" value="Seleccionar" onclick="submitFormulario('selectUtente');" />-->
                                     <input disabled id="editUtente" name="editUtente" class="submitButton buttonDisabled" type="button" value="Editar" onclick="submitFormulario('editUtente');" />
                            </c:otherwise>
                       </c:choose>
                    <input disabled id="consultarUtente" name="consultarUtente" class="submitButton buttonDisabled" type="button" value="Consultar" onclick="submitFormulario('consultarUtente');" />
                </c:when>
                <c:otherwise>
                           <!--<input disabled id="selectUtente" name="selectUtente" class="submitButton buttonDisabled" type="button" value="Seleccionar" onclick="submitFormulario('selectUtente');" />-->
                           <input disabled id="consultarUtente" name="consultarUtente" class="submitButton buttonDisabled" type="button" value="Consultar" onclick="submitFormulario('consultarUtente');"/> 
                </c:otherwise>
                </c:choose>
                
                <!-- disponibiliza opção de marcação de duplicado para perfis com modo de edicao ou perfil helpdesk = 275 mas não para os hospitais 376 -->
                <c:if test="${(sessionScope.pSessaoCodigoPerfil == 275 || pReadOnlyMode!='true' ) and sessionScope.pSessaoCodigoPerfil != 376 and sessionScope.pSessaoCodigoPerfil != 380}" >
                    <input disabled id="potDuplicado" name="potDuplicado" class="submitButton buttonDisabled" type="button" value="Marcar Pot. Duplicado" onclick="openPotDupPopup(document.getElementById('hiddenSelectedId').value);" />
                </c:if>
                
        </td></tr>
        </tbody>
        </table>
        
        <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr class="head">
                    <th class="selection"><span style="white-space: nowrap;">-</span></th>
                    <th class="numeric"><span style="white-space: nowrap;">Nº Utente</span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentes.labels.NomeCompleto}"/></span></th>
                    <th class="date"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentes.labels.DtaNasc}"/></span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentes.labels.Morada}"/></span></th>
                    <th class="text"><span style="white-space: nowrap;">Documento Identifica&ccedil;&atilde;o</span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentes.labels.CsaudeCod}"/></span></th>
                    <th class="text last">-</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="search" value="'" />
                <c:forEach var="Row" items="${bindings.ListaUtentes.rangeSet}" varStatus="lineListaUtentes">  
                        <c:choose> 
                          <c:when test="${lineListaUtentes.count % 2 != 0}">
                            <c:set var="rowClass" value="even"/>
                          </c:when>
                          <c:otherwise>
                              <c:set var="rowClass" value="odd"/>
                          </c:otherwise>
                        </c:choose>
                    <tr class="${rowClass}">
                    <td class="selection">
                        <input id="iiuId${lineListaUtentes.count}" name="iiuId${lineListaUtentes.count}" type="hidden" value="${Row.IiuId}"/>
                        <input id="iinId${lineListaUtentes.count}" name="iinId${lineListaUtentes.count}" type="hidden" value="${Row.IinId}"/>
                        <input id="tabInscr${lineListaUtentes.count}" name="tabInscr${lineListaUtentes.count}" type="hidden" value="${Row.TabInscr}"/>
                        <input id="csaudeId${lineListaUtentes.count}" name="csaudeId${lineListaUtentes.count}" type="hidden" value="${Row.CsaudeId}"/>
                        
                        <input name="selID" type="radio" 
                               value="${lineListaUtentes.count}" 
                               onclick="disponibilizaOpcoes(${sessionScope.pSessaoCodigoPerfil == 250?'true':'false'}); highlightRow(this, ${lineListaUtentes.count}); document.getElementById('hiddenSelectedId').value = '${Row.IiuId}'; opcoesMaternidade(${sessionScope.pSessaoCodigoPerfil}, ${empty Row.IinId?0:Row.IinId});"/>
                    </td> 
                    <td class="numeric"><c:out value="${Row.Nir}"/></td>
                    <td class="text"><c:out value="${Row.NomeCompleto}"/></td>
                    <td class="date"><c:out value="${Row.DtaNasc}"/></td>
                    <td class="text"><c:out value="${Row.Morada}"/></td>
                    <td class="text"><c:if test="${not empty Row.NumId}"><c:out value="${Row.CodigoId}"/>&nbsp;:&nbsp;<c:out value="${Row.NumId}"/></c:if></td>
                    <td class="text"><c:out value="${Row.CsaudeDesig}"/></td>
                    <td class="text last">
                        <c:if test="${Row.Obito == 'S'}">
                            <script type="text/javascript">
                                obitos[contadorObitos] = '${lineListaUtentes.count}';
                                contadorObitos++;
                            </script>
                            <img alt="" src="../img/note_black.gif" /> 
                        </c:if>
                        <c:if test="${not empty Row.IdpPotDup}">
                            <!-- apenas disponibilizar link para codigos de perfis < 251 ou seja supervisores ou superiores -->
                            <c:choose>
                                <c:when test="${sessionScope.pSessaoCodigoPerfil < 251 }">
                                    <img alt="Ver Potencial Duplicado" src="../img/note_blue.gif" style="cursor:pointer;" onclick="openPopUpDuplicados('${Row.IiuId}');" />
                                </c:when>
                                <c:otherwise>
                                    <img alt="Ver Potencial Duplicado" src="../img/note_blue.gif" style="cursor:none;"/>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${Row.Emigrante eq 'S'}">
                            <img alt="Utente Migrante" src="../img/note_green.gif" /> 
                        </c:if>
                    </td>
                    </tr>
                </c:forEach>
                <tr class="navigation">
                    <td colspan="8"> 
                        <jsp:include page="/com/navigationList.jsp" flush="true">
                          <jsp:param name="rangeBindingName" value="ListaUtentes"/>
                          <jsp:param name="targetPageName" value="pesquisaUtente.do"/>
                        </jsp:include>                             
                </td></tr>
            </tbody>
        </table>           
        <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr class="head">
                     <td class="hint"><span style="white-space:nowrap;">Legenda:</span></td>
                </tr>
                <tr class="head">   
                    <td class="hint"><span style="white-space:nowrap;"><img alt="" style="vertical-align:middle;" src="../img/note_blue.gif" height="16" width="16"/> - Potencial Duplicado;</span></td>
                </tr>
                <tr>
                    <td class="hint"><span style="white-space:nowrap;"><img alt="" style="vertical-align:middle;" src="../img/note_black.gif" height="16" width="16"/> - Óbito;</span></td>
                </tr>
                <tr>
                    <td class="hint"><span style="white-space:nowrap;"><img alt="" style="vertical-align:middle;" src="../img/note_green.gif" height="16" width="16"/> - Migrante;</span></td>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>               
        </c:when>
        <c:otherwise>
            <c:if test="${not empty param.pPesquisaTipoEfectuada}">
                <h4>Resultados Pesquisa</h4>
                <p class="hint">A pesquisa efectuada n&atilde;o retornou valores.</p>
            </c:if>
        </c:otherwise>
        </c:choose>
        
    <%--</c:if>--%>
        <!--atualiza-se o numero de resultados devolvidos pela pesquisa para saber se deve ser ativado ou nao o botao para marcar duplicados-->
        <script charset="UTF8" type="text/javascript">
            document.getElementById('numeroUtentesEmPesquisa').value = ${bindings.ListaUtentes.estimatedRowCount};
        </script>
    </form>
    
    <!-- UP -->
                        
    <jsp:include page="/com/footer.jsp" flush="true"/>
    <c:if test="${param.novaPesquisa=='Nova Pesquisa' }">
        <script type="text/javascript">
            limpa('P'); 
        </script>
    </c:if>
   
   </body>
</html>
