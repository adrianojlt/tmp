package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.InformacaoUtenteImpl;
import ora.pt.cons.igif.sics.common.ListaParametros;
import ora.pt.cons.igif.sics.common.ListaParametrosRow;
import ora.pt.cons.igif.sics.controller.misc.Git;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.controller.misc.SessionInfo;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.controller.v2.struts.actions.DataAction;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionErrors;


public class GitbaixasUtentePageController extends PageController {

    private static Logger log = Logger.getLogger(GitbaixasUtentePageController.class);
    
    public void prepareModel(LifecycleContext context) {
        try{
            DCIteratorBinding dciListas = (DCIteratorBinding) context.getBindingContainer().get("ListaBaixasIterator");
            ViewObject voListaBaixas = dciListas.getViewObject();
            HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
            
            //Gets the session associated with this "session". false because we do not want to create a new one
            HttpSession session = request.getSession(false);    
                
            DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject voInfUtente = dciInfUtil.getViewObject();
            InformacaoUtenteImpl voInfUtenteImpl = (InformacaoUtenteImpl)voInfUtente;  
            Row utenteInfRow = voInfUtente.getCurrentRow();
        
            //Check if we have selected the Utente
            if (!voInfUtenteImpl.isUtenteSelected()) {
                ActionErrors errors = new ActionErrors();
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)context;
                
                //Set Forward Action for when we select the Utente
                DCIteratorBinding dciListaParametros = (DCIteratorBinding) context.getBindingContainer().get("ListaParametrosIterator");
                ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();         
                
                //Executes Query to Get Baixa Forward Action
                voListaParametros.setPathForUrlsRedirectBaixa(); 
                voListaParametros.executeQuery(); //This Query must only return one value
                ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first(); 
                
                SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
                sessionInfo.setUrlRedirect(rowParametros.getValText());
                
                //Executes Query to pesquisa Uente Forward Action
                voListaParametros.setPathForUrlsRedirectPesquisaUtente();; 
                voListaParametros.executeQuery(); //This Query must only return one value
                rowParametros = (ListaParametrosRow)voListaParametros.first(); 
                
                //onGetUtente
                actionContext.setActionForward(rowParametros.getValText());
                actionContext.setActionErrors(errors);
                ((DataAction)actionContext.getAction()).saveErrors(actionContext);
                
                return;
            }
            
            // -- carregar entidades responsaveis para o utente
            Misc.runListaEntidadesResponsaveisUtentePub(context,"EPUB");
            
            String doRefresh = "Y";
             
            Enumeration en = request.getParameterNames();
            Object o = null;
            
            while ( en.hasMoreElements() ) {
                o = en.nextElement();
            
                if (o.toString().equalsIgnoreCase("event") || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0) {
                    if ( request.getParameter(o.toString()).toLowerCase().indexOf("rangechangelista") >= 0 
                         || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ) {
                        doRefresh = "N";
                    }
                }
                if (o.toString().equalsIgnoreCase("event")) {
                    if (request.getParameter(o.toString()).equalsIgnoreCase("selectBaixa")) {
                        doRefresh = "N";
                    }
                }
            }
            
            if (doRefresh.equalsIgnoreCase("Y")) {                
                voListaBaixas.clearCache();
                
                String utenteId = utenteInfRow.getAttribute("Idutente")!=null?utenteInfRow.getAttribute("Idutente").toString():null;
                 
                // Executes ListaBaixas query
                voListaBaixas.setNamedWhereClauseParam("idUtente",utenteId);
                voListaBaixas.executeQuery();
                
                // Has we are on the first iteration, there is no "Baixa" selected, so git.idBaixa is null and we do not execute the query
                session.setAttribute("git.idBaixa",null);
                    
                //Puts the number of returned rows on the Session to build SelectOnceChoice Rows Navigator
                session.setAttribute("git.listaBaixasNumRows", voListaBaixas.getRowCount());
            }
            
            //Verificar se se pode emitir baixas para este Utente
            Integer numEntidades = (Integer)session.getAttribute("infolistaEntidadesNumRows");
            Number numSegSocial = (Number)utenteInfRow.getAttribute("Numssocial");
            Number numUtente = (Number)utenteInfRow.getAttribute("Numutente");
            
            //Guardar entidade responsavel seleccionada no info utente
            String entRespSeleccionada;
            try {
                entRespSeleccionada = new String(request.getParameter("hiddenIEntidadeResponsavel"));
            }catch (Exception e) {
                entRespSeleccionada = new String("");
            }
            session.setAttribute("git.selectedEntidadeResponsavel",entRespSeleccionada);
            
            if ((numEntidades == 0 && numSegSocial == null) || numUtente == null) {
                if(session.getAttribute("isSAMCall") != null && session.getAttribute("isSAMCall").toString() == "S" &&
                    session.getAttribute("primeiraEntrada") !=null &&  session.getAttribute("primeiraEntrada").toString()=="S"){
                    session.setAttribute("primeiraEntrada", "N");
                }
                Misc.addMessage(context,"","Não é possivel emitir baixas!"+
                "\r \nPor favor, verifique os dados do utente no RNU. \n","",Misc.MSG_TYPE_WARNG);   
            }
            
            String warning = request.getParameter("warning")!=null ? request.getParameter("warning") : ""; 
            if(warning.length()>0){
                if(session.getAttribute("isSAMCall") != null && session.getAttribute("isSAMCall").toString() == "S" &&
                    session.getAttribute("primeiraEntrada") !=null && session.getAttribute("primeiraEntrada").toString()=="S"){
                    session.setAttribute("primeiraEntrada", "N");
                }
                Misc.addMessage(context,"","O contexto da operação foi alterado. Por favor tente de novo.","",Misc.MSG_TYPE_WARNG);
            }
            super.prepareModel(context);
            
        }catch (Exception e) {
            log.error(e);
            
            Misc.addMessage(context, "", "Erro inesperado!", e.getMessage(), Misc.MSG_TYPE_ERROR);
        }
    }

    
    public void onRangeChangeListaBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        HttpSession session = request.getSession(false);
        
        int selectedPos = 0;
        String navigationLinkButton;
        
        if (request.getParameter("nextRangeListaBaixas") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaBaixas"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaBaixas");
        
        // Controls the navigation on the ListBox
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
        
        //Resets the BaixaID
        session.setAttribute("git.idBaixa",null);
    }
    
    public void onRangeChangeListaItemsBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci       = (DCIteratorBinding) ctx.getBindingContainer().get("ListaItemsBaixasIterator");
        HttpServletRequest request  = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        int selectedPos = 0;
        String navigationLinkButton;   

        if (request.getParameter("nextRangeListaItemsBaixas") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaItemsBaixas"));
        }        
        navigationLinkButton = request.getParameter("event_RangeChangeListaItemsBaixas");
        
        // Controls the navigation on the ListBox
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
    }

    public void onSelectBaixa(PageLifecycleContext ctx) {
        DCIteratorBinding dci           = (DCIteratorBinding) ctx.getBindingContainer().get("ListaItemsBaixasIterator");
        HttpServletRequest request      = (HttpServletRequest) ctx.getEnvironment().getRequest();
        ViewObject voListaItemsBaixas   = dci.getViewObject(); 
        HttpSession session             = request.getSession(false);
        
        //Puts Item Id on Session
        Integer idBaixa = new Integer (request.getParameter("idBaixaSeleccionada"));
        session.setAttribute("git.idBaixa",idBaixa);
        
        //Executes ListaItemsBaixas query
        voListaItemsBaixas.setNamedWhereClauseParam("idBaixa",idBaixa);
        voListaItemsBaixas.executeQuery();

        //Puts the number of returned rows on the Session to build SelectOnceChoice Rows Navigator
        session.setAttribute("git.listaItemsBaixasNumRows", voListaItemsBaixas.getRowCount());     
    }
  
    public void onImprimirItemBaixa(PageLifecycleContext ctx) {
        try {
            HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
            String reportsGerados = "";
            
            Number idItemBaixa;
            try {
                idItemBaixa = new Number(request.getParameter("IdItemBaixa"));
            } catch (SQLException e) {
                log.error(e);
                idItemBaixa = null;
                throw e;
            }
            
            String codDoenca;
            codDoenca = new String(request.getParameter("selectedCodClassDoencaItemBaixa"));
            String tipoRegisto;
            tipoRegisto = new String(request.getParameter("hiddenCodTipoRegisto"));
            
            try {
                if (GitControllerComun.isBaixaForSegSocial(ctx,idItemBaixa)) {
                    reportsGerados = Git.generateReportLink(idItemBaixa.toString(),"SEGSOCIAL",ctx) +  ";"; 
                } else {
                    reportsGerados = Git.generateReportLink(idItemBaixa.toString(),"PUB",ctx) +  ";"; 
                }
                if (codDoenca.equals("DD") && tipoRegisto.equals("I")) {
                    reportsGerados = reportsGerados +  ";" + Git.generateReportLink(idItemBaixa.toString(),"MOD230",ctx); 
                }
                
            } catch (Exception e) {
                log.error(e);
                throw e;
            }
            
            request.setAttribute("git.reportsToPrint", reportsGerados);
            
        } catch(Exception e) {
            log.error(e);
            Misc.addMessage(ctx,"6401","Erro ao imprimir!", e.getMessage(),Misc.MSG_TYPE_ERROR);
        }
    }


}