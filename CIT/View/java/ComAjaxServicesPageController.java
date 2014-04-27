package ora.pt.cons.igif.sics.controller.com;

import java.io.PrintWriter;

import java.util.Collection;
import java.util.LinkedList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.utentes.IdentificacaoUtenteModuleImpl;
import ora.pt.cons.utils.date.DateUtils;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;


public class ComAjaxServicesPageController extends PageController {

    private static Logger log = Logger.getLogger(ComAjaxServicesPageController.class);
    
    private HttpServletRequest request = null;
    private HttpServletResponse response = null;
    private HttpSession session = null;
    
    // -- variavel para conter centro de saude de sessao do operador
    private String centroSaude = "";
    
    // -- ligação ao módulo de identificacao
    IdentificacaoUtenteModuleImpl amIdent = null;
    
    public void prepareModel(LifecycleContext context) {
        try{
            request = (HttpServletRequest) context.getEnvironment().getRequest();
            response = (HttpServletResponse) context.getEnvironment().getResponse();
            session = request.getSession(false);       
            
            
            response.addHeader("Cache-Control", "no-cache");
            response.addHeader("Cache-Control", "no-store");
            response.addHeader("Cache-Control", "must-revalidate");
                        
            centroSaude = session.getAttribute("centroSaudeEscolhido") == null ? "-1" : (String)session.getAttribute("centroSaudeEscolhido");
            
            // -- dar ordem de nao carregamento de view
            // nota: as view serão carregadas apenas qdo necessárias
            // obter ligacao à imlementacao do modulo de identificacao
            
            DCIteratorBinding dci = (DCIteratorBinding)context.getBindingContainer().get("ListaAgregadoFamiliarIterator");
            ViewObject vo = dci.getViewObject();
            amIdent = (IdentificacaoUtenteModuleImpl)vo.getApplicationModule();
            
            /*
            // ListaAgregadoFamiliarIterator (agregado de determinada família)
            vo.setMaxFetchSize(0);
            
            // ListaCodigosHierarquicosLovIterator (Distrito, Concelho e Freguesia)
            dci = (DCIteratorBinding)context.getBindingContainer().get("ListaCodigosHierarquicosLovIterator");
            vo = dci.getViewObject();
            vo.setMaxFetchSize(0);
            
            // DetalheFamiliaIterator
            dci = (DCIteratorBinding)context.getBindingContainer().get("ListaFamiliaIterator");
            vo = dci.getViewObject();
            vo.setMaxFetchSize(0);
            
            // DetalheFamiliaIterator
            dci = (DCIteratorBinding)context.getBindingContainer().get("DetalheFamiliaIterator");
            vo = dci.getViewObject();
            vo.setMaxFetchSize(0);
            
            // ListaCodigosGenericos1Iterator
            dci = (DCIteratorBinding)context.getBindingContainer().get("ListaCodigosGenericos1Iterator");
            vo = dci.getViewObject();
            vo.setMaxFetchSize(0);
            
            // ListaStatsSincronismoIterator
            dci = (DCIteratorBinding)context.getBindingContainer().get("ListaStatsSincronismoIterator");
            vo = dci.getViewObject();
            vo.setMaxFetchSize(0);
            */
            
        } catch(Exception ex){
          log.error("Erro no prepareModel", ex);
          Misc.addMessage(context,"as001","Erro no prepareModel",ex.getMessage(),Misc.MSG_TYPE_ERROR);
        }
        super.prepareModel(context);
    }
    
