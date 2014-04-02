 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
        <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
        <jsp:include page="/com/head.jsp" flush="true"/>
        <script type="text/javascript" src="../js_cit_v3/login_popup.js"></script>
        <script type="text/javascript" src="../js_cit_v3/login.js"></script>

  </head>
  <body onload="splash(false); ">
  <jsp:include page="/com/splash.jsp" flush="true"/>
    <div id="outerContainer">
            <div class="center">
                <jsp:include page="/pub/breadcrumb.jsp" flush="true">     
                    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                </jsp:include>
                <jsp:include page="/com/error.jsp" flush="true"/>
            </div>
            <c:if test="${empty sessionScope.centroSaudeEscolhido}" >
                <%-- 
                Considerações:
                #############
            
                Esta página tem como objectivo permitir ao utilizador a escolha do perfil para acesso à aplicação.
                - Se o perfil já tiver sido escolhido a página aparece em branco.
                - Caso o utilizador apenas detenha um perfil. A aplicação automáticamente adiciona esse perfil à sessão.
                - Caso o utilizador em causa detenha mais que um perfil é-lhe dada a possibilidade de escolha de um perfil.
                nota: de salientar que a navegação não será permitida enquanto não for escolhido um perfil.
                
                apresentar lista de perfis para escolha caso o utilizador tenha mais do que um 
                --%>
                <c:choose>
                <c:when test="${bindings.InformacaoUtilizador.estimatedRowCount>0}">
                <form method="POST" id="escolhaPerfil" name="escolhaPerfil" action="index.do" onsubmit="splash(true);">
                    <fieldset style="display:none">
                        <input type="hidden" name="event" id="idEvent" value="">
                        <input type="hidden" name="csaudeEscolhido" id="csaudeEscolhido" value="">
                        <input type="hidden" name="perfilEscolhido" id="perfilEscolhido" value="">
                        <input type="hidden" name="uri" id="uri" value="${param.uri}">
                    </fieldset>
                    
                    <div id ="formContainer" align ="left">
                    
                         <div class ="tabelaPerfis">
                                 <div class="subTitle">Por favor, seleccione a entidade:</div>
                                  <table  id="navigationTable">
                                    <tr class="navigation">
                                        <td>
                                            <jsp:include page="/com/navigationList.jsp" flush="true">
                                              <jsp:param name="rangeBindingName" value="InformacaoUtilizador"/>                      
                                              <jsp:param name="targetPageName" value="index.do"/>
                                            </jsp:include> 
                                         </td>
                                         </tr>
                                    </table>
                                   <table id="readOnlyTable" border="0" cellpadding="0" cellspacing="0" class="pesquisaresultados" style="width:100%">
                                       <thead>
                                            <tr class="head">
                                                <th class="pesquisaresultados"><span style="white-space: nowrap;">Entidade</span></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="Row" items="${bindings.InformacaoUtilizador.rangeSet}" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${status.count % 2 != 0}">
                                                        <c:set var="rowClass" value="pesquisaresultadosimpar"/>
                                                    </c:when> 
                                                    <c:otherwise>
                                                        <c:set var="rowClass" value="pesquisaresultadospar"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <tr class="${rowClass}" onclick="highlightRow(this,${status.count}); atribuiSeleccaoPerfil('${Row.CsId}','${Row.PerfilId}');"> 
                                                <td class="selection"  style="display:none;">
                                                <c:choose>
                                                    <c:when test="${not empty Row.ProfId}" >
                                                        <input name="selCod" class="radio" type="radio" onclick="highlightRow(this,${status.count}); atribuiSeleccaoPerfil('${Row.CsId}','${Row.PerfilId}');">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input name="selCod" class="radio" type="radio" onclick="highlightRow(this,${status.count}); atribuiSeleccaoPerfil('${Row.CsId}','${Row.PerfilId}');">
                                                        <!--<input name="selCod" class="radio" type="radio" disabled>-->
                                                    </c:otherwise>
                                                </c:choose>
                                                </td>
                                                <td class="text" ><c:out value="${Row.CsDesc} (${Row.CodigoCs} - ${Row.DescricaotipoCs})"/></td>
                                            </tr>
                                          </c:forEach>
                                        </tbody>
                                    </table>
                            </div>
                        </div>
                </form>
            </c:when>
            </c:choose>
        </c:if>
    </div>
    <jsp:include page="/com/footer.jsp" flush="true"/>
   </body>
</html>
