package ora.pt.cons.igif.sics.controller.pub;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.InformacaoUtilizadorRowImpl;
import ora.pt.cons.igif.sics.RootAppModuleImpl;
import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.controller.misc.SessionInfo;
import ora.pt.cons.igif.sics.suporte.ModulosSuporteModuleImpl;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import org.apache.log4j.Logger;


public class IndexPageController extends PageController {
    
    private static Logger log = Logger.getLogger(IndexPageController.class);
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    
    private String appCode = null;
    private boolean isForSAM = false;
    
    public void prepareModel(LifecycleContext ctx) {    
        try{
            request = (HttpServletRequest)ctx.getEnvironment().getRequest();        
            response = (HttpServletResponse)ctx.getEnvironment().getResponse();
            session = request.getSession(false);
            
            if (request.getParameter("flowId") !=null && request.getParameter("flowId").equals("CIT_0001") ){
                isForSAM = true;
                return;
            }
            
            DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            vo.clearWhereState();
            vo.setNamedWhereClauseParam("username", request.getRemoteUser());
            
            SessionInfo si = (SessionInfo)session.getAttribute("sessionInfo");
            if(si!=null){
                this.appCode = si.getAppAplcCode();
            }
            vo.setNamedWhereClauseParam("appCode", appCode);
            vo.executeQuery();
            super.prepareModel(ctx);
        } catch(Exception e){
          log.error("",e);
          Misc.addMessage(ctx,"","erro no prepare model", e.getMessage(),Misc.MSG_TYPE_ERROR);  
        }
    }

    public void prepareRender(LifecycleContext ctx) {
        try{
        
            if (isForSAM) return;
            DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            // verificar se user detem mais que um perfil
            // se sim os perfis irao ser apresentados para escolha de um por parte do utilizador
            // caso o utilizador apenas detenha um perfil, esse sera associado a sua sessao automaticamente
             
            String flowId = request.getParameter("flowId");
            
            if(request.getSession(false).getAttribute("centroSaudeEscolhido")==null && flowId == null){
                if (vo.getEstimatedRowCount() == 1) {
                    setAtributosSessao(ctx, vo);
                    //Não é necessário excolher perfil
                     StringBuffer sb = new StringBuffer();
                     sb.append(request.getContextPath()).append("/git/baixasUtente.do?");
                     String url = response.encodeRedirectURL(sb.toString());
                     response.sendRedirect(url);
                } else {
                    if(request.getParameter("erro")!=null){
                        if(request.getParameter("erro").equalsIgnoreCase("true")){
                            Misc.addMessage(ctx,"","Para usar a aplicação terá de escolher um Centro de Saúde.","",Misc.MSG_TYPE_WARNG);
                        }
                    }
                }
            }
            dci = (DCIteratorBinding)ctx.getBindingContainer().get("OpcoesMenuUtilizadorIterator");
            vo = (ViewObjectImpl)dci.getViewObject();  
            if(request.getSession(false).getAttribute("pSessaoPerfilId") != null){
                vo.clearWhereState();
                vo.setNamedWhereClauseParam("perfil",request.getSession(false).getAttribute("pSessaoPerfilId"));
                vo.setMaxFetchSize(-1); 
                vo.executeQuery();
            } else {
                vo.setMaxFetchSize(0); 
            }
            super.prepareRender(ctx);
        } catch(Exception e){
          log.error("",e);
          Misc.addMessage(ctx,"","erro no prepare render", e.getMessage(),Misc.MSG_TYPE_ERROR);  
        }
    }
    
