<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt"> 
    <head>
        <jsp:include page="/com/head.jsp" flush="true"/>
        <script type="text/javascript">

            function enableButton (button) { 
                button.className = 'subCont';
                button.removeAttribute("disabled");
            }
        
            function disableButton (button) { 
                button.className = 'buttonDisabled';
                button.setAttribute("disabled","disabled");
            }
        
            function maintainCheck(checkBox) {
                checkBox.checked = !checkBox.checked;
            }
        
            function genericAction (buttonPressed) {
                document.getElementById('opcaoSeleccionada').value = buttonPressed.value;
            
                //Para a selecção da entidade responsavel, é necessario ir buscar o 
                //valor que está seleccionado, para se manter seleccionado
                document.getElementById('hiddenBaixasIEntidadeResponsavel').value = document.getElementById('hiddenIEntidadeResponsavel').value;
                document.getElementById('hiddenBaixasIduHistEntUtID').value = document.getElementById('hiddenIduHistEntUtID').value;
                document.getElementById('hiddenBaixasNumBeneficiario').value = document.getElementById('hiddenNumBeneficiario').value;
                document.getElementById('hiddenItemBaixasIEntidadeResponsavel').value = document.getElementById('hiddenIEntidadeResponsavel').value;
                document.getElementById('hiddenItemBaixasIduHistEntUtID').value = document.getElementById('hiddenIduHistEntUtID').value;
                document.getElementById('hiddenItemBaixasNumBeneficiario').value = document.getElementById('hiddenNumBeneficiario').value;
                  
                //e informar ao sistema se é EPUB ou ERES. O index de segurança social é -1
                if (document.getElementById('hiddenIEntidadeResponsavel').value == '-1') {
                    document.getElementById('entidadePublica').value = 'ERES';
                } else {
                    document.getElementById('entidadePublica').value = 'EPUB';
                }
            
                if (buttonPressed.value == 'Nova Baixa') {
                    //splash(true);
                    
                    atribuiVazio("selectClassDoenca");
                    atribuiVazio("itemBaixainputFamiliar");
                    atribuiVazio("itemBaixainputFamiliarNome");
                    atribuiVazio("inputFamiliarNome");
                    atribuiVazio("itemBaixainputFamiliarDtaNasc");
                    atribuiVazio("itemBaixainputFamiliarInputFamiliarSelected");
                    atribuiVazio('itemBaixainputFamiliarInputFamiliarInputFamiliarId');
                    atribuiVazio('itemBaixainputFamiliarInputFamiliarInputFamiliarNiss');
                    atribuiVazio('itemBaixainputFamiliarInputFamiliarImpedidoNiss');
                    atribuiVazio('itemBaixainputFamiliarInputFamiliarIdParentesco');
                    atribuiVazio('itemBaixainputFamiliarInputFamiliarOutroParentesco');
                    atribuiVazio('itemBaixainputFamiliarOutroGrauParentesco');
                    atribuiVazio('itemBaixainputFamiliarGrauParentesco');
                    
                    buttonPressed.form.action='../git/edicaoBaixa.do';
                    buttonPressed.form.submit();    
                    return true;
                } else if (buttonPressed.value == 'Alterar') {
                    document.getElementById('itemBaixaentidadePublica').value = document.getElementById('hiddenBaixasSelectedTipoEntidadeResponsavel').value;
                    document.getElementById('itemBaixaIdSelectedentidadePublica').value = document.getElementById('hiddenBaixasSelectedIdEntidadeResponsavel').value;
                    buttonPressed.form.action='../git/edicaoBaixa.do';
                    buttonPressed.form.submit();
                } else if (buttonPressed.value == 'Anular') {
                    splash(true);
                    popUpGITMotivoAnulacaoLOV();
                    //refresh page
                    var oldDoc = window.location.toString();
                    window.location.replace(oldDoc);
                } else if (buttonPressed.value == 'Prorrogação') {
                    
                  splash(true);
                    <c:choose>
                        <c:when test="${sessionIdBaixaJsp == 0 || param.codTipoRegisto == 'A' || sessionNumBaixas == 0}">
                            buttonPressed.form.action='../git/edicaoBaixa.do';
                    
                        </c:when>
                        <c:otherwise>
                            document.getElementById('hiddenListaBaixas').value='PageLoadProrroBaixa';
                            // buttonPressed.form.action='../git/edicaoProrrogacaoBaixa.do?cirurgiaAmbulatorio='+document.getElementById("itemBaixacirurgiaambulatorio").value;
                            buttonPressed.form.action='../git/edicaoProrrogacaoBaixa.do';
                            
                        </c:otherwise>
                    </c:choose> 
                    buttonPressed.form.submit();
                }
            }
        </script>
        
        <%
            Integer sessionIdBaixa = (Integer)session.getAttribute("git.idBaixa");
            // There aren't any Baixa ID whith 0 
            if (sessionIdBaixa == null) {
                sessionIdBaixa = new Integer(0);
            }
        
            Integer sessionIdItemBaixa = (Integer)session.getAttribute("git.idItemBaixa");
            // There aren't any Baixa ID whith 0 
            if (sessionIdItemBaixa == null) {
                sessionIdItemBaixa = new Integer(0);
            }   
        
            Integer sessionNumBaixas = (Integer)session.getAttribute("git.listaBaixasNumRows");
            // There aren't any Baixa ID whith 0 
            if (sessionNumBaixas == null) {
                sessionNumBaixas = new Integer(0);
            }
        %>
   
    </head>
