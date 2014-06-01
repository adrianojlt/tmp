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
            <th class="text"></th>
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
            <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="detalheUtentePopUp('${Row.Id}');"></td>
            <td class="numeric"><c:out value="${Row.Nutente}"/></td>
            <td class="text"><c:out value="${Row.NomeCompleto}"/></td>
            <td class="date"><c:out value="${Row.DtaNasc}"/></td>
            <td class="text"><c:out value="${Row.CodParentesco} - ${Row.DescParentesco}"/></td>
            <td class="text last"><c:out value="${Row.NomeEquipa}"/></td>
        </tr>
        </c:forEach>
        <tr class="navigation">
        <td colspan="7">
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
        <c:out value="${Row.IdFamilia}|${Row.Rua}|${Row.Andar}|${Row.CodPostal}|${Row.Concelho}|${Row.ConcelhoId}|${Row.Distrito}|${Row.DistritoId}|${Row.Freguesia}|${Row.FreguesiaId}|${Row.IdCodPostal}|${Row.IdTpAndar}|${Row.IdTpPorta}|${Row.IdTpRua}|${Row.Localidade}|${Row.LocPostal}|${Row.Lugar}|${Row.Porta}|${Row.Procfam}|${Row.SeqPostal}|${Row.CsaudeCod}|${Row.CsaudeDesig}|${Row.MoradaCompleta}|${Row.Indicativo}|${Row.Telefone}|${Row.Descrua}|${Row.Desclado}|${Row.Descporta}"/>
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

<%-- [7] - <inicio> LISTA DE DOCUMENTOS MIGRANTES --%>
<c:if test="${param.event == 'GetListaDocsMigrantes' }">
    <c:forEach var="Row" items="${bindings.ListaTiposCartaoEntidade.rangeSet}" varStatus="status">
        <c:out value="${Row.Id}|${Row.DescAbrv}|${Row.Descricao};"/>
    </c:forEach>
</c:if>
<%-- [7] - <fim> LISTA DE DOCUMENTOS MIGRANTES --%>

<%-- [8] - <inicio> LISTA DE ENTIDADES --%>
<c:if test="${param.event == 'GetListaEntidades' }">
    <c:forEach var="Row" items="${bindings.ListaEntidades.rangeSet}" varStatus="status">
        <c:out value="${Row.Id}|${Row.Codigo}|${Row.Designacao};"/>
    </c:forEach>
</c:if>
<%-- [8] - <fim> LISTA DE ENTIDADES --%>


<%-- Indicadores de Medicos --%>
<c:if test="${param.event == 'GetIndicadoresMedicosFamiliaUnidade' }">
    <c:forEach var="Row" items="${bindings.ListaIndicadorMedEntidade.rangeSet}" varStatus="status">
        <c:out value="${Row.Value}"/>
    </c:forEach>
</c:if>

<%-- Indicadores GmF --%>
<c:if test="${param.event == 'GetIndicadoresGMF' }">
    
    <%--
    <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
        <thead>
            <tr class="head">
                <th class="textWithBorder" rowspan="2"><span style="white-space: nowrap;">Inscritos</span></th>
                <th class="textWithBorder" colspan="2"><span style="white-space: nowrap;">Totais</span></th>
                <th class="textWithBorder" colspan="2"><span style="white-space: nowrap;">Com Médico</span></th>
                <th class="textWithBorder" colspan="2"><span style="white-space: nowrap;">Sem Médico</span></th>
            </tr>
            <tr class="head">
                <th class="textWithBorder"><span style="white-space: nowrap;">Frequentadores</span></th>
                <th class="textWithBorder"><span style="white-space: nowrap;">Não Frequentadores</span></th>
                <th class="textWithBorder"><span style="white-space: nowrap;">Frequentadores</span></th>
                <th class="textWithBorder"><span style="white-space: nowrap;">Não Frequentadores</span></th>
                <th class="textWithBorder"><span style="white-space: nowrap;">Frequentadores</span></th>
                <th class="textWithBorder"><span style="white-space: nowrap;">Não Frequentadores</span></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="Row" items="${bindings.ListaIndicadores.rangeSet}" varStatus="line">
                <c:choose>
                    <c:when test="${line.count % 2 != 0}">
                        <c:set var="rowClass" value="even"/>
                    </c:when> 
                    <c:otherwise>
                        <c:set var="rowClass" value="odd"/>
                    </c:otherwise>
                </c:choose> 
                <tr class="${rowClass}">
                    <td class="numeric"><c:out value="${Row.Inscritos}"/></td>
                    <td class="numeric"><c:out value="${Row.Frequentadores}"/></td>
                    <td class="numeric"><c:out value="${Row.Naofrequentadores}"/></td>
                    <td class="numeric"><c:out value="${Row.Commedicofrequentadores}"/></td>
                    <td class="numeric"><c:out value="${Row.Commediconaofrequentadores}"/></td>
                    <td class="numeric"><c:out value="${Row.Semmedicofrequentadores}"/></td>
                    <td class="numeric last"><c:out value="${Row.Semmediconaofrequentadores}"/></td>
                </tr>     
            </c:forEach>                    
            <tr class="navigation"><td colspan="7"></td></tr>                
            </tbody>
        </table>
        --%>
        
        <c:forEach var="Row" items="${bindings.ListaIndicadores.rangeSet}" varStatus="line"><c:out value=";${Row.Codigoindicador}|${Row.Valorindicador}"/></c:forEach>
        
