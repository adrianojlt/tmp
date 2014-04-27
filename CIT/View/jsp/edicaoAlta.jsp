<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <jsp:include page="/com/head.jsp" flush="true"/>
        <script type="text/javascript">
            // Check if format of the date is valid, with 
            function checkDate(data){
                if (data == '') {
                    return true;
                }
                return Date.isValid(data,'dd-MM-yyyy');
            }
        
            function controlData(data) {    
                if (Date.isValid(data.value,'ddMMyyyy')) {
                    var dataTemp = Date.parseString (data.value,"ddMMyyyy");
                    data.value = dataTemp.format('dd-MM-yyyy');
                }
                //Check if the date is valid
                if (!checkDate(data.value)) { 
                    data.value='';
                    //alert('Data introduzida inválida!');
                    jAlert('Data introduzida inválida!', 'Alert Dialog');
                }
            }
        
            function voltar(){
                var form = document.getElementById('formAlta');
                splash(true);
                form.action='../git/baixasUtente.do';
                form.submit();
                return true;    
            }
        
            /*
            function verificarSeEliminaItemsBaixa (form) {
                var dataStringInicioUltimoItem = document.getElementById('hiddenEmissaoAltaLastItemDate').value;
                var dataStringAlta  = document.getElementById('dp-dalta').value; 
                var dataStringInicioTotal = document.getElementById('DataInicioTotal').value; 
                var dataInicioUltimoItem = Date.parseString(dataStringInicioUltimoItem,"dd-MM-yyyy");
                var dataAlta = Date.parseString(dataStringAlta,"dd-MM-yyyy");
                var dataInicioTotal = Date.parseString(dataStringInicioTotal,"dd-MM-yyyy");
                
                if(dataStringInicioTotal.length>0){ 
                    if (!dataAlta.isAfter(dataInicioTotal)) {
                        alert('Não pode emitir uma Alta para um período anterior ou igual ao CIT Inicial.');
                        return;
                    }
                    if (!dataAlta.isAfter(dataInicioUltimoItem)){
                        var resposta = confirm('Serão apagadas Prorrogações. Deseja continuar?');
                        if (resposta) {
                            splash(true);
                            form.submit();
                        }            
                    } else {
                       splash(true); 
                       form.submit(); 
                    }
                }else{
                    form.action='../git/baixasUtente.do?warning=true';
                    form.submit();
                }
            }
            */        
        
            function validaDataDeAlta () {

                var dataStringAlta  = document.getElementById('dp-dalta').value; 
                var dataStringInicioTotal = document.getElementById('DataInicioTotal').value; 
                var dataAlta = Date.parseString(dataStringAlta,"dd-MM-yyyy");
                var dataInicioTotal = Date.parseString(dataStringInicioTotal,"dd-MM-yyyy");

                if( dataStringInicioTotal.length > 0 ){ 

                    if ( !dataAlta.isAfter(dataInicioTotal) ) {

                        $.spmsDialog( 'error', 
                            { 
                                title: 'Erro', 
                                message: 'Não pode emitir uma Alta para um período anterior ou igual ao CIT Inicial.'
                            }
                        );

                        return false;

                    } else {    
                        return true;
                    }
                }
            }

            function saveEvent(arg) {

                if( validaDataDeAlta() ) {

                    $.spmsDialog( 'confirm', 
                        { 
                            title: 'Continuar?', 
                            message: 'Os dados serão gravados. Deseja continuar?', 
                            callback: function() {
                                splash(true);
                                document.getElementById('hidden').value='insertAlta'; 
                                arg.form.submit(); 
                            } 
                        }
                    );
                }
            }

        </script>
    </head>
    <body onload="splash(false);">
        <div id="outerContainer">
            <div class="center">
                <jsp:include page="/pub/breadcrumb.jsp" flush="true">      
                    <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/>
                    <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/>
                    <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
                    <jsp:param name="pTitle" value="Alta de Baixas/Prorrogra&ccedil;&atilde;o de Baixa"/>
                    <jsp:param name="pBackEnabled" value="true"/>
                </jsp:include>
                <jsp:include page="/com/splash.jsp" flush="true"/>
            </div>
            <div id ="formContainer" align ="left">         
                <jsp:include page="/com/error.jsp" flush="true"/>    
                <jsp:include page="/com/infoUtente.jsp" flush="true">
                    <jsp:param name="pDescricaoPagina" value="> ALTA"/>
                </jsp:include> 
   
   
                 <script type="text/javascript" >
                        //Entidades Responsaveis
                        if(document.getElementById("entResp")){
                            document.getElementById("entResp").disabled = true;
                        }
                    </script>                        
                <!-- DOWN -->
                <div>
                    <form id="formAlta" action="" onsubmit="splash(true);" method="POST">
                        <c:set var="idTipoAlta" value="" />
                        <p style="display: none;">
                            <input type="hidden" name="DataInicioTotal" id=DataInicioTotal value="${param.DataInicioTotal}" />
                            <input type="hidden" name="hiddenLastItemDataTermo" value="<c:out value="${param.hiddenLastItemDataTermo}" />" />
                            <input type="hidden" id="hiddenEmissaoAltaLastItemDate" name="hiddenEmissaoAltaLastItemDate" value="" />
                        </p>
                        <div class="subTitle">Alta</div>                                 
                        <div class ="subContainerTable">
                            <table id="inputForm" cellspacing="0" cellpadding="0" border="0">
                                <tbody>
                                    <tr>
                                        <td class="outputLabel" style="padding-bottom:6px;padding-top:5px">
                                            <span style="white-space: nowrap;">
                                                Data da Alta
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="outputLabel" style="padding-bottom:6px">                                            
                                            <input style="margin-bottom:0px;margin-right:3px;width:120px" onBlur="javascript:controlData(document.getElementById('dp-dalta'));" 
                                                   id="dp-dalta" name="dp-dalta" type="text" 
                                                   class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" value="" maxlength="10" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="outputLabel" style="padding-bottom:6px">Motivo</td>
                                    </tr>
                                    <tr>
                                        <td class="outputCell">                                                
                                            <select style="margin-bottom:0px" class="pesquisa" disabled>
                                                <c:forEach var="RowListaCodigosGenericos" items="${bindings.ListaCodigosGenericos.rangeSet}">
                                                    <c:choose>
                                                        <c:when test="${RowListaCodigosGenericos[\'Codigo\'] == 'N'}">
                                                            <option selected value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                                <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/>
                                                            </option>
                                                            <c:set var="idTipoAlta" value="${RowListaCodigosGenericos[\'Id\']}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="<c:out value="${RowListaCodigosGenericos[\'Id\']}"/>">
                                                            <c:out value="${RowListaCodigosGenericos[\'Descricao\']}"/></option>
                                                        </c:otherwise>
                                                    </c:choose>    
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="subContainerButtons">
                            <input type="hidden" id="selectTipoAlta" name="selectTipoAlta" value="<c:out value="${idTipoAlta}"/>" /> 
                            <input type="hidden" id="DataInicioTotal" name="DataInicioTotal" value="<c:out value="${param['DataInicioTotal']}"/>" /> 
                            <input type="hidden" id="selectClassDoenca" name="selectClassDoenca" value="<c:out value="${param['selectClassDoenca']}"/>" /> 
                            <input type="hidden" name="event" id="hidden" value=""/>
                            <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <!--<button style="width:70px" class="subCont" type="button" value="Gravar"onclick="if(validaDataDeAlta()){if(confirm('Os dados serão gravados. Deseja continuar?')){document.getElementById('hidden').value='insertAlta'; this.form.submit(); } }" >Gravar</button>-->
                                        <button style="width:70px" class="subCont" type="button" value="Gravar" onclick="saveEvent(this);" >Gravar</button>
                                    </td>
                                    <td>                                        
                                        <button style="width:75px" class="subCont" type="button" value="Cancelar" onclick="voltar();" >Cancelar</button>
                                    </td>
                                </tr>
                            </table>
                        </div> 
                        <script type="text/javascript">
                            document.getElementById('dp-dalta').value=addDaysToDateFormat('${param.hiddenLastItemDataTermo}',1);
                        </script>        
                        <jsp:include page="/git/ListaItemsBaixa.jsp" flush="true"/>  
                    </form>
                </div>
                <div id="footer" style="margin-left:-20px">
                    <!--<button type="button" class="button_emitir">EMITIR CIT</button>-->
                    <div id="divButtonTablePesquisaUtente">
                        <form method="POST" action="" id="formGetNewUtente" style="padding:0;margin:0;" onsubmit="">                        
                            <span style="white-space: nowrap;">
                                <input type="hidden" id="hiddenGetNewUtenteContext" name="hiddenGetNewUtenteContext" value='<%=request.getServletPath().split("/",3)[1]%>' /> 
                                <input type="hidden" id="hiddenGetNewUtentePage" name="hiddenGetNewUtentePage" value='<%=request.getServletPath().split("/",3)[2]%>' /> 
                                <button class="button_emitir" type="cubmit" id="buttonGetNewUtente" value="Nova&nbsp;&nbsp;Pesquisa" onclick="return novaPesquisaUtente(); ">Nova Pesquisa</button>                                    
                                <%
                                    String req = request.getRequestURI();
                                    if (req.indexOf("mig/")  > 1 || req.indexOf("admin/")  > 1){
                                %>
                                <input id="infoUtenteButtonRetirar" title="retirar utente de sessão" class="submitButton" type="button" value="Retirar Utente Sessão" onclick="return retirarUtenteSessao(); "/>
                                <%
                                    }
                                %>                        
                            </span>                            
                        </form>
                    </div>           
                </div>
            </div>
        </div>
        <jsp:include page="/com/footer.jsp" flush="true"/>
    </body>
</html>