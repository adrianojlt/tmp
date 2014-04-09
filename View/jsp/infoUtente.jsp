<%try{%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
    boolean utenteSelected              = false;
    boolean emissaoAlteracaoItemBaixa   = false;
    boolean baixasUtentePage            = false;
    
    String req = request.getRequestURI();
    if (req.indexOf("git")>1) {
          utenteSelected = true;
    }
    
    if (req.indexOf("edicaoBaixa") > 1 ) {
        emissaoAlteracaoItemBaixa = true;    
    }
    
    if (req.indexOf("baixasUtente") > 1 ) {
        baixasUtentePage = true;    
    }
    
    if(utenteSelected) { 
%>    
          
    <script type="text/javascript">
        
        var numBenefArray = new Array();
        var entRespArray  = new Array();
        var histEntUtArray  = new Array();
        var numBenef       = new Array();   //Saves num beneficiario by entitie
        
        function addNumBenef( numeroBenef, entidadeResp) {
            numBenef[entidadeResp] = numeroBenef;
            return;
        }
        
        function getNumBenef( entidadeResp) {
            return numBenef[entidadeResp];
        }
    
        var pubEntidades   = new Array();   //Saves if it is public entity
        
        function addpubEntidades( codigo, entidadeResp) {
            pubEntidades[entidadeResp] = codigo;
            return;
        }
        
        function getpubEntidades( entidadeResp) {
            return pubEntidades[entidadeResp];
        }
        
        function retirarUtenteSessao(){

            $.spmsDialog( 'confirm', 
                { 
                    title: 'Confirmar?', 
                    message: "O Utente será retirado da sessão. Confirma? O Utente será retirado da sessão. Confirma?", 
                    callback: function() { 
                        document.forms[0].action = "../idu/pesquisaUtente.do";
                        document.getElementById('idEvent').value='RetirarUtenteSessao';
                        document.forms[0].submit();
                    } 
                }
            );

            //if(confirm("O Utente será retirado da sessão. Confirma?")){
            //if( answer ){}
            
            return false;
        }
        
        function novaPesquisaUtente(){
            document.forms['formGetNewUtente'].action = "../idu/pesquisaUtente.do";
            //document.forms[0].action = "../idu/pesquisaUtente.do";
            //document.forms[0].submit();
            document.forms['formGetNewUtente'].submit();
            return false;
        }
        
        function changeSelectedEntidade (selectBox) {
            document.getElementById('numeroBeneficiario').value = numBenefArray[document.getElementById('entResp').value];
            //Actualiza numero beneficiario
            var numeroBeneficiarioField   = document.getElementById('hiddenNumBeneficiario');
            var entidadeResponsavelField  = document.getElementById('hiddenIEntidadeResponsavel');
            var numeroBeneficiarioFormField  = document.getElementById('hiddenNumBeneficiario_form');
            var histEntUtIdField          = document.getElementById('hiddenIduHistEntUtID');
            
            if (entidadeResponsavelField) {
                entidadeResponsavelField.value  = document.getElementById('entResp').value;
            }
            if (histEntUtIdField) {
                histEntUtIdField.value  = histEntUtArray[document.getElementById('entResp').value];
            }
            if (numeroBeneficiarioField) {
                numeroBeneficiarioField.value   = numBenefArray[document.getElementById('entResp').value];
            }
            
             if (numeroBeneficiarioFormField) {
                numeroBeneficiarioFormField.value   = numBenefArray[document.getElementById('numeroBeneficiarioFormField').value];
            }
            
            /*
            //Caso estejamos numa pagina de emissao de baixa
            //temos que ter em atenção que caso um valor mude nesta select box
            //o item manual pode ou nao ser seleccionado. Um item de baixa
            //manual so pode existir numa baixa de segurança social
            var objcheckBaixaManual = document.getElementById('checkBaixaManual');
            if (objcheckBaixaManual) {
                if (selectBox.value == '-1' ) { //Seg Social
                    document.getElementById('checkBaixaManual').disabled      = false;
                } else {
                    document.getElementById('checkBaixaManual').disabled      = true;
                    document.getElementById('checkBaixaManual').checked       = false;
                    document.getElementById('checkManualText').innerHTML      = '';
                }
            }
            */
            
        }
        
        function changeNumBenefonDiv (idDiv,selectList) {
            document.getElementById(idDiv).innerHTML = ""; 
            document.getElementById(idDiv).innerHTML = numBenef[selectList[selectList.selectedIndex].value];
            
            <c:if test="${param.porig == 'Baixas'}">
                document.getElementById("idEntidadeResponsavel").value = selectList[selectList.selectedIndex].value;
                document.getElementById("entidadePublica").value = getpubEntidades(selectList[selectList.selectedIndex].value);
            </c:if>
        }
    
    </script>
    
    <c:forEach var="Row" items="${bindings.ListaEntidadesResponsaveis.rangeSet}" varStatus="status">
      <script type="text/javascript">
        addNumBenef("<c:out value="${Row['Numbenef']}"/>","<c:out value="${Row['Id']}"/>");
        addpubEntidades("<c:out value="${Row['Codigo']}"/>","<c:out value="${Row['Id']}"/>");
      </script>
    </c:forEach>  
  
    <c:forEach var="RowInfUtente" items="${bindings.InformacaoUtente.rangeSet}" varStatus="lineInformacaoUtente">
        
        <p class="subtitulo">PESQUISA DE UTENTE <span style="color:#666666"> > UTENTE EM SESSÃO</span><span style="font-size:12px;color:#333333"> ${param.pDescricaoPagina} </span></p>              
        <p class="titulo" style="margin-top:0px;margin-bottom:10px">Utente em sessão</p>
        
        <table id="infoUtenteForm" style="margin-bottom:10px;width:98%" cellpadding="0" cellspacing="0">
            <thead/>
            <tbody>
                <%-- 1st Start --%>
                <tr style="height:20px;">
                    <td class="outputLabel" style="width:13%">
                        <span style="white-space: nowrap;">Nº Utente</span>
                    </td>
                    <td class="outputLabel" style="/*width:59%*/">
                        <input type="hidden" id="hiddenInfoUtenteSexoUtente" name="hiddenInfoUtenteSexoUtente" value='<c:out value="${RowInfUtente[\'Sexoutente\']}"/>' /> 
                        <span style="white-space: nowrap;">Nome</span>
                    </td>
                    <td class="outputLabel" style="width:15%">   
                        <span style="white-space: nowrap;">Data de nascimento</span>
                    </td>                    
                    <td class="outputLabel" style="width:30%"> </td>
                </tr> 
                <tr>                    
                    <td class="outputCell">
                        <span style="white-space: nowrap;" id="numUtenteInfo" >
                            <input type="text" value="${RowInfUtente.Numutente}" readonly class="inputReadOnly" style="width:88%"/>
                        </span>
                        <input type="hidden" id="hiddenNumUtenteInfo"  name="hiddenNumUtenteInfo" value='<c:out value="${RowInfUtente[\'Numutente\']}"/>' />
                        <input type="hidden" id="idUtenteInfo"  name="idUtenteInfo" value='<c:out value="${RowInfUtente[\'Idutente\']}"/>' />
                    </td>
                    <td class="outputCell" >
                        <span style="white-space: nowrap;" id="nomeUtenteInfo">
                            <input type="hidden" id="hiddenNomeInfoUtente" name="hiddenNomeInfoUtente" value='<c:out value="${RowInfUtente[\'Nomenormalizado\']}"/>' /> 
                            <input type="text" value="${RowInfUtente.Nomenormalizado}" class="inputReadOnly" style="width:97%;" readonly/>
                        </span>
                    </td>                    
                    <td class="outputCell" >
                        <input type="hidden" id="hiddenInfoUtenteDtaNasc" name="hiddenInfoUtenteDtaNasc" value='<c:out value="${RowInfUtente[\'Datanascimento\']}"/>' />
                        <span style="white-space: nowrap;" id="dtaNascUtenteInfo"> <input type="text" value="${RowInfUtente.Datanascimento}" style="width:85%" class="inputReadOnly" readonly/></span>
                    </td>
                    <td class="outputCell" > </td>
                    <script type="text/javascript">
                        //Verificar se entramos em modo consulta. Se sim, existe uma variável de sessao "readOnlyCIT"
                        //Esta variável so existe no caso da integração com o SAM (ver ContexFilter.java)
                        if ('${sessionScope.readOnlyCIT}' == 'yes') {
                            document.getElementById('divButtonTablePesquisaUtente').style.display = "none";
                        }
                    </script>                    
                </tr> 
            </tbody>
        </table>        
        <%-- 1st End --%>
        <c:set var="numRowsListaEntidades" value='<%=session.getAttribute("infolistaEntidadesNumRows")%>' />
        <%-- 2nd Start --%>
        <table style="margin-bottom:10px;width:98%" cellpadding="0" cellspacing="0">
            <thead/>
            <tbody>
                <tr style="height:20px">
                    <td class="outputLabel" style="width:13%">
                        <span style="white-space: nowrap;">BI
                            <!--<c:out value="${bindings.InformacaoUtente.labels[\'Numbi\']}"/>-->
                        </span>
                    </td>
                    <td class="outputLabel" style="width:29%">
                        <span style="white-space: nowrap;">
                            Entidade financeira respons&aacute;vel
                        </span>
                    </td>
                    <td class="outputLabel" colspan="2">
                        <span style="white-space: nowrap;" id="numeroBeneficiarioLabel">
                            Num. Benefici&aacute;rio
                        </span>
                    </td>
                </tr>
                <tr>                                   
                    <td class="outputCell" >
                        <span style="white-space: nowrap;" id="numBIInfoUtente">
                            <input type="hidden" id="hiddenBIInfoUtente" name="hiddenBIInfoUtente" value='<c:out value="${RowInfUtente[\'Numbi\']}"/>' />
                            <input type="text" value="${RowInfUtente.Numbi}" class="inputReadOnly" style="width:88%;" readonly/>
                         </span>
                    </td>        
                    <td class="outputCell">
                        <span style="white-space: nowrap;" id="entRespInfoUtente">
                            <select style="width:93%;margin-bottom: 0px;" class="pesquisa" id="entResp" name="entResp" onChange="changeSelectedEntidade(this);">
                                <option/>                   
                            </select>
                        </span>
                    </td>
                    <td class="outputCell" style="width:15%">
                        <input type="hidden" id="hiddenNissInfoUtente" name="hiddenNissInfoUtente" value='<c:out value="${RowInfUtente[\'Numssocial\']}"/>' />
                        <input type="hidden" id="hiddenNumBenefInfoUtente" name="hiddenNumBenefInfoUtente" value='<c:out value="${RowInfUtente[\'Numbeneficiario\']}"/>' />
                        <span style="white-space: nowrap;">
                            <input type="text" value="" id="numeroBeneficiario" class="inputReadOnly" style="width:88%" readonly/>                                                                
                            <c:if test="${numRowsListaEntidades != 0}" >                            
                                <input type="hidden" id="hiddenIEntidadeResponsavel" name="hiddenIEntidadeResponsavel" value="" />
                                <input type="hidden" id="hiddenIduHistEntUtID" name="hiddenIduHistEntUtID" value="" />
                                <input type="hidden" id="hiddenNumBeneficiario" name="hiddenNumBeneficiario" value="" />
                                <script type="text/javascript">
                                    var selectedEntidadeResponsavel = '${param.hiddenIEntidadeResponsavel}';
                                </script>    
                                <!-- Obter dados para a Select Box-->
                                <c:forEach var="Row" items="${bindings.ListaEntidadesResponsaveis.rangeSet}" varStatus="RowStatus"  >
                                    <c:if test="${Row['Expirado'] != 'S'}">
                                        <script type="text/javascript">
                                            numBenefArray[${Row['SysEntidadesId']}] = "${Row['Numbenef']}";
                                            entRespArray[${Row['SysEntidadesId']}] = "${Row['DescrAbvr']}";
                                            histEntUtArray[${Row['SysEntidadesId']}] = "${Row['Id']}";
                                        </script>
                                    </c:if>                                
                                </c:forEach>
                                <!-- Criar Select Box-->        
                                <!-- Preencher Select Box -->                
                                <script type="text/javascript">
                                    var selectionBoxEntResp = document.getElementById('entResp');                                
                                    //Remover o elemento vazio. Este elemento existe apenas para nao existir um warning no Jdev 10g
                                    selectionBoxEntResp.remove(0);
                                    //Preencher Select Box
                                    var novaOption;
                                    for (i in entRespArray) {
                                        novaOption          = document.createElement('option');
                                        novaOption.text     = entRespArray[i];
                                        novaOption.value    = i;                                       
                                        try {
                                            selectionBoxEntResp.add(novaOption,null);    // standards compliant; doesn't work in IE
                                        } catch (ex) {
                                            selectionBoxEntResp.add(novaOption);
                                        }                                    
                                    }                                
                                    //Seleccionar Entidade, caso já venha preSeleccionada
                                    //Por defeito fica a primeira, por isso temos tambem que preencher o numero de beneficiario
                                    //e o campo 'hiddenIEntidadeResponsavel'
                                    if (selectedEntidadeResponsavel != '') {
                                        selectionBoxEntResp.value = selectedEntidadeResponsavel;
                                    }
                                    document.getElementById('hiddenIEntidadeResponsavel').value = selectionBoxEntResp.value;
                                    document.getElementById('hiddenIduHistEntUtID').value = histEntUtArray[selectionBoxEntResp.value];
                                    document.getElementById('numeroBeneficiario').value = numBenefArray[selectionBoxEntResp.value];
                                    document.getElementById('hiddenNumBeneficiario').value = numBenefArray[selectionBoxEntResp.value];
                                                                                
                                    <% if (emissaoAlteracaoItemBaixa) { %>                                  
                                        //Caso estejamos na emissao ou alteracao de baixa, nao se pode mudar a entidade
                                        //visto que enterfere nas calssificações de doença
                                        selectionBoxEntResp.disabled   = true;    
                                    <% } %>                                                                  
                                </script>                                                
                            </c:if>                        
                            <c:if test="${numRowsListaEntidades == 0}" >  <%-- Não vai entrar no ciclo. Utente sem entidades responsáveis, quer Seg.Social ou Enti. Publicas --%>
                                <script type="text/javascript">
                                    document.getElementById("numeroBeneficiarioLabel").innerHTML = "NISS:"; 
                                    document.getElementById("numeroBeneficiario").value = "<c:out value="${bindings.InformacaoUtente.Numssocial}"/>"; 
                                </script>  
                            </c:if>
                            <script type="text/javascript"> 
                                <%-- Valor de num beneficiario seleccionado, quando mudada a select box das entidades responsaveis
                                document.getElementById("numeroBeneficiario").value = ''; --%>
                            </script> 
                        </span>
                    </td>
                    <td>
                        <div id="divButtonTableInfoUtente">
                            <span style="white-space: nowrap;">
                                <button class="detalhe" type="button" value="Detalhe Utente" 
                                        onclick="   /*splash(true);*/
                                                    detalheUtentePopUp('');
                                                    /*Faz Refresh para o caso de se ter actualizado o NISS*/
                                                    /*var oldDoc=window.location.toString();*/
                                                    /*window.location.replace(oldDoc);*/">DETALHE UTENTE</button>
                            </span>
                        </div>                        
                        <script type="text/javascript">
                            //Verificar se entramos em modo consulta. Se sim, existe uma variável de sessao "readOnlyCIT"
                            //Esta variável so existe no caso da integração com o SAM (ver ContexFilter.java)
                            if ('${sessionScope.readOnlyCIT}' == 'yes') {
                                document.getElementById('divButtonTableInfoUtente').style.display = "none";
                            }
                        </script>
                    </td>
                </tr>
                <%-- 2nd End --%>
            </tbody>
        </table>                                        
        <SCRIPT type="text/javascript" language="javascript">
            collapseExpandRow('infoUtente');    
        </SCRIPT>
    </c:forEach>
    <%-- </c:when>
    </c:choose> --%>
<%  } %>

<%
} catch(Exception e){
    e.printStackTrace();
}
%>