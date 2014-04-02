<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
  <head>

    <base target="_self">

    <title>Detalhe Utente</title>

    <%-- <jsp:include page="/com/head.jsp" flush="true"/> --%>

    <!-- <link rel="stylesheet" type="text/css" href="../css/featuredcontentglider.css" /> -->

    <!--
    <script type="text/javascript" src="../js/jquery-1.2.2.pack.js"></script>
    <script type="text/javascript" src="../js/featuredcontentglider.js"></script>
    -->


    <!--
    <link rel="stylesheet" type="text/css" href="../css_cit_v3/cit_v3_base.css" title="style"/>
    <link rel="stylesheet" type="text/css" href="../css_cit_v3/cit_v3_bread.css" title="style"/>
    -->

    <link href="../css_cit_v3/spms-grid.css" rel="stylesheet" type="text/css" />
    <link href="../css_cit_v3/spms-theme.css" rel="stylesheet" type="text/css" />

    <style type="text/css" media="Screen"> 

      body { 
        height: 600px;
        margin: 0;
        margin-bottom: 20px;
        font: 14px "arial";
        background-color: #e8e8e8;
      }

      .spms { width: 100%; }

      /*** IE7 Fixes ***/
      ul.tabnav li { *width: 19.3%; }
      .border { *width: 95.8%; }

    </style>

    <script type="text/javascript" src="../js_cit_v3/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="../js_cit_v3/breadcrumb.js"></script>  
    <script type="text/javascript" src="../js_cit_v3/user.js"></script>  
    <script type="text/javascript" src="../js_cit_v3/tabnavigation.js"></script>  
  </head>

<body onload="/*splash(false);*/ setAllReadOnly();">

