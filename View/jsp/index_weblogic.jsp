 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
        <link rel="stylesheet" type="text/css" href="../css_cit_v3/cit_v3_base.css" title="style"/>
        <script type="text/javascript" src="../js_cit_v3/login_popup.js"></script>
        <script type="text/javascript" src="../js_cit_v3/login.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    </head>
    <body onload=valida_login(); style="overflow-y:hidden; overflow-x:hidden;">
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
            <fieldset  style="display:none;">
                <input type="hidden" name="event" id="idEvent" value=""/ >
                <input type="hidden" name="csaudeEscolhido" id="csaudeEscolhido" value=""/>
                <input type="hidden" name="perfilEscolhido" id="perfilEscolhido" value=""/>
                <input type="hidden" name="uri" id="uri" value="${param.uri}"/>
            </fieldset>
            <div id="login_popup">
                <div id="login_popup_content_icons">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <img src="../imagens_cit_v3/logo_cit.png" alt="CIT" height="35" width="132">
                            </td>
                            <td align="center">
                                <img src="../imagens_cit_v3/separador.png" alt="separador" height="80" width="1">
                            </td>
                            <td align="right">
                                <img src="../imagens_cit_v3/logo_spms.png" alt="SPMS" height="54" width="100">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="login_popup_content">
                    <table>
                        <tr>
                            <td class="login">
                                <img src="../imagens_cit_v3/user.png" alt="user"/>
                            </td>
                            <td>
                                <input type="text" name="j_username" id="user" value="${sessionScope.username}" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="login">
                                <img src="../imagens_cit_v3/pass.png" alt="pass"/>
                            </td>
                            <td>
                                <input type="password" name="j_password" id="pass" value="password" disabled="disabled"/>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td style="width: 170px;">
                                <div id="error_msg">${not empty param.Retry? 'Senha incorrecta':''}</div>
                            </td>
                            <td>
                                <button type="button" class="button_avancar" id="avancarbutton"  disabled = "disabled">AVANÇAR</button>
                            </td>
                        </tr>
                    </table>   
                </div>
                <div id="login_popup_content2">
                    <div id="login_popup_content3"></div>
                    <table style="padding-top:15px">
                        <tr>
                            <td colspan="2"> 
                                <select name="cbPerfil"  id="cbPerfil"  onchange = "selectPerfil();">
                                    <option value="">ENTIDADE</option>
                                    <c:forEach var="Row" items="${bindings.InformacaoUtilizador.rangeSet}" varStatus="status">
                                         <option value="${Row.CsId};${Row.PerfilId}">${Row.CsDesc} (${Row.CodigoCs} - ${Row.DescricaotipoCs})</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button type="button" class="button_cancel" onclick="javascript:window.location.href='../com/logout.jsp';">CANCELAR</button>
                            </td>
                            <td>
                                <button type="button" class="button_ok" onclick="enterApplication()">ENTRAR</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </form>
        </c:when>
        </c:choose>
        </c:if>
        <jsp:include page="/com/footer.jsp" flush="true"/>
    </body>
</html>
