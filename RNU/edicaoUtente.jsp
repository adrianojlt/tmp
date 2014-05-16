<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title>edição de utente</title>
    <jsp:include page="/com/head.jsp" flush="true"/>
    <link rel="stylesheet" type="text/css" href="../css/featuredcontentglider.css" />
    <script type="text/javascript" src="../js/jquery-1.2.2.pack.js"></script>
    <script type="text/javascript" src="../js/featuredcontentglider.js"></script>
    <script type="text/javascript" src="../js/validacaoDocumentos.js"></script>
  
    <script type="text/javascript">
       var correspondenciaNaoPreenchida = 0;
        
       function saidaPagina() {
          var flagSairPagina = ''; 
         
          if (verificaDiferencasDadosUtente() == 1){
            flagSairPagina = flagSairPagina + 'Dados Utente\n';
          }
          
          if (verificaDiferencasCorrespondencia() == 1){
            flagSairPagina = flagSairPagina + 'Correspondencia\n';
          }
          
          if (verificaDiferencasContactos() == 1){
            flagSairPagina = flagSairPagina + 'Contactos\n';
          }
          
          if (verificaDiferencasBeneficios() == 1){
            flagSairPagina = flagSairPagina + 'Beneficios\n';
          }
          
          if (verificaDiferencasEntidades() == 1){
            flagSairPagina = flagSairPagina + 'SubSistemas\n';
          }
          
          if (correspondenciaNaoPreenchida == 1 && document.getElementById('idEvent').value != 'NovaInscricao' ){
            flagSairPagina = "ALERTATABCORRESPONDENCIANAOPREENCHIDO";
          }
     
          return flagSairPagina;
       }
       
       function alertaConfirmacaoSaidaPagina(){  
            var texto = saidaPagina();
            if( texto == 'ALERTATABCORRESPONDENCIANAOPREENCHIDO'){
                splash(false);
                return "Atenção: O utente não tem correspondência preenchida.\n Deseja mesmo assim abandonar a edição do utente?";
            } else if(texto != '' ){
                splash(false);
                return 'Modificou e não gravou dados nos seguintes formulários: \n' + texto + 'Deseja sair da página?';
            }
       }
       
    </script>
  </head>
  
  
<body onload="splash(false); contextualizaFormNatNac(); validaProcFam();" 
      onbeforeunload="return alertaConfirmacaoSaidaPagina();" 
      onunload="splash(true);">
<jsp:include page="/com/header.jsp" flush="true">     
    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
    <jsp:param name="pTitle" value="Manutenção Utente"/>
    <jsp:param name="pBackEnabled" value="true"/>
  </jsp:include>
  <script type="text/javascript" charset="UTF-8" src="../js/identificacao.js"></script>
  <script type="text/javascript" charset="UTF-8">
  
  
    function voltar(){
        var form = document.forms[0];
        form.action="../idu/pesquisaUtente.do?event=goBack";
        splash(true);
        form.submit();
        return true;    
    }
  </script>
  <!-- DOWN -->
<form method="POST" id="edicaoUtente" name="edicaoUtente" action="edicaoUtente.do" onsubmit="splash(true);" >
<fieldset>
<input type="hidden" id="idEvent" name="event" value=""/>
<input type="hidden" id="idEventTipo" name="idEventTipo" value=""/>
</fieldset>
  
    <%-- DADOS DO UTENTE --%>
    <jsp:include page="/idu/dadosUtente.jsp" flush="true">
        <jsp:param name="pEditMode" value="${not empty bindings.UtenteEdicao.IobId?'obito':'true'}"/> 
    </jsp:include>
        
    <script type="text/javascript">
        featuredcontentglider.init({
            gliderid: "canadaprovinces", //ID of main glider container
            contentclass: "glidecontent", //Shared CSS class name of each glider content
            togglerid: "p-select", //ID of toggler container
            remotecontent: "", //Get gliding contents from external file on server? "filename" or "" to disable
            selected: 0, //Default selected content index (0=1st)
            persiststate: true, //Remember last content shown within browser session (true/false)?
            speed: -500, //Glide animation duration (in milliseconds)
            direction: "updown", //set direction of glide: "updown", "downup", "leftright", or "rightleft"
            autorotate: false, //Auto rotate contents (true/false)?
            autorotateconfig: [3000, 2] //if auto rotate enabled, set [milliseconds_btw_rotations, cycles_before_stopping]
    })  
    </script>
        
    <div id="p-select" class="glidecontenttoggler">
        <a href="#" class="toc">Inscrição</a>
        <a href="#" class="toc">Correspondência</a>
        <a href="#" class="toc">Contactos</a>
        <a href="#" class="toc">Benefícios</a>
        <a href="#" class="toc">Subsistemas</a>
    </div> 
    
    <div id="canadaprovinces" class="glidecontentwrapper">
    
        <%-- Inscrição --%>
        <div class="glidecontent">
            <jsp:include page="/idu/inscricaoUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="${not empty bindings.UtenteEdicao.IobId?'false':'true'}"/>
            </jsp:include>    
        </div>
        
        <%-- Correspondencia --%>
        <div class="glidecontent">
            <jsp:include page="/idu/correspondenciaUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="${bindings.UtenteEdicao.RegUmic == 'S' ? 'false' : not empty bindings.UtenteEdicao.IobId?'false':'true'}"/>    
            </jsp:include>
        </div>
        
        <%-- Contactos --%>
        <div class="glidecontent">
            <jsp:include page="/idu/contactosUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="${not empty bindings.UtenteEdicao.IobId?'false':'true'}"/>
            </jsp:include>  
        </div>
        
        <%-- Beneficios --%>
        <div class="glidecontent">
            <jsp:include page="/idu/beneficiosUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="${not empty bindings.UtenteEdicao.IobId?'false':'true'}"/>
            </jsp:include>
        </div>
        
        <%-- Entidades --%>
        <div class="glidecontent">
            <jsp:include page="/idu/subsistemas.jsp" flush="true">
                <jsp:param name="pEditMode" value="${not empty bindings.UtenteEdicao.IobId?'false':'true'}"/>
            </jsp:include>
        </div>
        
    </div>
          
    </form>
    
    <!-- UP -->
    <jsp:include page="/com/footer.jsp" flush="true"/>
   </body>
</html>