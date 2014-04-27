package ora.pt.cons.igif.sics.controller;

//import ora.pt.cons.acss.rnu.web.tld.RNUTagSupport;
//import ora.pt.cons.acss.rnu.web.tld.RNUUtils;
import ora.pt.cons.igif.sics.InformacaoUtenteImpl;
import ora.pt.cons.igif.sics.controller.misc.Misc;

import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;

import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;

import org.apache.log4j.Logger;


public class PageController extends oracle.adf.controller.v2.lifecycle.PageController {
    
    private static Logger log = Logger.getLogger(PageController.class);
    
   // public PageController() {
    //}
    /*
    public void onNavigate(PageLifecycleContext ctx) {
        log.debug("entrou");
        try{
            RNUUtils rnuutils = RNUUtils.getInstance((StrutsPageLifecycleContext)ctx);
            rnuutils.handleNavigationEvent(RNUTagSupport.BINDING_SPEC_ADF10G);
        } catch(Exception e){
          log.error("", e);
          Misc.addMessage(ctx,"","erro ao navegar na tabela ",e.getMessage(),Misc.MSG_TYPE_ERROR);
        }
        log.debug("saiu");
    }
    */
    
    public void onRetirarUtenteSessao(PageLifecycleContext ctx) {
        log.debug("entrou onRetirarUtenteSessao");
        try{
            DCIteratorBinding dciInformacaoUtente = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject voInformacaoUtente = dciInformacaoUtente.getViewObject();
            
            /*vo.clearCache();
            vo.setMaxFetchSize(-1);
            vo.reset();*/
            //vo.removeCurrentRowFromCollection();
            //Clean ViewObject
            voInformacaoUtente.setNamedWhereClauseParam("idUtente",null);
            voInformacaoUtente.setNamedWhereClauseParam("idHistEntUtente",null);
            voInformacaoUtente.setNamedWhereClauseParam("numUtente",null);
            voInformacaoUtente.setNamedWhereClauseParam("numSSocial",null);
            voInformacaoUtente.setNamedWhereClauseParam("numBI",null);
            voInformacaoUtente.setNamedWhereClauseParam("nomeUtente",null);
            voInformacaoUtente.setNamedWhereClauseParam("dataNascimento",null);
            voInformacaoUtente.setNamedWhereClauseParam("Sexoutente",null);
            
            //vo.clearCache();
            //vo.setMaxFetchSize(-1);
            
            voInformacaoUtente.executeQuery();
        } catch(Exception e){
          log.error("", e);
          Misc.addMessage(ctx,"","erro ao retirar utente de sessão",e.getMessage(),Misc.MSG_TYPE_ERROR);
        }
        log.debug("saiu onRetirarUtenteSessao");
    }
    
    
    
}