</c:if>


<%-- Indicadores GmF --%>
<c:if test="${param.event == 'ListaUnisCs' }">
<c:forEach var="Row" items="${bindings.ListaEntidades.rangeSet}" varStatus="status">
        <c:out value="${Row.Id}|${Row.Designacao};"/>
</c:forEach>
</c:if>

<%-- Médicos de Familia Destino (pag transferencia) --%>
<c:if test="${param.event == 'GetListaMedicosDestino' }">
    <c:forEach var="Row" items="${bindings.ListaMedicosFamiliaDestino.rangeSet}" varStatus="status">
        <c:out value="${Row.IdEquipa}|${Row.NomeEquipa}|${Row.Numeroutentes};"/>
    </c:forEach>
</c:if>

<%-- <inicio> LISTA DE MEDICOS PARA O UNIS --%>
<c:if test="${param.event == 'GetListaMedicosFamiliaPorUnis' }">
    <c:forEach var="Row" items="${bindings.ListaMedicosFamilia.rangeSet}" varStatus="status">
        <c:out value="${Row.IdEquipa}|${Row.NomeEquipa};"/>
    </c:forEach>
</c:if>
<%-- <fim> LISTA DE MEDICOS PARA O UNIS --%>

<%-- <inicio> LISTA DE GRUPOS PARA A UNIS --%>
<c:if test="${param.event == 'GetListaGruposPorUnis' }">
    <c:forEach var="Row" items="${bindings.ListaGrupos.rangeSet}" varStatus="status">
        <c:out value="${Row.Idgrupo}|${Row.Nome};"/>
    </c:forEach>
</c:if>
<%-- <fim> LISTA DE GRUPOS PARA O UNIS --%>



<%-- LISTA DE OBITOS PARA OS INDICADORES --%>

<c:if test="${param.event == 'GetObitosParaIndicadores'|| param.event_RangeChangeListaObitos == 'RangeChangeListaObitos' }">


    <div class="ResultadoTotalListaDiv">Existem<strong> ${bindings.ListaObitos.estimatedRowCount} </strong> óbitos para os parametros selecionados</div><br/>
    <c:choose>
        <c:when test="${not empty bindings.ListaObitos.currentRow}">
            <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr class="head">
                        <th class="text">N.º de Utente</th>
                        <th class="text last">Nome</th>
                        <th class="text last">Data Nasc.</th>
                        <th class="text last">Nop</th>
                        <th class="text last">Data Óbito</th>
                        <th class="text last">Médico</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="RowObito" items="${bindings.ListaObitos.rangeSet}" varStatus="lineListaObitos">                                       
                        <c:choose>
                            <c:when test="${lineListaObitos.count %2 == 0}">
                                <c:set var="rowClass" value="odd"/>    
                            </c:when>
                            <c:otherwise>
                                <c:set var="rowClass" value="even"/>    
                            </c:otherwise>                    
                        </c:choose>
                            <tr class="${rowClass}">  
                                <td class="text"><c:out value="${RowObito.Nir}"/></td>
                                <td class="text"><c:out value="${RowObito.NomeCompleto}"/></td>
                                <td class="date"><c:out value="${RowObito.DtaNasc}"/></td>
                                <td class="text"><c:out value="${RowObito.Nop}"/></td>  
                                <td class="date"><c:out value="${RowObito.DtaObito}"/></td>  
                                <td class="text last"><c:out value="${RowObito.NomeEquipa}"/></td>  
                            </tr>
                        </c:forEach>
                        <tr class="navigation">
                            <td colspan="2" style="text-align:left">
                                <input id="export" class="submitButton" type="button" name="Exportar Excel" value="Exportar Excel" onclick="popUpExportExcel('exportListaObitos');"/>
                            </td>
                            <td colspan="4">        
                                <jsp:include page="/com/navigationList.jsp" flush="true">
                                    <jsp:param name="rangeBindingName" value="ListaObitos"/>
                                    <jsp:param name="targetPageName" value="../com/ajaxServices.do"/>
                                    <jsp:param name="requestType" value="ajaxServices"/>
                                    <jsp:param name="metodToCall" value="populateListaObitos"/>
                                </jsp:include> 
                            </td>
                        </tr>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
                <p class="hint">A pesquisa efectuada n&atilde;o retornou valores.</p>
            </c:otherwise>
        </c:choose>
