package ora.pt.cons.igif.sics.controller.misc;

import java.io.BufferedInputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;

import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import ora.pt.cons.igif.sics.RootAppModuleImpl;
import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.common.ListaParametros;
import ora.pt.cons.igif.sics.common.ListaParametrosRow;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.struts.actions.DataAction;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;

import org.apache.log4j.Logger;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class Misc {
    
    private static Logger log = 
            Logger.getLogger(Misc.class);
            
    public static final byte MSG_TYPE_SUCSS = 0;
    public static final byte MSG_TYPE_ERROR = 1;
    public static final byte MSG_TYPE_INFOR = 2;
    public static final byte MSG_TYPE_WARNG = 3;    

    /*********************************************************
    * Adds ActionMessages and ActionErrors to the existing ActionContext
    *
     @param context     the current StrutsPageLifecycleContext to which messages will be added.
     @param msgCode     message Code. Ignored on Success Messages.
     @param msgText     summary information on the Message.
     @param msgDetail   detailed information on the Message. Ignored on Success Messages
     @param msgType     identifies the message type. (MSG_TYPE_SUCSS/MSG_TYPE_ERROR/MSG_TYPE_INFOR/MSG_TYPE_WARNG)
    *
    *
    *********************************************************/
    public static void addMessage(LifecycleContext context,String msgCode, String msgText, String msgDetail, byte msgType) {
        HttpServletRequest request = null;
        StrutsPageLifecycleContext actionContext = null;
        ActionMessages messages = null;
        ActionErrors   errors   = null;
        // Check for Message Type
        switch(msgType){
            // It's a Success ActionMessage
            case MSG_TYPE_SUCSS:
                request = (HttpServletRequest)context.getEnvironment().getRequest();            
                messages = new ActionMessages();
                if(request.getAttribute(Globals.MESSAGE_KEY) != null){
                    messages = (ActionMessages) request.getAttribute(Globals.MESSAGE_KEY);
                }
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("success.Codigo"));
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("success.Mensagem",msgText));
                request.setAttribute(Globals.MESSAGE_KEY, messages);
            break;
            // It's an ActionError
            case MSG_TYPE_ERROR:
                actionContext = (StrutsPageLifecycleContext)context;
                errors = new ActionErrors();
                if(actionContext.getActionErrors() != null){
                    errors = actionContext.getActionErrors();
                }
                errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo",msgCode,msgText));
                errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem",msgDetail));                
                actionContext.setActionErrors(errors);
                ((DataAction)actionContext.getAction()).saveErrors(actionContext);
            break;
            // TODOM It's a Information ActionMessage
            case MSG_TYPE_INFOR:
                request = (HttpServletRequest)context.getEnvironment().getRequest();            
                messages = new ActionMessages();
                if(request.getAttribute(Globals.MESSAGE_KEY) != null){
                    messages = (ActionMessages) request.getAttribute(Globals.MESSAGE_KEY);
                }
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("information.Codigo"));
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("information.Mensagem",msgText));
                request.setAttribute(Globals.MESSAGE_KEY, messages);
            break;
            // TODOM It's a Warning ActionMessage
            case MSG_TYPE_WARNG:
                request = (HttpServletRequest)context.getEnvironment().getRequest();            
                messages = new ActionMessages();
                if(request.getAttribute(Globals.MESSAGE_KEY) != null){
                    messages = (ActionMessages) request.getAttribute(Globals.MESSAGE_KEY);
                }
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("warning.Codigo"));
                messages.add(ActionMessages.GLOBAL_MESSAGE,new ActionMessage("warning.Mensagem",msgText));
                request.setAttribute(Globals.MESSAGE_KEY, messages);
            break;            
        }
    }
    
    /*********************************************************
    * return true if exists messages or errors on ActionContext object 
    * @param context     the current StrutsPageLifecycleContext to which messages will be added.
    *********************************************************/
    public static boolean hasMessages(LifecycleContext context){
        
        StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)context;
        if(actionContext.getActionErrors() != null){
            if(actionContext.getActionErrors().size()>0){
                return true;
            }
        }
        
        HttpServletRequest request = (HttpServletRequest)context.getEnvironment().getRequest(); 
        if(request.getAttribute(Globals.MESSAGE_KEY) != null){
            return true;
        }
        
        return false;
    }
    
    /*********************************************************
    * return true if exists errors on ActionContext object 
    * @param context     the current StrutsPageLifecycleContext to which messages will be added.
    *********************************************************/
    public static boolean hasErrors(LifecycleContext context){
        
        StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)context;
        if(actionContext.getActionErrors() != null){
            if(actionContext.getActionErrors().size()>0){
                return true;
            }
        }
        
        return false;
    }
    
    
    public static void navigateListBox(DCIteratorBinding iteratorBinding, int selectedPos, String navigationLinkButton){
        
        //Gets Iterator Range Size
        int rangeSize = 0;
        rangeSize = iteratorBinding.getRangeSize();
        
        //Calculate nextPos of Iterator 
        int nextPos = 0;
        nextPos = selectedPos * rangeSize;
        
        //If next Position is on the last rangeSet we need a little trick
        if ((nextPos + rangeSize) > iteratorBinding.getViewObject().getRowCount()) {
            nextPos = (selectedPos - 1) * rangeSize; 
            iteratorBinding.setRangeStart(nextPos);
            iteratorBinding.internalGetNextRangeSet();
        } else {
            iteratorBinding.setRangeStart(nextPos);
        }

        return; 
    }
    
    public static void runListaEntidadesResponsaveisUtentePub(LifecycleContext ctx, String tipoEntidade) throws Exception {
        try  {
            HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
            
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject vo = dci.getViewObject();
            Row utenteInfRow = vo.getCurrentRow();
            
            DCIteratorBinding dciEntResp = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
            ViewObject voEntResp = dciEntResp.getViewObject();
            
            if (utenteInfRow != null) {    
                String utenteId = utenteInfRow.getAttribute("Idutente").toString();
                if(utenteId.length()>0){
                    voEntResp.setNamedWhereClauseParam("idUtente", utenteId);
                    voEntResp.setNamedWhereClauseParam("tipoEntidade", tipoEntidade);
                    voEntResp.clearCache();
                    voEntResp.setMaxFetchSize(-1);
                    voEntResp.setWhereClause(" expirado = 'N' ");
                    voEntResp.executeQuery();
                    HttpSession session = request.getSession(false);
                    session.setAttribute("infolistaEntidadesNumRows", voEntResp.getRowCount());
                } else {
                    voEntResp.clearCache();
                    voEntResp.setMaxFetchSize(0);
                }   
            } else {
                voEntResp.clearCache();
                voEntResp.setMaxFetchSize(0);
            }
        } catch (Exception ex)  {
          throw new Exception ("erro ao obter subsistemas do utente.");
        }
    }
    
    public static void runListaEntidadesUtente(LifecycleContext ctx) throws Exception {
        try  {   
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject vo = dci.getViewObject();
            Row utenteInfRow = vo.getCurrentRow();
            
            DCIteratorBinding dciEntResp = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesUtenteIterator");
            ViewObject voEntResp = dciEntResp.getViewObject();
            
            if (utenteInfRow != null) {    
                String utenteId = utenteInfRow.getAttribute("Idutente").toString();
                if(utenteId.length()>0){
                    voEntResp.setNamedWhereClauseParam("idUtente", utenteId);
                    voEntResp.clearCache();
                    voEntResp.setMaxFetchSize(-1);
                    voEntResp.setWhereClause(" expirado = 'N' and sys_entidades_id not in (-1) ");
                    voEntResp.executeQuery();
                } else {
                    voEntResp.clearCache();
                    voEntResp.setMaxFetchSize(0);
                }   
            } else {
                voEntResp.clearCache();
                voEntResp.setMaxFetchSize(0);
            }
        } catch (Exception ex)  {
          throw new Exception ("erro ao obter subsistemas do utente.");
        }
    }
   
    public static void goToNewPesquisaUtente (LifecycleContext ctx, String origin) {
        HttpServletRequest request  = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        //Gets the session associated with this "session". false because we do not want to create a new one
        HttpSession session = request.getSession(false);    
            
        ActionErrors errors = new ActionErrors();
        StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
        
        //
        //Set Forward Action for when we select the Utente
        DCIteratorBinding dciListaParametros    = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
        ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();         
        
        //Executes Query to get Origin Forward Action
        if (origin.compareToIgnoreCase("BAIXAS") == 0) {
            voListaParametros.setPathForUrlsRedirectBaixa();     
        } else if (origin.compareToIgnoreCase("RECEITAS") == 0) {
            voListaParametros.setPathForUrlsRedirectReceitas();     
        } else {
            voListaParametros.setPathForUrlsRedirectPesquisaUtente();
        }
        voListaParametros.executeQuery(); //This Query must only return one value
        ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first(); 
        
        SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
        sessionInfo.setUrlRedirect(rowParametros.getValText());
        //
        //
        
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
    
    /* 
    * Retorna o Iterador Respectivo 
    * */
    public static DCIteratorBinding returnIterator(LifecycleContext ctx, String PageIterator){
        DCIteratorBinding dciIterator = (DCIteratorBinding) ctx.getBindingContainer().get(PageIterator);
        return dciIterator;
    }
    
    /* 
     * método para gerar .pdf de relatório de identificação do utente e devolver link para abertura do mesmo
     * */
    public static String genLinkImpressaoIdentificacaoUtente(String idUtente,
                                                             String idFuncionario,
                                                             String unidadeSaudeInscricao,
                                                             PageLifecycleContext ctx) throws Exception{
                                                             
        DCIteratorBinding dciListaParametros = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
        ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();      
        voListaParametros.setPathForReportServerUrl();
        voListaParametros.executeQuery();
        ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first(); 
        
        String urlLink = null;
        String reportsServerURL = rowParametros.getValText() + "?";
        
        voListaParametros.setPathForReportsIdentificacaoParam();
        voListaParametros.executeQuery();
        voListaParametros.setRangeSize(-1);
        Row[] rowParametrosVec = voListaParametros.getAllRowsInRange();
       
        String paramDestype          = null; 
        String paramUserId           = null; 
        String paramReport           = null; 
        String paramDesformat        = null;
        String paramDesname          = null; 
        String paramIdUtente         = null; 
        String paramStatusformat     = null; 
        String reportFileExtension   = null;
        String reportFileExtText     = null;
        String reportServerCacheUrl  = null;
        
        long numberRegs = rowParametrosVec.length;
        for (int i=0; i < numberRegs; i++) {
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_FORMAT") ) {
                paramDesformat = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_NAME") ) {
                paramDesname = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_TYPE") ) {
                paramDestype = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("PARAM_IDUUTENTE_ID") ) {
                paramIdUtente  = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT") ) {
                paramReport  = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("STATUSFORMAT") ) {
                paramStatusformat = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("USER_ID") ) {
                paramUserId = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_FILE_EXTENSION") ) {
                reportFileExtension = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_FILE_EXTENSION_TEXT") ) {
                reportFileExtText = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
            if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_SERVER_CACHE_URL") ) {
                reportServerCacheUrl = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
            }
        }
        
        if(numberRegs>0){
            try{
                urlLink = new String();
                urlLink = urlLink + reportsServerURL;
                urlLink = urlLink + "destype=" + paramDestype + "&";
                urlLink = urlLink + "userid=" + paramUserId + "&";
                urlLink = urlLink + "report=" + paramReport + "&";
                urlLink = urlLink + "desformat=" + paramDesformat + "&";
                urlLink = urlLink + "P_UTENTE=" + paramIdUtente + "&"; // id utente
                urlLink = urlLink + "P_FUNC=" + idFuncionario + "&"; // id funcionario
                urlLink = urlLink + "P_US=" + unidadeSaudeInscricao + "&"; // id centro de saúde
                urlLink = urlLink + "statusformat=" + paramStatusformat + "&";
                urlLink = urlLink + "desname=" + paramDesname;
                urlLink = urlLink.replaceAll(paramIdUtente,idUtente);
                urlLink = urlLink.replaceAll(reportFileExtText,reportFileExtension);
                log.debug("UrlLink: " + urlLink);
                
                URL    url = null;
                BufferedInputStream bis = null;
                InputStreamReader isr = null;
                boolean erro = true;
                
                url = new URL(urlLink);
                bis = new BufferedInputStream(url.openStream());
                isr = new InputStreamReader(bis);
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                Document doc = builder.parse(new org.xml.sax.InputSource(isr));
                
                NodeList nl = doc.getElementsByTagName("job");
                urlLink = null;
                for(int i = 0 ; i < nl.getLength() ; i++){
                    Node n = nl.item(i);
                    Transformer t = TransformerFactory.newInstance().newTransformer();
                    StringWriter sw = new StringWriter();
                    t.transform(new DOMSource(n), new StreamResult(sw));
                    String yourAnswer = sw.toString();  
                    log.debug("Resposta: " + yourAnswer);
                    if(yourAnswer.indexOf(idUtente + reportFileExtension) >= 0 && yourAnswer.indexOf("<status code=\"4\">") >= 0){
                         erro = false;
                         break;
                    }
                }
      
                urlLink = reportServerCacheUrl;
                urlLink = urlLink.replaceAll(paramIdUtente,idUtente);
                urlLink = urlLink.replaceAll(reportFileExtText,reportFileExtension);
          
                if(erro){
                    throw new Exception("erro ao abrir ficha de utente");
                }
                
            } catch(Exception e){
              log.error("erro ao obter link de impressao de ficha de utente.", e);
              throw new Exception("erro ao abrir ficha de utente: " + e.getLocalizedMessage());
            }
        } else {
          Misc.addMessage(ctx,null,"Parâmetros de ligação ao report server não inicializados.","",Misc.MSG_TYPE_ERROR);  
        }
        log.debug("urlLink a devoler: " + urlLink);
        return urlLink;
    }
    
    public static void clearIteratorAndEexecuteQuery(LifecycleContext ctx, String itName){
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get(itName);
        ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
        vo.clearCache();
        vo.setMaxFetchSize(0);
        vo.executeQuery();
    }

}
