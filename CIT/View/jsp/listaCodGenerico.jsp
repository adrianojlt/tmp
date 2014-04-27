<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
    window['${param.objDescName}'] = function (){
        var obj = document.getElementById('${param.objDescName}');
        if(obj){
            if(obj.value.length>0){
                popUpCodigoGenericoLOV(null, '${param.pDominio}','${param.objIdName}', '${param.objCodName}', '${param.objDescName}');
            }
        }
    } 
</script>

<!-- 
pDominio

objIdName
objCodName
objDescName

objIdValue
objCodValue
objDescValue
-->


<input type="hidden" id="${param.objIdName}" name="${param.objIdName}" value="${param.objIdValue}" />
<input type="hidden" id="${param.objCodName}" name="${param.objCodName}" value="${param.objCodValue}" />
<c:choose>
<c:when test="${ param.pEditMode != 'true' }">
    <input type="text" id="${param.objDescName}" name="${param.objDescName}" class="${param.inputClass} disabled" value="${param.objDescValue}" readonly/>
    <img alt="${param.pLabelLista}" style="cursor:pointer;" src="../img/application_side_list_disable.gif" />
    <img alt="${param.pLabelCross}" style="cursor:pointer;" src="../img/cross_disabled.gif" />   
</c:when>
<c:otherwise>
    <input type="text"
           class="${param.inputClass}" 
           id="${param.objDescName}" name="${param.objDescName}" 
           value="${param.objDescValue}"
           onkeypress="chamaLovEnterPress(event, window['${param.objDescName}'] );" 
           onblur="window['${param.objDescName}']();"
           />
    <img alt="${param.pLabelLista}" style="cursor:pointer;" src="../img/application_side_list.gif" onclick="popUpCodigoGenericoLOV(null, '${param.pDominio}', '${param.objIdName}', '${param.objCodName}', '${param.objDescName}','${param.tipoDeTabela}'); "/>
    <img alt="${param.pLabelCross}" style="cursor:pointer;" src="../img/cross.gif" onclick="resetValores(new Array('${param.objIdName}','${param.objCodName}','${param.objDescName}'));"/>     
</c:otherwise>
</c:choose>