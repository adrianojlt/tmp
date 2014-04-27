<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pEditMode" value="${param.pEditMode}"/>

<script type="text/javascript">
function focusNext(objId, objName, objNameNext){
    if(objNameNext.length>0){
        if( document.getElementById(objNameNext) 
        && document.getElementById(objId).value.length>0 
        && document.getElementById(objName).value.length>0){
            document.getElementById(objNameNext).focus();
    }
    }
    
}

</script>

<td class="inputLabel">Distrito:</td>
<td class="inputCell">
    <span style="white-space:nowrap; vertical-align: bottom;">
        <input id="${param.idDistrito}" name="${param.idDistrito}" type="hidden" value="${param.idDistritoValue}" />
        <c:choose>
        <c:when test="${pEditMode != 'true'}" >
            <input id="${param.nomeDistrito}" name="${param.nomeDistrito}" type="text" class="inputCodLov disabled" value="${param.nomeDistritoValue}" readonly/>
            <img class="img" alt="" src="../img/application_side_list_disable.gif" />
            <img class="img" alt="" src="../img/cross_disabled.gif" />
        </c:when>
        <c:otherwise>
            <input id="${param.nomeDistrito}" name="${param.nomeDistrito}" type="text" class="inputCodLov" value="${param.nomeDistritoValue}"
               onkeypress="focusObjectOnEnterPressed('${param.nomeConcelho}', event);" 
               onblur="retriveValueDistConcFreg('${param.idDistrito}','${param.nomeDistrito}','','popUp${param.DistritoChaveId}'); focusNext('${param.idDistrito}','${param.nomeDistrito}','${param.nomeConcelho}'); "
               onfocus="enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}'); focusNext('${param.idDistrito}','${param.nomeDistrito}','${param.nomeConcelho}');" />
            <img class="img" alt="Lista de Valores" id="popUp${param.DistritoChaveId}" name="popUp${param.DistritoChaveId}" src="../img/application_side_list.gif" align="top" onclick="abreLovDistConcFreg('${param.idDistrito}','${param.nomeDistrito}', '', 'Distrito', 'Distrito', document.getElementById('${param.idDistrito}').value, document.getElementById('${param.nomeDistrito}').value, '${param.idConcelho};${param.nomeConcelho};${param.idFreguesia};${param.nomeFreguesia}','${param.DistritoChaveId};${param.ConcelhoChaveId};${param.FreguesiaChaveId}');"/>
            <img class="img" alt="Limpa"            id="cross${param.DistritoChaveId}" name="cross${param.DistritoChaveId}" src="../img/cross.gif"                 align="top" onclick="resetValores(new Array('${param.idDistrito}','${param.nomeDistrito}','${param.idConcelho}','${param.nomeConcelho}','${param.idFreguesia}','${param.nomeFreguesia}')); enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}');"/>
        </c:otherwise>
        </c:choose>
    </span>
</td>

