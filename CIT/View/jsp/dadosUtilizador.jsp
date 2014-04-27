<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title>Alteração de Password</title>
    <jsp:include page="/com/head.jsp" flush="true"/>
  </head>
<body onload="verifyChange(${sucessChangePass});" > 
    <!-- DOWN -->
  <script type="text/javascript">
  
  function changePassword(){
            document.getElementById("changePass").action='../sup/dadosUtilizador.do?event=changePassword';
           //splash(true);
            document.getElementById("changePass").submit();
        }
  </script>
     
    <div id="changepass"> 
    <div id="changepassheader">
        Alterar senha
        <img class="classclose" src="../imagens_cit_v3/x.png" alt="pass" onclick="window.close();" />
    </div>
    <div id="contentDiv">
            <jsp:include page="/com/error.jsp" flush="true"/></div>
        <form method="POST" id="changePass" name="changePass" action="">
        <fieldset style="display:none;">
            <input type="hidden" id="idUser" name="idUser" value="${bindings.UtilizadorView.Id}">
        </fieldset>
        <div id="changecontent">
            <div id="name">${sessionScope.username}<span style="color: #999999; margin-left: 15px; font-size: 13px; text-transform: none;" >Utilizador atual</span></div>                
            Senha atual</br>
            <input type="password" style="color: #000000; width: 205px;" id="actualPassword" name="actualPassword"></br>
            Nova senha</br>
            <input type="password" id="newPassword" name="newPassword" style="color: #000000; width: 205px;"></br>
            Confirmação da senha</br>
            <input type="password" id="confirmPassword" name="confirmPassword" style="color: #000000; width: 205px;"></br>
        </div>        
    </form>
    <div id="changepassfooter">
        <button type="submit" style="width: 75px;" class="bread_buttons" id="cancelarbutton" onclick="window.close();">CANCELAR</button>
        <button type="submit" class="bread_buttons" id="avancarbutton" onclick=" changePassword();">GRAVAR</button>        
    </div>
</div>
<div id="backgroundPopup"></div>

<%-- Sucesso a alterar password --%>
<div id="sucess">
    <table width="100%">
        <tr>
            <td align="left">
                <img src="../imagens_cit_v3/certo.png" alt="certo">
            </td>
            <td align="center">
                Senha modificada com sucesso
            </td>
            <td align="right">
                <img src="../imagens_cit_v3/x02.png" alt="close" onclick="window.close();">
            </td>
        </tr>
    </table>
</div>  
</body>
</html>