<div class="spms">

  <div class="header">Detalhe do utente</div>

  <div class="fixed-footer">
    <input type="button" class="spms-toolbar-button right" value="Fechar" onclick="self.close();" />
  </div>
   
  <c:forEach var="Row" items="${bindings.DetalheUtente.rangeSet}">
  <div class="container">

    <div class="row">
      <div class="col-1"> 
        <div class="subtitle">DADOS PESSOAIS</div>
      </div>
    </div>

    <div class="row">

      <div class="col-1-4"> 
        <div class="labelfield">Nº utente</div> 
        <div class="displayfield"><c:out value="${Row.Nir}"/></div> 
      </div>

      <div class="col-3-4" style="*width: 70%"> 
        <div class="labelfield">Nome</div> 
        <div class="displayfield"><c:out value="${Row.NomeCompleto}"/></div> 
      </div>

    </div>

    <div class="row">

      <div class="col-1-4"> 
        <div class="labelfield">Data de Nascimento</div> 
        <div class="displayfield"><c:out value="${Row.DataNasc}"/></div> 
      </div>

      <div class="col-1-4"> 
        <div class="labelfield">Sexo</div> 
          <div class="displayfield">
              <c:choose>
                  <c:when test="${Row.Sexo eq 'M'}"> Masculino </c:when>
                  <c:when test="${Row.Sexo eq 'F'}"> Feminino </c:when>
                  <c:otherwise> Indeterminado </c:otherwise>
              </c:choose>
          </div> 
      </div>

      <div class="col-2-4" style="*width: 44%;"> 
        <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.Nacionalidade}:"/></div> 
        <div class="displayfield"><c:out value="${Row.Nacionalidade}"/></div> 
      </div>

    </div>

    <div class="row">

      <div class="col-1-4" style="*width: 24%;"> 
        <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.TipoBi}:"/></div> 
        <div class="displayfield"><c:out value="${Row.TipoBi}"/></div> 
      </div>

      <div class="col-1-4" style="*width: 22%;"> 
        <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.NDocIdent}:"/></div> 
        <div class="displayfield"><c:out value="${Row.NDocIdent}"/></div> 
      </div>

      <div class="col-1-4" style="*width: 22%;"> 
        <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.Nif}:"/></div> 
        <div class="displayfield"><c:out value="${Row.Nif}"/></div> 
      </div>

      <div class="col-1-4" style="*width: 25%;"> 
        <div class="labelfield"><c:out value="NISS:"/></div> 
        <div class="displayfield"><c:out value="${Row.Niss}"/></div> 
      </div>

    </div>





    <div id="tabcontainer" class="tabcontainer">
      <ul class="tabnav">
          <li><a href="#" onclick="" class="active">Inscrição</a></li>
          <li><a href="#" onclick="" class="inactive">Naturalidade</a></li>
          <li><a href="#" onclick="" class="inactive">Morada</a></li>
          <li><a href="#" onclick="" class="inactive">Benefícios</a></li>
          <li><a href="#" onclick="" class="inactive">Subsistemas</a></li>
      </ul>
    </div>

    <div class="border"></div>






    <!-- INSCRICAO -->
    <div id="" class="tabcontent active">

      <div class="row">

        <div class="col-3-4" style="*width: 70%;"> 
          <div class="labelfield">Centro saúde</div> 
          <div class="displayfield"><c:out value="${bindings.InscricaoActiva.SenUnidSaude}"/></div> 
        </div>

        <div class="col-1-4"> 
          <div class="labelfield">Data Inscrição</div> 
          <div class="displayfield"><c:out value="${bindings.InscricaoActiva.DtaInsc}"/></div> 
        </div>

      </div>

      <div class="row">
        <div class="col-1-1" style="*width: 96%;"> 
          <div class="labelfield">Tipo de Inscrição</div> 
          <div class="displayfield"><c:out value="${bindings.InscricaoActiva.ScgTipoinscr}"/></div> 
        </div>
      </div>

      <div class="row">

        <div class="col-1-4"> 
          <div class="labelfield">Médico</div> 
          <div class="displayfield"><c:out value="${bindings.InscricaoActiva.NumCedula}"/></div> 
        </div>

        <div class="col-3-4" style="*width: 70%;"> 
          <div class="labelfield">.</div> 
          <div class="displayfield"><c:out value="${bindings.InscricaoActiva.ProEquipaNome}"/></div> 
        </div>

      </div>

    </div>





    <!-- NATURALIDADE -->
    <div id="" class="tabcontent inactive">

       <div class="row">

        <div class="col-2-4" style="*width: 48%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.CPaisNat}:"/></div> 
          <div class="displayfield"><c:out value="${Row.CPaisNat}"/></div> 
        </div>

        <div class="col-2-4" style="*width: 48%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.DistritoNat}"/></div> 
          <div class="displayfield"><c:out value="${Row.DistritoNat}"/></div> 
        </div>

      </div>

      <div class="row">

        <div class="col-2-4" style="*width: 48%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.ConcelhoNat}:"/></div> 
          <div class="displayfield"><c:out value="${Row.ConcelhoNat}"/></div> 
        </div>

        <div class="col-2-4" style="*width: 48%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.FreguesiaNat}:"/></div> 
          <div class="displayfield"><c:out value="${Row.FreguesiaNat}"/></div> 
        </div>

      </div>

    </div>





    <!-- MORADA -->
    <div id="" class="tabcontent inactive">

      <div class="row">

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaVia}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaVia}"/></div> 
        </div>

        <div class="col-2-4" style="*width: 46%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaRua}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaRua}"/></div> 
        </div>

        <div class="col-1-4" style="*width: 23%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaEdificio}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaEdificio}"/></div> 
        </div>

      </div>

      <div class="row">

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaPorta}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaPorta}"/></div> 
        </div>

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaLugar}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaLugar}"/></div> 
        </div>

        <div class="col-2-4" style="*width: 44%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaLocal}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaLocal}"/></div> 
        </div>

      </div>

      <div class="row">

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaDistrito}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaDistrito}"/></div> 
        </div>

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaConcelho}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaConcelho}"/></div> 
        </div>

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.MoradaFreguesia}:"/></div> 
          <div class="displayfield"><c:out value="${Row.MoradaFreguesia}"/></div> 
        </div>

        <div class="col-1-8" style="*width: 8.5%;"> 
          <div class="labelfield" style="width: 100px;"><c:out value="${bindings.DetalheUtente.labels.CodPostal1}:"/></div> 
          <div class="displayfield"><c:out value="${Row.CodPostal1}"/></div> 
        </div>

        <div class="col-1-8" style="*width: 8.5%;"> 
          <div class="labelfield">.</div> 
          <div class="displayfield"><c:out value="${Row.CodPostal2}"/></div> 
        </div>

      </div>

      <div class="row">

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.CodPostalLocal}:"/></div> 
          <div class="displayfield"><c:out value="${Row.CodPostalLocal}"/></div> 
        </div>

        <div class="col-1-4"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.Telf}:"/></div> 
          <div class="displayfield"><c:out value="${Row.Telf}"/></div> 
        </div>

        <div class="col-2-4" style="*width: 44%;"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.Email}:"/></div> 
          <div class="displayfield"><c:out value="${Row.Email}"/></div> 
        </div>

      </div> 

    </div>






    <!-- BENEFICIOS -->
    <div id="" class="tabcontent inactive">

      <div class="row">

        <div class="col-3-5" style="*width: 54%;"> 
          <div class="labelfield">Regime Especial de Comparticipaçao de Medicamentos</div> 
          <div class="displayfield"><c:out value="${Row.BenefRecmDescr}"/></div> 
        </div>

        <div class="col-1-5"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.BenefRecmDtaIni}:"/></div> 
          <div class="displayfield"><c:out value="${Row.BenefRecmDtaIni}"/></div> 
        </div>

        <div class="col-1-5"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.BenefRecmDtaFim}:"/></div> 
          <div class="displayfield"><c:out value="${Row.BenefRecmDtaFim}"/></div> 
        </div>

      </div>

      <div class="row">

        <div class="col-3-5" style="*width: 54%;"> 
          <div class="labelfield">Isenção de Taxa Moderadora</div> 
          <div class="displayfield"><c:out value="${Row.BenefIsencaoDescr}"/></div> 
        </div>

        <div class="col-1-5"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.BenefIsencaoDtaIni}:"/></div> 
          <div class="displayfield"><c:out value="${Row.BenefIsencaoDtaIni}"/></div> 
        </div>

        <div class="col-1-5"> 
          <div class="labelfield"><c:out value="${bindings.DetalheUtente.labels.BenefIsencaoDtaFim}:"/></div> 
          <div class="displayfield"><c:out value="${Row.BenefIsencaoDtaFim}"/></div> 
        </div>

      </div>  

      <div class="row">
        <div class="col-1"> 
          <div class="subtitle">ISENÇÃO DE TAXA MODERADORA</div>
        </div>
      </div>

      <div class="row">
        <div class="col-1-1"> 

          <c:choose>
              <c:when test="${not empty bindings.ListaBeneficiosDoUtente.currentRow }">
              <table id="readOnlyTable" class="spms-table" cellpadding="0" cellspacing="0" border="1">
                  <!--<thead/>-->
                  <thead>
                    <tr class="head">
                      <th class="text"><span style="white-space: nowrap;"><c:out value="Motivo"/></span></th>
                      <th class="date"><span style="white-space: nowrap;"><c:out value="Dt. Início"/></span></th>
                      <th class="date last"><span style="white-space: nowrap;"><c:out value="Dt. Validade"/></span></th>
                    </tr>            
                  </thead>
                  <tbody>
                      
                      <c:forEach var="Row" items="${bindings.ListaBeneficiosDoUtente.rangeSet}" varStatus="lineListaBeneficios">    
                          <script type="text/javascript">
                              benefiosMedicacaoEspecial[countBeneficiosMedicacaoEspecial]='<c:out value="${Row.IduBenefUtId}"/>';
                              countBeneficiosMedicacaoEspecial++;
                          </script>
                      <c:choose>
                      <c:when test="${lineListaBeneficios.count % 2 != 0}">
                          <c:set var="classTR" value="even" />
                      </c:when>
                      <c:otherwise>
                          <c:set var="classTR" value="odd" />
                      </c:otherwise>
                      </c:choose>
                      <tr class="${classTR}">
                          <td class="text"><c:out value="${Row.Descr}"/></td>
                          <td class="date"><c:out value="${Row.DataIni}"/></td>
                          <td class="date last"><c:out value="${Row.DtaValidade}"/></td>
                      </tr>
                      </c:forEach>
                      <tr class="navigation">
                     </tr>
                  </tbody>
              </table>

               <table>
                <tbody>
                  <tr class="navigation">
                    <td colspan="3">
                      <jsp:include page="/com/navigationList.jsp" flush="true">
                        <jsp:param name="rangeBindingName" value="ListaBeneficiosDoUtente"/>                      
                        <jsp:param name="listaNumRowsName" value="idu.listaBeneficiosUtenteNumRows"/>
                        <jsp:param name="targetPageName" value="detalheUtente.do"/>
                      </jsp:include> 
                    </td>
                  </tr>
                </tbody>
              </table>

              </c:when>
              <c:otherwise>
                  <p><i>Sem registos de Outras Medicações Especiais</i></p>
              </c:otherwise>
          </c:choose>

        </div>  
      </div>  

  </div>




    <!-- SUBSISTEMAS -->
    <div id="" class="tabcontent inactive">

      <div class="row">
        <div class="col-1"> 
          <div class="subtitle">SUBSISTEMAS ASSOCIADOS AO UTENTE</div>
        </div>
      </div>

      <div class="row">

          <c:choose>
              <c:when test="${not empty bindings.ListaEntidadesUtente.currentRow }">
              <table id="readOnlyTable" class="spms-table" cellpadding="0" cellspacing="0" border="0">

                  <thead>
                      <tr class="head">
                          <th class="text"><span style="white-space: nowrap;"><c:out value="Ent. Resp."/></span></th>
                          <th class="text"><span style="white-space: nowrap;"><c:out value="Nº Benef."/></span></th>
                          <th class="text last"><span style="white-space: nowrap;"><c:out value="Validade"/></span></th>
                      </tr>
                  </thead>

                  <tbody>
                  <c:forEach var="Row" items="${bindings.ListaEntidadesUtente.rangeSet}" varStatus="lineListaSubsistemas">    
                      <c:choose>
                          <c:when test="${lineListaSubsistemas.count % 2 != 0}">
                              <c:set var="classTR" value="even" />
                          </c:when>
                          <c:otherwise>
                              <c:set var="classTR" value="odd" />
                          </c:otherwise>
                      </c:choose>
                      <tr class="${classTR}">
                        <td class="text"><c:out value="${Row.Designacao}"/></td>
                        <td class="text"><c:out value="${Row.Numbenef}"/></td>
                        <td class="date last"><c:out value="${Row.DtaVal}"/></td>
                     </tr> 
                  </c:forEach>
                 
                  </tbody>
              </table>
              <table>
                <tbody><tr class="navigation"><td colspan="4"></td></tr></tbody>
              </table>
              </c:when>
              <c:otherwise>
                  <p><i>Sem registos de Subsistemas</i></p>
              </c:otherwise>
          </c:choose>

      </div>

    </div>




  </c:forEach>
  </div><!--#END .container -->





</div><!--#END .spms -->

</body>
</html>