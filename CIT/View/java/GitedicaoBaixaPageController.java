package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import java.text.SimpleDateFormat;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.InformacaoUtenteRowImpl;
import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.baixas.common.BaixasModule;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.suporte.common.ModulosSuporteModule;
import ora.pt.cons.igif.sics.utentes.ListaUtentesRowImpl;
import ora.pt.cons.utils.date.DateUtils;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.controller.v2.struts.actions.DataAction;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;


public class GitedicaoBaixaPageController extends PageController {

    private static Logger log = Logger.getLogger(GitedicaoBaixaPageController.class);
            
    private Boolean assFamSelected;        
    private Number  assFamIdFamiliar;
    private String  assFamNomeFamiliar;
    private Number  assFamNissFamiliar;
    private Number  assFamNissFamiliarImpedido;
    private Date    assFamDtaNascFamiliar;
    private Number  assFamIdParentesco; 
    private Boolean assFamSelectedOutroParentesco;
    private String  assFamOutroParentesco;
    private Number  utenteInfoIduHistEntUtId;
    private String  utenteInfoNumBeneficiario;
    private Number  utenteInfonissUtente;
    private Number idClassDoenca;
    
    ActionErrors errors;
    StrutsPageLifecycleContext actionContext;
    
    public void prepareModel(LifecycleContext context) {
        try {
            
            DCIteratorBinding dciGCLD = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericosIteratorGCLD");
            ViewObject voListaCodigosGenericosGCLD = dciGCLD.getViewObject();
            DCIteratorBinding dciPARE = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos1IteratorPARE");
            ViewObject voListaCodigosGenericosPARE = dciPARE.getViewObject();                               
            DCIteratorBinding dciIdDF = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos2IteratorIdDF");
            ViewObject voListaCodigosGenericosIdDF = dciIdDF.getViewObject();
            DCIteratorBinding dciIdAM = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos3IteratorIdAM");
            ViewObject voListaCodigosGenericosIdAM = dciIdAM.getViewObject();
            DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject voInfUtente = dciInfUtil.getViewObject();
        
            HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
            HttpSession session = request.getSession(false);
            System.out.println(request.getParameter("hiddenIEntidadeResponsavel"));
            
            String doRefresh = "Y";
            Enumeration en = request.getParameterNames();
            Object o = null;
            
            while ( en.hasMoreElements() ) {
                o = en.nextElement();
                if ( o.toString().equalsIgnoreCase("event") || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ) {
                    if ( request.getParameter(o.toString()).toLowerCase().indexOf("rangechangelista") >= 0 
                                                           || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ) {
                        doRefresh = "N";
                    }
                }
            }
            
            // Is not an action of changing the range of Iterator
            if ( doRefresh.equalsIgnoreCase("Y") ) {   
            
                String pubEntity = request.getParameter("entidadePublica")!=null?request.getParameter("entidadePublica"):"";
                String utenteId = request.getParameter("iduIdentUt")!=null?request.getParameter("iduIdentUt"):voInfUtente.getCurrentRow().getAttribute("Idutente").toString();
                
                DCIteratorBinding dciEntResp = (DCIteratorBinding) context.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
                ViewObject voEntResp = dciEntResp.getViewObject();
                voEntResp.setNamedWhereClauseParam("idUtente",utenteId);
                //We only want the public entities
                //If the Utente doesn't have any, so we was social security
                voEntResp.setNamedWhereClauseParam("tipoEntidade","EPUB");
                voEntResp.executeQuery();
                
                session.setAttribute("infolistaEntidadesNumRows", voEntResp.getRowCount());
                           
                //Get Id Centro Saude
                // @ruimoura: alterado para obter o centro de saude escolhido em sessao
                Integer centroSaudeId;
                centroSaudeId = request.getSession(false).getAttribute("centroSaudeEscolhido")!= null ? Integer.parseInt((String)request.getSession(false).getAttribute("centroSaudeEscolhido")) : 0;
                         
                voListaCodigosGenericosGCLD.clearCache();
                voListaCodigosGenericosPARE.clearCache();
                voListaCodigosGenericosIdDF.clearCache();
                voListaCodigosGenericosIdAM.clearCache();
                
                ModulosSuporteModule supModule = (ModulosSuporteModule)voListaCodigosGenericosPARE.getApplicationModule();
                //Get ID for Assistencia Familiares
                if (pubEntity.compareTo("EPUB") == 0) {
                    supModule = (ModulosSuporteModule)voListaCodigosGenericosIdDF.getApplicationModule();
                    supModule.listaCodigosGenericos2CodTipExecutesQuery("GITP","DF");
                    supModule.listaCodigosGenericos3CodTipExecutesQuery("GITP","AM");
                    
                    Row idAMRow = voListaCodigosGenericosIdAM.first();
                    String idAMString = (idAMRow.getAttribute("Id")).toString();
                    session.setAttribute("GitidAMAssistenciaFamiliar",idAMString);
                } else {
                    voListaCodigosGenericosIdAM.setMaxFetchSize(0);
                    supModule = (ModulosSuporteModule)voListaCodigosGenericosIdDF.getApplicationModule();
                    supModule.listaCodigosGenericos2CodTipExecutesQuery("GCLD","DF");
                }
                Row idDFRow = voListaCodigosGenericosIdDF.first();
                String idDFString = (idDFRow.getAttribute("Id")).toString();
                session.setAttribute("GitidDFAssistenciaFamiliar", idDFString);
                
                supModule.listaCodigosGenericos3CodTipExecutesQuery("PARC","O");
                Row idOutroParentescoRow = voListaCodigosGenericosIdAM.first();
                String idOutroParentescoString = (idOutroParentescoRow.getAttribute("Id")).toString();
                session.setAttribute("GitidOutroGrauParentesco", idOutroParentescoString);
                
                if (pubEntity.compareTo("EPUB") == 0)
                    supModule.listaCodigosGenericosExecutesQuery("GITP");
                else
                    supModule.listaCodigosGenericosExecutesQuery("GCLD");
                supModule.listaCodigosGenericos1ExecutesQuery("PARC");
                
            }
            
            Misc.runListaEntidadesResponsaveisUtentePub(context,"EPUB");
            
            // Little workaround to the query does not execute two times.
            // The refresh condition is RefreshCondition="${param['event'] != 'PageLoadEdicaoBaixa'}" on page Load, then we change it to null
            dciGCLD.setRefreshExpression("");
            dciPARE.setRefreshExpression("");
            dciIdAM.setRefreshExpression("");
            dciIdDF.setRefreshExpression("");
            
             super.prepareModel(context);
            
        } catch (Exception e){
            log.error(e);
            Misc.addMessage(context,"","Erro na aplicação. Contactar Direcção Informática do Centro","Erro na aplicação. Contactar Direcção Informática do Centro",Misc.MSG_TYPE_ERROR);      
        }
 
    }
    
            
    public void onRangeChangeListaBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        int selectedPos = 0;
        String navigationLinkButton;   
        
