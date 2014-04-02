 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
    <jsp:include page="/com/head.jsp" flush="true"/>
  </head>
  <body onload="splash(false); ">
    <jsp:include page="/com/header.jsp" flush="true">     
    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
    <jsp:param name="pTitle" value="Registo Nacional de Certificados de Incapacidade Temporária"/>
  </jsp:include>

  <script type="text/javascript">
   function atribuiSeleccaoPerfil(csaude,perfil){
        document.escolhaPerfil.csaudeEscolhido.value = csaude;
        document.escolhaPerfil.perfilEscolhido.value = perfil;
        
        setEnabledOrDisabledButtons(new Array('btSeleccionar'), false);
   }
   
   function SeleccionarPerfil(){
        if(document.escolhaPerfil.csaudeEscolhido.value.length>0){
            document.getElementById('idEvent').value = 'addPerfil';
            splash(true);
            document.escolhaPerfil.submit();
        } else {
            alert("Tem que seleccionar um perfil.");
        }
   }
  </script>

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
            <fieldset>
                <input type="hidden" name="event" id="idEvent" value="">
                <input type="hidden" name="csaudeEscolhido" id="csaudeEscolhido" value="">
                <input type="hidden" name="perfilEscolhido" id="perfilEscolhido" value="">
                <input type="hidden" name="uri" id="uri" value="${param.uri}">
            </fieldset>
        
        <h4>Perfis</h4>
        <p class="hint">Por favor, escolha um dos seus perfis para acesso à aplicação.</p>
        
           <table id="readOnlyTable" border="0" cellpadding="0" cellspacing="0">
           <thead>
                <tr class="head">
                    <th class="selection"><span style="white-space: nowrap;">-</span></th>
                    <th class="text"><span style="white-space: nowrap;">Entidade</span></th>
                    <th class="text last"><span style="white-space: nowrap;">Perfil</span></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="Row" items="${bindings.InformacaoUtilizador.rangeSet}" varStatus="status">
                <c:choose>
                <c:when test="${status.count % 2 != 0}">
                    <c:set var="rowClass" value="even"/>
                </c:when> 
                <c:otherwise>
                    <c:set var="rowClass" value="odd"/>
                </c:otherwise>
                </c:choose>
                
                <tr class="${rowClass}"> 
                <td class="selection" >
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
                <td class="text last" ><c:out value="${Row.papel}"/></td>
                </tr>
                
                
                
              </c:forEach>
              <tr class="navigation">
                <td colspan="3">
                    <jsp:include page="/com/navigationList.jsp" flush="true">
                      <jsp:param name="rangeBindingName" value="InformacaoUtilizador"/>                      
                      <jsp:param name="targetPageName" value="index.do"/>
                    </jsp:include> 
                 </td>
                 </tr>
            </tbody>
            </table>
            
            <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
            <tr>
                <td>
                    <input class="submitButton" type="button" id="btSeleccionar" name="btSeleccionar" value="Seleccionar" onclick="SeleccionarPerfil();" />  
                    <script type="text/javascript">setEnabledOrDisabledButtons(new Array('btSeleccionar'), true);</script>
                </td>
            </tr>
            </tbody>
            </table>
        </form>
    </c:when>
    </c:choose>
    </c:if>
    <jsp:include page="/com/footer.jsp" flush="true"/>
   </body>
</html>
