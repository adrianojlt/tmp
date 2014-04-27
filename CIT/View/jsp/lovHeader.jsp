<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
    <script type="text/javascript" src="../js/popups.js"></script>


    <jsp:include page="/com/splash.jsp" flush="true"/>

    <table class="topHeaderTable" cellpadding="0" cellspacing="0">
        <thead/>
        <tbody>
            <tr>
                <td class="topHeaderTableLeftCol">&nbsp;</td>
                <td class="topHeaderTableMiddleCol">&nbsp;
                     <span class="headerTitle">- <c:out value="${param.pTitleLov}" escapeXml="false"/> -</span> 
                </td>
                <td  class="topHeaderTableRightCol">&nbsp;</td>
            </tr>
        </tbody>
    </table>
    
    <table class="bottomHeaderTable" cellpadding="0" cellspacing="0">
        <thead/>
        <tbody>
            <tr>
                <td class="bottomHeaderTableLeftCol">&nbsp;</td>
                <td class="bottomHeaderTableRightCol">
                    <table cellpadding="0" cellspacing="0" border="0">
                        <thead/>
                        <tbody> 
                            <tr>
                                <td align="center" style="background-color:white;height:17px;width:17px;">
                                    <img src="../img/menu/menu_top2.gif" align="top" alt=""/>
                                </td> 
                                
                                <c:choose>
                                <c:when test="${param.pBackEnabled == 'true'}">
                                    <td align="center" style="height:17px;width:20px;background-color:white;">
                                        <img onClick="self.close(); return true;" style="padding-left:2px;padding-right:2px;padding-top:1px;cursor:pointer;" src="../img/menu_back.jpg" align="top" alt="Voltar"/>
                                    </td>
                                </c:when>
                                <c:otherwise>
                                    <td align="center" style="height:17px;width:20px;background-color:white;">
                                        <img style="padding-left:2px;padding-right:2px;padding-top:1px;" src="../img/menu_noback.jpg" align="top" alt="Operação Indisponível"/>
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

    <div id="contentDiv">
            <jsp:include page="/com/error.jsp" flush="true"/>