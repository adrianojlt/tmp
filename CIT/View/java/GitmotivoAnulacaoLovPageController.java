package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import ora.pt.cons.igif.sics.baixas.common.BaixasModule;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.suporte.common.ModulosSuporteModule;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;



public class GitmotivoAnulacaoLovPageController extends PageController {
    
   private HttpServletRequest request;
    
    
    public void onGetNewUtente(PageLifecycleContext ctx) {
        Misc.goToNewPesquisaUtente(ctx,"BAIXAS");
    }
    
    private static Logger log = Logger.getLogger(GitmotivoAnulacaoLovPageController.class);
                
    public void prepareModel(LifecycleContext context) {    

        /* To execute View object os Annul types*/
        DCIteratorBinding dciGTAN = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericosIterator");
        ViewObject voListaCodigosGenericos = dciGTAN.getViewObject();
        ModulosSuporteModule supModuleGTAN = (ModulosSuporteModule)voListaCodigosGenericos.getApplicationModule();
        supModuleGTAN.listaCodigosGenericosExecutesQuery("GTAN");
        dciGTAN.setRefreshExpression("");
        
        super.prepareModel(context);
    }

    public void onAnnul(PageLifecycleContext ctx) {
        try  {
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaItemsBaixasIterator");
            ViewObject voListaItemsBaixas = dci.getViewObject(); 
            
            request = (HttpServletRequest) ctx.getEnvironment().getRequest();
            DCIteratorBinding dciInfUtil = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
            ViewObject voInfUtili = dciInfUtil.getViewObject();
            
            Number idItemBaixa;
            Number scgMotivoAnulacao;
        
            // Id Item Baixa to annul
            try {
                idItemBaixa = new Number(request.getParameter("hiddenidItemBaixa"));
            } catch (SQLException e) {
                return;
            }
        
            // Id Item Baixa to annul
            try {
                scgMotivoAnulacao = new Number(request.getParameter("radioIdMotivo"));
            } catch (SQLException e) {
                return;
            }
           
            //Get Id Centro Saude
            Number sysEntidadesId;
            try {
                sysEntidadesId = new Number(voInfUtili.getCurrentRow().getAttribute("CsId").toString());
            } catch (SQLException e) {
                // error - nao consegui obter um Profissional
                log.debug(voInfUtili.getCurrentRow().getAttribute("CsId"));
                log.error(e);
                sysEntidadesId = null;  
            }
            
            //Get ID Profissional
            Number proProfissidPessoalId;
            try {
                proProfissidPessoalId = new Number(voInfUtili.getCurrentRow().getAttribute("ProfissidPessoalId").toString());
            } catch (SQLException e) {
                // error - nao consegui obter num Profissional
                log.debug(voInfUtili.getCurrentRow().getAttribute("ProfId"));
                log.error(e);
                proProfissidPessoalId = null;
            }
    
            String requestsObject;
            requestsObject = request.getParameter("comentarioAnulacao");
            String comentarioAnulacao = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject));
            
            BaixasModule baixasModule = (BaixasModule) voListaItemsBaixas.getApplicationModule();
            Integer result = baixasModule.annulItemBaixa(idItemBaixa, scgMotivoAnulacao, comentarioAnulacao, sysEntidadesId, proProfissidPessoalId);
            
            //To Refresh the data on screen
            voListaItemsBaixas.clearCache();
            
            
            // ordem de registo de log de operacoes especiais
            // de salientar que o registo apenas será efectuado se o operador for de Administração das Baixas
            if(result == 0){
                registaOperEspLog(ctx, baixasModule, idItemBaixa, scgMotivoAnulacao, comentarioAnulacao);    
            }
           
        } catch (Exception ex)  {
          log.error("", ex);
          Misc.addMessage(ctx,"","Erro ao anular item baixa","Por favor tente novamente.",Misc.MSG_TYPE_ERROR);  
          request.setAttribute("Erro", "Erro");
          
        }
    }
    
    private void registaOperEspLog(PageLifecycleContext ctx, 
                                   BaixasModule baixasModule,
                                   Number idItemBaixa,
                                   Number scgMotivoAnulacao,
                                   String comentarioAnulacao){
        request  = (HttpServletRequest) ctx.getEnvironment().getRequest();
        // registar log de operacoes especiais
        // nota: apenas regista se estiver em modo de operador com perfil especial
        try {
            boolean gitAdmin = false;
            if (request.getParameter("gitAdmin") != null) {
                if (request.getParameter("gitAdmin").equalsIgnoreCase("true")) {
                    gitAdmin = true;
                }
            }
            if (gitAdmin) {
                Number idBaixa = new Number(0);
                // obter id da baixa
                try {
                    idBaixa = new Number(request.getParameter("hiddenidBaixa"));
                } catch (SQLException e) { 
                  log.error(e);
                  // não lanço erro, posteriormente será apenas registado o log se o idBaixa for > 0 
                }
                
                if ( 
                    idBaixa.intValue()>0 && idItemBaixa.intValue()>0              // baixa e item baixa > 0
                    && scgMotivoAnulacao.intValue()>0  ) {                        // motivo para anular escolhido
                  
                    // obter entidade a qual esta associado o operador e profissional que esta a efectuar a alteração
                    Number entidadeId = new Number(request.getSession(false).getAttribute("centroSaudeEscolhido")!=null ? request.getSession(false).getAttribute("centroSaudeEscolhido").toString() : "0");
                    Number profissionalId = new Number(request.getSession(false).getAttribute("pSessaoProfissidId")!=null ? request.getSession(false).getAttribute("pSessaoProfissidId").toString() : "0");
                    // regista log de operacoes
                    baixasModule.registaOperacoesLog(idBaixa,
                                                     idItemBaixa,
                                                     "AS", // código de anulação simples
                                                     scgMotivoAnulacao,
                                                     comentarioAnulacao,
                                                     entidadeId,
                                                     profissionalId,
                                                     true);
                }
            }
        } catch (Exception e) {
            // erro ao registar log operacoes
            log.error("", e);
            // nota: não lanço erro para não invalidar a operacao de anulacao
        }
    }
    
    public void onRangeChangeListaCodigosGenericos(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaCodigosGenericosIterator");
        request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        int selectedPos = 0;
        String navigationLinkButton;   
        
        if (request.getParameter("nextRangeListaCodigosGenericos") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaCodigosGenericos"));
        }
        
        navigationLinkButton = request.getParameter("event_RangeChangeListaCodigosGenericos");
        
        // Controls the navigation on the ListBox
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);         
    }

}
