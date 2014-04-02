<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ page import="java.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>

        <title>Motivo de Anulação de CIT</title>
        <base target="_self">

        <jsp:include page="/com/head.jsp" flush="true"/>
        
        <script type="text/javascript">
       
            function enableButton (button) { 
                button.className = 'subCont';
                button.removeAttribute("disabled");
            }
            
            function closeWindow() {
                <c:if test="${param.hiddenAnnulCit == 'set' and requestScope.Erro != 'Erro' }">
                   self.close();
                </c:if>
            }        

            function cancelEvent(arg) {

                $.spmsDialog( 'confirm', 
                    { 
                        title: 'Confirmar?', 
                        message: 'Confirma a anulação?', 
                        callback: function() {
                            splash(true);
                            document.getElementById('idevent').value='annul';
                            arg.form.submit()
                        } 
                    }
                );
            }
        </script>      
    </head>
    <body onload="splash(false); closeWindow();">
        <div id="outerContainer">
            <div class="center">
                <jsp:include page="/pub/breadcrumb.jsp" flush="true">      
                    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/>
                    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/>
                    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                    <jsp:param name="pTitle" value="Alta de Baixas/Prorrogra&ccedil;&atilde;o de Baixa"/>
                    <jsp:param name="pBackEnabled" value="true"/>
                </jsp:include>
                <jsp:include page="/com/splash.jsp" flush="true"/>                
            </div>
            <div id ="formContainer" align ="left" style="width:95.5%">
                <jsp:include page="/com/error.jsp" flush="true"/>
                <jsp:include page="/com/infoUtente.jsp" flush="true">
                    <jsp:param name="pDescricaoPagina" value="> ANULAR"/>
                </jsp:include>
                <form method="POST" action="" onsubmit="splash(true);">                  
                    <div class="subTitle">Motivo de Anulação de CIT</div>
                    <div class ="subContainerTable">
                        <table id="navigationTable" style="width:100%">
                            <tr class="navigation">
                                <td> 
                                    <jsp:include page="/com/navigationList.jsp" flush="false">
                                        <jsp:param name="rangeBindingName" value="ListaCodigosGenericos"/>                                                          
                                        <jsp:param name="targetPageName" value="motivoAnulacaoLov.do"/>
                                    </jsp:include>
                                </td>
                            </tr> 
                        </table>                                 
                        <table  id="readOnlyTable" class="baixas" cellpadding="0" cellspacing="1" border="0" style="width:100%">
                            <thead>
                                <tr class="head">
                                    <th class="pesquisaresultados">Código</th>
                                    <th class="pesquisaresultados">Descrição</th>  
                                </tr>
                            </thead>
                            <tbody>        
                                <c:forEach var="RowListaCodigosGenericos" items="${bindings.ListaCodigosGenericos.rangeSet}" varStatus="lineListaCodigosGenericos">
                                    <c:choose>
                                        <c:when test="${lineListaCodigosGenericos.count % 2 != 0}">
                                            <c:set var="trClassItemBaixa" value="pesquisaresultadosimpar"/>
                                        </c:when>   
                                        <c:otherwise>
                                            <c:set var="trClassItemBaixa" value="pesquisaresultadospar"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <input type="hidden" name="radioIdMotivo" id="radioIdMotivo" value=""/>
                                    <tr class="${trClassItemBaixa}" onClick="javascript:highlightRow(this,${lineListaCodigosGenericos.count});
                                                                             enableButton(document.getElementById('event_annul'));
                                                                             document.getElementById('hiddenAnnulCit').value = 'set';
                                                                             document.getElementById('radioIdMotivo').value = '<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>'">                                    
                                        <td class="text pesquisaresultados">
                                            <c:out value="${RowListaCodigosGenericos[\'Codigo\']}"/>
                                        </td>
                                        <td class="text pesquisaresultados">
                                            <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                        </td>
                                    </tr> 
                                </c:forEach>
                            </tbody>
                        </table>
                        <table style="width:90%">
                            <tbody>
                                <tr>
                                    <td align="left" colspan="2" style="padding-top:20px;padding-bottom:6px;text-indent:0px;">Comentário de Anulação</td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="text-indent:0px;">
                                        <input style="width:100%" id="comentarioAnulacao" name="comentarioAnulacao" maxlength="150" class="inputTextSix"></input>
                                    </td>
                                </tr>
                            </tbody>
                        </table>                        
                    </div>
                    <div id="divButtonTableItemsBaixas" class="subContainerButtons" style="width:98.5%">
                        <table id="buttonTable" cellpadding="0" cellspacing="1" border="0">
                            <thead/>
                            <tbody>
                                <tr>
                                    <td>
                                        <!-- onLoad this page, if this variable is set, then it will close the window -->
                                        <input type="hidden" name="hiddenAnnulCit" id="hiddenAnnulCit" value=""/>
                                        <input type="hidden" name="hiddenidItemBaixa" id="hiddenidItemBaixa" value="<c:out value="${param.idItemBaixa}"/>"/>
                                        <input type="hidden" name="hiddenidBaixa" id="hiddenidBaixa" value="<c:out value="${param.idBaixa}"/>"/>
                                        <input type="hidden" name="gitAdmin" id="gitAdmin" value="<c:out value="${param.gitAdmin}"/>"/>
                                        <input type="hidden" name="event" id="idevent" value=""/>
                                        <button style="width:65px" class="subCont buttonDisabled" id="event_annul" name="event_annul" type="button" onclick="cancelEvent(this);" value="Anular" disabled >Anular</button>
                                    </td>
                                    <td>
                                        <button style="width:80px" class="subCont" type="button" onclick="self.close();" value="Cancelar">Cancelar</button>
                                        
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
        </div>
     </body>
</html>