    public void onGitPesquisaUtenteBaixaFamiliar(PageLifecycleContext ctx) {
        
        String nirUtentePesquisa = request.getParameter("pNirUtente")!=null?request.getParameter("pNirUtente"):null;
        String nomeUtentePesquisa = request.getParameter("pNomeUtente")!=null?request.getParameter("pNomeUtente"):null;
        String dtaNascPesquisa = request.getParameter("pDtaNasc")!=null?request.getParameter("pDtaNasc"):null;
        String nissPesquisa = request.getParameter("pNiss")!=null?request.getParameter("pNiss"):null;
        
        DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
        ViewObjectImpl voListaUtentes = (ViewObjectImpl)dciListasUtentes.getViewObject();
        
        IdentificacaoUtenteModuleImpl am = (IdentificacaoUtenteModuleImpl) voListaUtentes.getApplicationModule();
        
        Collection params = new LinkedList();
        
        if (nirUtentePesquisa != null) {
            params.add(new Object[][]{{"Number","nir", nirUtentePesquisa }});
        }
        
        if (nissPesquisa != null) {
            params.add(new Object[][]{{"Number","niss", nissPesquisa }});
        }
        
        if (dtaNascPesquisa != null) {
            java.util.Date dt = null;
            try {
                dt = DateUtils.parseToDate(dtaNascPesquisa, DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            } catch (Exception e) {
              // TODO: propagar excepcao
            }
            params.add(new Object[][]{{"Date","dta_nasc",dt}});
        }
      
        if (nomeUtentePesquisa != null) {
            params.add(new Object[][]{{"String","nomes_proprios", nomeUtentePesquisa }});
        }
      
        int a = am.listaUtentesAddWhereClause(params, new Number(16));
        if(a==15){
            Misc.addMessage(ctx, "1", "Demasiados registos encontrados. Por favor redefina a sua pesquisa.", "", Misc.MSG_TYPE_WARNG);
        }
        
    }
    
    public void onGetDistConcFreg(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosHierarquicosLovIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            
            String idPaiCodHier = request.getParameter("pIdPaiCodHier")!=null?request.getParameter("pIdPaiCodHier"):"";
            String descricao = request.getParameter("pDescricao")!=null?request.getParameter("pDescricao"):"";
            
            vo.setWhereClause(null);
            vo.clearWhereState();
            
            int fetchsize = -1;
            if(idPaiCodHier.length()>0){
                vo.setWhereClause("SYS_COD_HIER_ID = " + idPaiCodHier);
                fetchsize = -1;
            }
            
            if(descricao.length()>0){
                if ( vo.getWhereClause() != null ) {
                    vo.setWhereClause(vo.getWhereClause() + " AND geral.NORMALIZA_NOME(DESCRICAO) like '%' || GERAL.NORMALIZA_NOME('" + descricao + "') || '%'");
                } else {
                    vo.setWhereClause(" geral.NORMALIZA_NOME(DESCRICAO) like '%' || GERAL.NORMALIZA_NOME('" + descricao + "') || '%'");
                }
                fetchsize = -1;
            }
            
            // apenas deixar escolher registos de distritos, concelhos e freguesias activos
            if ( vo.getWhereClause() != null ) {
                vo.setWhereClause(vo.getWhereClause() + " AND DATA_INACTIVO IS NULL ");
            } else {
                vo.setWhereClause("  DATA_INACTIVO IS NULL ");
            }
            
            if ( fetchsize == -1 && ( idPaiCodHier.length()==0 ) ) {
                if ( vo.getWhereClause() != null ) {
                    vo.setWhereClause(vo.getWhereClause() + " AND SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
                } else {
                    vo.setWhereClause("SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
                }
                
            }
            
            vo.clearCache();
            vo.setMaxFetchSize(fetchsize);
            vo.executeQuery();   
            // caso devolva mais que um registo limpa view object
            if(vo.getEstimatedRowCount()>1){
                vo.clearCache();
                vo.setMaxFetchSize(0);
            }
        
        } catch(Exception e){
          log.error("",e);
            try{
                PrintWriter out = response.getWriter();
                out.print("-1");
            } catch(Exception ex){}
        }
    }
    
    public void onGetAgregadoFamilia(PageLifecycleContext ctx) {
        try{
            String idFamilia = request.getParameter("pIdFamilia")!=null?request.getParameter("pIdFamilia"):"";
            amIdent.edicaoUtenteListaAgregadoFamiliarAddWhereClause(idFamilia);
        } catch(Exception e){
          log.error("Erro ao obter agregado de família",e);  
          try{
                PrintWriter out = response.getWriter();
                out.print("-1");
          } catch(Exception ex){}
        }
    }
    
    
    public void onGetDetalheFamilia(PageLifecycleContext ctx) {
        try{
            String idFamilia = request.getParameter("pIdFamilia")!=null?request.getParameter("pIdFamilia"):"";
            amIdent.detalheFamilia(idFamilia);
        } catch(Exception e){
          log.error("Erro ao obter agregado de família",e);
          try{
                PrintWriter out = response.getWriter();
                out.print("-1");
          } catch(Exception ex){} 
        }
    }
    
    public void onGetSelectedBoxParentescos(PageLifecycleContext ctx) throws Exception {
        try{
            // para a familia em causa obter parentescos já atribuidos
            String idFamilia = request.getParameter("pIdFamiliaEscolhido")!=null?request.getParameter("pIdFamiliaEscolhido"):"";
            log.debug("pIdFamiliaEscolhido = " + idFamilia);
            String[] grausAtribuidos =  amIdent.getParentescosAtribuidos(idFamilia);
            DCIteratorBinding  dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaCodigosGenericos1Iterator");
            ViewObject vo = dci.getViewObject();
            vo.clearCache();
            vo.setMaxFetchSize(-1);
            String whereClause = "TipoCodigo_codtipo IN ('PARE') AND ";
            whereClause = whereClause.concat("( tipocod_central = 'S' OR ( tipocod_central = 'N' AND scg_sys_entidades_id = " + centroSaude + ") ) ");
            whereClause = whereClause.concat(" and id not in ( ").concat(grausAtribuidos[0]).concat(")");
            vo.setWhereClause(whereClause);
            vo.setOrderByClause("CODIGO");
            vo.executeQuery();
            request.setAttribute("grausAtribuidosDesc",grausAtribuidos[1]);
        } catch(Exception e){
          log.error("Erro ao obter códigos genericos de parentescos", e);
          try{
                PrintWriter out = response.getWriter();
                out.print("-1");
          } catch(Exception ex){} 
        }
    }
    
    public void onRangeChangeListaAgregadoFamiliar(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaAgregadoFamiliarIterator");
            int selectedPos = 0;
            if ( request.getParameter("nextRangeListaAgregadoFamiliar") != null ) {
                selectedPos = Integer.parseInt(request.getParameter("nextRangeListaAgregadoFamiliar"));
            }
            String navigationLinkButton = request.getParameter("event_RangeChangeListaAgregadoFamiliar");
            Misc.navigateListBox(dci,selectedPos,navigationLinkButton);  
        } catch(Exception e){
            
        }
               
    }
    
    public void onRangeChangeListaFamilia(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaFamiliaIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        if (request.getParameter("nextRangeListaFamilia") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaFamilia"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaFamilia");
        Misc.navigateListBox(dci, selectedPos, navigationLinkButton);
    }
    
    
    public void onValidaNiss(PageLifecycleContext ctx) {
        String valido = "false";
        session.removeAttribute("gitPesquisaUtenteNissValido");
        try{          
            String niss = request.getParameter("niss")!=null?request.getParameter("niss"):"";
            if(niss.length()>0){
                boolean validNiss = amIdent.isValidNiss(niss);
                if (validNiss) {
                    valido = "true";
                } else {
                    valido = "false";
                }
            }
        } catch(Exception e){
          log.error(e);
          valido = "false";
        }
        session.setAttribute("gitPesquisaUtenteNissValido",valido);
    }
    
    
    public void onGetEntidadesResponsaveis(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dciEntResp = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
            String utenteId = request.getParameter("idUtente")!=null?request.getParameter("idUtente"):"";
            ViewObject voEntResp = dciEntResp.getViewObject();
            voEntResp.setNamedWhereClauseParam("idUtente",utenteId);
            //We only want the public entities
            //If the Utente doesn't have any, so we was social security
            voEntResp.setNamedWhereClauseParam("tipoEntidade","EPUB");
            voEntResp.executeQuery();
            
           if (voEntResp.getEstimatedRowCount()>1){
                Misc.addMessage(ctx,"2","O utente tem mais do que uma entidade responsável válida para a emissão do CIT, por favor, confirme a entidade responsável selecionada.","",Misc.MSG_TYPE_WARNG);
            }
           
        } catch(Exception e){
          log.error("Erro ao obter agregado de família",e);  
          try{
                PrintWriter out = response.getWriter();
                out.print("-1");
          } catch(Exception ex){}
        }
    }
    
