<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"
              import="java.io.CharArrayWriter, java.io.PrintWriter"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
        <link href="../css/snu_page_skeleton.css" rel="stylesheet" media="screen"/> 
        <script type="text/javascript" src="../js/igif.js"></script>
        <script type="text/javascript" src="../js/xp_progress.js"></script>        
    </head>
    <body onLoad="splash(false);">
            <div><a id="redirectLink" class="headerLink" href="<%=request.getContextPath()%>/git/baixasUtente.do"></a></div>
    <script type="text/javascript">
        var link = document.getElementById("redirectLink").href;
       // window.location=link;
    </script> 
        <div id="preload" class="splashDiv"></div>
        <div id="splash" class="loadDiv">
            <script type="text/javascript">
                var bar1= createBar(150,15,'rgb(247,247,247)',0,'white','blue',50,15,10,"");
            </script>
            <br>
            <span style="font-family:Tahoma, Verdana, Helvetica, sans-serif;text-align: center;vertical-align:top;font-size:12px;color:#779EC7;font-weight:bold;">
                Aguarde por favor...
            </span>
        </div>
        <div id="headerDiv">
            <table class="topHeaderTable" cellpadding="0" cellspacing="0">
                <thead/>
                <tbody>
                <tr>
                    <td class="topHeaderTableLeftCol">&nbsp;</td>
                    <td class="topHeaderTableMiddleCol">
                        <span class="headerTitle">- Registo Nacional de Certificados de Incapacidade Temporária -</span>
                    </td>
                    <td class="topHeaderTableRightCol">&nbsp;</td>
                </tr>
                </tbody>
            </table>
            <table class="bottomHeaderTable" cellpadding="0" cellspacing="0">
                <thead/>
                <tbody>
                    <tr>
                        <td class="bottomHeaderTableLeftCol">&nbsp;</td>
                        <td class="bottomHeaderTableRightCol">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <thead/>
                                <tbody> 
                                    <tr>
                                        <td class="bottomHeaderTableCornerRight">&nbsp;</td>
                                        <td class="bottomHeaderTableCornerEnd">&nbsp;</td> 
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="topSep" style="padding-top:30px;"></div>        
        <div id="contentDiv">
            <h4>Erro Interno do Servidor</h4>
            <% if(exception != null){ 
            exception.printStackTrace();
            %>
            <span class="errorMessageLabel">Não foi possível processar o seu pedido devido a um erro interno do servidor. Notifique o administrador de sistemas da mensagem de erro abaixo.</span>
            <pre class="informationMessageText">
                <%
                    CharArrayWriter charArrayWriter = new CharArrayWriter(); 
                    PrintWriter printWriter = new PrintWriter(charArrayWriter, true); 
                    exception.printStackTrace(printWriter); 
                    out.println(charArrayWriter.toString().replaceAll("\n","<br>"));                
                %>
            </pre>
            <% }else{ %>
            
            <% } %>
        </div>
        <div id="botSep" style="padding-bottom:50px;"></div>        
    </body>
</html>