<body onload=" selectFirstItem('radioIdBaixa'); selectFirstItem('IdItemBaixa'); splash(false)">
    <div id="outerContainer">
        <div class="center">
            <jsp:include page="/pub/breadcrumb.jsp" flush="true">     
                <jsp:param name="pIdCentroSaude" value="${centroSaudeEscolhido}"/> 
                <jsp:param name="pCodigoCentroSaude" value="${pSessaoCodigoCentroSaude}"/> 
                <jsp:param name="pDescricaoCentroSaude" value="${pSessaoDescricaoCentroSaude}"/>
            </jsp:include>
            <jsp:include page="/com/splash.jsp" flush="true"/>
        </div>
        <div id ="formContainer" align ="left">
            <jsp:include page="/com/error.jsp" flush="true"/>                            
            <jsp:include page="/com/infoUtente.jsp" flush="true"/>
            <!-- DOWN -->             
            <form method="POST" id="x" class="formCIThistory" action="baixasUtente.do" onsubmit="splash(true);">                          
                <div class="subTitle">Hist&oacute;rico de Incapacidades Tempor&aacute;rias</div>
                <c:set value="<%=sessionIdBaixa.toString()%>" var="sessionIdBaixaJsp" />
                <c:set value="<%=sessionIdItemBaixa.toString()%>" var="sessionIdItemBaixaJsp" />
                <c:set value="<%=sessionNumBaixas.toString()%>" var="sessionNumBaixas" />    
                <div class ="subContainerTable">                                         
                    <%-- Check if utente as entidade associated. If not, he can't have any Baixa  --%>
                    <c:set var="numRowsListaEntidades" value='<%=session.getAttribute("infolistaEntidadesNumRows")%>'/>                        
                    <%-- This is necessary to preserve the Data de Termo for prorrogacao and Alta. Dates has to be continuous --%>
                    <input type="hidden" id="hiddenLastItemDataTermo" name="hiddenLastItemDataTermo" value="<c:out value="${param.hiddenLastItemDataTermo}"/>" /> 
                    <input type="hidden" id="selectClassDoenca" name="selectClassDoenca" value="<c:out value="${param.selectClassDoenca}"/>" /> 
                    <input type="hidden" id="idClassDoencaDF" name="idClassDoencaDF" value="<c:out value="${param.idClassDoencaDF}"/>" />                         
                    <input type="hidden" id="hiddenBaixasIduHistEntUtID" name="hiddenIduHistEntUtID" value="<c:out value="${param.hiddenIduHistEntUtID}"/>" />
                    <input type="hidden" id="hiddenBaixasNumBeneficiario" name="hiddenNumBeneficiario" value="<c:out value="${param.hiddenNumBeneficiario}"/>" />
                    <input type="hidden" id="hiddenBaixasIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="<c:out value="${param.hiddenIEntidadeResponsavel}"/>" />
                    <!-- Id e Tipo de Entidade que está seleccionado na Lista de Baixas-->
                    <input type="hidden" id="hiddenBaixasSelectedIdEntidadeResponsavel" name="hiddenSelectedIdEntidadeResponsavel" value="<c:out value="${param.hiddenSelectedIdEntidadeResponsavel}"/>" />
                    <input type="hidden" id="hiddenBaixasSelectedTipoEntidadeResponsavel" name="hiddenSelectedTipoEntidadeResponsavel" value="<c:out value="${param.hiddenSelectedTipoEntidadeResponsavel}"/>" />                                 
                    <input type="hidden" id="inputFamiliar" name="inputFamiliar" value="<c:out value="${param.inputFamiliar}"/>" /> 
                    <input type="hidden" id="selectParentesco" name="selectParentesco" value="<c:out value="${param.selectParentesco}"/>" /> 
                    <input type="hidden" id="OutroGrauParentesco" name="OutroGrauParentesco" value="<c:out value="${param.OutroGrauParentesco}"/>" />
                    <input type="hidden" id="inputFamiliarNome" name="inputFamiliarNome" value="<c:out value="${param.inputFamiliarNome}"/>" />                           
                    <input type="hidden" id="codTipoRegisto" name="codTipoRegisto" value="<c:out value="${param.codTipoRegisto}"/>" /> 
                    <input type="hidden" id="DataInicioTotal" name="DataInicioTotal" value="<c:out value="${param.DataInicioTotal}"/>" />                           
                    <input type="hidden" id="BaixaincActProf" name="incActProf" value="" />
                    <input type="hidden" id="BaixacuiIna" name="cuiIna" value="" />
                    <input type="hidden" id="Baixainternamento" name="internamento" value="" />
                    <input type="hidden" id="Baixacirurgiaambulatorio" name="cirurgiaAmbulatorio" value="" />
                    <input type="hidden" id="Baixaautorizacao" name="autorizacao" value="" />
                    <input type="hidden" id="Baixajustificacao" name="justificacao" value="" />
                    <input type="hidden" id="idBaixaSeleccionada" name="idBaixaSeleccionada" value="" />
                    <!-- Para saber que baixa temos selecionada. (primeira, segunda, etc)-->
                    <input type="hidden" id="selectedBaixaCount" name="selectedBaixaCount" value="<c:out value="${param.selectedBaixaCount}"/>" />                                     
                    <!-- Entidades Responsaveis -->
                    <input type="hidden" id="idEntidadeResponsavel" name="idEntidadeResponsavel" value="<c:out value="${param.idEntidadeResponsavel}"/>" />                           
                    <input type="hidden" id="warning" name="warning" value="${param.warning}"/>                           
                    <script type="text/javascript">
                        //Entidades Responsaveis
                        if (document.getElementById("idEntidadeResponsavel").value == "" && document.getElementById("entResp")) {
                            document.getElementById("idEntidadeResponsavel").value = document.getElementById("entResp").value;
                        }
                    </script>                          
                    <!-- Saber se a entidade é EPUB ou ERES -->
                    <input type="hidden" id="entidadePublica" name="entidadePublica" value="EPUB"/>
                    
                    <%  // There is no selected Baixa
                    if (sessionNumBaixas.intValue() != 0) { %>
                        <table id="navigationTable" style="width:98%">
                            <tr class="navigation">
                                <td> 
                                    <jsp:include page="/com/navigationList.jsp" flush="false">
                                        <jsp:param name="rangeBindingName" value="ListaBaixas"/>                      
                                        <jsp:param name="listaNumRowsName" value="git.listaBaixasNumRows"/>    
                                        <jsp:param name="targetPageName" value="baixasUtente.do"/>
                                    </jsp:include>
                                </td>
                            </tr> 
                        </table> 
                        <table id="readOnlyTable" class="baixas" style="table-layout: fixed;" cellpadding="0" cellspacing="1">
                            <thead>
                                <tr class="head">
                                    <th class="pesquisaresultados" style="width: 8%; min-width:90px"><span style="white-space: nowrap;"><c:out value="N.º boletim"/></span></th>
                                    <th class="pesquisaresultados" style="width: 8%; min-width:100px"><span style="white-space: nowrap;"><c:out value="Data início"/></span></th>
                                    <th class="pesquisaresultados" style="width: 8%; min-width:100px"><span style="white-space: nowrap;"><c:out value="Data alta"/></span></th>
                                    <th class="pesquisaresultados" style="width: 8%; min-width:90px"><span style="white-space: nowrap;"><c:out value="Tipo registo"/></span></th>
                                    <th class="pesquisaresultados" style="width: 10%; min-width:110px"><span style="white-space: nowrap;"><c:out value="Nº beneficiário"/></span></th>
                                    <th class="pesquisaresultados" style="width: 8%"> <span style="white-space: nowrap;"><c:out value="Entidade"/></span></th>
                                    <th class="pesquisaresultados" style="width: 25%"><span style="white-space: nowrap;"><c:out value="Unidade saúde"/></span></th>
                                    <th class="pesquisaresultados" style="width: 25%"><span style="white-space: nowrap;"><c:out value="Médico"/></span></th>
                                </tr>
                            </thead>
                            <tbody>                                  
                                <c:forEach var="RowListaBaixas" items="${bindings.ListaBaixas.rangeSet}" varStatus="lineListaBaixas">                                                                                                            
                                    <c:choose>
                                        <c:when test="${RowListaBaixas[\'Id\'] == sessionIdBaixaJsp}">
                                            <c:set var="rowClass" value="highlight"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${lineListaBaixas.count % 2 != 0}">
                                                    <c:set var="rowClass" value="pesquisaresultadosimpar"/>
                                                </c:when>   
                                                <c:otherwise>
                                                    <c:set var="rowClass" value="pesquisaresultadospar"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                    <tr class="${rowClass}"   onClick="javascript:
                                            //splash(true);
                                            document.getElementById('idBaixaSeleccionada').value='<c:out value="${RowListaBaixas[\'Id\']}"/>';
                                            document.getElementById('codTipoRegisto').value='<c:out value="${RowListaBaixas[\'Codtiporegisto\']}"/>';
                                            document.getElementById('selectClassDoenca').value='<c:out value="${RowListaBaixas[\'Anterioridclassifdoenca\']}"/>';
                                            document.getElementById('idClassDoencaDF').value='<c:out value="${RowListaBaixas[\'Idcodassistenciafamiliar\']}"/>';
                                            
                                            document.getElementById('inputFamiliar').value='<c:out value="${RowListaBaixas[\'Anteriornomefamiliar\']}"/>';
                                            document.getElementById('inputFamiliarNome').value='<c:out value="${RowListaBaixas[\'Anteriornomefamiliar\']}"/>';
                                            document.getElementById('inputFamiliarNome').value='<c:out value="${RowListaBaixas[\'Anteriornomefamiliar\']}"/>';
                                            document.getElementById('selectParentesco').value='<c:out value="${RowListaBaixas[\'Anterioridparentesco\']}"/>';
                                            document.getElementById('OutroGrauParentesco').value='<c:out value="${RowListaBaixas[\'Outrograuparentesco\']}"/>';
                                            
                                            document.getElementById('hiddenLastItemDataTermo').value='<c:out value="${RowListaBaixas[\'DataTermo\']}"/>';
                                            document.getElementById('DataInicioTotal').value='<c:out value="${RowListaBaixas[\'DataInicioTotal\']}"/>';
                                            
                                            //Entidades Responsaveis 
                                            document.getElementById('idEntidadeResponsavel').value='<c:out value="${RowListaBaixas[\'Histid\']}"/>';
                                            document.getElementById('entidadePublica').value='<c:out value="${RowListaBaixas[\'Codigoentidadepub\']}"/>';
                                            //Quando é vazio, é 'ERES'
                                            if ('' == '<c:out value="${RowListaBaixas[\'Codigoentidadepub\']}"/>') {
                                                document.getElementById('hiddenBaixasSelectedTipoEntidadeResponsavel').value='ERES';    
                                            } else {
                                                document.getElementById('hiddenBaixasSelectedTipoEntidadeResponsavel').value='EPUB';    
                                            }
                                            document.getElementById('hiddenBaixasSelectedIdEntidadeResponsavel').value='<c:out value="${RowListaBaixas[\'Entidaderesponsavelid\']}"/>';
                                            
                                                                                           
                                           //highlightRow(this,${lineListaBaixas.count});
                                            
                                            document.getElementById('selectedBaixaCount').value='<c:out value="${lineListaBaixas.count}"/>'; 
                                            document.getElementById('hiddenListaBaixas').value='SelectBaixa'; 
                                           document.getElementById('x').submit();" >
                                        <td class="selection" style="display:none;">
                                            <c:choose>
                                                <c:when test="${RowListaBaixas[\'Id\'] == sessionIdBaixaJsp}">
                                                    <input type="radio" id="radioIdBaixa" name="radioIdBaixa" value="<c:out value="${RowListaBaixas[\'Id\']}"/>" checked="true" />
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="radio" id="radioIdBaixa" name="radioIdBaixa" value="<c:out value="${RowListaBaixas[\'Id\']}"/>"  
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="numeric pesquisaresultados">
                                            <c:out value="${RowListaBaixas.NumBoletim}"/>
                                        </td>
                                        <td class="date pesquisaresultados" >
                                            <c:out value="${RowListaBaixas.DataInicioTotal}"/>
                                        </td>
                                        <td class="date pesquisaresultados">
                                            <c:out value="${RowListaBaixas.Dataalta}"/> <c:if test="${RowListaBaixas[\'Dataalta\'] == null}"> <c:set var="idBaixaAberta" value="${RowListaBaixas[\'Id\']}"/></c:if> 
                                        </td>
                                        <td class="text pesquisaresultados">
                                            <c:out value="${RowListaBaixas.Tiporegisto}"/>
                                        </td>
                                        <td class="text pesquisaresultados">
                                            <c:out value="${RowListaBaixas.Numbenef}"/>
                                        </td>
                                        <td class="date pesquisaresultados" title="${RowListaBaixas.Entidaderesponsavel}">
                                            <div class="adjust-text-div" style="/*width:110px;*/text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                                <c:out value="${RowListaBaixas.Entidaderesponsavel}"/>
                                            </div>
                                        </td>
                                        <td class="text pesquisaresultados" title="${RowListaBaixas.Entidade}">
                                            <div class="adjust-text-div" style="margin-right: 5px; text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                                <c:out value="${RowListaBaixas.Entidade}"/>
                                            </div>
                                        </td>
                                        <td class="text last pesquisaresultados" title="${RowListaBaixas.Profissional}">
                                            <div class="adjust-text-div" style="text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-transform:capitalize">
                                                <c:out value="${RowListaBaixas.Profissional}"/>
                                            </div>
                                        </td>                                
                                    </tr>
                                </c:forEach>
                                <tr class="navigation">
                                    <td colspan="9">
                                        <%--  For the case we have an open Baixa e we whant to pass a new one--%>
                                        <input type="hidden" id="IdbaixaAltaAberta" name="IdbaixaAltaAberta" value="<c:out value="${idBaixaAberta}"/>" /> 
                                    </td>
                                </tr>
                            </tbody>
                        </table>                      
                <% // To close the if to shown or not ListaBaixas 
                    } else {  %>
                        <div style="padding-top:10px">
                            <c:out value="Este utente não tem baixas registadas"/>                                    
                        </div>
                <%
                    }
                %>
                </div>         
                <div id="divButtonTableBaixas" class="subContainerButtons">     
                    <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
                        <thead/>
                        <tbody>
                            <tr>
                                <td>
                                    <input type="hidden" id="opcaoSeleccionada" name="opcaoSeleccionada" value="" />  
                                    <button style="width:85px" class="subCont" id="buttonForm" name="buttonForm" type="button" value="Nova Baixa" onclick="genericAction(this);" >Nova Baixa</button>
                                </td>
                                <td>
                                    <button style="width:105px" class="subCont <c:if test="${param.codTipoRegisto == 'A' || sessionNumBaixas == 0}">buttonDisabled</c:if>"
                                            name="progBaixa" id="progBaixa"
                                            type="button"
                                            value="Prorrogação" <c:if test="${param.codTipoRegisto == 'A' || sessionNumBaixas == 0}">disabled</c:if>
                                            onclick="genericAction(this);" >Prorrogação</button>
                                </td>
                                <td>
                                    <button style="width:50px" class="subCont <c:if test="${sessionIdBaixaJsp == 0 || param.codTipoRegisto == 'A'}">buttonDisabled</c:if>" 
                                            type="button" 
                                            value="Alta" 
                                            name="altaBaixa" id="altaBaixa"
                                            <c:if test="${sessionIdBaixaJsp == 0 || param.codTipoRegisto == 'A'}">disabled</c:if> 
                                            onclick="document.getElementById('hiddenListaBaixas').value='PageLoadEdicaoAlta';
                                             this.form.action='../git/edicaoAlta.do';this.form.submit();">Alta</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <c:forEach var="RowListaBaixas" items="${bindings.ListaBaixas.rangeSet}" varStatus="lineListaBaixas">                                
                    <%-- Para o caso de haver alguma baixa em aberto, não se pode abrir nenhuma nova baixa  --%>
                    <c:if test="${RowListaBaixas[\'Dataalta\'] == null}">
                        <script type="text/javascript">
                            document.getElementById('buttonForm').setAttribute('disabled','disabled');
                            document.getElementById('buttonForm').className += ' buttonDisabled' ;
                        </script>   
                    </c:if>                                
                    <c:if test="${(RowListaBaixas[\'Dataalta\'] == null && sessionIdBaixaJsp == 0) or (param.entidadePublica == 'EPUB')}">
                        <script type="text/javascript"> 
                            document.getElementById('progBaixa').disabled=true;
                            document.getElementById('progBaixa').className += ' buttonDisabled' ;
                        </script>   
                    </c:if>
                </c:forEach>
                <c:if test="${(numRowsListaEntidades == 0 && bindings.InformacaoUtente.Numssocial == null) || empty bindings.InformacaoUtente.Numutente}">
                    <script type="text/javascript">   
                        document.getElementById('buttonForm').setAttribute('disabled','disabled');
                        document.getElementById('buttonForm').className += ' buttonDisabled' ;
                        document.getElementById('progBaixa').setAttribute('disabled','disabled');
                        document.getElementById('progBaixa').className += ' buttonDisabled' ;
                    </script>
                    <!--  Utente não tem entidade responsável associada e/ou não tem numero de utente associado, logo não é possível passar baixa.<br> -->
                </c:if>                         
                <script type="text/javascript">
                    //Verificar se entramos em modo consulta. Se sim, existe uma variável de sessao "readOnlyCIT"
                    //Esta variável so existe no caso da integração com o SAM (ver ContexFilter.java)
                    if ('${sessionScope.readOnlyCIT}' == 'yes') {
                        document.getElementById('divButtonTableBaixas').style.display = "none";
                    }
                </script>
            </form>
            <div id="footer" style="margin-left:-20px">
                <!--<button type="button" class="button_emitir">EMITIR CIT</button>-->
                <div id="divButtonTablePesquisaUtente">
                    <form method="POST" action="" id="formGetNewUtente" onsubmit="">                        
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
            <%--
                --
                --
                --
                Detalhes de Baixas
                --
                --
                --
            --%>
            <form method="POST" name="formItemsBaixa" class="formItemsBaixa" action="" onsubmit="">
                <fieldset style="display:none;">
                    <input type="hidden" id="hiddenLastItemDataTermo" name="hiddenLastItemDataTermo" value="<c:out value="${param.hiddenLastItemDataTermo}"/>" /> 
                    <input type="hidden" id="codTipoRegisto" name="codTipoRegisto" value="<c:out value="${param.codTipoRegisto}"/>" /> 
                    <input type="hidden" id="idSelectedBaixa" name="idSelectedBaixa" value="<c:out value="${sessionIdBaixaJsp}"/>" />      
                    <input type="hidden" id="itemBaixaselectClassDoenca" name="selectClassDoenca" value="" /> 
                    <input type="hidden" id="itemBaixaCodTiporegisto" name="hiddenCodTipoRegisto" value="" /> 
                    <!-- Entidades Responsaveis -->
                    <input type="hidden" id="itemBaixaentidadePublica" name="entidadePublica" value="<c:out value="${param.entidadePublica}"/>" />
                    <input type="hidden" id="itemBaixaIdSelectedentidadePublica" name="IdEntidadePublica" value="<c:out value="${param.IdEntidadePublica}"/>" />                
                </fieldset>    
                <script type="text/javascript">        
                    //Entidades Responsaveis
                    document.getElementById("itemBaixaentidadePublica").value = document.getElementById("entidadePublica").value;
                </script>         
                <p style="display:none">
                    <input type="hidden" id="itemBaixainputFamiliar" name="inputFamiliar" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarNome" name="inputFamiliarNome" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarDtaNasc" name="inputFamiliarDtaNasc" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarSelected" name="inputFamiliarSelected" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarInputFamiliarId" name="inputFamiliarId" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarInputFamiliarNiss" name="inputFamiliarNiss" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarImpedidoNiss" name="inputnissFamiliarImpedido" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarIdParentesco" name="inputFamiliarIdParentesco" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarInputFamiliarOutroParentesco" name="inputFamiliarOutroParentesco" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarOutroGrauParentesco" name="inputFamiliarOutroParentescoTexto" value="" />
                    <input type="hidden" id="itemBaixainputFamiliarGrauParentesco" name="itemBaixainputFamiliarGrauParentesco" value="" />
                    <input type="hidden" id="hiddenItemBaixasIduHistEntUtID" name="hiddenIduHistEntUtID" value="<c:out value="${param.hiddenIduHistEntUtID}"/>" />
                    <input type="hidden" id="hiddenItemBaixasNumBeneficiario" name="hiddenNumBeneficiario" value="<c:out value="${param.hiddenNumBeneficiario}"/>" />
                    <input type="hidden" id="hiddenItemBaixasIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="<c:out value="${param.hiddenIEntidadeResponsavel}"/>"  />
                    <input type="hidden" id="itemBaixaselectParentesco" name="selectParentesco" value="" />
                    <input type="hidden" id="itemBaixaOutroGrauParentesco" name="OutroGrauParentesco" value="" />
                    <input type="hidden" id="itemBaixadp-dinicio" name="dp-dinicio" value="" />
                    <input type="hidden" id="itemBaixadp-dtermo" name="dp-dtermo" value="" />
                    <input type="hidden" id="itemBaixadp-dias" name="dp-dias" value="" />
                    <input type="hidden" id="itemBaixaincActProf" name="incActProf" value="" />
                    <input type="hidden" id="itemBaixacuiIna" name="cuiIna" value="" />
                    <input type="hidden" id="itemBaixainternamento" name="internamento" value="" />
                    <input type="hidden" id="itemBaixacirurgiaambulatorio" name="cirurgiaAmbulatorio" value="" />
                    <input type="hidden" id="itemBaixaautorizacao" name="autorizacao" value="" />
                    <input type="hidden" id="itemBaixajustificacao" name="justificacao" value="" />
                </p>      
                <%  // There is no selected Baixa
                if (sessionNumBaixas.intValue() != 0) { %>
                    <div class="subTitle" style="margin-top:20px">Detalhes da Incapacidade Tempor&aacute;ria</div>                        
                        <%  // There is no selected Baixa
                        if (sessionIdBaixa.intValue() != 0) { %>
                            <div class ="subContainerTable">
                                <script type="text/javascript">
                                    //Verificar se entramos em modo consulta. Se sim, existe uma variável de sessao "readOnlyCIT"
                                    //Esta variável so existe no caso da integração com o SAM (ver ContexFilter.java)
                                    if ('${sessionScope.readOnlyCIT}' == 'yes') {
                                        document.getElementById('divButtonTableItemsBaixas').style.display = "none";
                                    }
                                </script>
                                <table id="navigationTable" style="width:98%">
                                    <tr class="navigation">
                                        <td> 
                                            <jsp:include page="/com/navigationList.jsp" flush="true">
                                                <jsp:param name="rangeBindingName" value="ListaItemsBaixas"/>                      
                                                <jsp:param name="listaNumRowsName" value="git.listaItemsBaixasNumRows"/>    
                                                <jsp:param name="targetPageName" value="baixasUtente.do"/>
                                            </jsp:include> 
                                        </td>
                                    </tr> 
                                </table>                                                                                                
                                <table id="readOnlyTable" class="baixas" style="table-layout: fixed;" cellpadding="0" cellspacing="1">
                                    <thead>
                                        <tr class="head">
                                            <th class="pesquisaresultados" style="width: 10%; min-width:90px;"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Tiporegisto\']}"/></span></th>
                                            <th class="pesquisaresultados" style="min-width:165px;"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Classdoenca\']}"/></span></th>
                                            <th class="pesquisaresultados" style="width: 10%; min-width:90px;"><span style="white-space: nowrap;"><c:out value="Data início"/></span></th>
                                            <th class="pesquisaresultados" style="width: 5%; min-width:50px;"><span style="white-space: nowrap;"><c:out value="Dias"/></span></th>
                                            <th class="pesquisaresultados" style="width: 9%; min-width:90px;"><span style="white-space: nowrap;"><c:out value="Data termo"/></span></th>
                                            <th class="pesquisaresultados" style="width: 3%; min-width:30px;text-align:center;text-indent:0px;"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Incapacitado\']}"/></span></th>
                                            <th class="pesquisaresultados" style="width: 3%; min-width:30px;text-align:center;text-indent:0px;"><span style="white-space: nowrap;"><c:out value="CA"/></span></th>
                                            <th class="pesquisaresultados" style="width: 3%; min-width:30px;text-align:center;text-indent:0px;"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Autorizsaida\']}"/></span></th>
                                            <th class="pesquisaresultados" style="width: 15%; min-width:90px;"><span style="white-space: nowrap;"><c:out value="Unidade saúde"/></span></th>
                                            <th class="pesquisaresultados" style="width: 10%; min-width:90px;"><span style="white-space: nowrap;"><c:out value="Médico"/></span></th>
                                            <th class="pesquisaresultados" style="width: 12%; min-width:100px;"><span style="white-space: nowrap;"><c:out value="${bindings.ListaItemsBaixas.labels[\'Datacriacao\']}"/></span></th>
                                        </tr>
                                    </thead>
                                    <tbody>                              
                                        <c:forEach var="RowListaItemsBaixas" items="${bindings.ListaItemsBaixas.rangeSet}" varStatus="lineListaItemsBaixas">                
                                            <c:choose>
                                                <c:when test="${lineListaItemsBaixas.count % 2 != 0}">
                                                    <c:set var="trClassItemBaixa" value="pesquisaresultadosimpar"/>
                                                </c:when>   
                                                <c:otherwise>
                                                    <c:set var="trClassItemBaixa" value="pesquisaresultadospar"/>
                                                </c:otherwise>
                                            </c:choose>                                            
                                            <fmt:setLocale value="pt_PT"/>
                                            <fmt:parseNumber var="DiasDiferenca" type="number" value="${RowListaItemsBaixas[\'Diasdiferenca\']}"/>
                                            <fmt:parseNumber var="Onze" type="number" value="11"/>                     
                                            <tr class="${trClassItemBaixa}" onClick="
                                                                javascript:highlightRow(this,${lineListaItemsBaixas.count}); 
                                                                document.getElementById('selectedIdItemBaixa').value = '<c:out value="${RowListaItemsBaixas.Id}"/>';
                                                                document.getElementById('selectedCodClassDoencaItemBaixa').value = '<c:out value="${RowListaItemsBaixas[\'Codclassdoenca\']}"/>';                                    
                                                                document.getElementById('itemBaixaCodTiporegisto').value = '<c:out value="${RowListaItemsBaixas[\'Codigoitembaixa\']}"/>';                                    
                                                                <%-- We only must print Baixas for I or P Items Baixas --%>
                                                                <c:choose>
                                                                    <c:when test="${RowListaItemsBaixas[\'Codigoitembaixa\'] == 'P' || RowListaItemsBaixas[\'Codigoitembaixa\'] == 'I'}">
                                                                        <c:if test="${not((numRowsListaEntidades == 0 && bindings.InformacaoUtente.Numssocial == null) || empty bindings.InformacaoUtente.Numutente)}">
                                                                            enableButton(document.getElementById('printItemBaixaButton'));
                                                                        </c:if>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        disableButton(document.getElementById('printItemBaixaButton'));
                                                                    </c:otherwise>
                                                                </c:choose>                                        
                                                                document.getElementById('itemBaixaselectClassDoenca').value = '<c:out value="${RowListaItemsBaixas[\'Idclassdoenca\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliar').value = '<c:out value="${RowListaItemsBaixas[\'Nomefamiliar\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarNome').value = '<c:out value="${RowListaItemsBaixas[\'Nomefamiliar\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarDtaNasc').value='<c:out value="${RowListaItemsBaixas[\'Dtanascfamiliar\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarOutroGrauParentesco').value='<c:out value="${RowListaItemsBaixas[\'Outrograuparentesco\']}"/>';
                                                                document.getElementById('itemBaixaselectParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Idparentesco\']}"/>';
                                                                document.getElementById('itemBaixaOutroGrauParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Outrograuparentesco\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarInputFamiliarInputFamiliarId').value='<c:out value="${RowListaItemsBaixas[\'Ididentutidffamiliar\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarInputFamiliarInputFamiliarNiss').value='<c:out value="${RowListaItemsBaixas[\'Nissfamiliar\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarInputFamiliarImpedidoNiss').value='<c:out value="${RowListaItemsBaixas[\'Nissprogenitor\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarInputFamiliarIdParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Idparentesco\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarInputFamiliarOutroParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Outrograuparentesco\']}"/>';
                                                                document.getElementById('itemBaixainputFamiliarGrauParentesco').value = '<c:out value="${RowListaItemsBaixas[\'Parentesco\']}"/>';
                                                                if (document.getElementById('itemBaixainputFamiliarNome').value != '' ) {
                                                                    document.getElementById('itemBaixainputFamiliarInputFamiliarSelected').value = 'selected';
                                                                }
                                                                document.getElementById('itemBaixadp-dinicio').value = '<c:out value="${RowListaItemsBaixas[\'Datainicio\']}"/>';
                                                                document.getElementById('itemBaixadp-dtermo').value = '<c:out value="${RowListaItemsBaixas[\'Datatermo\']}"/>';
                                                                document.getElementById('itemBaixadp-dias').value = '<c:out value="${RowListaItemsBaixas[\'Diasbaixa\']}"/>';                                
                                                                document.getElementById('itemBaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';
                                                                document.getElementById('BaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';                                                                    
                                                                // correcao de dados
                                                                <c:choose>
                                                                    <c:when test="${RowListaItemsBaixas.Codclassdoenca ne 'DF' &&
                                                                        RowListaItemsBaixas.Codclassdoenca ne 'AM' &&
                                                                        RowListaItemsBaixas.Codclassdoenca ne 'RC' &&
                                                                        RowListaItemsBaixas.Codclassdoenca ne 'IG' && 
                                                                        RowListaItemsBaixas.Incapacitado eq 'N' && RowListaItemsBaixas.Cuidadosinadiaveis eq 'N'}">  
                                                                        document.getElementById('itemBaixaincActProf').value = 'S';
                                                                        document.getElementById('BaixaincActProf').value = 'S';
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        document.getElementById('itemBaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';
                                                                        document.getElementById('BaixaincActProf').value = '<c:out value="${RowListaItemsBaixas[\'Incapacitado\']}"/>';
                                                                    </c:otherwise>
                                                                </c:choose>                                    
                                                                document.getElementById('itemBaixacuiIna').value = '<c:out value="${RowListaItemsBaixas[\'Cuidadosinadiaveis\']}"/>';
                                                                document.getElementById('itemBaixainternamento').value = '<c:out value="${RowListaItemsBaixas[\'Internamento\']}"/>';
                                                                document.getElementById('itemBaixacirurgiaambulatorio').value = '<c:out value="${RowListaItemsBaixas[\'Cirurgiaambulatorio\']}"/>';
                                                                document.getElementById('itemBaixaautorizacao').value = '<c:out value="${RowListaItemsBaixas[\'Autorizsaida\']}"/>';
                                                                document.getElementById('itemBaixajustificacao').value = '<c:out value="${RowListaItemsBaixas[\'Justificacao\']}"/>';                                    
                                                                document.getElementById('BaixacuiIna').value = '<c:out value="${RowListaItemsBaixas[\'Cuidadosinadiaveis\']}"/>';
                                                                document.getElementById('Baixainternamento').value = '<c:out value="${RowListaItemsBaixas[\'Internamento\']}"/>';
                                                                document.getElementById('Baixacirurgiaambulatorio').value = '<c:out value="${RowListaItemsBaixas[\'Cirurgiaambulatorio\']}"/>';
                                                                document.getElementById('Baixaautorizacao').value = '<c:out value="${RowListaItemsBaixas[\'Autorizsaida\']}"/>';
                                                                document.getElementById('Baixajustificacao').value = '<c:out value="${RowListaItemsBaixas[\'Justificacao\']}"/>';
                                                                <%-- We cannot alter , unless it's the last one given by the Profissional --%>
                                                                disableButton(document.getElementById('buttonItemAlterar')); 
                                                                disableButton(document.getElementById('buttonItemAnular')); 
                                                                <c:choose>
                                                                    <c:when test="${ lineListaItemsBaixas.count == 1 &&  
                                                                             ( param.selectedBaixaCount == 1 || RowListaItemsBaixas.Gitbaixasid == idBaixaAberta ) &&
                                                                             (empty param.nextRangeListaItemsBaixas || param.nextRangeListaItemsBaixas eq '0') &&
                                                                         DiasDiferenca < Onze  }">
                                                      
                                                                        // Opção Alterar
                                                                        <c:if test="${RowListaItemsBaixas[\'Codigoitembaixa\'] == 'I' || RowListaItemsBaixas[\'Codigoitembaixa\'] == 'P'}">
                                                                            enableButton(document.getElementById('buttonItemAlterar'));
                                                                        </c:if>                                                      
                                                                        // Opção Anular
                                                                        // disponibiliza opção para o betim sem baixa
                                                                        // caso não exista disponibiliza para o ultimo boletim
                                                                        <c:choose>
                                                                            <c:when test="${RowListaItemsBaixas.Gitbaixasid == idBaixaAberta}">
                                                                                enableButton(document.getElementById('buttonItemAnular'));
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <c:if test="${empty idBaixaAberta && lineListaItemsBaixas.count == 1 && param.selectedBaixaCount == 1}">
                                                                                    enableButton(document.getElementById('buttonItemAnular'));
                                                                                </c:if>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                //Certos tipos de baixa nao podem ter porrogaçoes                                    
                                                                if ('<c:out value="${RowListaItemsBaixas[\'Codclassdoenca\']}"/>' == 'RC' || '<c:out value="${RowListaItemsBaixas[\'Codclassdoenca\']}"/>' == 'IG' || '<c:out value="${RowListaItemsBaixas[\'Codclassdoenca\']}"/>' == 'DF') {
                                                                    document.getElementById('progBaixa').setAttribute('disabled','disabled');
                                                                    document.getElementById('progBaixa').className += ' buttonDisabled' ;    
                                                                }"
                                            >
                                                <td class="selection" style="display:none;">
                                                    <input type="radio" name="IdItemBaixa" id="IdItemBaixa" value="<c:out value="${RowListaItemsBaixas.Id}"/>" <c:if test="${RowListaItemsBaixas.Id == sessionIdItemBaixaJsp}">checked</c:if>                                                            
                                                </td>
                                                <td class="text pesquisaresultados">
                                                    <c:out value="${RowListaItemsBaixas.Tiporegisto}"/>
                                                </td>
                                                <td class="text pesquisaresultados" title="${RowListaItemsBaixas.Classdoenca}">
                                                    <div class="adjust-text-div" style="width: 100%; text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                                        <c:out value="${RowListaItemsBaixas.Classdoenca}"/>
                                                    </div>
                                                </td>                                                    
                                                <td class="date pesquisaresultados">
                                                    <c:out value="${RowListaItemsBaixas.Datainicio}"/>
                                                </td>
                                                <td class="text pesquisaresultados">
                                                    <c:out value="${RowListaItemsBaixas.Diasbaixa}"/>
                                                </td>
                                                <td class="date pesquisaresultados">
                                                    <c:out value="${RowListaItemsBaixas.Datatermo}"/>
                                                </td>
                                                <td style="text-align:center;text-indent:0px">                                           
                                                    <c:choose>
                                                        <c:when test="${RowListaItemsBaixas[\'Internamento\']=='S'}">   
                                                            <input class="pesquisacheckbox" type="checkbox" title="Internamento" checked="checked" disabled/>
                                                        </c:when>
                                                        <c:otherwise>
                                                             <input class="pesquisacheckbox" type="checkbox" title="Internamento" disabled/>
                                                        </c:otherwise>
                                                    </c:choose> 
                                                </td>                                                                                                                                                                            
                                                <td style="text-align:center;text-indent:0px">
                                                    <c:choose>
                                                        <c:when test="${RowListaItemsBaixas[\'Cirurgiaambulatorio\']=='S'}">   
                                                            <input class="pesquisacheckbox" type="checkbox" title="Cirurgia Ambulatório" checked="checked" disabled/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input class="pesquisacheckbox" type="checkbox" title="Cirurgia Ambulatório" disabled/>
                                                        </c:otherwise>
                                                    </c:choose> 
                                                </td>
                                                <td style="text-align:center;text-indent:0px">
                                                    <c:choose>
                                                        <c:when test="${RowListaItemsBaixas[\'Autorizsaida\']=='S'}">   
                                                            <input class="pesquisacheckbox" type="checkbox" checked="checked" title="Autorização Saida: <c:out value="${RowListaItemsBaixas.Justificacao}"/>" disabled />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input class="pesquisacheckbox" type="checkbox" title="Autorização Saida: Não está autorizado a sair" disabled />
                                                        </c:otherwise>
                                                    </c:choose> 
                                                </td>
                                                <td class="text pesquisaresultados" title="${RowListaItemsBaixas.Entidade}">
                                                    <div class="adjust-text-div" style="width: 100%; text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                                        <c:out value="${RowListaItemsBaixas.Entidade}"/>
                                                    </div>
                                                </td>
                                                <td class="text pesquisaresultados" title="${RowListaItemsBaixas.Medico}">
                                                    <div class="adjust-text-div" style="text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-transform:capitalize;">
                                                        <c:out value="${RowListaItemsBaixas.Medico}"/>
                                                    </div>
                                                </td>
                                                <td class="text pesquisaresultados" title="${RowListaItemsBaixas.Datacriacao}">
                                                    <div class="adjust-text-div" style="text-overflow: ellipsis;white-space: nowrap;overflow: hidden;">
                                                        <c:out value="${RowListaItemsBaixas.Datacriacao}"/>
                                                    </div>
                                                </td>
                                            </tr>              
                                        </c:forEach>
                                        <tr align="right">                                            
                                            <td colspan="11" style="background-color:#e2e2e2">
                                                <table>
                                                    <tr style="text-indent:0px;background-color:#e2e2e2">
                                                        <td style="font-size:12px">
                                                            <c:out value="I"/>
                                                        </td>
                                                        <td style="font-size:10px">
                                                            <c:out value=" - Internamento"/>
                                                        </td>
                                                        <td style="font-size:12px;text-indent:15px">
                                                            <c:out value="CA"/>
                                                        </td>
                                                        <td style="font-size:10px">
                                                            <c:out value=" - Cirurgia Ambulatório"/>
                                                        </td>
                                                        <td style="font-size:12px;text-indent:15px">
                                                            <c:out value="A"/>
                                                        </td>                                                                                                                 
                                                        <td style="font-size:10px">
                                                            <c:out value=" - Autorização de saída"/>
                                                        </td>
                                                    </tr>
                                                </table>                                               
                                            </td>                                             
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="divButtonTableItemsBaixas" class="subContainerButtons">                            
                                <table id="buttonTable" cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <thead/>
                                    <tbody>
                                        <tr>
                                            <td style="width:70px">
                                                <input type="hidden"  id="opcaoSeleccionada"  name="opcaoSeleccionada" value="Alterar" />  
                                                <input type="hidden" name="selectedIdItemBaixa" id="selectedIdItemBaixa" value="" />
                                                <input type="hidden" name="selectedCodClassDoencaItemBaixa" id="selectedCodClassDoencaItemBaixa" value="" />
                                                <button style="width:70px" class="subCont" id="buttonItemAlterar" name="buttonForm" type="button" value="Alterar" onclick="genericAction(this);" >Alterar</button>
                                            </td>
                                            <td>
                                                <button style="width:65px" class="subCont" id="buttonItemAnular" name="buttonItemAnular" type="button" value="Anular" onclick="genericAction(this);" >Anular</button>
                                            </td>
                                            <td align="right">                            
                                                 <button style="width:70px" class="subCont" id="printItemBaixaButton" name="printItemBaixaButton" type="button" value="Imprimir" <c:if test="${sessionIdBaixaJsp == 0}">disabled</c:if> onclick="imprimirItemBaixa(document.getElementById('selectedIdItemBaixa').value,
                                                                                    '<c:out value="${param.entidadePublica}"/>',
                                                                                    document.getElementById('selectedCodClassDoencaItemBaixa').value);" >Imprimir</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>                    
                            <script type="text/javascript">
                                //Verificar se entramos em modo consulta. Se sim, existe uma variável de sessao "readOnlyCIT"
                                //Esta variável so existe no caso da integração com o SAM (ver ContexFilter.java)
                                if ('${sessionScope.readOnlyCIT}' == 'yes') {
                                    document.getElementById('divButtonTableItemsBaixas').style.display = "none";
                                }
                            </script>                                
                        <% // To close the if to shown or not ListaItemsBaixas 
                        } 
                        %>
                    </div>
                <% // To close the if to shown or not ListaBaixas 
                }  
                %>
            </form>
            <!-- UP -->                                                        
            <c:if test="${(numRowsListaEntidades == 0 && bindings.InformacaoUtente.Numssocial == null) || empty bindings.InformacaoUtente.Numutente}">
                <script type="text/javascript">   
                    document.getElementById('buttonForm').setAttribute('disabled','disabled');
                    document.getElementById('buttonForm').className += ' buttonDisabled' ;        
                    document.getElementById('progBaixa').setAttribute('disabled','disabled');
                    document.getElementById('progBaixa').className += ' buttonDisabled' ;            
                    document.getElementById('altaBaixa').setAttribute('disabled','disabled');
                    document.getElementById('altaBaixa').className += ' buttonDisabled' ;        
                    if (document.getElementById('buttonItemAlterar')) { //if exists
                        document.getElementById('buttonItemAlterar').setAttribute('disabled','disabled');
                        document.getElementById('buttonItemAlterar').className += ' buttonDisabled' ;                
                        document.getElementById('buttonItemAnular').setAttribute('disabled','disabled');
                        document.getElementById('buttonItemAnular').className += ' buttonDisabled' ;                
                        document.getElementById('printItemBaixaButton').setAttribute('disabled','disabled');
                        document.getElementById('printItemBaixaButton').className += ' buttonDisabled' ;
                    }
                </script>
            </c:if>                                  
            <script type="text/javascript">
                var reportsGerados = "<%=request.getAttribute("git.reportsToPrint")!=null?request.getAttribute("git.reportsToPrint").toString():""%>";
                if(reportsGerados.length>0){
                    var report = reportsGerados.split(";");
                    for(var i = 0;i<report.length;i++){
                        if(report[i].length>0){
                            imprimirReport(report[i],i);
                        }
                    }
                }
                <%request.setAttribute("git.reportsToPrint","");%>                
            </script>
        </div>      
    </div>                     
    <jsp:include page="/com/footer.jsp" flush="true"/> 
</body>
</html>