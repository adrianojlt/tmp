package ora.pt.cons.igif.sics.controller.idu;

import javax.servlet.http.HttpServletRequest;

import ora.pt.cons.igif.sics.controller.misc.Misc;

import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;


public class IducodHierLovPageController extends PageController {
    
    public void onSearch(PageLifecycleContext ctx) {
    
        DCIteratorBinding dciListaCodigosHierarquicosLov = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosHierarquicosLovIterator");
        ViewObject voListaCodigosHierarquicosLov = dciListaCodigosHierarquicosLov.getViewObject();
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
    
        int fetchsize = -1;
        voListaCodigosHierarquicosLov.setWhereClause(null);
        if ( request.getParameter("idPaiCodHier") != null )
        {
           if ( !request.getParameter("idPaiCodHier").equalsIgnoreCase("")
                && !request.getParameter("idPaiCodHier").equalsIgnoreCase("-1") ) {
                voListaCodigosHierarquicosLov.setWhereClause("SYS_COD_HIER_ID = "+ request.getParameter("idPaiCodHier"));
                fetchsize = -1;
            }
        }
        
        if ( request.getParameter("desc") != null && !request.getParameter("desc").equalsIgnoreCase("") ) {
            if ( voListaCodigosHierarquicosLov.getWhereClause() != null ) {
                voListaCodigosHierarquicosLov.setWhereClause(voListaCodigosHierarquicosLov.getWhereClause() + " AND geral.NORMALIZA_NOME(DESCRICAO) like '%' || GERAL.NORMALIZA_NOME('" + request.getParameter("desc") + "') || '%'");
            } else {
                voListaCodigosHierarquicosLov.setWhereClause(" geral.NORMALIZA_NOME(DESCRICAO) like '%' || GERAL.NORMALIZA_NOME('" + request.getParameter("desc") + "') || '%'");
                
            }
            fetchsize = -1;
        }
        
        // apenas deixar escolher registos de distritos, concelhos e freguesias activos
        if ( voListaCodigosHierarquicosLov.getWhereClause() != null ) {
            voListaCodigosHierarquicosLov.setWhereClause(voListaCodigosHierarquicosLov.getWhereClause() + " AND DATA_INACTIVO IS NULL ");
        } else {
            voListaCodigosHierarquicosLov.setWhereClause("  DATA_INACTIVO IS NULL ");
        }
        
        if ( fetchsize == -1 && ( request.getParameter("idPaiCodHier").equalsIgnoreCase("-1") || request.getParameter("idPaiCodHier").equalsIgnoreCase("") ) ) {
            if ( voListaCodigosHierarquicosLov.getWhereClause() != null ) {
                voListaCodigosHierarquicosLov.setWhereClause(voListaCodigosHierarquicosLov.getWhereClause() + " AND SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
            } else {
                voListaCodigosHierarquicosLov.setWhereClause("SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
            }
            
        }
        
        voListaCodigosHierarquicosLov.clearCache();
        voListaCodigosHierarquicosLov.setMaxFetchSize(fetchsize);
        voListaCodigosHierarquicosLov.executeQuery();
    }
    
    public void onRangeChangeListaCodigosHierarquicosLov(PageLifecycleContext ctx) {
        DCIteratorBinding dci       = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosHierarquicosLovIterator");
        HttpServletRequest request  = (HttpServletRequest) ctx.getEnvironment().getRequest();
        int selectedPos = 0;
        String navigationLinkButton;   
        if ( request.getParameter("nextRangeListaCodigosHierarquicosLov") != null ) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaCodigosHierarquicosLov"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaCodigosHierarquicosLov");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);         
    }

}
