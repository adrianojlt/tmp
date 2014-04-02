<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">

    <head>
        <title>Pesquisa de Utentes</title>
        <jsp:include page="/com/head.jsp" flush="true"/> 
        <link href="../css_cit_v3/spms-grid.css" rel="stylesheet" type="text/css" />

        <style type="text/css" media="Screen"> 
            .tdResize { max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        </style>

        <!--[if IE]>
        <style>
            .tdResize { table-layout: fixed; width: 100px; }
        </style>
        <![endif]--> 

    </head>

    <body onload=" onloadFirstTime(); onLoadConcFreguesias('${param.idDistrito}', '${param.idConcelho}', '${param.idFreguesia}'); splash(false); ">   
        <div id="outerContainer">
            <div class="center">
                <jsp:include page="/pub/breadcrumb.jsp" flush="true">     
                    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                </jsp:include>
                <jsp:include page="/com/splash.jsp" flush="true"/>                
            </div>    
            <!-- DOWN -->
            <div id ="formContainer" align ="left">
                <jsp:include page="/com/error.jsp" flush="true"/>
                <form id="forma" name="forma" action="pesquisaUtente.do" method="POST">        
                    <fieldset style="display:none;">
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
                        <input type="hidden" id="rowNumberSelected" name="rowNumberSelected" value=""/>
                    </fieldset>                            
                    <p class="titulo">PESQUISA DE UTENTE</p>
                    <table cellpadding="0" cellspacing="0" style="width:98%">
                        <tr>
                            <td style="width:13%">
                                Nº Utente
                            </td>
                            <td style="width:56%">
                                Nome
                            </td>
                            <td style="width:8%">
                                Idade de
                            </td>
                            <td style="width:8%">
                                a
                            </td>
                            <td style="width:15%">
                                Data de nascimento
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="nSNS" name="nSNS" type="text" class="pesquisa" style="width:87%;" onkeypress="noAlpha(this); focusObjectOnEnterPressed('pesquisa', event);" onkeyup="noAlpha(this);" maxlength="9" value="${param.nSNS}"/>
                            </td>
                            <td>
                                <input id="nomes" name="nomes" type="text" class="pesquisa" style="width:97%;" value="${param.nomes}" onkeypress="focusObjectOnEnterPressed('pesquisa', event);" />
                            </td>
                            <td>
                                <input id="idadeDe" name="idadeDe" type="text" class="pesquisa" style="width:76%;" onkeypress="noAlpha(this); focusObjectOnEnterPressed('pesquisa', event);" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeDe');" value="${param.idadeDe}"/>
                            </td>
                            <td>
                                <input id="idadeA" name="idadeA" type="text" class="pesquisa" style="width:76%;" onkeypress="noAlpha(this); focusObjectOnEnterPressed('pesquisa', event);" onkeyup="noAlpha(this);" onchange="colocaLimiteIdadeDefeito('idadeAte');" value="${param.idadeA}"/>
                            </td>
                            <td>
                               <input id="dataNasc" name="dataNasc" type="text" style="width:82%;margin-right:3px" class=" pesquisa inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" maxlength="10" value="${param.dataNasc}" onkeypress="valData(this,event); focusObjectOnEnterPressed('pesquisa', event); " onkeyup="valData(this,event);" onblur="valData(this,event);"/>
                    
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" style="width:98%;display:${param.pPesquisaAvancada?'':'none'};" id="pesquisaavancada">
                        <tr style>
                            <td style="width:17%">
                                NISS
                            </td>
                            <td style="width:17%">
                                NOP
                            </td>
                            <td style="width:34%">
                                País
                            </td>
                            <td>
                                Nacionalidade
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="pNiss" class="pesquisa" id="pNiss" value ="${param.pNiss}" style="width:85%"/>
                            </td>
                            <td>
                                <input type="text" name="nOP" class="pesquisa" id="nOP" value ="${param.nOP}" style="width:85%"/>
                            </td>
                            <td>
                                <select id="paisNat" name="paisNat" class="pesquisa" style="width:95%" onchange="controlaPaisNat();">
                                    <option value="" label=""/>
                                    <%-- caso nao tenha sido escolhida nenhuma opcao coloca portugal por defeito --%>                                    
                                    <c:forEach var="Row" items="${bindings.ListaPaisesLov.rangeSet}" varStatus="lineListaPaisesLov">        
                                        <c:set var="idPaisNat" value="${param.paisNat}"/>
                                        <c:choose>
                                            <c:when test="${ ( Row.Id == idPaisNat )}">
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}" selected><c:out value="${Row.Descricao}"/></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>
                                <select id="paisNac" name="paisNac" class="pesquisa" style="width:100%">
                                    <option value="" label=""/>
                                    <%-- caso nao tenha sido escolhida nenhuma opcao coloca portugal por defeito --%>
                                    <c:forEach var="Row" items="${bindings.ListaPaisesLov.rangeSet}" varStatus="lineListaPaisesLov">
                                        <c:set var="idPaisNac" value="${param.paisNac}"/>
                                        <c:choose>
                                            <c:when test="${ ( Row.Id == idPaisNac)}">
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}" selected><c:out value="${Row.Descricao}"/></option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${Row.Id}" title="${Row.Codigo} - ${Row.Descricao}" label="${Row.Descricao}"><c:out value="${Row.Descricao}"/></option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>                        
                        <tr>
                            <td colspan="2">
                                Distrito
                            </td>
                            <td>
                                Concelho
                            </td>
                            <td>
                                Freguesia
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">    
                                <select name="idDistrito"  id="idDistrito" style="width:95%" class="pesquisa" onchange = "getConcelhos();">
                                    <option value=""></option>
                                    <c:forEach var="Row" items="${bindings.ListaDistritosLov.rangeSet}" varStatus="status">
                                        <option value="${Row.Id}" ${param.idDistrito==Row.Id?'selected':''}>${Row.Descricao}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>        
                                <select name="idConcelho"  id="idConcelho" style="width:95%" class="pesquisa" onchange = "getFreguesias();">                       
                                </select>
                            </td>
                            <td>
                                <select name="idFreguesia"  id="idFreguesia" style="width:100%" class="pesquisa" onchange = "">
                                </select>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>                            
                                <button style="margin-bottom:0px" type="button" class="pesquisar"  id="pesquisa" name="search" onclick="if(validaFiltroPesquisa()){ submitFormulario('search'); }" >PESQUISAR</button>
                            </td>
                            <td>
                                <button style="margin-bottom:0px" type="button" class="limpar" onclick="cleartext(); ">LIMPAR</button>
                            </td>
                            <td>
                                <input style="margin-top:0px;vertical-align:middle" class="pesquisacheckbox" type="checkbox" name="avancada" id="checkavancada"  ${param.pPesquisaAvancada?'checked':''}  onchange="pesquisaavancada()" onclick="pesquisaavancada()"/>
                            </td>
                            <td style="padding-left: 5px;">
                                Pesquisa avançada    
                            </td>
                        </tr>
                    </table>
                    <c:choose>
                        <c:when test="${not empty bindings.ListaUtentesIterator.currentRow}">
                            <table id="navigationTable" style="width:98%">
                                <tr class="navigation">
                                    <td> 
                                        <jsp:include page="/com/navigationList.jsp" flush="true">
                                            <jsp:param name="rangeBindingName" value="ListaUtentes"/>
                                            <jsp:param name="targetPageName" value="pesquisaUtente.do"/>
                                        </jsp:include>
                                    </td>
                                </tr> 
                            </table>
                            <table class="pesquisaresultados">        
                                <thead>              
                                    <tr>
                                        <th class="pesquisaresultados">
                                            N. SNS
                                        </th>
                                        <th class="pesquisaresultados">
                                            Nome
                                        </th>
                                        <th class="pesquisaresultados">
                                            Data Nasc.
                                        </th>
                                        <th class="pesquisaresultados">
                                            Morada
                                        </th>
                                        <th class="pesquisaresultados">
                                            Doc. Identificação
                                        </th>
                                        <th class="pesquisaresultados">
                                            Centro de Saúde
                                        </th>
                                        <th class="pesquisaresultados"></th>
                                        <th class="pesquisaresultados"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="Row" items="${bindings.ListaUtentes.rangeSet}" varStatus="lineListaUtentes">  
                                        <c:choose> 
                                            <c:when test="${lineListaUtentes.count % 2 != 0}">
                                                <c:set var="rowClass" value="pesquisaresultadosimpar"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="rowClass" value="pesquisaresultadospar"/>
                                            </c:otherwise>
                                        </c:choose>

                                        <tr class="${rowClass}" onclick="seleccionarUtente(${lineListaUtentes.count}, '${Row.Obito}' )">

                                            <td class="selection" style="display:none;">
                                                <input id="iiuId${lineListaUtentes.count}" name="iiuId${lineListaUtentes.count}" type="hidden" value="${Row.IiuId}"/>
                                                <input id="iinId${lineListaUtentes.count}" name="iinId${lineListaUtentes.count}" type="hidden" value="${Row.IinId}"/>
                                                <input id="tabInscr${lineListaUtentes.count}" name="tabInscr${lineListaUtentes.count}" type="hidden" value="${Row.TabInscr}"/>
                                                <input id="csaudeId${lineListaUtentes.count}" name="csaudeId${lineListaUtentes.count}" type="hidden" value="${Row.CsaudeId}"/>
                                                <input id="selID" name="selID" type="radio" value="${lineListaUtentes.count}" onclick="disponibilizaOpcoes(); highlightRow(this, ${lineListaUtentes.count});"/>
                                            </td> 

                                            <td id="" class="numeric pesquisaresultados" style="width:5%;">    
                                                <c:out value="${Row.Nir}"/>                                
                                            </td>

                                            <td id="nomeUtente" class="text pesquisaresultados tdResize" title="${Row.NomeCompleto}" style="width:10%;">
                                                <c:out value="${Row.NomeCompleto}"/>
                                            </td>                                                                                        

                                            <td class="date pesquisaresultados" style="width:7%;">
                                                <c:out value="${Row.DtaNasc}"/>
                                            </td>

                                            <td id="moradaUtente" class="text pesquisaresultados tdResize" title="${Row.Morada}" style="width: 15%;">
                                                <c:out value="${Row.Morada}"/>
                                            </td>

                                            <td class="text pesquisaresultados" style="width:8%;">
                                                <c:if test="${not empty Row.NumId}">
                                                    <c:out value="${Row.CodigoId}"/>&nbsp;:&nbsp;<c:out value="${Row.NumId}"/>
                                                </c:if>
                                            </td>

                                            <td id="centroSaudeUtente" class="text pesquisaresultados tdResize" title="${Row.CsaudeDesig}" style="width:10%;">
                                                <c:out value="${Row.CsaudeDesig}"/>
                                            </td>

                                            <td class="text pesquisaresultados" style="width:2%; text-indent:3px;">
                                                <c:choose>
                                                    <c:when test="${not empty Row.IdpPotDup}">
                                                        <script type="text/javascript">
                                                            obitos[contadorObitos] = '${lineListaUtentes.count}';
                                                            contadorObitos++;
                                                        </script>
                                                        <img alt="" src="../imagens_cit_v3/potdup.png" height="16" width="16" /> 
                                                    </c:when>
                                                </c:choose>
                                            </td>

                                            <td style="width:2%; text-indent:3px;">
                                                <c:choose>
                                                    <c:when test="${Row.Obito == 'S'}">
                                                        <img class="img" alt="Ver Potencial Duplicado" 
                                                             src="../imagens_cit_v3/obito.png" height="16" width="16"/>
                                                    </c:when>
                                                </c:choose>
                                            </td>

                                        </tr>

                                    </c:forEach>
                                </tbody>
                            </table>
                            <table align="right" style="margin-right:20px;">
                                <tr>
                                    <td>
                                        <img class="img" alt="Duplicado" src="../imagens_cit_v3/potdup.png" height="14" width="14"/>
                                    </td>
                                    <td style="font-size: 10px;">
                                        Potencial Duplicado
                                    </td>
                                    <td style="padding-left:20px;">
                                        <img class="img" alt="Obito" src="../imagens_cit_v3/obito.png" height="14" width="14"/>
                                    </td>
                                    <td style="font-size: 10px;">
                                        Óbito
                                    </td>
                                </tr>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty param.pPesquisaTipoEfectuada}">
                                <h4 style="padding-left:20px;">Resultados Pesquisa</h4>
                                <p class="hint" style="padding-left:20px;">A pesquisa efectuada n&atilde;o retornou valores.</p>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </form>
            <!-- UP -->
            </div>                
            <jsp:include page="/com/footer.jsp" flush="true"/>
            <c:if test="${param.novaPesquisa=='Nova Pesquisa' }">
                <script type="text/javascript">
                    limpa('P'); 
                </script>
            </c:if>    
        </div>
        
    </body>
</html>