    public void onGetDistConcFregParaCombos(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosHierarquicosCombosIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            vo.clearCache();
            String idPaiCodHier = request.getParameter("pIdPaiCodHier")!=null?request.getParameter("pIdPaiCodHier"):"";
            
            vo.setWhereClause(null);
            vo.clearWhereState();
            
            int fetchsize = -1;
            if(idPaiCodHier.length()>0){
                vo.setWhereClause("SYS_COD_HIER_ID = " + idPaiCodHier);
                fetchsize = -1;
            }
            
            // apenas deixar escolher registos de distritos, concelhos e freguesias activos
            if ( vo.getWhereClause() != null ) {
                vo.setWhereClause(vo.getWhereClause() + " AND DATA_INACTIVO IS NULL ");
            } else {
                vo.setWhereClause("  DATA_INACTIVO IS NULL ");
            }
            
            if ( fetchsize == -1 && ( idPaiCodHier.length()==0 ) ) {
                if ( vo.getWhereClause() != null ) {
                    vo.setWhereClause(vo.getWhereClause() + " AND SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
                } else {
                    vo.setWhereClause("SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'DIST' )");
                }
                
            }
            
            //vo.setNamedWhereClauseParam("bindDummy",1);
            vo.clearCache();
            vo.setMaxFetchSize(fetchsize);
            System.out.println(vo.getEstimatedRowCount());
            vo.executeQuery();   
        
        } catch(Exception e){
          log.error("",e);
            try{
                PrintWriter out = response.getWriter();
                out.print("-1");
            } catch(Exception ex){}
        }
        
    }
}
