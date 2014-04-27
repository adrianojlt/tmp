package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.suporte.common.ModulosSuporteModule;
import ora.pt.cons.igif.sics.utentes.ListaAgregadoFamiliarImpl;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;


public class pesquisaFamiliarLovPageController  extends PageController {
   
    private static Logger log = Logger.getLogger(GitmotivoAnulacaoLovPageController.class);
                
    public void prepareModel(LifecycleContext context) {    
        
        HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
        HttpSession session = request.getSession(false);

        //Obter graus de Parentesco
        DCIteratorBinding dciPARE = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos1IteratorPARE");
        ViewObject voListaCodigosGenericosPARE = dciPARE.getViewObject();                               
        
        voListaCodigosGenericosPARE.clearCache(); 
        ModulosSuporteModule supModule = (ModulosSuporteModule)voListaCodigosGenericosPARE.getApplicationModule();
        supModule.listaCodigosGenericos3CodTipExecutesQuery("PARC","O");
              
        dciPARE.setRefreshExpression("");
        
        //Obter id do Utente
        DCIteratorBinding dciInfUten = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtente = dciInfUten.getViewObject();
        //Get Id Utente
        Number iduIdentUtId;
        try {
            iduIdentUtId = new Number(voInfUtente.getCurrentRow().getAttribute("Idutente").toString());
            request.setAttribute("idUtenteSessao", iduIdentUtId);
        } catch (SQLException e) {
            //error - nao consegui obter Id do Utente
            log.error(e);
            iduIdentUtId = null;  
        }
         
        //Obter agregado Familiar
        DCIteratorBinding dciLisAgregFam= (DCIteratorBinding) context.getBindingContainer().get("ListaAgregadoFamiliarIterator");
        ListaAgregadoFamiliarImpl voLisAgregFam = (ListaAgregadoFamiliarImpl)dciLisAgregFam.getViewObject();

        try {
            voLisAgregFam.getListaAgregadoFamiliarWithIdUtente(iduIdentUtId.toString());
        } catch (Exception e) {
            log.error(e);
        }
        
        DCIteratorBinding dciIdAM = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos3IteratorIdAM");
        ViewObject voListaCodigosGenericosIdAM = dciIdAM.getViewObject();
        voListaCodigosGenericosIdAM.clearCache();
        
        Row idOutroParentescoRow = voListaCodigosGenericosIdAM.first();
        String idOutroParentescoString = (idOutroParentescoRow.getAttribute("Id")).toString();
        session.setAttribute("GitidOutroGrauParentesco",idOutroParentescoString);
         
        super.prepareModel(context);
    }
   
}
