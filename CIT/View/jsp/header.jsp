<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- Variables Start --%>
<c:set var="ctxPath" value="<%=request.getContextPath().replaceAll(\"/\",\"\")%>"/>
<c:set var="ssoURL" value="/${ctxPath}/com/logout.jsp"/>
<c:set var="userDisplayName" value="${pageContext.request.remoteUser}"/>

<%
  boolean redirectToIndex = false;
  if(request.getRequestURI().endsWith("pub/index.jsp") || request.getRequestURI().endsWith("pub/index.do")){
        redirectToIndex = true;
  }
  
  String sessionFlowId = (String)session.getAttribute("flowId");
%>
        
<c:set value="<%=sessionFlowId%>" var="sessionFlowId" />
        
<script type="text/javascript">
    if(opener && <%=redirectToIndex%>){
        alert("A sua sessão expirou. Por favor escolha novamente o perfil para acesso a aplicação."); 
        opener.redirectToIndex();
        window.close();
    }
    
      function openFaqs(){  
    
          var width = 980;
          var height = 600;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          var trackingWindow = window.open('https://estudo.min-saude.pt/eaprender/courses/CITINFORMACAOUTIL/document/CIT_FAQs.pdf','',settings);
          trackingWindow.focus();            
    }
</script>

    <jsp:include page="/com/splash.jsp" flush="true"/>
        <!-- Header Start -->
        <div id="headerDiv"> 
            <table class="topHeaderTable" cellpadding="0" cellspacing="0">
                <thead/>
                <tbody>
                    <tr>
                        <td class="topHeaderTableLeftCol">
                            <c:choose>
                                <c:when test="${not empty param.pDescricaoCentroSaude}">
                                    <span class="headerLabel">Entidade de Sa&uacute;de:</span>
                                    <span class="headerText"><c:out value="${param.pDescricaoCentroSaude}" escapeXml="false"/></span>                    
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="topHeaderTableMiddleCol">
                            <span class="headerTitle">- <c:out value="${param.pTitle}" escapeXml="false"/> -</span>
                        </td>
                        <td class="topHeaderTableRightCol">
                            <c:choose>
                                <c:when test="${not empty pageContext.request.remoteUser}">
                                    <span class="headerLabel">Utilizador:</span>
                                    <span style="padding-right:2px;" class="headerText"><c:out value="${userDisplayName}" escapeXml="false"/></span>
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="bottomHeaderTable" cellpadding="0" cellspacing="0">
                <thead/>
                    <tbody>
                    <tr>
                        <td class="bottomHeaderTableLeftCol">
                            <jsp:include page="/com/menu.jsp" flush="true"/> 
                        </td>
                        <td  class="bottomHeaderTableRightCol">
                            <table align="center" cellpadding="0" cellspacing="0" border="0">
                                <thead/>
                                <tbody> 
                                    <tr>
                                        <td align="center" style="background-color:white;height:17px;width:17px;">
                                            <img src="../img/menu/menu_top2.gif" align="top" alt=""/>
                                        </td>                                    
                                        <c:choose>
                                            <c:when test="${not empty pageContext.request.remoteUser}">
                                                
                                                <%--
                                                <td align="center" style="height:17px;width:20px;background-color:white;">
                                                    <img onClick="alert('sem funcionalidade de impressão presente');" id="btImpressao" style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/printer.gif" align="top" alt="Imprimir"/>
                                                </td>
                                                --%>
                                                
                                                <c:choose>
                                                    <c:when test="${param.pBackEnabled == 'true'}">
                                                        <td align="center" style="height:17px;width:20px;background-color:white;">
                                                            <img onClick="javascript:voltar();" style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_back.jpg" align="top" alt="Voltar"/>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td align="center" style="height:17px;width:20px;background-color:white;">
                                                            <img style="padding-left:2px;padding-right:2px;padding-top:1px;" src="../img/menu_noback.jpg" align="top" alt="Operação Indisponível"/>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                               
                                                <td align="center" style="height:17px;width:20px;background-color:white;">
                                                    <img onClick="javascript:openFaqs();" style="padding-left:2px;padding-right:2px;cursor:pointer;" src="../img/question.gif" align="top" alt="Faqs - Perguntas Frequentes"/>
                                                </td>
                                               
                                                
                                                <td align="center" style="height:17px;width:20px;background-color:white;">
                                                   
                                                   <c:choose>
                                                       <c:when test="${fn:startsWith(sessionFlowId,'CIT')}">
                                                          <img style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_key_disabled.jpg" align="top" alt="Operação Indisponível" />
                                                        </c:when>
                                                       <c:otherwise>
                                                    <img onClick="javascript:popUpDadosUtilizador();" style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_key.jpg" align="top" alt="Informações do Utilizador"/>
                                                       </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td align="center" style="height:17px;width:20px;background-color:white;">
                                                        <c:choose>
                                                           <c:when test="${fn:startsWith(sessionFlowId,'CIT')}">
                                                              <img style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_logout_disabled.jpg" align="top" alt="Operação Indisponível"/>
                                                            </c:when>
                                                           <c:otherwise>
                                                    <img onClick="javascript:window.location.href='${ssoURL}';" style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_logout.jpg" align="top" alt="Sair de Sessão"/>
                                                           </c:otherwise>
                                                        </c:choose>
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td align="center" style="height:17px;width:20px;background-color:white;">
                                                    &nbsp;
                                                </td>
                                                <td align="center" style="height:17px;background-color:white;">
                                                    <a href="#" style="padding-left:2px;padding-right:2px;padding-top:1px;" class="headerAlertLink">Login</a>
                                                </td>
                                            </c:otherwise>
                                        </c:choose>                                                                      
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                       
                    </tr>
                </tbody>
            </table>
                <jsp:include page="/com/infoUtente.jsp" flush="true"/>
              <%--  
                    <jsp:param name="porig" value="${param.pOrigem}"/>
                </jsp:include> --%>
        </div>
        <!-- Header End -->
        <script language="Javascript" type="text/javascript">
            if(document.getElementById('infoUtenteForm')){
                document.write('<div id="topSep" style="padding-top:90px;"></div>');
            }else{
                document.write('<div id="topSep" style="padding-top:30px;"></div>');
            }
        </script>
        <div id="contentDiv">
            <jsp:include page="/com/error.jsp" flush="true"/>
            