<td class="inputLabel">Concelho:</td>
<td class="inputCell">
    <span style="white-space:nowrap; vertical-align: bottom;">
        <input id="${param.idConcelho}" name="${param.idConcelho}" type="hidden" value="${param.idConcelhoValue}"/>
        
        <c:choose>
        <c:when test="${pEditMode != 'true'}" >
            <input id="${param.nomeConcelho}" name="${param.nomeConcelho}" type="text" class="inputCodLov disabled" value="${param.nomeConcelhoValue}" readonly/>
            <img class="img" alt="" src="../img/application_side_list_disable.gif" />
            <img class="img" alt="" src="../img/cross_disabled.gif" />
        </c:when>
        <c:otherwise>
            <input id="${param.nomeConcelho}" name="${param.nomeConcelho}" type="text" class="inputCodLov" 
               value="${param.nomeConcelhoValue}"
               onkeypress="focusObjectOnEnterPressed('${param.nomeFreguesia}', event);" 
               onblur="retriveValueDistConcFreg('${param.idConcelho}', '${param.nomeConcelho}', '${param.idDistrito}' ,'popUp${param.ConcelhoChaveId}');"
               onfocus="enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}'); focusNext('${param.idConcelho}','${param.nomeConcelho}','${param.nomeFreguesia}');" />
            <img class="img" alt="Lista de Valores" id="popUp${param.ConcelhoChaveId}" name="popUp${param.ConcelhoChaveId}" src="../img/application_side_list.gif" align="top" onclick="abreLovDistConcFreg('${param.idConcelho}','${param.nomeConcelho}', document.getElementById('${param.idDistrito}').value ,'Concelho', 'Concelho', document.getElementById('${param.idConcelho}').value, document.getElementById('${param.nomeConcelho}').value, '${param.idFreguesia};${param.nomeFreguesia}', '${param.DistritoChaveId};${param.ConcelhoChaveId};${param.FreguesiaChaveId}');"/>
            <img class="img" alt="Limpa"            id="cross${param.ConcelhoChaveId}" name="cross${param.ConcelhoChaveId}" src="../img/cross.gif"                 align="top" onclick="resetValores(new Array('${param.idConcelho}','${param.nomeConcelho}','${param.idFreguesia}','${param.nomeFreguesia}')); enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}');"/>
        </c:otherwise>
        </c:choose>
    </span>
</td>

<td class="inputLabel">Freguesia:</td>
<td class="inputCell">
    <span style="white-space:nowrap; vertical-align: bottom;">
        <input id="${param.idFreguesia}" name="${param.idFreguesia}" type="hidden" value="${param.idFreguesiaValue}"/>
        <c:choose>
        <c:when test="${pEditMode != 'true'}" >
            <input id="${param.nomeFreguesia}" name="${param.nomeFreguesia}" type="text" class="inputCodLov disabled" value="${param.nomeFreguesiaValue}" readonly/>
            <img class="img" alt="" src="../img/application_side_list_disable.gif" />
            <img class="img" alt="" src="../img/cross_disabled.gif" />
        </c:when>
        <c:otherwise>
            <input id="${param.nomeFreguesia}" name="${param.nomeFreguesia}" type="text" class="inputCodLov" 
               value="${param.nomeFreguesiaValue}"
               onkeypress="if(window.event.keyCode==13){retriveValueDistConcFreg('${param.idFreguesia}', '${param.nomeFreguesia}', '${param.idConcelho}' ,'popUp${param.FreguesiaChaveId}');} " 
               onblur="retriveValueDistConcFreg('${param.idFreguesia}', '${param.nomeFreguesia}', '${param.idConcelho}' ,'popUp${param.FreguesiaChaveId}');"
               onfocus="enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}');" />
            <img class="img" alt="Lista de Valores" id="popUp${param.FreguesiaChaveId}" name="popUp${param.FreguesiaChaveId}" src="../img/application_side_list.gif" align="top" onclick="abreLovDistConcFreg('${param.idFreguesia}','${param.nomeFreguesia}',document.getElementById('${param.idConcelho}').value, 'Freguesia', 'Freguesia', document.getElementById('${param.idFreguesia}').value, document.getElementById('${param.nomeFreguesia}').value, '', '${param.DistritoChaveId};${param.ConcelhoChaveId};${param.FreguesiaChaveId}');"/>
            <img class="img" alt="Limpa"            id="cross${param.FreguesiaChaveId}" name="cross${param.FreguesiaChaveId}" src="../img/cross.gif"                 align="top" onclick="resetValores(new Array('${param.idFreguesia}','${param.nomeFreguesia}')); enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}');"/>
        </c:otherwise>
        </c:choose>
    </span>
</td>
    
<c:choose>
<c:when test="${pEditMode != 'true' }" >
  
</c:when>
<c:otherwise>
    <script type="text/javascript">
        enableDisableDistConcFreg('${param.DistritoChaveId}','${param.ConcelhoChaveId}','${param.FreguesiaChaveId}');
    </script>
</c:otherwise>
</c:choose>