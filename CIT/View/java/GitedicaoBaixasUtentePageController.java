package ora.pt.cons.igif.sics.controller.git;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.baixas.ListaHistBaixasRowImpl;
import ora.pt.cons.igif.sics.baixas.common.BaixasModule;
import ora.pt.cons.igif.sics.controller.misc.Misc;

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


public class GitedicaoBaixasUtentePageController extends PageController {
    
    private static Logger log = Logger.getLogger(GitedicaoBaixasUtentePageController.class);
    
    // variaveis globais inicializadas no prepareModel 
    private String idUtente = null;
    private HttpServletRequest request = null;
    private HttpSession session = null;
    
    // variavel para guardar a primeira baixa e pesquisar items baixa por defeito
    private String pIdHistBaixa = "0";
    
    // variaveis globais para controlo de carregamento de iteradores apenas se necessário
    private boolean refreshEntidadesResponsaveis = true;
    private boolean refreshListaHistBaixas = true;
    private boolean refreshHistItemsBaixas = true;
    private boolean refreshListaOperacoesLog = true;
    private boolean executaPrepareRender = true;
    
    
    public void onGetNewUtente(PageLifecycleContext ctx) {
        Misc.goToNewPesquisaUtente(ctx,"BAIXAS");
    }
    
    public void prepareRender(LifecycleContext context) {
        if(executaPrepareRender){
            // prepare ViewObject da Lista de Operacoes de Log
            prepareViewObjectListaOperacoesLog(context);
        
            // prepare ViewObject da Lista de Entidades Responsaveis
            prepareViewObjectListaEntidadesResponsaveis(context);
            
            // prepare ViewObject da Lista de Baixas
            prepareViewObjectListaHistBaixas(context);
            
            // prepare ViewObject da Lista de Items Baixas
            prepareViewObjectListaHistItemsBaixas(context);
        }
        super.prepareRender(context);
    }
    
    public void prepareModel(LifecycleContext context) { 
        // ViewObject InformacaoUtente
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtente = dciInfUtil.getViewObject();
        // ao entrar no módulo caso o utente nao tenha sido escolhido direcciona para a pagina de pesquisaUtente.do
        Row utenteInfRow = voInfUtente.getCurrentRow();
        if (utenteInfRow == null) {
            StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)context;
             actionContext.setActionForward("onGetUtente");
            ((DataAction)actionContext.getAction()).saveErrors(actionContext);
            executaPrepareRender = false;
            return;
        }
        // inicializar HttpServletRequest e HttpSession
        request = (HttpServletRequest) context.getEnvironment().getRequest();
        session = request.getSession(false);
        
        // inicializar idUtente seleccionado
        idUtente = utenteInfRow.getAttribute("Idutente") != null ? utenteInfRow.getAttribute("Idutente").toString() : null;
        