        if (request.getParameter("nextRangeListaBaixas") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaBaixas"));
        }
        
        navigationLinkButton = request.getParameter("event_RangeChangeListaBaixas");
        
        // Controls the navigation on the ListBox
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);         
    }
    
    
    private void getUtenteInfo(PageLifecycleContext ctx, HttpServletRequest request){
        try  {
            DCIteratorBinding dciInfUten = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject voInfUtente = dciInfUten.getViewObject();
            String requestsObject = null;
                
            requestsObject = request.getParameter("hiddenIduHistEntUtID")!=null?request.getParameter("hiddenIduHistEntUtID"):"";
            if(requestsObject.length()>0){
                utenteInfoIduHistEntUtId = new Number(requestsObject);
            } else {
                utenteInfoIduHistEntUtId = null;
            }
            
            requestsObject = request.getParameter("hiddenNumBeneficiario_form")!=null?request.getParameter("hiddenNumBeneficiario_form"):"";
            if(requestsObject.length()>0){
                utenteInfoNumBeneficiario = new String(requestsObject);
            } else {
                utenteInfoNumBeneficiario = null;
            }
            
            Row r = voInfUtente.getCurrentRow();
 //           requestsObject = null;
   //         requestsObject = request.getParameter("hiddenIsSam")!=null?request.getParameter("hiddenIsSam"):"";
            if(r!=null) {
                Object oNumSSocial = r.getAttribute("Numssocial");
                if(oNumSSocial!=null){
                    utenteInfonissUtente = new Number(oNumSSocial.toString());
                }
            } else {
               
                    utenteInfonissUtente = null;
                
            }
            
        } catch (Exception ex)  {
          log.error(ex);
          Misc.addMessage(ctx,"","Erro ao obter informação do utente",ex.getMessage(),Misc.MSG_TYPE_ERROR);      
        }
    }
    
    
    private void getAssistenciaFamiliarData (HttpServletRequest request, HttpSession session){
        String  requestsObject;
        String  nomeFamiliar;
        String  outroParentesco;
        String  selectedFamiliar;
        Boolean selectedAssistenciaFamilia = false;
        Boolean selectedOutroParentesco = false;
    
        Number idParentesco;
        Number idFamiliar;
        String idParentescoString = null;
        java.util.Date requestsDate;
        requestsDate = null;
        
        Number nissFamiliar;
        Number nissFamiliarImpedido;
        Date requesDateTemp;
        requesDateTemp = null;
        Date dataNasc;
        
        requestsObject = request.getParameter("inputFamiliarSelected");
        selectedFamiliar = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject));
        
        if (selectedFamiliar != null && selectedFamiliar.equals("selected")) {
            
            requestsObject = request.getParameter("inputFamiliarNome");
            nomeFamiliar = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject));
            requestsObject = request.getParameter("inputFamiliarOutroParentesco");
            outroParentesco = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject));
            
            //Process Data Nascimento
            requestsObject  = request.getParameter("inputFamiliarDtaNasc");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(),DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                log.error(e);
            }
            dataNasc = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp);
            
            //Process IdFamiliar
            requestsObject = request.getParameter("inputFamiliarId");
            try {
                idFamiliar = new Number(requestsObject);
            } catch (Exception e) {
                idFamiliar = null;
                log.error("",e);
            }
            
            //Process Niss
            requestsObject = request.getParameter("inputFamiliarNiss");
            try {
                nissFamiliar = new Number(requestsObject);
            } catch (Exception e) {
                nissFamiliar = null;
                log.error(e);
            }
            
            //Process Niss Familiar Impedido
            requestsObject = request.getParameter("inputnissFamiliarImpedido");
            try {
                nissFamiliarImpedido = new Number(requestsObject);
            } catch (Exception e) {
                nissFamiliarImpedido = null;
                log.error(e);
            }
            
            try {
                selectedAssistenciaFamilia = false;
                String idAssistenciaFamilia = (String) session.getAttribute("GitidDFAssistenciaFamiliar");
                selectedAssistenciaFamilia = selectedAssistenciaFamilia || idClassDoenca.toString().equals(idAssistenciaFamilia);
                idAssistenciaFamilia = (String) session.getAttribute("GitidAMAssistenciaFamiliar");
                selectedAssistenciaFamilia = selectedAssistenciaFamilia || idClassDoenca.toString().equals(idAssistenciaFamilia);
                
                idParentescoString = request.getParameter("inputFamiliarIdParentesco");
                if (selectedAssistenciaFamilia && !idParentescoString.equals("")) {
                    idParentesco = new Number(idParentescoString);
                } else {
                    idParentesco = null;
                }
                
            } catch (Exception e) {
                //If selectClassDoenca is not "Assistencia a familiares"
                selectedAssistenciaFamilia = false;
                idParentesco = null;
                idFamiliar   = null;
                log.error(e);
            }
            
            // Has selected Outro Parentesco?
            try {
                String idGitidOutroGrauParentesco = (String) session.getAttribute("GitidOutroGrauParentesco");
                selectedOutroParentesco = idGitidOutroGrauParentesco.equals(idParentescoString);
            } catch (Exception e) {
                //If selectClassDoenca is not "Assistencia a familiares"
                selectedOutroParentesco = false;
                idParentesco = null;
                log.error(e);
            }
           
            assFamSelected        = true; 
            
            assFamIdFamiliar      = idFamiliar;
            assFamNomeFamiliar    = nomeFamiliar;
            assFamNissFamiliar    = nissFamiliar;
            assFamDtaNascFamiliar = dataNasc;
            assFamNissFamiliarImpedido  = nissFamiliarImpedido;
            
            assFamIdParentesco    = idParentesco;
            assFamSelectedOutroParentesco   = selectedOutroParentesco;
            assFamOutroParentesco = outroParentesco;
            
        } else {
            assFamSelected = false;
        }
    }
    
    
    public void onInsertNewBaixa (PageLifecycleContext ctx) throws Exception{
    try{

        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
        DCIteratorBinding dciScgGCLD = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosGenericosIteratorGCLD");
        DCIteratorBinding dciScgPARE = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosGenericos1IteratorPARE");
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
        DCIteratorBinding dciInfUten = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtente = dciInfUten.getViewObject();
        
        
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
               
        HttpSession session = request.getSession(false);

        String requestsObject;
        java.util.Date requestsDate;
        requestsDate = null;
        Date requesDateTemp;
        requesDateTemp = null;

        Number  idBaixaAltaAberta;

        Date dataInicio;
        Date dataTermo;
        Date dataInicioLastBoletim;
        Date dataFimLastBoletim;
        String baixaManual;
        String novaBaixa;
        String entidadePublica;
        
        //Public Entity
        entidadePublica = request.getParameter("entidadePublica");
            
        // Process 
        try {
            requestsObject = request.getParameter("IdbaixaAltaAberta");
            if (requestsObject == null || requestsObject.compareTo("") == 0 ) {
                requestsObject = new String ("0");
            }
            idBaixaAltaAberta = new Number(requestsObject);
        } catch (SQLException e) {
            log.error(e);
            idBaixaAltaAberta = new Number(0);
        }
        
        // Process ClassFicacao Doenca
        try {
            idClassDoenca = new Number(request.getParameter("selectClassDoenca"));
        } catch (SQLException e) {
            log.error(e);
            return;    
        }
        
        //Process Familiar 
        getAssistenciaFamiliarData(request,session);
             
        //Process Data Inicio
        requestsObject  = request.getParameter("dp-dinicio");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error(e);
        }
        
        dataInicio = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Process Data Termo
        requestsObject  = request.getParameter("dp-dtermo");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error(e);
        }
        dataTermo = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Process Data Inicio Ultimo Boletim
        requestsObject = request.getParameter("DataInicioTotal");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error(e);
        }
        dataInicioLastBoletim = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Process Data Termo Ultimo Bole
        requestsObject = request.getParameter("hiddenLastItemDataTermo");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error(e);
        }
        dataFimLastBoletim = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Manual Baixa Item
        baixaManual = (request.getParameter("checkBaixaManual") != null ? new String("S") : new String("N"));
        
        //Opcoes de Item de Baixa
        GitControllerComun.opcoesItemBaixa(request,session);
   
         //Get Id Utente em sessao
         boolean utenteDiferente = false;
         Number iduIdentUtId = null;
         try {
            String idUtente = request.getParameter("iduIdentUt")!=null?request.getParameter("iduIdentUt"):"";
            if(idUtente.equalsIgnoreCase(voInfUtente.getCurrentRow().getAttribute("Idutente").toString())){
                iduIdentUtId = new Number(voInfUtente.getCurrentRow().getAttribute("Idutente").toString());
            } else {
                utenteDiferente = true;
            }
             
         } catch (SQLException e) {
             log.error(e);
             iduIdentUtId = null;  
         }
         
         // obter utente por request
        
        Number iduIdentUtDupId = null;
       
        //Get Id Centro Saude
        Number sysEntidadesId;
        ViewObject voInfUtili = dciInfUtil.getViewObject();
        try {
            sysEntidadesId = new Number(voInfUtili.getCurrentRow().getAttribute("CsId").toString());
        } catch (SQLException e) {
            log.error(e);
            sysEntidadesId = null;
        }
        
        //Get Utente Information
        getUtenteInfo(ctx,request);
        
        //Get ID Profissional
        Number proProfissidPessoalId;
        try {
            proProfissidPessoalId = new Number(voInfUtili.getCurrentRow().getAttribute("ProfissidPessoalId").toString());
        } catch (SQLException e) {
            log.error(e);
            proProfissidPessoalId = null;
        }
       
        //Process
        novaBaixa = request.getParameter("novaBaixa")!=null?request.getParameter("novaBaixa"):"";
        if(novaBaixa.length()>0 || utenteDiferente){
        
            ViewObject voListaBaixas = dci.getViewObject();
            ViewObject voscgGCLD = dciScgGCLD.getViewObject();
            ViewObject voscgPARE = dciScgPARE.getViewObject();
            
            //Try to insert de information on the Fantastic Oracle DB :)              
            BaixasModule baixasModule = (BaixasModule) voListaBaixas.getApplicationModule();
            
            //For error handling
            errors = new ActionErrors();
            actionContext = (StrutsPageLifecycleContext)ctx;
            
            //Obter Numero Episodio
            Number numEpisodio = GitControllerComun.getNumEpisodio(session);
            
            //Obter Modulo da Consulta
            Number idScgModulo = GitControllerComun.getScgModuloIg(ctx);
            
            //After insert, clear View Object Cache
            Integer result = 0;
            result = baixasModule.insertNewBaixa(novaBaixa,
                                                utenteInfoIduHistEntUtId,
                                                entidadePublica,
                                                iduIdentUtDupId,
                                                iduIdentUtId,
                                                utenteInfonissUtente,
                                                utenteInfoNumBeneficiario,
                                                assFamSelected,
                                                assFamNomeFamiliar,
                                                assFamDtaNascFamiliar,
                                                assFamNissFamiliar,
                                                assFamNissFamiliarImpedido,
                                                assFamIdFamiliar,
                                                assFamIdParentesco,
                                                assFamOutroParentesco,
                                                assFamSelectedOutroParentesco,
                                                sysEntidadesId,
                                                proProfissidPessoalId,
                                                dataInicio,
                                                dataTermo,
                                                dataInicioLastBoletim,
                                                dataFimLastBoletim,
                                                idClassDoenca,
                                                GitControllerComun.incapacidade,
                                                GitControllerComun.cuidadosInadiaveis,
                                                GitControllerComun.internamento,
                                                GitControllerComun.cirurgiaAmbulatorio,
                                                GitControllerComun.autorizacao,
                                                GitControllerComun.justificacao,
                                                idBaixaAltaAberta,
                                                baixaManual,
                                                numEpisodio,
                                                idScgModulo);
          
            voListaBaixas.clearCache();
            voscgGCLD.clearCache();
            voscgPARE.clearCache();
            
            processErrors(result,false);
            
            if(session.getAttribute("isSAMCall")!=null && session.getAttribute("isSAMCall").toString() == "S" && 
                session.getAttribute("primeiraEntrada")!=null && session.getAttribute("primeiraEntrada").toString()=="S")
            {
                session.setAttribute("primeiraEntrada", "N");
            }
             
            actionContext.setActionErrors(errors);
            ((DataAction)actionContext.getAction()).saveErrors(actionContext);
        } else {
                // redirect consulta baixas para obrigar a que o contexto seja reconstruido
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
                actionContext.setActionForward("onWarning");
        }
        
        } catch (Exception ex)  {
          log.error("",ex);
          Misc.addMessage(ctx,"","Erro ao inserir baixa",ex.getLocalizedMessage(),Misc.MSG_TYPE_ERROR);
        }
    }
    
    public void onUpdateItemBaixa (PageLifecycleContext ctx) {
        try  {
        
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
            DCIteratorBinding dciItems = (DCIteratorBinding) ctx.getBindingContainer().get("ListaItemsBaixasIterator");
            
            DCIteratorBinding dciScgGCLD = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosGenericosIteratorGCLD");
            DCIteratorBinding dciScgPARE = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosGenericos1IteratorPARE");
            
            DCIteratorBinding dciInfUtil = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
          
            HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
            HttpSession session = request.getSession(false);
            
            /*
             * Parameters given by edicaoBaixa to insert a new baixa
             *      novaBaixa           - yes/no    (Nova Baixa or Prorrogação)
             *      selectClassDoenca   - Id Classificacao Doenca
             *      inputFamiliar       - Nome Familiar
             *      selectParentesco    - Id Parentesco
             *      dp-dinicio          - Data Inicio Baixa
             *      dp-dtermo           - Data Termo Baixa
             *      
             *      incActProf          - Inc. Act. Prof.       (on/null)
             *      cuiIna              - Cuidados Inadiáveis   (on/null)
             *      internamento        - Internamento          (on/null)
             *      autorizacao         - Autorização           (on/null)
             *      justificacao        - Justificao            (on/null)
             *      IdItemBaixa         - Id do Item de Baixa para se fazer update
             * */
    
            String requestsObject;
            java.util.Date requestsDate;
            requestsDate = null;
            Date requesDateTemp;
            requesDateTemp = null;
    
            Date dataInicio;
            Date oldDataInicio;
            Date dataTermo;
            Date oldDataTermo;
            String tipoRegisto;
            String entidadePublica;
            
            Number idItemBaixa;
            Number idBaixa;
            
            String baixaManual;
            String novaBaixa;
    
            //Public Entity
            entidadePublica = request.getParameter("entidadePublica");
            
            //Type of register
            tipoRegisto = request.getParameter("hiddenCodTipoRegisto");
            
            // Process idItemBaixa
            try {
                idItemBaixa = new Number(request.getParameter("IdItemBaixa"));
            } catch (SQLException e) {
                log.error(e);
                idItemBaixa = null;
            }
            
            // Process idBaixa
            try {
                idBaixa = new Number(request.getParameter("idSelectedBaixa"));
            } catch (SQLException e) {
                log.error(e);
                idBaixa = null;
            }
            
            // Process ClassFicacao Doenca
            try {
                idClassDoenca = new Number(request.getParameter("selectClassDoenca"));
            } catch (SQLException e) {
                log.error(e);
                return; 
            }
            
            //Process Familiar 
            getAssistenciaFamiliarData(request,session);
            
            //Get Utente Information
            getUtenteInfo(ctx,request);
            //Process Data Inicio
            requestsObject  = request.getParameter("dp-dinicio");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                log.error(e);
            }
            dataInicio = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Process Data Inicio Original
            requestsObject = request.getParameter("old-dp-dinicio");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                log.error(e);
            }
            oldDataInicio = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Process Data Termo
            requestsObject  = request.getParameter("dp-dtermo");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                log.error(e);
            }
            dataTermo = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Manual Baixa Item
            baixaManual = (request.getParameter("checkBaixaManual") != null ? new String("S") : new String("N"));
            
            //Process Old Data Termo
            requestsObject = request.getParameter("old-dp-dtermo");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(),DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                log.error(e);
            }
            oldDataTermo = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Opcoes de Item de Baixa
            GitControllerComun.opcoesItemBaixa(request,session);
            
            ViewObject voInfUtili = dciInfUtil.getViewObject();
              
            //Get Id Centro Saude
            Number sysEntidadesId;
            try {
                sysEntidadesId = new Number(voInfUtili.getCurrentRow().getAttribute("CsId").toString());
            } catch (SQLException e) {
                log.error(e);
                //error nao consegui obter num Profissional
                System.out.println(voInfUtili.getCurrentRow().getAttribute("CsId"));
                sysEntidadesId = null;  
            }
             
            //Get ID Profissional
            Number proProfissidPessoalId;
            try {
                proProfissidPessoalId = new Number(voInfUtili.getCurrentRow().getAttribute("ProfissidPessoalId").toString());
            } catch (SQLException e) {
                log.error(e);
                proProfissidPessoalId = null;
                //error nao consegui obter num Profissional
            }
            
            //Process Nome Familia
            requestsObject = request.getParameter("novaBaixa");
            novaBaixa = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject));
            
            
            //Try to insert de information on the Fantastic Oracle DB :)              
            ViewObject voListaBaixas = dci.getViewObject();
            ViewObject voListaItemBaixas = dciItems.getViewObject();
            ViewObject voscgGCLD = dciScgGCLD.getViewObject();
            ViewObject voscgPARE = dciScgPARE.getViewObject();
            
            BaixasModule baixasModule = (BaixasModule) voListaBaixas.getApplicationModule();
            
            //Obter Numero Episodio
            Number numEpisodio = GitControllerComun.getNumEpisodio(session);
            
            //Obter Modulo da Consulta
            Number idScgModulo = GitControllerComun.getScgModuloIg(ctx);
                 
            // verificar de que módulo foi requerida a accao (git baixas ou admin baixas)
            String accao = request.getParameter("gitad")!=null?request.getParameter("gitad").toString():"";
            boolean admin = false;
            if(accao.equalsIgnoreCase("S")) {
                admin = true;
            }
                   
            // ver se operação foi requerida 
            Integer result;
            result = baixasModule.updateItemBaixa(idItemBaixa,
                                                  idBaixa,
                                                  assFamSelected,
                                                  assFamNomeFamiliar,
                                                  assFamDtaNascFamiliar,
                                                  assFamNissFamiliar,
                                                  assFamNissFamiliarImpedido,
                                                  assFamIdFamiliar,
                                                  assFamIdParentesco,
                                                  assFamOutroParentesco,
                                                  assFamSelectedOutroParentesco,
                                                  sysEntidadesId,
                                                  proProfissidPessoalId,
                                                  dataInicio,
                                                  oldDataInicio,
                                                  dataTermo,
                                                  oldDataTermo,
                                                  idClassDoenca,
                                                  GitControllerComun.incapacidade,
                                                  GitControllerComun.cuidadosInadiaveis,
                                                  GitControllerComun.internamento,
                                                  GitControllerComun.cirurgiaAmbulatorio,
                                                  GitControllerComun.autorizacao,
                                                  GitControllerComun.justificacao,
                                                  tipoRegisto,
                                                  entidadePublica,
                                                  baixaManual,
                                                  numEpisodio,
                                                  idScgModulo,
                                                  admin);
            
            //After insert, clear View Object Cache
            voListaBaixas.clearCache();
            voListaItemBaixas.clearCache();
            voscgGCLD.clearCache();
            voscgPARE.clearCache();
            
            //For error handling
            errors = new ActionErrors();
            actionContext = (StrutsPageLifecycleContext)ctx;
            
            processErrors(result,admin);
           
            actionContext.setActionErrors(errors);
            ((DataAction)actionContext.getAction()).saveErrors(actionContext);
        } catch (Exception ex)  {
          log.error("", ex);
          Misc.addMessage(ctx,"","Erro ao alterar item baixa",ex.getMessage(),Misc.MSG_TYPE_ERROR);      
        }
    }

    private void processErrors(Integer result,boolean admin) {
        switch (result.intValue()){
            //Success
            case  0:     // -- verificar se a alteração foi solicitada no módulo de administração ou no de git baixas e
                         // -- direccionar para o respectivo módulo
                         if(admin){
                            actionContext.setActionForward("onSuccessAdmin");
                         } else {
                            actionContext.setActionForward("onSuccess");
                         }
                         break;
            //DataInicio is null
            case -1:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6101","Data Início vazia"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Inicio não pode ser vazia"));
                         actionContext.setActionForward("onError");
                         break;
            //DataTermo is null
            case -2:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6102","Data Termo vazia"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Termo não pode ser vazia"));
                         actionContext.setActionForward("onError");
                         break;
            //Numero de dias Invalido
            case -3:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6103","Número de dias Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Nº de dias para uma Baixa Inicial não pode ser superior a 12."));
                         actionContext.setActionForward("onError");
                         break;
            //Numero de dias Invalido
            case -4:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6104","Número de dias Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Número de dias para uma Prorrogação não pode exceder os 30 dias"));
                         actionContext.setActionForward("onError");
                         break;
            //Data Inicio Invalida
            case -31:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6105","Data Início Inválida"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser superior  a 1 dia em relação à data actual."));
                         actionContext.setActionForward("onError");
                         break;
            //Data Inicio Invalida
            case -30:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6106","Data Início Inválida"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser inferior a 10 dias em relação à data actual."));
                         actionContext.setActionForward("onError");
                         break;
            //Justificacao nao atribuida
            case -7:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6107","Justificação não atribuida"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Por favor, preencha a Justificação de saída."));
                         actionContext.setActionForward("onError");
                         break;
            //Nome Familar nao atribuido quando selecionado assistencia a familiares
            case -8:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6108","Dados em falta"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Foi seleccionada a classificação Assistência a Familiares, mas não foi identificado o familiar doente. Por favor, pesquise pelo familiar."));
                         actionContext.setActionForward("onError");
                         break;
            case -9:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6109","Data Início/Data Termo"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser superior à Data Termo."));
                         actionContext.setActionForward("onError");
                         break;
            case -10:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6110","Data Início Inválida"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início já está incluída num Boletim de Baixa."));
                         actionContext.setActionForward("onError");
                         break;
            //Numero de dias Invalido
            case -11:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6111","Número de dias Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Número de dias para uma Baixa Inicial não pode exceder os 30 dias para um funcionário Público"));
                         actionContext.setActionForward("onError");
                         break;
            case -12:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6112","Parentesco não definido!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Grau de Parentesco é obrgatório quando seleccionado o grau \"Outro\""));
                         actionContext.setActionForward("onError");
                         break;
            case -13:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6113","Prorrogação Sobreposta"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","A alteração das datas, provoca que a progorração seguinte seja sobreposta"));
                         actionContext.setActionForward("onError");
                         break;
            case -14:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6114","Data Início/Data Termo"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Inicio não pode ser superior à Data Termo."));
                         actionContext.setActionForward("onError");
                         break;
            case -15:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6115","Niss Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Niss introduzido para familiar é inválido."));
                         actionContext.setActionForward("onError");
                         break;
            case -16:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6116","Niss Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Niss introduzido para familiar impedido é inválido."));
                         actionContext.setActionForward("onError");
                         break;
            case -17:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6117","Número de dias inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Em Assistência a familiares, não motivada por Internamento ou Cirurgia de Ambulatório,  o Nº de dias não pode ser superior a 30."));
                         actionContext.setActionForward("onError");
                         break;
            case -18:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6118","Número de dias inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Em Gravidez de Risco Clínico o Nº de dias tem de estar compreendido entre 1 e 300."));
                         actionContext.setActionForward("onError");
                         break;
            case -19:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6119","Número de dias inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Em Cód. Trabalho (Art.38º) o Nº de dias tem de estar compreendido entre 14 e 30."));
                         actionContext.setActionForward("onError");
                         break;                    
            case -20:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6121","Internamento e Cirurgia Ambulatorio!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Estas opções não podem ser seleccionadas em conjunto!"));
                         actionContext.setActionForward("onError");
                         break;                    
            case -21:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6121","Incapacitado seleccionado!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","A opção \"Incapacitado para Activ. Prof.\" não se aplica às classificações de doença \"Cód. Trabalho (Artº 38.º)\" e \"Gravidez de Risco Clínico\""));
                         actionContext.setActionForward("onError");
                         break;
            case -22:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6122","Cuidados Inadiáveis seleccionado!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","A opção \"Cuidados Inadiáveis\" não se aplica às classificações de doença \"Cód. Trabalho (Artº 38.º)\" e \"Gravidez de Risco Clínico\""));
                         actionContext.setActionForward("onError");
                         break;
            case -23:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6123","Necessário Incapacitado ou Cuidados Inadiáveis!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Necessario ter pelo menos uma das duas opções seleccionadas"));
                         actionContext.setActionForward("onError");
                         break;
            case -24:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6124","Porrogação inválida!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","As classificações de doença RC, IG e DF não podem ter porrrogações!"));
                         actionContext.setActionForward("onError");
                         break; 
            case -32:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6125","Número de dias Inválido!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Em Assistência a familiares, motivada por Internamento ou Cirurgia de Ambulatório,  o Nº de dias não pode ser superior a 999."));
                         actionContext.setActionForward("onError");
                         break; 
            //Data de inicio Invalido
            case -33:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6208","Data Início inválida"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ultrapassar a data de sistema em mais de 3 dias."));
                         actionContext.setActionForward("onError");
                         break;
            case -40:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6126","Número de dias Inválido!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Nº de dias para uma Baixa Inicial para uma Entidade Pública não pode ser superior a 30."));
                         actionContext.setActionForward("onError");
                         break; 
            case -42:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6127","Data Início/Data Termo!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Já existe registo de baixa para o período que pretende prescrever."));
                         actionContext.setActionForward("onError");
                         break; 
            case -20000: errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6128","Prescrição inválida!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Não é possível criar um novo Boletim. Utente tem Boletim sem Alta, por favor verifique boletins anteriores."));
                         actionContext.setActionForward("onError");
                         break; 
            case -20001: errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6129","Prescrição inválida!"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Não é possível criar a baixa. Utente já tem baixa para o período, por favor verifique baixas anteriores."));
                         actionContext.setActionForward("onError");
                         break; 
            //Numero de dias Invalido
            case -43:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6130","Número de dias Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Nº de dias para Assistência a Familiares não pode ser superior a 30."));
                         actionContext.setActionForward("onError");
                         break;
            //Numero de dias Invalido
            case -44:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6130","Número de dias Inválido"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser inferior a 30 dias em relação à data actual."));
                         actionContext.setActionForward("onError");
                         break;
            //Dados em Falta
            case -45:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6130","Dados em falta"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","O campo 'Data Nasc' é de preenchimento obrigatório, caso não seja preenchido o NISS."));
                         actionContext.setActionForward("onError");
                         break;
            //Niss do utente = niss do familiiar (ERES)
            case -47:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6131","Dados incorrectos"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","O NISS do utente é igual ao NISS do familiar doente. A SS poderá rejeitar as baixas nesta situação, pelo que, por favor, solicite a atualização dos dados dos utentes no RNU."));
                         errors.add(ActionErrors.GLOBAL_MESSAGE, new ActionError("warning.Mensagem","Caso o dado incorreto seja o NISS do familiar poderá através da opção “Pesquisar Familiar Doente > Inserção Manual” prosseguir o registo introduzindo os dados corretos do familiar manualmente."));
                         //Misc.addMessage(context,"","Caso o dado incorreto seja o NISS do familiar poderá através da opção “Pesquisar Familiar Doente > Inserção Manual” prosseguir o registo introduzindo os dados corretos do familiar manualmente.","",Misc.MSG_TYPE_WARNG); 
                         actionContext.setActionForward("onError");
                         break;
            default :    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","61" + result.toString(),"Erro Grave"));
                         errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Erro na aplicação. Contactar Direcção Informática do Centro"));
                         actionContext.setActionForward("onError");
                         break;
        } 
        
    }

    private void actualizaUtenteSessao(ViewObject voInfUtente, String idNovoUtente , LifecycleContext ctx) {
    
            InformacaoUtenteRowImpl newUtente = (InformacaoUtenteRowImpl)voInfUtente.getCurrentRow();
            DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
            ViewObjectImpl voInformacaoUtente = (ViewObjectImpl)dciListasUtentes.getViewObject();
           
         
           if(voInformacaoUtente.getWhereClause().contains("nir")){
                voInformacaoUtente.removeNamedWhereClauseParam("nir");
           }
           
        if(voInformacaoUtente.getWhereClause().contains("nomeToNormal")){
             voInformacaoUtente.removeNamedWhereClauseParam("nomeToNormal");
        }
           
            if(voInformacaoUtente.getWhereClause().contains("nome")){
                 voInformacaoUtente.removeNamedWhereClauseParam("nome");
            }
           
             if(voInformacaoUtente.getWhereClause().contains("niss")){
                  voInformacaoUtente.removeNamedWhereClauseParam("niss");
             } 
             
        if(voInformacaoUtente.getWhereClause().contains("dta_nasc")){
             voInformacaoUtente.removeNamedWhereClauseParam("dta_nasc");
        }
           
            voInformacaoUtente.setWhereClause("iiu_id="+idNovoUtente);
            voInformacaoUtente.clearCache();
            voInformacaoUtente.executeQuery();

            if(voInformacaoUtente.getFetchedRowCount() > 0){
                    Number idUtente;
                    Number idHistEntUtente;
                    Number nir;
                    Number niss;
                    String numId;
                    String nome;
                    java.util.Date dtaNasc;
                    
                    String sexoUtente;
                    ListaUtentesRowImpl rListaUtentes = (ListaUtentesRowImpl)voInformacaoUtente.first();
                   
                    idUtente = rListaUtentes.getIiuId();
                    newUtente.setIdutente(idUtente);
               
                    idHistEntUtente = rListaUtentes.getIheId();
                    newUtente.setIdhistentutente(idHistEntUtente);
             
                    nir = rListaUtentes.getNir();
                    newUtente.setNumutente(nir);
               
                    
                    niss = rListaUtentes.getNiss();
                    newUtente.setNumssocial(niss);
                    
               
                    numId = rListaUtentes.getNumId();
                    newUtente.setNumbi(numId);
                    
                    nome = rListaUtentes.getNomeCompleto();
                    newUtente.setNomeutente(nome);
                    newUtente.setNomenormalizado(nome);
                
                    dtaNasc = rListaUtentes.getDtaNasc().getValue();
                    String data = null;
                    if(dtaNasc!=null){
                        SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                        data =format.format(dtaNasc);
                    }
                    newUtente.setDatanascimento(data);
                    
                    sexoUtente = rListaUtentes.getSexoutente();
                    newUtente.setSexoutente(sexoUtente);
                    
                }
                        
    }
    
    
    public void onActualizaEcran (PageLifecycleContext context) {
    
        DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaBaixasIterator");
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtente = dciInfUtil.getViewObject();
        ViewObject voListaBaixas = dci.getViewObject();
        
        
        HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
        HttpSession session = request.getSession(false);


        System.out.println(request.getParameter("hiddenIEntidadeResponsavel"));  

        if(request.getParameter("hiddenIdUtenteParaTrocar")!=null
        && !request.getParameter("hiddenIdUtenteParaTrocar").trim().equals("")
        && request.getParameter("hiddenIdUtenteParaTrocar") != voInfUtente.getCurrentRow().getAttribute("Idutente") .toString() ) {
            // refresh Utente Sessao
            actualizaUtenteSessao(voInfUtente,request.getParameter("hiddenIdUtenteParaTrocar"),context );
            voListaBaixas.clearCache();
            voListaBaixas.setNamedWhereClauseParam("idUtente",request.getParameter("hiddenIdUtenteParaTrocar") );
            voListaBaixas.executeQuery();
        }
        
        //session.removeAttribute("isSAMCall");
        
        DCIteratorBinding dciEntResp = (DCIteratorBinding) context.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
        ViewObject voEntResp = dciEntResp.getViewObject();
        voEntResp.setNamedWhereClauseParam("idUtente",request.getParameter("hiddenIdUtenteParaTrocar"));
        //We only want the public entities
        //If the Utente doesn't have any, so we was social security
        voEntResp.setNamedWhereClauseParam("tipoEntidade","EPUB");
        voEntResp.executeQuery();
        
        session.setAttribute("infolistaEntidadesNumRows", voEntResp.getRowCount());
    
        Number numSegSocial = (Number)voInfUtente.getCurrentRow().getAttribute("Numssocial");
        Number numUtente = (Number)voInfUtente.getCurrentRow().getAttribute("Numutente");
        if ((numSegSocial == null && voEntResp.getFetchedRowCount() == 0) || numUtente == null) {
            Misc.addMessage(context,"","Não é possivel emitir baixas!","Utente não tem entidade responsável associada e/ou não tem número de utente associado, logo não é possível passar baixa.\n" + 
            "\n",Misc.MSG_TYPE_WARNG);   
        }
        
        if(session.getAttribute("isSAMCall")!=null && session.getAttribute("isSAMCall").toString() == "S" && 
            session.getAttribute("primeiraEntrada")!=null && session.getAttribute("primeiraEntrada").toString()=="S")
        {
            session.setAttribute("primeiraEntrada", "N");
        }
                    
    }
    
}


