 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title>consulta de utente</title>
    <jsp:include page="/com/head.jsp" flush="true"/>
    <link rel="stylesheet" type="text/css" href="../css/featuredcontentglider.css" />
    <script type="text/javascript" src="../js/jquery-1.2.2.pack.js"></script>
    <script type="text/javascript" src="../js/featuredcontentglider.js"></script>
    <script type="text/javascript" charset="UTF-8" src="../js/identificacao.js"></script>
    <script type="text/javascript" charset="UTF-8">
    function voltar(){
        var form = document.forms[0];
        if(document.getElementById('viaNovoUtente').value=="true" || document.getElementById('viaNovoUtente').value=="true/"){
            voltarPesquisaMae();
        }
        else if(!document.getElementById('invoker') || document.getElementById('invoker').value=="" ){
            form.action="../idu/pesquisaUtente.do?event=goBack";
        }
        else{
            form.action="../idu/consultaListasUtentes.do?event=goBack";
        }
        splash(true);
        form.submit();
        return true;    
    }
     function voltarPesquisaMae(){
        document.getElementById('idEvent').value = 'voltaSearchMae';
        document.forms[0].submit();    
    }
    </script>
  </head>
<body onload="splash(false);">
      <c:choose>
        <c:when test="${empty param.popup}">
             <jsp:include page="../com/header.jsp" flush="true">     
                <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                <jsp:param name="pTitle" value="Consulta Utente"/>
                <jsp:param name="pBackEnabled" value="true"/>
            </jsp:include>
        </c:when>
        <c:otherwise>
             <jsp:include page="../com/lovHeader.jsp" flush="true">     
                <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                <jsp:param name="pTitleLov" value="Consulta Utente"/>
                <jsp:param name="pBackEnabled" value="true"/>
            </jsp:include>
        </c:otherwise>
    </c:choose>
  <!-- DOWN -->
<form method="POST" id="consultaUtente" action="consultaUtente.do" onsubmit="splash(true);">
<fieldset>
<input id="aces" type="hidden" name="aces" value="${requestScope.aces}"/>
<input id="ars" type="hidden" name="ars" value="${requestScope.ars}"/>
<input id="cs" type="hidden" name="cs" value="${requestScope.cs}"/>
<input id="us" type="hidden" name="us" value="${requestScope.us}"/>
<input id="hiddenMedicoFamilia" type="hidden" name="hiddenMedicoFamilia" value="${requestScope.hiddenMedicoFamilia}"/>
<input id="hiddenDataDeConsultaNovoValue" type="hidden" name="hiddenDataDeConsultaNovoValue" value="${requestScope.hiddenDataDeConsultaNovoValue}"/>
<input id="hiddenDataAConsultaNovoValue" type="hidden" name="hiddenDataAConsultaNovoValue" value="${requestScope.hiddenDataAConsultaNovoValue}"/>

<input id="invoker" type="hidden" name="invoker" value="${requestScope.invoker}"/>
<input type="hidden" name="novaFamilia" value="${param.novaFamilia}">
<input type="hidden" name="novaFamilia" value="${param.novaFamilia}">
<input type="hidden" name="elementosAlterados" value="">
<input type="hidden" id="idEvent" name="event" value=""/>
<input type="hidden" id="idEventTipo" name="idEventTipo" value=""/>
</fieldset>

    <%-- DADOS DO UTENTE --%>
    <jsp:include page="/idu/dadosUtente.jsp" flush="true">
        <jsp:param name="pEditMode" value="false"/> 
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
                <jsp:param name="pEditMode" value="false"/> 
            </jsp:include>    
        </div>
        
        <%-- Correspondencia --%>
        <div class="glidecontent">
            <jsp:include page="/idu/correspondenciaUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="false"/>
            </jsp:include>
        </div>
        
        <%-- Contactos --%>
        <div class="glidecontent">
            <jsp:include page="/idu/contactosUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="false"/>
            </jsp:include>  
        </div>
        
        <%-- Beneficios --%>
        <div class="glidecontent">
            <jsp:include page="/idu/beneficiosUtente.jsp" flush="true">
                <jsp:param name="pEditMode" value="false"/>
            </jsp:include>
        </div>
        
        <%-- Entidades --%>
        <div class="glidecontent">
            <jsp:include page="/idu/subsistemas.jsp" flush="true">
                <jsp:param name="pEditMode" value="false"/>
            </jsp:include>
        </div>

    </div>
        
    </form>
    
    <!-- UP -->
    <jsp:include page="/com/footer.jsp" flush="true"/>
   </body>
</html>