</c:if>
<%-- <fim> LISTA DE OBITOS PARA OS INDICADORES --%>


<%-- LISTA DE NOVOS UTENTES PARA AS LISTAGENS DE UTENTES--%>

<c:if test="${param.event == 'GetNovosUtentesParaListagens'|| param.event_RangeChangeListaNovosUtentes == 'RangeChangeListaNovosUtentes' }">
    <div class="ResultadoTotalListaDiv">Existem<strong> ${bindings.ListaNovosUtentes.estimatedRowCount} </strong> novos utentes para os parametros selecionados</div><br/>
    <c:choose>
        <c:when test="${not empty bindings.ListaNovosUtentes.currentRow}">
           <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                    <thead>
                        <tr class="head">
                            <th class="selection"><span style="white-space: nowrap;">-</span></th>
                            <th class="numeric"><span style="white-space: nowrap;">N.º de Utente</span></th>
                            <th class="text"><span style="white-space: nowrap;">Nome</span></th>
                            <th class="date"><span style="white-space: nowrap;">Data Nasc.</span></th>
                            <th class="text"><span style="white-space: nowrap;">Morada</span></th>
                            <th class="text"><span style="white-space: nowrap;">Documento Identifica&ccedil;&atilde;o</span></th>
                            <th class="text"><span style="white-space: nowrap;">Centro Saúde</span></th>
                            <th class="text last">-</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="search" value="'" />
                        <c:forEach var="Row" items="${bindings.ListaNovosUtentes.rangeSet}" varStatus="lineListaUtentes">  
                                <c:choose> 
                                  <c:when test="${lineListaUtentes.count % 2 != 0}">
                                    <c:set var="rowClass" value="even"/>
                                  </c:when>
                                  <c:otherwise>
                                      <c:set var="rowClass" value="odd"/>
                                  </c:otherwise>
                                </c:choose>
                            <tr class="${rowClass}">
                            <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="detalheUtentePopUp('${Row.IiuId}');"></td>
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
                            <td colspan="2" style="text-align:left">
                                <input id="export" class="submitButton" type="button" name="Exportar Excel" value="Exportar Excel" onclick="popUpExportExcel('exportListaNovosUtentes');"/>
                            </td>
                            <td colspan="6"> 
                                <jsp:include page="/com/navigationList.jsp" flush="true">
                                    <jsp:param name="rangeBindingName" value="ListaNovosUtentes"/>
                                    <jsp:param name="targetPageName" value="../com/ajaxServices.do"/>
                                    <jsp:param name="requestType" value="ajaxServices"/>
                                    <jsp:param name="metodToCall" value="populateListaNovosUtentes"/>
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
                <p class="hint">A pesquisa efectuada n&atilde;o retornou valores.</p>
            </c:otherwise>
        </c:choose>
</c:if>

<%-- <fim> LISTA DE NOVOS UTENTES PARA AS LISTAGENS DE UTENTES --%>

