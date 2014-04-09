<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <jsp:include page="/com/head.jsp" flush="true"/>
        <script type="text/javascript" src="../js_cit_v3/prorrogacao.js"></script> 
    </head>
    <body onload="splash(false); document.getElementById('dp-dinicio').value=addDaysToDateFormat('<c:out value="${param.hiddenLastItemDataTermo}"/>',1);dataInicioGlobal = document.getElementById('dp-dinicio').value;">
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
                    <jsp:param name="pDescricaoPagina" value="> PRORROGAÇÃO"/>
                </jsp:include>
                <!-- DOWN -->
                <!-- Opens the information about the Utente                            
                            <!-- Entidades Responsaveis -->
                <form id="formProg"  action="" onsubmit="splash(true);" method="POST">
                    <input type="hidden" id="idEvent" name="event" value=""/>
                    <input type="hidden" id="hiddenSubmitIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="<c:out value="${param.hiddenIEntidadeResponsavel}"/>" /> 
                    <input type="hidden" id="idEntidadeResponsavel" name="idEntidadeResponsavel" value="<c:out value="${param.idEntidadeResponsavel}"/>" /> 
                    <input type="hidden" id="DataInicioTotal" name="DataInicioTotal" value="<c:out value="${param.DataInicioTotal}"/>" />  
                    <input type="hidden" id="hiddenLastItemDataTermo" name="hiddenLastItemDataTermo" value="<c:out value="${param.hiddenLastItemDataTermo}" />" />      
                    <script type="text/javascript" >
                        //Entidades Responsaveis
                        if(document.getElementById("entResp")){
                            document.getElementById("entResp").disabled = true;
                        }
                    </script>                        
                    <c:choose>
                        <c:when test="${param.entidadePublica == null}"> 
                            <c:forEach var="Row" items="${bindings.ListaEntidadesResponsaveis.rangeSet}" varStatus="status">
                                <c:if test="${Row['EntDefault'] == 'S'}">
                                    <input type="hidden" id="entidadePublica" name="entidadePublica" value="<c:out value="${Row['Codigo']}"/>" /> 
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" id="entidadePublica" name="entidadePublica" value="<c:out value="${param.entidadePublica}"/>" />
                        </c:otherwise>
                    </c:choose>          
                    <div class="subTitle">Prorrogação</div>
                    <script type="text/javascript">
                        // Se é alterar baixa, temos que colocar no menu das entidades
                        // a entidade que está inserida na baixa, e nao a que está seleccionada na lista
                        if ('${param.hiddenBaixasSelectedIdEntidadeResponsavel}' == '') {
                            //É Segurança social
                            document.getElementById('entResp').value = '-1';
                        } else {
                            document.getElementById('entResp').value = '${param.hiddenBaixasSelectedIdEntidadeResponsavel}';
                        }
                        document.getElementById('hiddenIEntidadeResponsavel').value = document.getElementById('entResp').value;
                        document.getElementById('hiddenIduHistEntUtID').value = histEntUtArray[document.getElementById('entResp').value];
                        document.getElementById('numeroBeneficiario').innerHTML = numBenefArray[document.getElementById('entResp').value];
                        document.getElementById('hiddenNumBeneficiario').value = numBenefArray[document.getElementById('entResp').value];            
                    </script>
                    <div class ="subContainerTable">                                                    
                        <table id="inputForm" cellspacing="0" cellpadding="0" border="0">
                            <thead/>
                            <tbody>
                                <tr>
                                    <td class="outputLabel" style="padding-bottom:6px;padding-top:6px" colspan="7">Classifica&ccedil;&atilde;o Doen&ccedil;a</td>
                                </tr>
                                <tr>
                                    <td class="outputCell" style="width:270px">
                                        <c:set var="flagDisabledDoenca" value="true"/>
                                        <input type="hidden" name="selectClassDoenca" value="<c:out value="${param['selectClassDoenca']}" />" /> 
                                        <input type="hidden" name="inputFamiliar" value="<c:out value="${param['inputFamiliar']}" />" /> 
                                        <input type="hidden" name="selectParentesco" value="<c:out value="${param['selectParentesco']}" />" />                 
                                        <select class="pesquisa" disabled style="width:210px;margin-bottom:0px">
                                            <c:forEach var="RowListaCodigosGenericos" items="${bindings.ListaCodigosGenericos.rangeSet}">
                                                <c:choose>
                                                    <c:when test="${param.selectClassDoenca == RowListaCodigosGenericos.Id}">
                                                        <option selected value="${RowListaCodigosGenericos.Id}"><c:out value="${RowListaCodigosGenericos.Descricao}"/></option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${RowListaCodigosGenericos.Id}"><c:out value="${RowListaCodigosGenericos.Descricao}"/></option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                    </td>                                       
                                    <td class="outputCell" style="width:30px">
                                        <c:choose>
                                            <c:when test="${param['incActProf'] == 'on' || param['incActProf'] == 'S'}">
                                                <input id="incActProf" name="incActProf" type="checkbox" class="pesquisacheckbox" checked disabled/>
                                            </c:when>
                                            <c:otherwise>
                                                <input id="incActProf" name="incActProf" type="checkbox" class="pesquisacheckbox" disabled/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="outputLabel" style="width:130px">Incap. Activ. Prof.</td>                                        
                                    <td class="outputCell" style="width:30px">
                                        <c:choose>
                                            <c:when test="${param['cuiIna'] == 'on' || param['cuiIna'] == 'S'}">
                                                <input id="cuiIna" name="cuiIna" type="checkbox" class="pesquisacheckbox" checked disabled/> 
                                            </c:when>
                                            <c:otherwise>
                                                <input id="cuiIna" name="cuiIna" type="checkbox" class="pesquisacheckbox" disabled/>
                                            </c:otherwise>
                                       </c:choose>
                                    </td>
                                    <td class="outputLabel" style="width:147px">Cuidados Inadi&aacute;veis</td>                                        
                                    <td class="outputCell" style="width:30px">
                                        <c:choose>
                                            <c:when test="${param['impBenefGra'] == 'on' || param['impBenefGra'] == 'S'}">
                                                <input id="impBenefGra" name="impBenefGra" type="checkbox" class="pesquisacheckbox" checked disabled/> 
                                            </c:when>
                                            <c:otherwise>
                                                <input id="impBenefGra" name="impBenefGra" type="checkbox" class="pesquisacheckbox" disabled/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="outputLabel">Imp. Benef. Grávidas</td>
                                </tr>
                                <tr>
                                    <td colspan="7" style="padding-top:10px">
                                        <table>
                                            <tr>
                                                <td>
                                                    <input style="margin-left:0px" id="checkBaixaManual" name="checkBaixaManual" class="pesquisacheckbox" type="checkbox" disabled 
                                                           onclick="javascript: if (document.getElementById('checkManualText').innerHTML != '') 
                                                                                    document.getElementById('checkManualText').innerHTML = '';
                                                                                else {
                                                                                    dataInicioManual = dataInicioGlobal;
                                                                                    dataTermoManual = addDaysToDateFormat(getElementById('dp-dinicio').value,-1);
                                                                                    document.getElementById('checkManualText').innerHTML = 'Item Baixa Manual de ' + dataInicioManual + ' a ' + dataTermoManual ;
                                                                                }"
                                                    />
                                                </td>
                                                <td class="outputLabel">Baixa Inicial Manual</td>
                                                <td> 
                                                    <div id="checkManualText" style="white-space:nowrap; vertical-align: baseline; color: red; padding-left: 20px">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" style="padding-bottom:6px;padding-top:10px">
                                        <table>
                                            <tr>
                                                <td class="outputLabel" style="width:160px">Data de in&iacute;cio
                                                    <span style="color:#cc3333">*</span>
                                                </td>
                                                <td class="outputLabel" style="width:160px">N&ordm; de dias
                                                    <span id="ast_num_dias" style="color:#cc3333">*</span>
                                                </td>
                                                <td colspan="5" class="outputLabel">Data de Termo
                                                    <span id="ast_data_termo" style="color:#cc3333">*</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    
                                                    <input style="margin-bottom:0px;width: 120px;margin-right:3px" onBlur="javascript:controlDataInicio(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" 
                                                      value="${param['dp-dinicio']}" id="dp-dinicio" name="dp-dinicio" type="text" class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" 
                                                      onchange="if(dataInicioProValida()){                                                                                   
                                                             if (document.getElementById('checkManualText').innerHTML != '') {
                                                                dataInicioManual = dataInicioGlobal;
                                                                dataTermoManual = addDaysToDateFormat(getElementById('dp-dinicio').value,-1);
                                                                document.getElementById('checkManualText').innerHTML = 'Item Baixa de Manual ' + dataInicioManual + ' a ' + dataTermoManual ;
                                                             }                                                
                                                             if (dataInicioGlobal != this.value) {
                                                                checkBaixaManual.removeAttribute('disabled');
                                                             } else {
                                                                checkBaixaManual.setAttribute('disabled','disabled');
                                                                checkBaixaManual.checked = false;
                                                                document.getElementById('checkManualText').innerHTML = '';
                                                             }
                                                      } else {
                                                        alert('Data introduzida inválida! A Data de Início tem de ser superior à data de termo do último item de baixa.');
                                                      }
                                                      " 
                                                      maxlength="10" />
                                                </td>
                                                <td class="outputLabel">
                                                    <input style="margin-bottom:0px;width: 120px;" onkeypress="javascript: keyCheck(event,document.getElementById('dp-dtermo'));" 
                                                           onBlur="javascript:controlNrDias(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" 
                                                           value="${param['dp-dias']}" 
                                                           id="dp-dias" name="dp-dias" class="inputTextOne" type="text"/>
                                                </td>
                                                <td class="outputLabel" style="width:164px">
                                                    <input style="margin-bottom:0px;width: 120px;margin-right:3px" onBlur="javascript:controlDataFim(document.getElementById('dp-dinicio'),document.getElementById('dp-dtermo'),document.getElementById('dp-dias'));" 
                                                           value="${param['dp-dtermo']}" id="dp-dtermo" name="dp-dtermo" type="text" 
                                                           class="inputDate w8em format-d-m-y divider-dash highlight-days-67 range-low-1900-01-01 range-high-2100-12-31 no-transparency" maxlength="10" />
                                                </td>

                                                <td class="outputLabel">
                                                    <c:choose>
                                                        <c:when test="${param['internamento'] == 'on' || param['internamento'] == 'S'}">
                                                            <input class="pesquisacheckbox" id="internamento" name="internamento" type="checkbox" checked onclick="document.getElementById('cirurgiaAmbulatorio').checked=false;"/> 
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input class="pesquisacheckbox" id="internamento" name="internamento" type="checkbox" onclick="document.getElementById('cirurgiaAmbulatorio').checked=false;" />
                                                        </c:otherwise>
                                                    </c:choose>    
                                                </td>
                                                <td class="outputLabel" style="padding-right:20px">Internamento</td>                                        
                                                <td class="outputLabel">
                                                    <c:choose>
                                                        <c:when test="${param['cirurgiaAmbulatorio'] == 'on' || param['cirurgiaAmbulatorio'] == 'S'}">
                                                            <input class="pesquisacheckbox" id="cirurgiaAmbulatorio" name="cirurgiaAmbulatorio" type="checkbox" checked onclick="document.getElementById('internamento').checked=false;"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input class="pesquisacheckbox" id="cirurgiaAmbulatorio" name="cirurgiaAmbulatorio" type="checkbox" onclick="document.getElementById('internamento').checked=false;"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="outputLabel" colspan="2">Cirurgia Ambulatório</td>

                                            </tr>                                                
                                        </table>
                                    </td>                                        
                                </tr>
                                <tr>
                                    <td colspan="7" style="padding-bottom:6px;padding-top:10px">
                                        <table>
                                            <tr>
                                                <td colspan="3"></td>
                                                <td class="outputLabel">Justifica&ccedil;&atilde;o</td>
                                            </tr>
                                            <tr>
                                                <td class="outputLabel">
                                                    <c:choose>
                                                        <c:when test="${param['autorizacao'] == 'on' || param['autorizacao'] == 'S'}">
                                                            <input style="margin-left:0px" class="pesquisacheckbox" id="autorizacao" name="autorizacao" type="checkbox" checked 
                                                                   onclick=" 
                                                                            if (this.checked == true) {
                                                                                if (document.getElementById('justificacao').value == 'Não está autorizado a sair')
                                                                                    document.getElementById('justificacao').value = '';
                                                                            } else {
                                                                                document.getElementById('justificacao').value = 'Não está autorizado a sair';
                                                                            } "          
                                                            />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input style="margin-left:0px" class="pesquisacheckbox" id="autorizacao" name="autorizacao" type="checkbox"
                                                                   onclick=" 
                                                                            if (this.checked == true) {
                                                                                if (document.getElementById('justificacao').value == 'Não está autorizado a sair')
                                                                                    document.getElementById('justificacao').value = '';
                                                                            } else {
                                                                                document.getElementById('justificacao').value = 'Não está autorizado a sair';
                                                                            } "          
                                                            />
                                                        </c:otherwise>
                                                    </c:choose>                                            
                                                </td>
                                                <td class="outputLabel" style="padding-right:5px">Autoriza&ccedil;&atilde;o de Sa&iacute;da</td>
                                                <td style="padding-right:20px;*padding-right:13px"> 
                                                    <img alt="" title="Nos casos de incapacidade por doença, ao selecionar esta opção é obrigatório preencher a Justificação da necessidade de ausência do beneficiário do domicílio no horário estabelecido.
                                                        O doente só pode ausentar-se do domicílio para tratamento. Em casos devidamente fundamentados o médico pode autorizar a ausência no período das 11 às 15h e das 18 às 21h."  style="padding-left:2px;padding-right:2px;padding-top:1px;" src="../imagens_cit_v3/info.png" align="top" />                                                                                                       
                                                </td>
                                                <td class="outputLabel">
                                                    <c:choose>
                                                        <c:when test="${param['autorizacao'] == 'on' || param['autorizacao'] == 'S'}">
                                                            <input style="margin-bottom:0px;width:730px" value="${param['justificacao']}" type="text" name="justificacao" id="justificacao" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input style="margin-bottom:0px;width:730px" value="Não está autorizado a sair" type="text" name="justificacao" id="justificacao" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>    
                        </table>                                                                                                                                     
                    </div>                    
                    <div class="subContainerButtons">
                        <table id="buttonTable" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>                                                                
                                    <button style="width:70px" class="subCont" type="button" value="Gravar" name="event" onclick="prorrogar(this);">Gravar</button>
                                </td>
                                <td>
                                    <button style="width:75px" class="subCont" type="button" value="Cancelar" onclick="genericAction(this);" >Cancelar</button>
                                </td>
                            </tr>
                        </table>
                    </div> 
                </form>
                <jsp:include page="/git/ListaItemsBaixa.jsp" flush="true"/>   
            </div>
            <div id="footer">
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
        <jsp:include page="/com/footer.jsp" flush="true"/>
    </body>
</html>