    public void onIntegrateSAMBaixas(PageLifecycleContext ctx) {
        try{
            onAddPerfil(ctx);
            
            // -- caso existam mensagens, devolve-os
            if (Misc.hasMessages(ctx)) {
                // session.setAttribute("hasErrors",true);
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext) ctx;
                actionContext.setActionForward("onError");
                return;
            }
            
            String nir = request.getParameter("nir");
            String event = "integrateSAMBaixas";
            StringBuffer sb = new StringBuffer();
            sb.append(request.getContextPath()).append("/idu/pesquisaUtente.do?");
            sb.append("nir=" + nir);
            sb.append("&event=" + event);
            String url = response.encodeRedirectURL(sb.toString());
            response.sendRedirect(url);
        } catch(Exception e){
            log.error("",e);
            Misc.addMessage(ctx,"","erro ao integrar SAM Baixas", e.getMessage(), Misc.MSG_TYPE_ERROR);  
        }
        
    }
    
    public void onAddPerfil(PageLifecycleContext ctx) {
        try{
            // -- adicionar perfil escolhido a sessao caso o centro saude nao tenha
            // -- ainda sido escolhido
            if(request.getSession(false).getAttribute("centroSaudeEscolhido")==null){
            
                // obter parametros escolhidos pelo operador
                String cSaudeEscolhido = request.getParameter("csaudeEscolhido");
                String perfilEscolhido = request.getParameter("perfilEscolhido");
                String cs       = request.getParameter("cs");
                String tinst    = request.getParameter("tinst") ;
                // -- se ambos nao forem null
                if(cSaudeEscolhido!=null || (cs!=null && tinst != null)){
                
                    DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
                    ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
                    vo.clearWhereState();
                    
                    // -- aplica filtro para o centro de saude escolhido pelo utilizador.
                    if(cs!=null && tinst != null){
                        RootAppModuleImpl rootAm = (RootAppModuleImpl) vo.getApplicationModule();   
                        cSaudeEscolhido = rootAm.getCSId(cs,tinst);
                        perfilEscolhido = null;
                    }
                    
                    if (cSaudeEscolhido != null) {
                        vo.setNamedWhereClauseParam("centrosaude", cSaudeEscolhido);
                        vo.setNamedWhereClauseParam("perfil", perfilEscolhido);
                        vo.setNamedWhereClauseParam("appCode", appCode);
                        vo.executeQuery();
                        
                        long numero = vo.getEstimatedRowCount();
                        if(numero == 0){
                            Misc.addMessage(ctx,"", "Perfil", "O utilizador não tem perfil de acesso para a entidade fornecida.", Misc.MSG_TYPE_ERROR);
                        }
                        
                        setAtributosSessao(ctx, vo);
                        StringBuffer sb = new StringBuffer();
                        sb.append(request.getContextPath()).append("/git/baixasUtente.do?");
                        String url = response.encodeRedirectURL(sb.toString());
                        response.sendRedirect(url);
                    } else {
                        Misc.addMessage(ctx,"", "Perfil", "Entidade fornecida inválida.", Misc.MSG_TYPE_ERROR);
                    }
                }
            }
        } catch(Exception e){
          log.error("",e);
          Misc.addMessage(ctx,"","erro ao adicionar perfil", e.getMessage(),Misc.MSG_TYPE_ERROR);  
        }
    }
    
    public void onRangeChangeInformacaoUtilizador(PageLifecycleContext ctx) {    
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
        int selectedPos = 0;
        String navigationLinkButton;   
        selectedPos = Integer.parseInt(request.getParameter("nextRangeInformacaoUtilizador"));
        navigationLinkButton = request.getParameter("linkButton");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);         
    }
    
    private void setAtributosSessao(LifecycleContext ctx, ViewObjectImpl intUView) {    
        try{
            // -- coloca em sessao centro de saude escolhido
            InformacaoUtilizadorRowImpl r = (InformacaoUtilizadorRowImpl)intUView.getCurrentRow();
            
            if (r==null) return;
            session.setAttribute("centroSaudeEscolhido",r.getCsId().toString());
            session.setAttribute("pSessaoDescricaoCentroSaude",r.getCsDesc().toString());
            session.setAttribute("pSessaoCodigoCentroSaude",r.getCodCs().toString());
            session.setAttribute("pSessaoNomeCliente",r.getNomeclin()!=null?r.getNomeclin().toString():"");
            session.setAttribute("pSessaoProfissidId",r.getProfId()!=null?r.getProfId().toString():"");
            session.setAttribute("pSessaoPerfilId",r.getPerfilId().toString());
            session.setAttribute("pUserId",r.getUserId().toString());
            session.setAttribute("pSessaoCodigoExtensoCentroSaude",r.getCodigoCs().toString());
            
            // -- obter ARSD do centro de saúde
            RootAppModuleImpl rootAM = (RootAppModuleImpl)intUView.getApplicationModule();
            ModulosSuporteModuleImpl ms = (ModulosSuporteModuleImpl)rootAM.getModulosSuporteModule();
            String[] arsd = ms.obtemARSDDaEntidade(r.getCsId().toString());
            if(arsd!=null){
                session.setAttribute("pSessaoARSD_id", arsd[0]);
                session.setAttribute("pSessaoARSD_codigo", arsd[1]);
                session.setAttribute("pSessaoARSD_designacao", arsd[2]);
            }
            
            log.debug("atributo 'centroSaudeEscolhido' = <" + session.getAttribute("centroSaudeEscolhido")!=null?session.getAttribute("centroSaudeEscolhido"):"" + ">" +
                      "atributo 'pSessaoDescricaoCentroSaude' = <" + session.getAttribute("pSessaoDescricaoCentroSaude")!=null?session.getAttribute("pSessaoDescricaoCentroSaude"):"" + ">" +
                      "atributo 'pSessaoCodigoCentroSaude' = <" + session.getAttribute("pSessaoCodigoCentroSaude")!=null?session.getAttribute("pSessaoCodigoCentroSaude"):"" + ">" +
                      "atributo 'pSessaoNomeCliente' = <" + session.getAttribute("pSessaoNomeCliente")!=null?session.getAttribute("pSessaoNomeCliente"):"" + ">" +
                      "atributo 'pSessaoProfissidId' = <" + session.getAttribute("pSessaoProfissidId")!=null?session.getAttribute("pSessaoProfissidId"):"" + ">" +
                      "atributo 'pSessaoPerfilId' = <" + session.getAttribute("pSessaoPerfilId")!=null?session.getAttribute("pSessaoPerfilId"):"" + ">" +
                      "atributo 'pUserId' = <" + session.getAttribute("pUserId")!=null?session.getAttribute("pUserId"):"" + ">" +
                      "atributo 'pSessaoCodigoExtensoCentroSaude' = <" + session.getAttribute("pSessaoCodigoExtensoCentroSaude")!=null?session.getAttribute("pSessaoCodigoExtensoCentroSaude"):"" + ">" +
                      "atributo 'pSessaoARSD_id' = <" + session.getAttribute("pSessaoARSD_id")!=null?session.getAttribute("pSessaoARSD_id"):"" + ">" +
                      "atributo 'pSessaoARSD_codigo' = <" + session.getAttribute("pSessaoARSD_codigo")!=null?session.getAttribute("pSessaoARSD_codigo"):"" + ">" +
                      "atributo 'pSessaoARSD_designacao' = <" + session.getAttribute("pSessaoARSD_designacao")!=null?session.getAttribute("pSessaoARSD_designacao"):"" + ">");
                      
        } catch(Exception e){
            log.error("",e);
            Misc.addMessage(ctx,"","erro ao inicializar atributos de sessao",e.getMessage(),Misc.MSG_TYPE_ERROR);
        }
    }
    
}
