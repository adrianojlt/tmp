package ora.pt.cons.igif.sics.controller.idu;

import javax.servlet.http.HttpServletRequest;

import ora.pt.cons.igif.sics.RootAppModuleImpl;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.utentes.IdentificacaoUtenteModuleImpl;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;

import org.apache.log4j.Logger;


public class ComdetalheUtentePageController extends PageController {
    
    private static Logger log = Logger.getLogger(ComdetalheUtentePageController.class);
    
    public void prepareModel(LifecycleContext ctx) {
        try {
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("DetalheUtenteIterator");
            ViewObject voDetalheUt = dci.getViewObject();
            HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        
            RootAppModuleImpl ram = (RootAppModuleImpl)voDetalheUt.getApplicationModule();
            IdentificacaoUtenteModuleImpl iam = (IdentificacaoUtenteModuleImpl)ram.getIdentificacaoUtenteModule();
    
            ViewObject vo = ram.getInformacaoUtente();
    
            String idUtente = request.getParameter("idUtente")!= null ? request.getParameter("idUtente") :  vo.getCurrentRow().getAttribute("Idutente").toString();  
            if(idUtente.length()>0){
                ram.detalheUtenteAddWhereClause(idUtente);
                iam.listaBeneficiosUtenteAddWhereClause(idUtente);
                request.setAttribute("idu.listaBeneficiosUtenteNumRows", iam.getListaBeneficiosDoUtente().getRowCount());        
                
                // -- estabelecer ligação ao módulo de identificação
                String idInscricao = iam.obtemIdInscricaoActiva(idUtente);
                if(idInscricao!=null && idInscricao.length()>0){
                    iam.edicaoUtenteInscricaoActivaAddWhereClause(idInscricao);
                } else {
                    Misc.clearIteratorAndEexecuteQuery(ctx,"InscricaoActivaIterator");
                }
                
                // -- carregar entidades responsaveis para o utente
                Misc.runListaEntidadesUtente(ctx);
            } else {
                Misc.clearIteratorAndEexecuteQuery(ctx,"DetalheUtenteIterator");
                Misc.clearIteratorAndEexecuteQuery(ctx,"InscricaoActivaIterator");
                Misc.clearIteratorAndEexecuteQuery(ctx,"ListaBeneficiosDoUtenteIterator");
                Misc.clearIteratorAndEexecuteQuery(ctx,"ListaEntidadesResponsaveisIterator");
            }
            super.prepareModel(ctx);
            
        } catch (Exception e) {
          log.error(e);
          Misc.addMessage(ctx,"","ocorreu erro imprevisto", e.getMessage(), Misc.MSG_TYPE_ERROR);
        }       
    }
    
    public void onRangeChangeListaBeneficiosDoUtente(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaBeneficiosDoUtenteIterator");
        HttpServletRequest request = (HttpServletRequest)ctx.getEnvironment().getRequest();
        int selectedPos = 0;
        String navigationLinkButton;
        if (request.getParameter("nextRangeListaBeneficiosDoUtente") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaBeneficiosDoUtente"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaBeneficiosDoUtente");
        Misc.navigateListBox(dci, selectedPos, navigationLinkButton);
    }    
    
    /*
    public void onAlterar(PageLifecycleContext ctx){
        
        DCIteratorBinding dciInfUten        = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
        InformacaoUtente voInfUtente        = (InformacaoUtente)dciInfUten.getViewObject();
        DCIteratorBinding dciDetUtente       = (DCIteratorBinding) ctx.getBindingContainer().get("DetalheUtenteIterator");
        DetalheUtenteImpl voDetUtente        = (DetalheUtenteImpl)dciDetUtente.getViewObject();
        
        //Get NumBeneficiário
        HttpServletRequest request      = (HttpServletRequest) ctx.getEnvironment().getRequest();
        String niss;
        Number nissNumber;
        // Process 
        try {
            niss = request.getParameter("nissUtente");
            nissNumber = new Number(niss);
        } catch (Exception e) {
            log.error(e);
            niss = null;
            nissNumber = null;
            Misc.addMessage(ctx,"6199","Niss inválido!","Niss introduzido é inválido!",Misc.MSG_TYPE_ERROR);
        }
        
        if(!Misc.hasErrors(ctx)){
            //Check if Niss is Valid
            RootAppModuleImpl               rootAppModule   = (RootAppModuleImpl) voInfUtente.getApplicationModule();
            IdentificacaoUtenteModuleImpl   identAppModule  = (IdentificacaoUtenteModuleImpl)rootAppModule.getIdentificacaoUtenteModule();
                        
            if (identAppModule.isValidNiss(niss)) {
                voInfUtente.updateNissUtente(nissNumber);
                
                DetalheUtenteRowImpl rowDetUtente = (DetalheUtenteRowImpl)voDetUtente.getCurrentRow();
                rowDetUtente.setNiss(nissNumber);
                voDetUtente.getDBTransaction().commit();
                Misc.addMessage(ctx,"","Niss modificado com sucesso!","",Misc.MSG_TYPE_SUCSS);
            } else {
                Misc.addMessage(ctx,"6199","Niss inválido!","Niss introduzido é inválido!",Misc.MSG_TYPE_ERROR);
            }
        }
    }
    */
}
