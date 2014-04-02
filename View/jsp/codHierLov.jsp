<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
  <head>
    <title></title>
    <jsp:include page="/com/head.jsp" flush="true"/>
  </head>
<body onload="splash(false);">
    <jsp:include page="/com/lovHeader.jsp" flush="true">
        <jsp:param name="pTitleLov" value="${param.titulo}"/>
        <jsp:param name="pBackEnabled" value="true"/>
    </jsp:include>  
    <!-- DOWN -->

<script type="text/javascript">
function seleccionar() {
    var rownum = document.getElementById('rownum').value;
    
    var objId = opener.document.getElementById(document.getElementById('campoId').value);
    objId.value = document.getElementById('id'+rownum).value;
    
    var objDesc = opener.document.getElementById(document.getElementById('campoDesc').value);
    objDesc.value = document.getElementById('desc'+rownum).value;
    objDesc.focus();    
    
    // -- objectos a limpar
    objL = document.getElementById('objLimpar');
    if(objL.value.length>0){
        var a = objL.value.split(";");
        var contador = 0;
        while (contador < a.length){
          opener.document.getElementById(a[contador]).value = '';
          contador+=1;
        }
    }
    
    // -- chamar função para recolocar contexto
    objL = document.getElementById('objsChave');
    if(objL.value.length>0){
        var a = objL.value.split(";");
        opener.enableDisableDistConcFreg(a[0],a[1],a[2]);
    }
    
    self.close();
}

</script>


<c:if test="${bindings.ListaCodigosHierarquicosLov.estimatedRowCount == 1 }">
    <c:set var="apenasUmElemento" value="true"/>
</c:if>

<form method="POST" id="forma" action="codHierLov.do" onsubmit="splash(true);">
<fieldset>
<input id="rownum" type="hidden"/>
<input type="hidden" id="idEvent" name="event" value=""/>
<input id="primeira" name="primeira" type="hidden" value="false"/>
<input id="objLimpar" name="objLimpar" type="hidden" value="${param.objLimpar}"/>
<input id="objsChave" name="objsChave" type="hidden" value="${param.objsChave}"/>

<input id="idPaiCodHier" name="idPaiCodHier" type="hidden" value="${empty param.idPaiCodHier ? '-1' : param.idPaiCodHier }"/>
<input id="campoId" name="campoId" type="hidden" value="${param.campoId}"/>
<input id="campoDesc" name="campoDesc" type="hidden" value="${param.campoDesc}"/>
<input id="label" name="label" type="hidden" value="${empty param.label ? 'Distrito' : param.label }"/>
<input id="titulo" name="titulo" type="hidden" value="${param.titulo}"/>


</fieldset>

<h4>Pesquisa</h4>
<table id="inputForm" border="0" cellpadding="0" cellspacing="0">
    <thead/>
    <tbody>
        <tr>
        <td class="inputLabel"><c:out value="${empty param.label ? 'Distrito' : param.label }:"/></td>
        <td class="inputCell" colspan="2">
            <span style="white-space: nowrap;">
            <input onKeyPress="handleKeyPress(this,'search',event);" class="inputTextTwo" name="desc" type="text" value="${param.desc}" id="desc" maxlength="100" />
            <img class="img" alt="Limpa" name="crossDist" id="crossDist" src="../img/cross.gif" onclick="resetValores(new Array('desc'));" />
            </span>
        </td>
        </tr>
    </tbody>
</table>
<table id="buttonTable" border="0" cellpadding="0" cellspacing="0">
    <thead/>
    <tbody>
        <tr>
            <td>
            <input class="submitButton" type="submit" value="Pesquisar" id="pesquisa" name="event_Search" />
            </td>  
        </tr>
    </tbody>
</table>

<h4>Resultado da Pesquisa</h4>
<c:choose>
    <c:when test="${empty bindings.ListaCodigosHierarquicosLov.currentRow }">
        <p class="hint">A pesquisa efectuada não retornou valores.</p>
    </c:when>
    <c:otherwise>
        <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
            <thead/>
            <tbody>
                <tr>
                    <td>
                        <input class="submitButton" id="btSeleccionar" name="btSeleccionar" type="button" value="Seleccionar" onclick="seleccionar();"/>
                        <input class="submitButton" type="button" value="Voltar" onclick="self.close();" />
                        <script type="text/javascript">setEnabledOrDisabledButtons(new Array('btSeleccionar'), true);</script>
                    </td>
                    </tr>
            </tbody>
        </table>
        <table id="readOnlyTable" cellpadding="0" cellspacing="0" border="0">
            <thead>
                <tr class="head">
                    <th class="selection">-</th>
                    <th class="text last">Descrição</th>
                </tr>    
            </thead>
            <tbody>
                <c:forEach var="RowLov" items="${bindings.ListaCodigosHierarquicosLov.rangeSet}" varStatus="lineListaCodigosHierarquicosLov">
                        <c:choose>
                            <c:when test="${lineListaCodigosHierarquicosLov.count %2 == 0}">
                                <c:set var="rowClass" value="odd"/>    
                            </c:when>
                            <c:otherwise>
                                <c:set var="rowClass" value="even"/>    
                            </c:otherwise>                    
                        </c:choose>    
                        <tr class="${rowClass}">
                            <td class="selection">
                                <input name="selId" class="radio" type="radio" 
                                        value="<c:out value="${lineListaCodigosHierarquicosLov.count}"/>" 
                                        onclick="document.getElementById('rownum').value=this.value; highlightRow(this,${lineListaCodigosHierarquicosLov.count}); setEnabledOrDisabledButtons(new Array('btSeleccionar'), false);"/>
                                <input type="hidden" id="id${lineListaCodigosHierarquicosLov.count}" value="${RowLov.Id}"/>
                                <input type="hidden" id="desc${lineListaCodigosHierarquicosLov.count}" value="${RowLov.Descricao}"/>
                            </td>
                            <td class="text last"><c:out value="${RowLov.Descricao}"/></td>
                        </tr>
                        <c:if test="${apenasUmElemento == 'true' }">
                            <script type="text/javascript">
                                if(opener.document.getElementById(document.getElementById('campoId').value).value.length == 0){
                                    document.getElementById('rownum').value='${lineListaCodigosHierarquicosLov.count}';
                                    seleccionar();
                                }
                            </script>
                        </c:if>
                    </c:forEach>    
                    <tr class="navigation">
                        <td colspan="2">
                            <jsp:include page="/com/navigationList.jsp" flush="true">
                                <jsp:param name="rangeBindingName" value="ListaCodigosHierarquicosLov"/>
                                <jsp:param name="targetPageName" value="codHierLov.do"/>
                            </jsp:include>
                        </td>
                    </tr>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>  
</form>

<!-- UP -->       
<jsp:include page="/com/lovFooter.jsp" flush="true">
    <jsp:param name="pTitleLov" value="${param.titulo}"/>
</jsp:include>

</body>
</html>
