package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.baixas.common.BaixasModule;
import ora.pt.cons.igif.sics.suporte.common.ModulosSuporteModule;
import ora.pt.cons.utils.date.DateUtils;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.controller.v2.struts.actions.DataAction;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;


public class GitedicaoAltaPageController extends PageController {

    private static Logger log = Logger.getLogger(GitedicaoAltaPageController.class);
    
    public void prepareModel(LifecycleContext context) {
        DCIteratorBinding dciGTIA = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericosIterator");
        ViewObject voListaCodigosGenericosGTIA = dciGTIA.getViewObject();
        DCIteratorBinding dciInfUtil2 = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtil2 = dciInfUtil2.getViewObject();
        
        HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
        String doRefresh = "Y";
        Enumeration en = request.getParameterNames();
        Object o = null;
        
        while (en.hasMoreElements()) {
            o = en.nextElement();
            if (o.toString().equalsIgnoreCase("event") || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0){
                if ( request.getParameter(o.toString()).toLowerCase().indexOf("rangechangelista") >= 0 
                     || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ){
                    doRefresh = "N";
                }
            }
        }
        
        if (doRefresh.equalsIgnoreCase("Y")) {                   
            //Entidades Responsaveis
            String utenteId = voInfUtil2.getCurrentRow().getAttribute("Idutente").toString();
            
            DCIteratorBinding dciEntResp = (DCIteratorBinding) context.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
            ViewObject voEntResp = dciEntResp.getViewObject();
            voEntResp.setNamedWhereClauseParam("idUtente", utenteId);
            voEntResp.executeQuery();
            voListaCodigosGenericosGTIA.clearCache();
            
            //Gets Suporte Module
            ModulosSuporteModule supModuleGTIA = (ModulosSuporteModule)voListaCodigosGenericosGTIA.getApplicationModule();        
            supModuleGTIA.listaCodigosGenericosExecutesQuery("GTIA");     
        }
        
        super.prepareModel(context);
    }
    
    public void onInsertAlta(PageLifecycleContext context) {
        HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
        HttpSession session = request.getSession(false);
        DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaItemsBaixasIterator");
        
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtilizadorIterator");
        ViewObject voInfUtente = dciInfUtil.getViewObject();
             
        /*
         * Parameters given by edicaoBaixa to insert a new baixa
         * 
         * dp-dalta        - Data Alta
         * selectTipoAlta  - Id do Tipo Alta
         * DataInicioTotal - Data de Inicio do Perido de Baixa
         * selectClassDoenca - Id da classficação de doenca
         * 
         * */ 
        
        Number idClassDoenca;
        String requestsObject;
        java.util.Date requestsDate;
        requestsDate = null;
        Date requesDateTemp;
        requesDateTemp = null;
        
        Date dataAlta;
        Date dataTermoLastItem;
        Number scgTipoAltaId;
        Date dataInicioPeridoBaixa;
        
        // Process ClassFicacao Doenca
        try {
            idClassDoenca = new Number(request.getParameter("selectClassDoenca"));
        } catch (SQLException e) {
            //If selectClassDoenca is null
            log.error(e);
            return;    
        }  
        //Process Data Inicio
        requestsObject  = request.getParameter("dp-dalta");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error("",e);
        }
        dataAlta = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Process Data Inicio
        requestsObject  = request.getParameter("DataInicioTotal");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(),DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error("",e);
        }
        dataInicioPeridoBaixa      = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
        
        //Process Data Termo Last Item
        requestsObject  = request.getParameter("hiddenLastItemDataTermo");
        try {
            requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
            requesDateTemp = new Date(d1);
        } catch (Exception e) {
            log.error("",e);
        }
        dataTermoLastItem = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp);
        
        // Process ClassFicacao Doenca
        try {
            scgTipoAltaId = new Number(request.getParameter("selectTipoAlta"));
        } catch (SQLException e) {
            //If selectClassDoenca is null
            log.error("",e);
            return;    
        }
         
        // Gets the Id of the selected Baixa
        Number idBaixa = null;
        
        try {
            idBaixa = new Number((Integer)session.getAttribute("git.idBaixa"));
        } catch (SQLException e) {
            log.error("",e);
        }
        
         //Get Id Centro Saude
         Number sysEntidadesId;
         try {
             sysEntidadesId = new Number(voInfUtente.getCurrentRow().getAttribute("CsId").toString());
         } catch (SQLException e) {
             //error - nao consegui obter num Profissional
             log.error("",e);
             System.out.println(voInfUtente.getCurrentRow().getAttribute("CsId"));
             sysEntidadesId = null;  
         }
         
         //Get ID Profissional
         Number proProfissidPessoalId;
         try {
             proProfissidPessoalId = new Number(voInfUtente.getCurrentRow().getAttribute("ProfissidPessoalId").toString());
         } catch (SQLException e) {
             //error - nao consegui obter num Profissional
             proProfissidPessoalId = null;
             log.error("",e);
         }
        
        //Obter Numero Episodio
        Number numEpisodio = GitControllerComun.getNumEpisodio(session);
        
        //Obter Modulo da Consulta
        Number idScgModulo = GitControllerComun.getScgModuloIg(context); 
       
        //Try to insert de information on the Fantastic Oracle DB :)              
        ViewObject voListaItemsBaixas = dci.getViewObject();
        BaixasModule baixasModule = (BaixasModule) voListaItemsBaixas.getApplicationModule();
        Integer result = baixasModule.insertNewAlta(idBaixa,scgTipoAltaId,dataAlta,dataInicioPeridoBaixa,dataTermoLastItem,sysEntidadesId,proProfissidPessoalId,idClassDoenca,numEpisodio,idScgModulo);
        
        //After insert, clear View Object Cache
        voListaItemsBaixas.clearCache();
        
        //For error handling
        ActionErrors errors = new ActionErrors();
        StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)context;
        
        switch (result.intValue()){
            //Success
            case  0:    actionContext.setActionForward("onSuccess");
                        break;
            //DataInicio is null
            case -1:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6301","Data Alta vazia"));
                        errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Alta não pode ser vazia"));
                        actionContext.setActionForward("onError");
                        break;
            //DataTermo is null
            case -2:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6302","Data Alta invalida"));
                        errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Alta não pode ser anterior a data de Inicio do periodo de Baixa"));
                        actionContext.setActionForward("onError");
                        break;
            //Data de incio Invalido
            case -5:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6305","Data Alta inválida"));
                        errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Alta tem que consecutiva com o Item de Baixa anterior."));
                        actionContext.setActionForward("onError");
                        break;
            //Data de incio Invalido
            case -6:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6306","Data Alta inválida"));
                        errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Alta não pode exceder a data de termo do último item por mais do que um dia."));
                        actionContext.setActionForward("onError");
                        break;
            
            default:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","63" + result.toString(),"Erro Grave"));
                        errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Erro na aplicação. Contactar Direcção Informática do Centro"));
                        actionContext.setActionForward("onError");
                        break;
        }
        
        actionContext.setActionErrors(errors);
        ((DataAction)actionContext.getAction()).saveErrors(actionContext);
    }

}