<%--  LISTA DE FREGUESIAS PARA AS LISTAGENS DE UTENTES --%>
<c:if test="${param.event == 'GetListaFreguesiasPesquisaListas' }">
    <table cellpadding="0" cellspacing="0" width="90%">                  
        <c:forEach var="Row" items="${bindings.ListaFreguesiasDeFamiliaUnidade.rangeSet}" varStatus="lineListaFreguesiasDeFamiliaUnidade">
             <c:set var="paramName">p_Fregusia_${Row.Id}_hidden</c:set>
                  <tr>
                        <td>
                               <span style="white-space:nowrap; vertical-align: bottom;">                                    
                                     <c:choose>                                       
                                          <c:when test="${param[paramName] eq '1'}">                                        
                                               <input onclick="check(this)" type="checkbox" checked="true"  id="p_Fregusia_${Row.Id}" name="p_Fregusia_${Row.Id}" value="${Row.Id}"></input> <c:out value="${Row.Descricao}"/>                                                                         
                                           </c:when>
                                           <c:otherwise>
                                                <input onclick="check(this)" type="checkbox" id="p_Fregusia_${Row.Id}" name="p_Fregusia_${Row.Id}" value="${Row.Id}"></input> <c:out value="${Row.Descricao}"/>
                                           </c:otherwise>
                                     </c:choose>    
                                     <input type="hidden" id="p_Fregusia_${Row.Id}_hidden" name="p_Fregusia_${Row.Id}_hidden" value="${param[paramName]}"/>
                                 </span>
                         </td>
                     </tr>
                </c:forEach>                    
            </table>
</c:if>
<%-- <fim> LISTA DE FREGUESIAS PARA AS LISTAGENS DE UTENTES --%>

<%--  LISTA DE UTENTES PARA AS LISTAGENS --%>
<c:if test="${param.event == 'GetListasOutros'|| param.event_RangeChangeListaUtentesGrupo == 'RangeChangeListaUtentesGrupo' }">

    <div class="ResultadoTotalListaDiv">Existem<strong> ${bindings.ListaUtentesGrupo.estimatedRowCount} </strong> utentes para os parametros selecionados</div><br/>
    <c:choose>
        <c:when test="${not empty bindings.ListaUtentesGrupo.currentRow}">
            <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
                <thead>
                    <tr class="head">
                        <th class="selection"><span style="white-space: nowrap;">-</span></th>
                        <th class="text">N.º de Utente</th>
                        <th class="text last">Nome</th>
                        <th class="text last">Data Nasc.</th>
                        <th class = "text last">Morada</th>
                        <th class = "text last">Telemóvel</th>
                        <th class="text last">Nop</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="RowUtente" items="${bindings.ListaUtentesGrupo.rangeSet}" varStatus="lineListaUtentes">                                       
                        <c:choose>
                            <c:when test="${lineListaUtentes.count %2 == 0}">
                                <c:set var="rowClass" value="odd"/>    
                            </c:when>
                            <c:otherwise>
                                <c:set var="rowClass" value="even"/>    
                            </c:otherwise>                    
                        </c:choose>
                            <tr class="${rowClass}">  
                                <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="detalheUtentePopUp('${RowUtente.Id}');"></td>
                                <td class="text"><c:out value="${RowUtente.Nir}"/></td>
                                <td class="text"><c:out value="${RowUtente.NomeCompleto}"/></td>
                                <td class="date"><c:out value="${RowUtente.DtaNasc}"/></td>
                                <td class="text"><c:out value="${RowUtente.Morada}"/></td>
                                <td class="text"><c:out value="${RowUtente.Telemovel}"/></td>
                                <td class="text last"><c:out value="${RowUtente.Nop}"/></td>  
                            </tr>
                        </c:forEach>
                        <tr class="navigation">
                            <td colspan="2" style="text-align:left">
                                <input id="export" class="submitButton" type="button" name="Exportar Excel" value="Exportar Excel" onclick="popUpExportExcel('exportUtentesGrupo');"/>
                            </td>
                            <td colspan="5">        
                                <jsp:include page="/com/navigationList.jsp" flush="true">
                                    <jsp:param name="rangeBindingName" value="ListaUtentesGrupo"/>
                                    <jsp:param name="targetPageName" value="../com/ajaxServices.do"/>
                                    <jsp:param name="requestType" value="ajaxServices"/>
                                    <jsp:param name="metodToCall" value="populateListaOutros"/>
                                </jsp:include> 
                            </td>
                        </tr>
                </tbody>
              </table>
            </c:when>
            <c:otherwise>
                <p class="hint">A pesquisa efectuada n&atilde;o retornou valores.</p>
            </c:otherwise>
        </c:choose>
