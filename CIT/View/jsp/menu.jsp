<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--Inicializamos as variaveis necessarias-->
<c:set var="currParent" value=""/>
<c:set var="oldParent" value=""/>

        <ul id="pmenu">
                <c:forEach var="Row" items="${bindings.OpcoesMenuUtilizador.rangeSet}" varStatus="lineOpcoesMenu">
                    <c:set var="currParent" value="${Row.PaiNome}"/>
                    <c:choose>
                        <c:when test="${currParent != oldParent}">
                            <c:choose>
                                <c:when test="${not empty oldParent}">
                                    <%="</ul><!--[if lte IE 6]></td></tr></table></a><![endif]--></li>"%>
                                </c:when>                
                            </c:choose>
                            <li class="drop"><a href="#nogo" class="encloseNoBorder">${Row.PaiPrompt}<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>                        
                                <li><a href="${Row.FilhoUrl}" onClick="splash(true);" class="enclose"><c:out value="${Row.FilhoPrompt}"/></a></li>
                </c:when>
                <c:otherwise>
                                <li><a href="${Row.FilhoUrl}" onClick="splash(true);" ><c:out value="${Row.FilhoPrompt}"/></a></li>                
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${lineOpcoesMenu.count == bindings.OpcoesMenuUtilizador.estimatedRowCount}">
                    <%="</ul><!--[if lte IE 6]></td></tr></table></a><![endif]--></li>"%>               
                </c:when>
            </c:choose>            
            <c:set var="oldParent" value="${currParent}"/>        
        </c:forEach>
        </ul>