        super.prepareModel(context);
    }
    
    // obter items de uma baixa apartir da baixa seleccionada
    public void onSelectBaixa(PageLifecycleContext ctx) {
        refreshListaHistBaixas = false;
    }
    
    // alterar tipo de registo de items baixa de Progorração p/ Inicial e Inicial p/ Progorração 
    // @descricao: 1. marcar como anulado o registo que se vai mudar de tipo
    //             2. inserir um novo registo com os mesmos dados à excepção do tipo (colocar tipo para a alteração pretendida)
    public void onAlterarItemBaixa(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaHistItemsBaixasIterator");
            ViewObject vo = dci.getViewObject(); 
            
            // obter baixa seleccionada na pagina
            Number idBaixa = new Number(request.getParameter("radioIdBaixa")!=null ? request.getParameter("radioIdBaixa").toString() : "0");
            log.debug("Id Baixa associada = " + idBaixa);
            
            // obter item baixa seleccionado na pagina
            Number idItemBaixa = new Number(request.getParameter("IdItemBaixa")!=null ? request.getParameter("IdItemBaixa").toString() : "0");
            log.debug("Item Baixa a alterar = " + idItemBaixa);
            
            // obter item baixa manual para anular no caso de alteração para inicial
            Number idItemBaixaAnularAltInicial = new Number(request.getParameter("IdItemBaixaAnularAltInicial")!=null ? request.getParameter("IdItemBaixaAnularAltInicial").toString() : "0");
            log.debug("Item Baixa a anular na alteração para inicial = " + idItemBaixaAnularAltInicial);
            
            // continua para alteração do registo apenas se existir baixa e item baixa seleccionados
            if(idBaixa.intValue()>0 && idItemBaixa.intValue()>0) {
                // obter entidade a qual esta associado o operador e profissional que esta a efectuar a alteração
                Number entidadeId = new Number(request.getSession(false).getAttribute("centroSaudeEscolhido")!=null ? request.getSession(false).getAttribute("centroSaudeEscolhido").toString() : "0");
                Number profissionalId = new Number(request.getSession(false).getAttribute("pSessaoProfissidId")!=null ? request.getSession(false).getAttribute("pSessaoProfissidId").toString() : "0");
                String comentarioAnulacao = "Anulação automática por alteração de tipo de registo.";
                
                BaixasModule baixasModule = (BaixasModule) vo.getApplicationModule();
                Number idMotivo = baixasModule.obtemId("GTAN", "8"); // 8 - codigo de 'Anulação Interna' p/ os Motivos de Anulação
                
                Number idNovoTipo = new Number();
                String tipoRegisto = request.getParameter("alterarTipoRegisto")!=null ? request.getParameter("alterarTipoRegisto"):"";
                if(tipoRegisto.equalsIgnoreCase("I")) {
                    idNovoTipo = baixasModule.obtemId("GTRG", "I"); // I - codigo de 'Inicial' p/ os Items Baixas
                } else if(tipoRegisto.equalsIgnoreCase("P")) {
                    idNovoTipo = baixasModule.obtemId("GTRG", "P"); // P - codigo de 'Prorrogação' p/ os Items Baixas
                }
                
                if(idNovoTipo.intValue()>0 && tipoRegisto.trim().length()>0) {
                    baixasModule.alteraTipoComBaseItemBaixa(idBaixa, idItemBaixa, idMotivo, comentarioAnulacao, entidadeId, profissionalId, idNovoTipo, tipoRegisto, idItemBaixaAnularAltInicial);
                }
            }
        } catch(Exception e){
          log.error(e);  
        }
    }
    
    private void prepareViewObjectListaHistBaixas(LifecycleContext context) {
        if(refreshListaHistBaixas){
            DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaHistBaixasIterator");
            ViewObject vo = dci.getViewObject();
            vo.clearCache();
            vo.setNamedWhereClauseParam("idUtente", idUtente);
            vo.executeQuery();
            
            // obter o primeiro registo para que por defeito fique seleccionado
            ListaHistBaixasRowImpl r = (ListaHistBaixasRowImpl)vo.getCurrentRow();
            pIdHistBaixa = "" + r.getId();
            log.debug("idHistBaixa:<"+pIdHistBaixa+">");
          
            // coloca valor de registos de baixas obtidos para informar paginador
            session.setAttribute("git.ad.listaHistBaixasNumRows", vo.getRowCount());
        }
    }
    
    private void prepareViewObjectListaHistItemsBaixas(LifecycleContext context) {
        if (refreshHistItemsBaixas) {
            String idBaixa = request.getParameter("radioIdBaixa")!=null ? request.getParameter("radioIdBaixa").toString() : "0";
            session.setAttribute("git.ad.idBaixa", idBaixa);
    
            DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaHistItemsBaixasIterator");
            ViewObject vo = dci.getViewObject(); 
            vo.setNamedWhereClauseParam("idBaixa", idBaixa);
            vo.executeQuery();
            
            // colocar em sessao o valor de items da baixa devolvidos para informar o paginador
            session.setAttribute("git.ad.listaHistItemsBaixasNumRows", vo.getRowCount());
        }
    }          
    
    private void prepareViewObjectListaOperacoesLog(LifecycleContext context) {
        if(refreshListaOperacoesLog){
            DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaOperacoesLogIterator");
            ViewObject vo = dci.getViewObject();
            vo.clearCache();
            // obter id baixa seleccionada
            String idBaixa = request.getParameter("radioIdBaixa")!=null ? request.getParameter("radioIdBaixa") : "-1";
            vo.setNamedWhereClauseParam("idBaixa", idBaixa);
            vo.executeQuery();
            // coloca valor de registos de log obtidos para informar paginador
            session.setAttribute("git.ad.listaOperacoesLogNumRows", vo.getRowCount());
            refreshListaHistBaixas = true;
        }
    }
    
    private void prepareViewObjectListaEntidadesResponsaveis(LifecycleContext context) {
        if(refreshEntidadesResponsaveis){
            DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
            ViewObject vo = dci.getViewObject();
            vo.setNamedWhereClauseParam("idUtente", idUtente);
            vo.setNamedWhereClauseParam("tipoEntidade","EPUB");
            vo.executeQuery();
            session.setAttribute("infolistaEntidadesNumRows", vo.getRowCount());
        }
    }
    
    // metodo para paginacao de Lista Historico de Baixas: ListaHistBaixas
    public void onRangeChangeListaHistBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaHistBaixasIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        log.debug("nextRangeListaHistBaixas:<"+request.getParameter("nextRangeListaHistBaixas")+">");
        if (request.getParameter("nextRangeListaHistBaixas") != null){
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaHistBaixas"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaHistBaixas");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
        
        refreshEntidadesResponsaveis = false;
        refreshListaHistBaixas = false;
        refreshHistItemsBaixas = false;
        refreshListaOperacoesLog = false;
    }
    
    // metodo para paginacao de Lista Historico de Items Baixas: ListaHistItemsBaixa
    public void onRangeChangeListaHistItemsBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaHistItemsBaixasIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        log.debug("nextRangeListaHistItemsBaixas:<"+request.getParameter("nextRangeListaHistItemsBaixas")+">");
        if (request.getParameter("nextRangeListaHistItemsBaixas") != null){
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaHistItemsBaixas"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaHistItemsBaixas");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
        refreshEntidadesResponsaveis = false;
        refreshListaHistBaixas = false;
        refreshHistItemsBaixas = false;
        refreshListaOperacoesLog = false;
    }
    
    // metodo para paginacao de Lista de Operacoes Log: ListaOperacoesLog
    public void onRangeChangeListaOperacoesLog(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaOperacoesLogIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        log.debug("nextRangeListaOperacoesLog:<"+request.getParameter("nextRangeListaOperacoesLog")+">");
        if (request.getParameter("nextRangeListaOperacoesLog") != null){
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaOperacoesLog"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaOperacoesLog");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
        refreshEntidadesResponsaveis = false;
        refreshListaHistBaixas = false;
        refreshHistItemsBaixas = false;
        refreshListaOperacoesLog = false;
    }
    
}