</c:if>
<%--  <fim> LISTA DE UTENTES PARA AS LISTAGENS --%>

<%--  Verificação de NIF e NIss --%>
<c:if test="${param.event == 'ValidateDoc' }">
        <c:if test="${requestScope.InvalidNif == 'true'}">
            <div class = "errorMessageText divValidacao">Por Favor introduza um NIF válido. </div>
        </c:if>
        <c:if test="${requestScope.InvalidNiss == 'true'}">
            <div class = "errorMessageText divValidacao">Por Favor introduza um NISS válido. </div>
        </c:if>
        <c:if test="${not empty bindings.ListaUtentesNifDuplicado.currentRow and param.tipoDoc=='NIF'}">
            <div class = "errorMessageText divValidacao">O NIF indicado já existe registado para ${bindings.ListaUtentesNifDuplicado.estimatedRowCount} utente(s): 
                <table style="color:black">
                    <thead></thead>
                    <tbody>
                         <c:forEach var="RowUtente" items="${bindings.ListaUtentesNifDuplicado.rangeSet}" varStatus="lineListaUtentes">
                            <tr>
                                <c:if test="${param.edit == 'true'}">
                                     <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="edicaoDocsUtentePopUp('${RowUtente.Id}');"></td>
                                </c:if>
                                <td class="text"><c:out value="${RowUtente.Nir}"/></td>
                                <td class="text"><c:out value="${RowUtente.NomeCompleto}"/></td>
                                <td class="date"><c:out value="${RowUtente.DtaNasc}"/></td>
                            </tr>
                         </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${not empty bindings.ListaUtentesNissDuplicado.currentRow  and param.tipoDoc=='NISS'}">
             <div class = "errorMessageText divValidacao">O NISS indicado já existe registado para ${bindings.ListaUtentesNissDuplicado.estimatedRowCount} utente(s): 
                <table style="color:black">
                    <thead></thead>
                    <tbody>
                         <c:forEach var="RowUtente" items="${bindings.ListaUtentesNissDuplicado.rangeSet}" varStatus="lineListaUtentes">
                            <tr>
                               <c:if test="${param.edit == 'true'}">
                                     <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="edicaoDocsUtentePopUp('${RowUtente.Id}');"></td>
                                </c:if>
                                <td class="text"><c:out value="${RowUtente.Nir}"/></td>
                                <td class="text"><c:out value="${RowUtente.NomeCompleto}"/></td>
                                <td class="date"><c:out value="${RowUtente.DtaNasc}"/></td>
                            </tr>
                         </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${not empty bindings.ListaUtentesDocIdentDuplicado.currentRow  and param.tipoDoc=='BI'}">
             <div class = "errorMessageText divValidacao">O documento de identificação indicado já existe registado para ${bindings.ListaUtentesDocIdentDuplicado.estimatedRowCount} utente(s): 
                <table style="color:black">
                    <thead></thead>
                    <tbody>
                         <c:forEach var="RowUtente" items="${bindings.ListaUtentesDocIdentDuplicado.rangeSet}" varStatus="lineListaUtentes">
                            <tr>
                                <c:if test="${param.edit == 'true'}">
                                     <td class="text"><img class="img" alt="Detalhe Utente" src="../img/page.gif" onclick="edicaoDocsUtentePopUp('${RowUtente.Id}');"></td>
                                </c:if>
                                <td class="text"><c:out value="${RowUtente.Nir}"/></td>
                                <td class="text"><c:out value="${RowUtente.NomeCompleto}"/></td>
                                <td class="date"><c:out value="${RowUtente.DtaNasc}"/></td>
                            </tr>
                         </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

</c:if>
<%--  <fim>  Verificação de NIF e Niss --%>

<%--   --%>
<c:if test="${param.event == 'ValidateMaternidade'}">
    <%--
    '{ "edit": true }'
    --%>
    ${requestScope.editable}
    <%--
    <c:if test="${requestScope.editable == 'true'}">
        true
    </c:if>

    <c:if test="${requestScope.editable == 'false'}">
        false
    </c:if>
    --%>

</c:if>
