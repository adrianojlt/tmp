<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 
    Pesquisa Mãe
    ------------------------
    @autor: Sónia Pereira
    @descricao: 
        - Nesta página deverá se possível pesquisar e seleccionarr a mãe do novo utente e aceder aos dados da inscrição de forma a copiá-los para o novo utente
--%>
<script type ="text/javascript">
    function disponibilizaOpcoes(){
        // se utente seleccionado esta marcado como óbito faz disable da opção de seleccionar e editar
        var registos = document.getElementsByName("selIDMae");
        for (var j = 0 ; j < registos.length ; j++) {
            if(registos[j].checked ){
                        setEnabledOrDisabledButtons(new Array('selectMae'), false);
               }
        }
    }

</script>
<h4><span style="white-space:nowrap; vertical-align: baseline;"><a style="cursor:pointer;" onclick="collapseExpandArea('divPesMaeDocColExp', 'divDocColExpStyle', 'imgPesMaeDocColExp');"><img alt="" id="imgPesMaeDocColExp" name="imgDocColExp" src="${param.divDocColExpStyle == 'display:none;' ? '../img/nolines_plus.gif' : '../img/nolines_minus.gif'}" />Pesquisa Mãe</a></span></h4>
<div id="divPesMaeDocColExp" style="${empty param.divPesMaeDocColExpStyle ? 'display:block;' : param.divPesMaeDocColExpStyle}">
    <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
                <tr>
                    <td class="inputLabel">Nº Utente:</td>
                    <td class="inputCell" colspan="3">
                        <input id="nSNSMaePesquisa" name="nSNSMaePesquisa" type="text" class="inputTextOne" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" value="${param.nSNSMaePesquisa}"/>
                    </td>
                </tr>
                <tr>
                    <td class="inputLabel">Nome:</td>
                    <td class="inputCell" colspan="3">
                            <input id="nomesMaePesquisa" name="nomesMaePesquisa" type="text" class="inputTextSix" value="${param.nomesMaePesquisa}" maxlength="200" onkeypress="noSpecialCaracters(this);focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noSpecialCaracters(this);" onblur="noSpecialCaracters(this);" />
                    </td>
                </tr>
                            <tr>
                <td class="inputLabel">Idade de:</td>
                <td class="inputCell">
                    <span style="white-space:nowrap; vertical-align: bottom;">
                        <input id="idadeDe" name="idadeDeMae" type="text" class="inputTextZero" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeDe');" value="${param.idadeDeMae}" style="width: 25px;"/>
                        a
                        <input id="idadeA" name="idadeAMae" type="text" class="inputTextZero" onkeypress="noAlpha(this); focusObjectOnEnterPressed(event,'pesquisa');" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeAte');" value="${param.idadeAMae}" style="width: 25px;"/>
                        
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentesMaeIterator.currentRow && param.pPesquisaTipoEfectuada=='false'}">
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
                    <c:when test="${not empty bindings.ListaUtentesMaeIterator.currentRow && not empty param.pPesquisaTipoEfectuada }">
                        <input id="dataNascMae" name="dataNascMae" type="text" class="inputTextOne disabled" value="${param.dataNascMae}" />   
                    </c:when>
                    <c:otherwise>
                        <input id="dataNascMae" name="dataNascMae" type="text" class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" maxlength="10" value="${param.dataNascMae}" onkeypress="valData(this,event); focusObjectOnEnterPressed(event,'pesquisa'); " onkeyup="valData(this,event);" onblur="valData(this,event);"/>
                    </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
      </table>
      
      <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
                <thead/>
                <tbody>
                <tr >
                    <td>
                        <c:choose>
                            <c:when test="${not empty bindings.ListaUtentesMae.currentRow}">
                                <input id="pesquisa" class="submitButton" type="button" name="search" value="Pesquisar" onclick="searchMae(); "/>

                                <%--<c:if test="${pCriacao == true}"> --%>
                                    <input disabled id="selectMae" name="selectMae" class="submitButton buttonDisabled" type="button" value="Continuar" onclick="submitFormulario('editUtenteComMae');" />
                                <%-- </c:if> --%>

                            </c:when>
                            <c:otherwise>
                                <input id="pesquisa" class="submitButton" type="button" name="search" value="Pesquisar" onclick="searchMae(); "/>
                            </c:otherwise>
                        </c:choose> 
                    </td>
                </tr>
                </tbody>
            </table>
            
            <c:choose>
            <c:when test="${not empty showPesquisaMae and  empty fromBack}">
                <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                <thead></thead>
                <tbody>
                    <tr style ="border-bottom: 1px solid black;">
                     <td class='selection'><input name="selIDMae" type="radio" 
                                   value="" 
                                   onclick=" disponibilizaOpcoes() ;document.getElementById('hiddenSelectedIdMae').value = ''"/>
                    </td>
                     <td class='text'>Não foi encontrada a mãe</td>
                    </tr>
                    </tbody>
                </table>
            </c:when>
            </c:choose>
            
            <br/>
            
      <c:choose>
        <c:when test="${not empty bindings.ListaUtentesMaeIterator.currentRow}">
        
             <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr class="head">
                    <th class="selection"><span style="white-space: nowrap;">-</span></th>
                    <th class="text"><span style="white-space: nowrap;">-</span></th>
                    <th class="numeric"><span style="white-space: nowrap;">Nº Utente </span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentesMae.labels.NomeCompleto}"/></span></th>
                    <th class="date"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentesMae.labels.DtaNasc}"/></span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentesMae.labels.Morada}"/></span></th>
                    <th class="text"><span style="white-space: nowrap;">Documento Identifica&ccedil;&atilde;o</span></th>
                    <th class="text"><span style="white-space: nowrap;"><c:out value="${bindings.ListaUtentesMae.labels.CsaudeCod}"/></span></th>
                    <th class="text last">-</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="search" value="'" />
                <c:forEach var="RowMae" items="${bindings.ListaUtentesMae.rangeSet}" varStatus="lineListaUtentes">  
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
                        <input id="iiuId${lineListaUtentes.count}" name="iiuId${lineListaUtentes.count}" type="hidden" value="${RowMae.IiuId}"/>
                        <input id="iinId${lineListaUtentes.count}" name="iinId${lineListaUtentes.count}" type="hidden" value="${RowMae.IinId}"/>
                        <input id="tabInscr${lineListaUtentes.count}" name="tabInscr${lineListaUtentes.count}" type="hidden" value="${RowMae.TabInscr}"/>
                        <input id="csaudeId${lineListaUtentes.count}" name="csaudeId${lineListaUtentes.count}" type="hidden" value="${RowMae.CsaudeId}"/>
                        
                        <input name="selIDMae" type="radio" 
                               value="${lineListaUtentes.count}" 
                               onclick=" disponibilizaOpcoes(); highlightRow(this, ${lineListaUtentes.count}); document.getElementById('hiddenSelectedIdMae').value = '${RowMae.IiuId}'"/>
                    </td> 
                     <td  class="text">
                    <img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="detalheUtentePopUp('${RowMae.IiuId}');">
                    
                </td>
                    <td class="numeric"><c:out value="${RowMae.Nir}"/></td>
                    <td class="text"><c:out value="${RowMae.NomeCompleto}"/></td>
                    <td class="date"><c:out value="${RowMae.DtaNasc}"/></td>
                    <td class="text"><c:out value="${RowMae.Morada}"/></td>
                    <td class="text"><c:if test="${not empty RowMae.NumId}"><c:out value="${RowMae.CodigoId}"/>&nbsp;:&nbsp;<c:out value="${RowMae.NumId}"/></c:if></td>
                    <td class="text"><c:out value="${RowMae.CsaudeDesig}"/></td>
                    <td class="text last">
                        <c:if test="${RowMae.Obito == 'S'}">
                            <script type="text/javascript">
                                obitos[contadorObitos] = '${lineListaUtentes.count}';
                                contadorObitos++;
                            </script>
                            <img alt="" src="../img/note_black.gif" /> 
                        </c:if>
                    </td>
                    </tr>
                </c:forEach>
                <tr class="navigation">
                    <td colspan="9"> 
                        <jsp:include page="/com/navigationList.jsp" flush="true">
                          <jsp:param name="rangeBindingName" value="ListaUtentesMae"/>
                          <jsp:param name="targetPageName" value="novoUtente.do"/>
                        </jsp:include>                             
                </td></tr>
            </tbody>
        </table>           
        <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr class="head">
                     <td class="hint"><span style="white-space:nowrap;">Legenda:</span></td>
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
                <input id="btFinalizarInscricao" name="btFinalizarInscricao" class="submitButton" type="button" value="Finalizar Inscrição" onclick="" />                
            </c:if>
        </c:otherwise>



        </c:choose>
</div>