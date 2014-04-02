<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
        <link href="../css/snu_page_skeleton.css" rel="stylesheet" media="screen"/> 
        <script type="text/javascript" src="../js/igif.js"></script>
        <script type="text/javascript" src="../js/xp_progress.js"></script>        
    </head>
    <body onLoad="splash(false);">
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
            <h4>Recurso Não Encontrado</h4>
            <p class="errorMessageLabel">O recurso a que tentou aceder não foi encontrado.</p>
            <pre class="informationMessageText">
                Clique neste <a class="headerLink" href="<%=request.getContextPath()%>/pub/index.do">link</a>para aceder à aplicação.
            </pre>
        </div>
        <div id="botSep" style="padding-bottom:50px;"></div>        
    </body>
</html>
