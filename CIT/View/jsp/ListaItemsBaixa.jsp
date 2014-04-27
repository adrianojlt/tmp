 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>ListaItemsBaixa</title>
    </head>
    <body>
        <table id="navigationTable" style="margin-top:5px;width:98%">
            <tr class="navigation">
                <td> 
                    <jsp:include page="/com/navigationList.jsp" flush="true">
                        <jsp:param name="rangeBindingName" value="ListaItemsBaixas"/>                      
                        <jsp:param name="listaNumRowsName" value="git.listaItemsBaixasNumRows"/>    
                        <jsp:param name="targetPageName" value="edicaoProrrogacaoBaixa.do"/>
                    </jsp:include> 
                </td>
            </tr> 
        </table>
         <table id="readOnlyTable" class="baixas" cellpadding="0" cellspacing="1">
            <thead>
                <tr class="head">
                    <th class="pesquisaresultados" style="width:90px"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Tiporegisto\']}"/></span></th>
                    <th class="pesquisaresultados" style="width:225px"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Classdoenca\']}"/></span></th>
                    <th class="pesquisaresultados" style="width:90px"><span style="white-space: nowrap;"><c:out value="Data início"/></span></th>
                    <th class="pesquisaresultados" style="width:50px"><span style="white-space: nowrap;"><c:out value="Dias"/></span></th>
                    <th class="pesquisaresultados" style="width:90px"><span style="white-space: nowrap;"><c:out value="Data termo"/></span></th>
                    <th class="pesquisaresultados" style="width:30px;text-align:center;text-indent:0px"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Incapacitado\']}"/></span></th>
                    <th class="pesquisaresultados" style="width:30px;text-align:center;text-indent:0px"><span style="white-space: nowrap;"><c:out value="CA"/></span></th>
                    <th class="pesquisaresultados" style="width:30px;text-align:center;text-indent:0px"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Autorizsaida\']}"/></span></th>
                    <th class="pesquisaresultados" style="width:185px"><span style="white-space: nowrap;"><c:out value="Unidade saúde"/></span></th>
                    <th class="pesquisaresultados" style="width:160px"><span style="white-space: nowrap;"><c:out value="Médico"/></span></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="RowListaItemsBaixas" items="${bindings.ListaItemsBaixas.rangeSet}" varStatus="lineListaItemsBaixas">
                    <c:choose>
                        <c:when test="${lineListaItemsBaixas.count % 2 != 0}">
                            <c:set var="trClassItemBaixa" value="pesquisaresultadosimpar"/>
                        </c:when>   
                        <c:otherwise>
                            <c:set var="trClassItemBaixa" value="pesquisaresultadospar"/>
                        </c:otherwise>
                    </c:choose>
                    <fmt:setLocale value="pt_PT"/>
                    <fmt:parseNumber var="DiasDiferenca" type="number" value="${RowListaItemsBaixas.Diasdiferenca}"/>
                    <fmt:parseNumber var="Onze" type="number" value="11"/>
                    <tr class="${trClassItemBaixa}">
                        <td class="text pesquisaresultados"><c:out value="${RowListaItemsBaixas.Tiporegisto}"/></td>
                        <td class="text pesquisaresultados"><c:out value="${RowListaItemsBaixas.Classdoenca}"/></td>
                        <td class="date pesquisaresultados"><c:out value="${RowListaItemsBaixas.Datainicio}"/></td>
                        <td class="text pesquisaresultados"><c:out value="${RowListaItemsBaixas.Diasbaixa}"/>
                            <script type="text/javascript">
                                <%--// Campo para ajudar a verificação se a inserção de Baixa vai apagar algum item de baixa --%>
                                if (document.getElementById('hiddenEmissaoAltaLastItemDate') && document.getElementById('hiddenEmissaoAltaLastItemDate').value == '') {
                                    document.getElementById('hiddenEmissaoAltaLastItemDate').value = '<c:out value="${RowListaItemsBaixas[\'Datainicio\']}"/>';
                                }
                            </script>
                        </td>
                        <td class="date pesquisaresultados"><c:out value="${RowListaItemsBaixas.Datatermo}"/></td>
                        <td style="text-align:center;text-indent:0px">                                           
                            <c:choose>
                                <c:when test="${RowListaItemsBaixas[\'Incapacitado\']=='S'}">   
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" title="Incapacitado" checked="checked" disabled/>
                                </c:when>
                                <c:otherwise>                            
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" disabled="disabled" title="Incapacitado"/>                                                          
                                </c:otherwise>
                            </c:choose> 
                        </td>                            
                        <td style="text-align:center;text-indent:0px">
                            <c:choose>
                                <c:when test="${RowListaItemsBaixas[\'Cirurgiaambulatorio\']=='S'}">   
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" title="Cirurgia Ambulatorio" checked="checked" disabled/>
                                </c:when>
                                <c:otherwise>
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" title="Cirurgia Ambulatorio" disabled/>
                                </c:otherwise>
                            </c:choose> 
                        </td>
                        <td style="text-align:center;text-indent:0px">
                            <c:choose>
                                <c:when test="${RowListaItemsBaixas[\'Autorizsaida\']=='S'}">   
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" checked="checked" title="Autorização Saida: <c:out value="${RowListaItemsBaixas.Justificacao}"/>" disabled />
                                </c:when>
                                <c:otherwise>
                                    <input style="margin-bottom:0px;" class="pesquisacheckbox" type="checkbox" title="Autorização Saida: Não está autorizado a sair" disabled />
                                </c:otherwise>
                            </c:choose> 
                        </td>
                        <c:set var="title_entidade" value="${RowListaItemsBaixas[\'Entidade\']}"/>
                        <td class="text" title="${title_entidade}">
                            <div class="adjust-text-div" style="width:185px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                <c:out value="${RowListaItemsBaixas[\'Entidade\']}"/>
                            </div>
                        </td>
                        <c:set var="title_medico" value="${RowListaItemsBaixas[\'Medico\']}"/>
                        <td class="text last" title="${title_medico}">
                            <div class="adjust-text-div" style="width:160px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                <c:out value="${RowListaItemsBaixas[\'Medico\']}"/>
                            </div>
                        </td>
                    </tr>
                </c:forEach>               
            </tbody>
        </table>  
    </body>
</html>