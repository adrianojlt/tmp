<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ page contentType="text/xml;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--
    Esta página permite implementar serviços para usar c/ tecnologia ajax
    nota: o serviço será invocado pelo nome do evento, evento este que terá de ser unico.
    
    LISTA DE SERVIÇOS
    -----------------
    
    [1] - LISTA CÓDIGOS HIERARQUICOS DE DISTRITO, CONCELHOS E FREGUESIAS
    [2] - LISTA AGREGADO DO UTENTE (paginação)
    [3] - LISTA DE PROCESSOS DE FAMÍLIA (paginação)
    [4] - DETALHE DE PROCESSO DE FAMÍLIA
    [5] - DEVOLVER NA NOVA INSCRIÇÃO SELECTED BOX COM GRAUS DE PARENTESCOS POSSIVEIS PARA ASSOCIAÇÃO
    [6] - DEVOLVE ESTATISTICAS DO SINCRONISMO
--%>

<c:if test="${param.event == 'GitPesquisaUtenteBaixaFamiliar' }">
    
    <table width="100%">
        <thead/>
        <tr><td>
            <html:messages id="msg" message="true">
                <span><c:out value="${msg}" escapeXml="false"/></span>
            </html:messages>
            <html:errors/>
        </td>
        </tr>
    </table>
    
    <h4>Resultado da Pesquisa</h4>
    
    <table  id="readOnlyTable" class="spms-table" cellpadding="0" cellspacing="0" border="0">
           <thead>
              <tr class="head">
                  <!--<th class="selection">-</th>-->
                  <th class="numeric"  >
                    <c:out value="${bindings.ListaUtentes.labels[\'Nir\']}"/>
                  </th>
                  <th class="text">
                    <c:out value="${bindings.ListaUtentes.labels[\'NomeCompleto\']}"/>
                  </th>
                  <th class="date"  >
                    <c:out value="${bindings.ListaUtentes.labels[\'DtaNasc\']}"/>
                  </th>
                  <th class="text last"  >
                    <c:out value="NISS"/>
                  </th>  
            </tr>
           </thead>
           <tbody>
    
            <c:forEach var="RowListaUtentes" items="${bindings.ListaUtentes.rangeSet}" varStatus="lineListaUtentes">
                <c:choose>
                    <c:when test="${lineListaUtentes.count % 2 != 0}">
                         <c:set var="trClassAgregado" value="even"/>
                    </c:when>   
                    <c:otherwise>
                        <c:set var="trClassAgregado" value="odd"/>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                  <c:when test="${empty param.pTipoPesq}">
                    <tr class="${trClassAgregado}" onclick=" if(<c:out value="${RowListaUtentes.Obito!='S' }"/>) {if (idUtenteSessao != <c:out value="${RowListaUtentes[\'IiuId\']}"/>) {highlightRow(this,${lineListaUtentes.count}); enableButton(document.getElementById('event_seleccionaAgregado')); document.getElementById('hiddenDtaNascFamiliar').value = '<c:out value="${RowListaUtentes[\'DtaNasc\']}"/>'; document.getElementById('textDtaNascFamiliar').value   = '<c:out value="${RowListaUtentes[\'DtaNasc\']}"/>'; document.getElementById('hiddenNomeFamiliar').value = '<c:out value="${RowListaUtentes[\'NomeNormalizado\']}"/>'; document.getElementById('textNomeFamiliar').value = '<c:out value="${RowListaUtentes[\'NomeNormalizado\']}"/>'; document.getElementById('hiddenNissFamiliar').value = '<c:out value="${RowListaUtentes[\'Niss\']}"/>'; document.getElementById('textNissFamiliar').value = '<c:out value="${RowListaUtentes[\'Niss\']}"/>'; document.getElementById('hiddenIdFamiliar').value = '<c:out value="${RowListaUtentes[\'IiuId\']}"/>'; document.getElementById('hiddenSeleccionaFamilia').value = 'selected'; } else {alert('Não pode seleccionar o mesmo utente para quem está a emitir baixa!'); } } else{alert('Não é possível seleccionar este familiar. Por favor, verifique os dados do familiar no RNU.'); } ">
                      <td class="numeric"><c:out value="${RowListaUtentes[\'Nir\']}"/></td>
                      <td class="text"><c:out value="${RowListaUtentes[\'NomeCompleto\']}"/></td>
                      <td class="date"><c:out value="${RowListaUtentes[\'DtaNasc\']}"/></td>
                      <td class="text last"><c:out value="${RowListaUtentes[\'Niss\']}"/></td>
                    </tr>

                  </c:when>
                  <c:otherwise>

                    <tr class="${trClassAgregado}" onclick="
                       trClickedPesquisaUtente(
                          this, 
                          { 
                              Obito: '${RowListaUtentes.Obito}', 
                              Nir: '<c:out value="${RowListaUtentes[\'Nir\']}"/>', 
                              isNirEmpty: ${empty RowListaUtentes.Nir},
                              IiuId: '<c:out value="${RowListaUtentes[\'IiuId\']}"/>', 
                              Niss: '<c:out value="${RowListaUtentes[\'Niss\']}"/>', 
                              DtaNasc: '<c:out value="${RowListaUtentes[\'DtaNasc\']}"/>', 
                              Numbenef: '<c:out value="${RowListaUtentes[\'Numbenef\']}"/>', 
                              DtaNasc: '<c:out value="${RowListaUtentes[\'DtaNasc\']}"/>', 
                              NomeNormalizado: '<c:out value="${RowListaUtentes[\'NomeNormalizado\']}"/>', 
                              NumId: '<c:out value="${RowListaUtentes[\'NumId\']}"/>', 
                              Niss: '<c:out value="${RowListaUtentes[\'Niss\']}"/>', 
                              Numbenef: '<c:out value="${RowListaUtentes[\'Numbenef\']}"/>',
                              Count: ${lineListaUtentes.count}
                          }
                      );
                    ">
                      <td class="numeric"><c:out value="${RowListaUtentes[\'Nir\']}"/></td>
                      <td class="text"><c:out value="${RowListaUtentes[\'NomeCompleto\']}"/></td>
                      <td class="date"><c:out value="${RowListaUtentes[\'DtaNasc\']}"/></td>
                      <td class="text last"><c:out value="${RowListaUtentes[\'Niss\']}"/></td>
                    </tr>

                  </c:otherwise>
                </c:choose>

            </c:forEach>
            
            <%--
            <tr class="navigation">
                <td colspan="5">
                    <jsp:include page="/com/navigationList.jsp" flush="false">
                    <jsp:param name="rangeBindingName" value="ListaUtentes"/>                      
                    <jsp:param name="targetPageName" value="pesquisaFamiliar.do"/>
                    </jsp:include> 
                </td>
            </tr>
            --%>
            <tr class="navigation">
               <td colspan="5"></td>
            </tr>
          </tbody>
          </table>
          
           <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
                <tr>
                    <td>
                        <input class="submitButton spms-button" 
                                      id="event_seleccionaPesquisaAgregado" 
                                    name="event_seleccionaPesquisaAgregado" 
                                    type="button"
                                    onclick="procurarNovoUtente();"
                                   value="Nova Pesquisa"/>
                    </td>
                </tr>
            </tbody>
           </table> 
</c:if>


<%-- 
    [1] <inicio> LISTA CÓDIGOS HIERARQUICOS DE DISTRITO, CONCELHOS E FREGUESIAS 
--%>
<c:if test="${param.event == 'GetDistConcFreg' }">
    <c:forEach var="Row" items="${bindings.ListaCodigosHierarquicosLov.rangeSet}" varStatus="status">
        <c:out value="${Row.Id}|${Row.Descricao}"/>
    </c:forEach>
</c:if>
<%-- [1] <fim> LISTA CÓDIGOS HIERARQUICOS DE DISTRITO, CONCELHOS E FREGUESIAS --%>


<%-- 
    [2] <inicio> LISTA AGREGADO DO UTENTE 
--%>
<c:if test="${param.event == 'GetAgregadoFamilia' || param.event_RangeChangeListaAgregadoFamiliar == 'RangeChangeListaAgregadoFamiliar' }">
<c:choose>
    <c:when test="${ not empty bindings.ListaAgregadoFamiliar.currentRow }">
        <c:set var="otherParams" value="" />
        <c:if test="${not empty param.pBotoes}">
            <c:set var="otherParams" value="&pBotoes=true" />
        <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
        <thead/>
        <tbody>
            <tr>
                <td>
                <input id="btAlterarAgregado" name="btAlterarAgregado" class="submitButton" type="button" value="Alterar Parentescos do Agregado" onclick="return alterarAgregado();"/>
                <input id="btAlterarMedicosAgregado" name="btAlterarMedicosAgregado" class="submitButton" type="button" value="Alterar Médicos do Agregado" onclick="return alterarMedicosAgregado();"/>
                </td>
            </tr>
        </tbody>
        </table>
        </c:if>
        
        <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
        <thead>
        <tr class="head">
            <th class="numeric"><c:out value="${bindings.ListaAgregadoFamiliar.labels.Nutente}"/></th>
            <th class="text"><c:out value="${bindings.ListaAgregadoFamiliar.labels.NomeCompleto}"/></th>
            <th class="date"><c:out value="${bindings.ListaAgregadoFamiliar.labels.DtaNasc}"/></th>
            <th class="text"><c:out value="${bindings.ListaAgregadoFamiliar.labels.DescParentesco}"/></th>
            <th class="text last"><c:out value="${bindings.ListaAgregadoFamiliar.labels.NomeEquipa}"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="Row" items="${bindings.ListaAgregadoFamiliar.rangeSet}" varStatus="lineListaAgregadoFamiliar">                                        
        <c:choose>
            <c:when test="${lineListaAgregadoFamiliar.count %2 == 0}">
                <c:set var="rowClass" value="odd"/>    
            </c:when>
            <c:otherwise>
                <c:set var="rowClass" value="even"/>    
            </c:otherwise>                    
        </c:choose>
        <tr class="${rowClass}">                                                
            <td class="numeric"><c:out value="${Row.Nutente}"/></td>
            <td class="text"><c:out value="${Row.NomeCompleto}"/></td>
            <td class="date"><c:out value="${Row.DtaNasc}"/></td>
            <td class="text"><c:out value="${Row.CodParentesco} - ${Row.DescParentesco}"/></td>
            <td class="text last"><c:out value="${Row.NomeEquipa}"/></td>
        </tr>
        </c:forEach>
        <tr class="navigation">
        <td colspan="5">
            <jsp:include page="/com/navigationList.jsp" flush="true">
              <jsp:param name="rangeBindingName" value="ListaAgregadoFamiliar"/>
              <jsp:param name="targetPageName" value="../com/ajaxServices.do"/>
              <jsp:param name="requestType" value="ajaxServices"/>
              <jsp:param name="metodToCall" value="populateAgregadoFamilia"/>
              <jsp:param name="otherParams" value="${otherParams}"/>
            </jsp:include> 
         </td>
         </tr>
         </tbody>
         </table> 
    </c:when>
    <c:otherwise>
        <p class="hint">N&atilde;o existe Agregado para a família.</p>
    </c:otherwise>
    </c:choose>
</c:if>
<%-- [2] <FIM> LISTA AGREGADO DO UTENTE --%>


<%-- 
    [3] - <inicio> LISTA DE PROCESSOS DE FAMÍLIA 
--%>
<c:if test="${param.event == 'ListaFamilia' || param.event_RangeChangeListaFamilia == 'RangeChangeListaFamilia' }">
    <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
    <thead/>
    <tbody>
        <tr>
            <td>
            <c:choose>
                <c:when test="${empty bindings.ListaFamiliaIterator.currentRow}">
                    <input class="submitButton buttonDisabled" type="submit" value="Nova Pesquisa" disabled/>
                </c:when>
                <c:otherwise>
                    <input id="event_NovaPesquisa" name="event_NovaPesquisa" class="submitButton" type="submit" value="Nova Pesquisa"/>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${ param.btSearchFamilia eq 'Pesquisar' }">
                    <input id="btNovaFamilia" name="btNovaFamilia" class="submitButton" type="button" value="Nova Família" onclick="novaFamilia();"/>
                </c:when>
                <c:otherwise>
                    <input id="btNovaFamilia" name="btNovaFamilia" class="submitButton buttonDisabled" type="button" value="Nova Família" disabled/>
                </c:otherwise>
            </c:choose>
            <input id="btSeleccionarFamilia" name="btSeleccionarFamilia" class="submitButton buttonDisabled" type="button" value="Associar Família ao Utente" onclick="seleccionarFamilia();" disabled/>
            </td>
        </tr>
    </tbody>
  </table>      
         
  <c:choose>
  <c:when test="${not empty bindings.ListaFamiliaIterator.currentRow }">
  <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
    <thead>
        <tr class="head">
            <th class="selection">-</th>
            <th class="text">Nº Processo</th>
            <th class="text last">Morada</th>
        </tr>
    </thead>
    <tbody>
 
        <c:forEach var="Row" items="${bindings.ListaFamilia.rangeSet}" varStatus="lineListaFamilia">                                       
            <c:choose>
                <c:when test="${lineListaFamilia.count %2 == 0}">
                    <c:set var="rowClass" value="odd"/>    
                </c:when>
                <c:otherwise>
                    <c:set var="rowClass" value="even"/>    
                </c:otherwise>                    
            </c:choose>
                <tr class="${rowClass}">                                                            
                    <td class="selection">
                        <input id="selIdPFam" name="selIdPFam" type="radio" onclick="highlightRow(this,${lineListaFamilia.count}); detalheFamilia('${Row.IdFamilia}');" />
                    </td>
                    <td class="numeric"><c:out value="${Row.Procfam}"/></td>
                    <td class="text last"><c:out value="${Row.MoradaCompleta}"/></td>  
                </tr>
            </c:forEach>
            <tr class="navigation">
                <td colspan="3">        
                    <jsp:include page="/com/navigationList.jsp" flush="true">
                        <jsp:param name="rangeBindingName" value="ListaFamilia"/>
                        <jsp:param name="targetPageName" value="../com/ajaxServices.do"/>
                        <jsp:param name="requestType" value="ajaxServices"/>
                        <jsp:param name="metodToCall" value="populateListaFamilia"/>
                    </jsp:include> 
                </td>
            </tr>
    </tbody>
  </table>
  </c:when>
  </c:choose>
</c:if>
<%--[3] - <fim> LISTA DE PROCESSOS DE FAMÍLIA --%>


<%-- 
    [4] - <inicio> DETALHE DE PROCESSO DE FAMÍLIA
--%>
<c:if test="${param.event == 'GetDetalheFamilia' }">
    <c:forEach var="Row" items="${bindings.DetalheFamilia.rangeSet}" varStatus="status">
        <c:out value="${Row.IdFamilia}|${Row.Rua}|${Row.Andar}|${Row.CodPostal}|${Row.Concelho}|${Row.ConcelhoId}|${Row.Distrito}|${Row.DistritoId}|${Row.Freguesia}|${Row.FreguesiaId}|${Row.IdCodPostal}|${Row.IdTpAndar}|${Row.IdTpPorta}|${Row.IdTpRua}|${Row.Localidade}|${Row.LocPostal}|${Row.Lugar}|${Row.Porta}|${Row.Procfam}|${Row.SeqPostal}|${Row.CsaudeCod}|${Row.CsaudeDesig}|${Row.MoradaCompleta}|${Row.Indicativo}|${Row.Telefone}|${Row.Descrua}"/>
    </c:forEach>
</c:if>
<%-- [4] - <fim> DETALHE DE PROCESSO DE FAMÍLIA --%>

<%-- 
    [5] <inicio> DEVOLVER NA NOVA INSCRIÇÃO SELECTED BOX COM GRAUS DE PARENTESCOS POSSIVEIS PARA ASSOCIAÇÃO
--%>
<c:if test="${param.event == 'GetSelectedBoxParentescos' }">
    <p class="hint" id="msgEscolhaGrauParentesco"><font color="red">Por favor, escolha Grau de Parentesco para o utente.</font></p>
    <p class="hint">Graus de Parentesco já pertencentes ao Agregado da Família: <c:out value="${grausAtribuidosDesc}"/></p>
    <table id="inputForm" cellpadding="0" cellspacing="0" border="0">
    <thead/>
    <tbody>
    <tr>
    <td class="inputLabel">Parentesco:</td>
    <td class="inputCell" colspan="2" style="width:350px;">
        <input type="hidden" name="pNovaInscrIdGrauParentescoCod" id="pNovaInscrIdGrauParentescoCod" value="">
        <select id="pNovaInscrIdGrauParentesco" name="pNovaInscrIdGrauParentesco" class="inputChoiceThree" onchange="if(this.value.length==0){expandRow('msgEscolhaGrauParentesco');} else {collapseRow('msgEscolhaGrauParentesco');}">
            <option value="" label="-----------------------------------" title="escolha um grau de parentesco"/>   
            <c:forEach var="Row" items="${bindings.ListaCodigosGenericos1.rangeSet}" varStatus="lineListaCodigosGenericos">
                    <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
            </c:forEach>
        </select>    
    </td>
    </tr>
    </tbody>
    </table>
</c:if>
<%-- [5] <fim>  DEVOLVER NA NOVA INSCRIÇÃO SELECTED BOX COM GRAUS DE PARENTESCOS POSSIVEIS PARA ASSOCIAÇÃO --%>

<%-- 
    [6] <inicio> DEVOLVE ESTATISTICAS DO SINCRONISMO
--%>

<c:if test="${param.event == 'GetSincStats' }">
   <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0" >
           <thead>
             <tr class="head">
                <th class="text"  ><span style="white-space: nowrap;"><c:out value="Estado"/></span></th>
                <th class="text"  ><span style="white-space: nowrap;"><c:out value="Contagem"/></span></th>
              </tr>
           </thead>
           <tbody>
             <c:forEach var="Row" items="${bindings.ListaStatsSincronismo.rangeSet}" varStatus="status">
                 <c:choose>
                    <c:when test="${status.count %2 == 0}">
                        <c:set var="rowClass" value="odd"/>    
                    </c:when>
                    <c:otherwise>
                        <c:set var="rowClass" value="even"/>    
                    </c:otherwise>                    
                 </c:choose>
                 <tr class="${rowClass}">                                                            
                    <td class="numeric"><c:out value="${Row.SinStatus}"/></td>
                    <td class="text last"><c:out value="${Row.Contagem}"/></td>  
                </tr>
                
             </c:forEach>
             <tr class="navigation">
                <td colspan="2">        
                     <i>Última actualização: <%= request.getAttribute("DataActualizacao") %> </i>

                </td>
            </tr>
           </tbody>
         </table>

         
</c:if>
<%-- [6] <fim>  DEVOLVE ESTATISTICAS DO SINCRONISMO --%>

<%-- 
    [7] - <inicio> VALIDA NISS
--%>
<c:if test="${param.event == 'validaNiss' }">
    <c:out value="${sessionScope.gitPesquisaUtenteNissValido}"></c:out>
</c:if>
<%-- [4] - <fim> VALIDA NISS --%>


<%-- 
    [8] - <inicio> Obter entidades responsaveis
--%>
<c:if test="${param.event == 'getEntidadesResponsaveis' }">
   <span style="white-space: nowrap;" id="entRespInfoUtente">
        <%-- Só aparece a select box, se existir entidades responsaveis relacionadas--%>
        
            <input type="hidden" id="hiddenIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="" />
            <input type="hidden" id="hiddenIduHistEntUtID" name="hiddenIduHistEntUtID" value="" />
            <input type="hidden" id="hiddenNumBeneficiario" name="hiddenNumBeneficiario" value="" />
            <!-- Obter dados para a Select Box-->
            <select class="selectfield inputChoiceFour" id="entResp" name="entResp"  onChange="retiraNumBenef(this.value);">                 
                   
            <c:forEach var="Row" items="${bindings.ListaEntidadesResponsaveis.rangeSet}" varStatus="RowStatus"  >
                <c:if test="${Row['Expirado'] != 'S'}">
                    <option value="${Row.SysEntidadesId};${Row.Numbenef};${Row.Id}">${Row['DescrAbvr']}</option>
                </c:if>
            </c:forEach>
             </select>
    </span>
</c:if>
<%-- [8] - <fim>  Obter entidades responsaveis --%>

<c:if test="${param.event == 'GetDistConcFregParaCombos' }">
    <c:forEach var="Row" items="${bindings.ListaCodigosHierarquicosCombos.rangeSet}" varStatus="statusCombos">
        <c:out value="${Row.Id}|${Row.Descricao};"/>
    </c:forEach>
</c:if>