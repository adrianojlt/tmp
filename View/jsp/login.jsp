<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" errorPage="/pub/error.jsp"%>
<html>
    <head>

        <title>Certificados de Incapacidade Temporária</title>

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

        <jsp:include page="/com/head.jsp" flush="true"/>        

        <style type="text/css" media="Screen"> 
            input {
                border: 0px;
            }
        </style>

        <script type="text/javascript">

            $(document).ready(function(){

                /*
                jQuery('#pass').bind('focus', function() {
                    alterainputpass();
                    alert('alterainputpass');
                }).bind('blur', function() {
                    verificartextopass();
                    alert('verificartextopass');
                });
                */

                /*
                jQuery('#pass').on({
                    focus: function() {
                        alterainputpass();
                    },
                    blur: function() {
                        verificartextopass();
                    }
                });
                */
            });

        </script>

    </head>    
    <body style="overflow-y:hidden; overflow-x:hidden;">
        <div id="login_popup">
            <div id="login_popup_content_icons">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <img src="../imagens_cit_v3/logo_cit_login.png" alt="CIT" height="35" width="132">
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
                <form method="POST" action="j_security_check">
                    <table>
                        <tr>
                            <td class="login">
                                <img src="../imagens_cit_v3/user.png" alt="user"/>
                            </td>
                            <td>
                                <input type="text" name="j_username" id="user" value="UTILIZADOR" onfocus="alterainputuser()" onblur="verificartextouser()" style="color: #CCCCCC;"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="login">
                                <img src="../imagens_cit_v3/pass.png" alt="pass"/>
                            </td>
                            <td>
                                <input type="text" name="j_password" id="pass" value="SENHA" onfocus="alterainputpass()" onblur="verificartextopass()" style="color: #CCCCCC;"/>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td style="width: 175px;">
                                <script type="text/javascript">
                                    if(${not empty param.Retry}) {     
                                        document.getElementById("pass").style.border = "1px solid #ff0000";
                                    }
                                </script>
                                <div id="error_msg">${not empty param.Retry? 'Senha incorrecta':''}</div>
                            </td>
                            <td style="width:95px">
                                <button type="submit" class="button_avancar">AVANÇAR</button>
                            </td>
                        </tr>
                    </table>   
                </form>
            </div>
        </div>
    </body>
</html>
