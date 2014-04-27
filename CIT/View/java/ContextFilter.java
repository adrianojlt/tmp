package ora.pt.cons.igif.sics.servlets;

import java.io.IOException;

import java.text.SimpleDateFormat;

import java.util.Calendar;

import java.util.Hashtable;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.controller.misc.SessionInfo;

import oracle.adf.model.servlet.ADFBindingFilter;

import org.apache.log4j.Logger;
import org.apache.log4j.MDC;


public class ContextFilter extends ADFBindingFilter {

    private static Logger logger = Logger.getLogger(ContextFilter.class);
    protected FilterConfig filterConfig;

    private static String APP_CODE = null;
    private static boolean redirectSSO_Oracle = false;
    
    public void init(FilterConfig filterConfig) throws ServletException {
        super.init(filterConfig);
        this.filterConfig = filterConfig;
        String redirect = filterConfig.getInitParameter("SessionTimeoutRedirectSSOOracle");
        if(APP_CODE==null){
           APP_CODE =  filterConfig.getInitParameter("ApplicationCode");
        }
        if(redirect.equalsIgnoreCase("true")){
            this.redirectSSO_Oracle = true;
        }
        logger.debug("INIT CONTEXTFILTER ");
    }

    public void destroy() {
        this.filterConfig = null;
        super.destroy();
    }

    public void doFilter(ServletRequest request, 
                         ServletResponse response, 
                         FilterChain chain) throws IOException, 
                                                   ServletException {
     
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        HttpServletResponse httpResponse = (HttpServletResponse)response;
        HttpSession httpSession = httpRequest.getSession();
        
        try{
            if(naoExpirouSessao(request)){
                initOthers(httpRequest, httpResponse, httpSession);
                
                String tpl = request.getParameter("_timePageLoaded")!=null ? request.getParameter("_timePageLoaded") : "";
                if(tpl.length()>0) {
                    logger.debug("Time Page Loaded=" + tpl);
                    Calendar cal = Calendar.getInstance();
                    String DATE_FORMAT = "yyyy-mm-dd HH:MM:ss";
                    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
                    logger.debug("Time Page Submit=" + sdf.format(cal.getTime()));
                    
                }
                
                //Sónia Pereira - Adicionar dados de login à sessão
                httpSession.setAttribute("username", httpRequest.getRemoteUser());
                
                // verificar se o utilizador ja escolheu um perfil - centroSaudeEscolhido || é integracao SAM
                boolean redirectCS = httpSession.getAttribute("centroSaudeEscolhido")==null?true:false;
               
               /* TODO  Retirar daqui 
                httpSession.setAttribute("isSAMCall", "S");
                httpSession.setAttribute("primeiraEntrada", "S"); 
                /* TODO  Fim Retirar daqui */ 
                
                String sam = integraSAM(httpRequest, httpResponse, request);
                if (!sam.equals("")){
                    //httpResponse.sendRedirect(httpResponse.encodeRedirectURL(sam)); 
                    ((HttpServletResponse) response).sendRedirect(sam);
                }                
                else if (redirectCS && !httpRequest.getRequestURI().endsWith("index.do")) {
                    httpResponse.sendRedirect(httpResponse.encodeRedirectURL(httpRequest.getContextPath()+"/pub/index.do"));
                } else {
                    super.doFilter(request,response,chain);
                }  
            } else {
                ((HttpServletResponse) response).sendRedirect("../com/logout.jsp?reason=expired");
            } 
        } catch (Exception e) {
          logger.error("",e);
          throw new ServletException(e.getMessage());
        }  
    }
    
    private void initOthers(HttpServletRequest httpRequest, 
                            HttpServletResponse httpResponse, 
                            HttpSession httpSession){
        try{
            MDC.put("username", httpRequest.getRemoteUser()!=null?httpRequest.getRemoteUser():"");
            setHeader(httpRequest, httpResponse);   
            // Puts on the session an object to hold miscelleanous of information
            if (httpSession.getAttribute("sessionInfo") == null) { //To be set only there if sessionInfo is not set (ContextFilter.java is run at every request)
                SessionInfo sessionInfo = new SessionInfo();
                sessionInfo.setAppAplcCode(this.APP_CODE);
                httpSession.setAttribute("sessionInfo", sessionInfo);
            }
            novoUtentePressed(httpRequest, httpSession);
        } catch(Exception e){
          logger.error("",e);
        }
    }
    
    private void setHeader(HttpServletRequest httpRequest, HttpServletResponse httpResponse){
        try{
            httpRequest.setCharacterEncoding("UTF-8");
            httpResponse.setCharacterEncoding("UTF-8");
            httpResponse.addHeader("Pragma", "no-cache");
            httpResponse.addHeader("Cache-Control", "no-cache");
            httpResponse.addHeader("Cache-Control", "no-store");
            httpResponse.addHeader("Cache-Control", "must-revalidate");
            httpResponse.addHeader("Expires", "Mon, 1 Jan 2006 05:00:00 GMT");  
        } catch(Exception e){ 
            logger.error("erro no set do Header ",e);  
        }
    }
    
    // verifica se request vem do SAM redirecciona para /pub/index.do para a acção 'integrateSAMBaixas' de init de contexto
    private String integraSAM(HttpServletRequest httpRequest, HttpServletResponse httpResponse, ServletRequest request){  
        boolean override = false;
  
        try{
            HttpSession session = httpRequest.getSession();
            override = request.getParameter("flowId") != null ? true : false;
            if(override){

                String flowId = request.getParameter("flowId");

                if(flowId.equalsIgnoreCase("CIT_0001")){
                    String flowParamNames = request.getParameter("flowParamNames");
                    String flowParamValues = request.getParameter("flowParamValues");                
                    String event = "integrateSAMBaixas";
                    StringBuffer sb = new StringBuffer();
                    sb.append(httpRequest.getContextPath()).append("/pub/index.do?");
                    Hashtable params = new Hashtable();
                    String[] flowParams = null;
                    String[] flowValues = null;                    
                    if(String.valueOf(flowParamNames.charAt(0)).equalsIgnoreCase("[") && String.valueOf(flowParamNames.charAt(flowParamNames.length()-1)).equalsIgnoreCase("]")){
                        flowParams = flowParamNames.substring(1,flowParamNames.length()-1).split(",");
                    }
                    if(String.valueOf(flowParamValues.charAt(0)).equalsIgnoreCase("[") && String.valueOf(flowParamValues.charAt(flowParamValues.length()-1)).equalsIgnoreCase("]")){
                        flowValues = flowParamValues.substring(1,flowParamValues.length()-1).split(",");
                    }
                    for(int i = 0 ; i < flowParams.length ; i++){
                        params.put(flowParams[i],flowValues[i]);
                    }                    
                    String inst = String.valueOf(params.get("ninst")); //request.getParameter("cs");
                    String nir = String.valueOf(params.get("nsns")); //request.getParameter("nir");
                    String tipoInst = String.valueOf(params.get("tinst")); //request.getParameter("cs");
                    String cons = String.valueOf(params.get("cons")); //Parametro Consulta CIT
                    String numEpisodio = String.valueOf(params.get("nepis")); //Numero Episodio
                    String moduloConsulta = String.valueOf(params.get("cmod")!=null?params.get("cmod"):""); //Modulo da Consulta
                    
                    if (cons != null && cons.equalsIgnoreCase("yes")) {
                        session.setAttribute("readOnlyCIT","yes");
                    } else {
                        session.setAttribute("readOnlyCIT","no");
                    }
                    
                    if (numEpisodio != null) {
                        session.setAttribute("numEpisodio",numEpisodio);
                    } else {
                        session.setAttribute("numEpisodio",null);
                    }
                    
                    if (moduloConsulta.length()>0) {
                        session.setAttribute("moduloConsulta",moduloConsulta);
                    } else {
                        session.setAttribute("moduloConsulta",null);
                    }
                     
                    sb.append("cs=" + inst);
                    sb.append("&nir=" + nir);
                    sb.append("&tinst=" + tipoInst);
                    sb.append("&event=" + event);
                    
                    session.setAttribute("flowId",flowId);
                    session.setAttribute("isSAMCall", "S");
                    session.setAttribute("primeiraEntrada", "S");
                    
                    System.out.println("sendRedirect:" + sb.toString() );
                    //httpResponse.sendRedirect(httpResponse.encodeRedirectURL(sb.toString())); 
                    return sb.toString();
                   
                }

            }
        } catch(Exception e){
          logger.error("erro ao verificar se foi requerida integração com o SAM ",e);
        }
        
        return "";
       
    }
    
    private void novoUtentePressed(HttpServletRequest httpRequest, HttpSession httpSession){
        // Button "Novo Utente" on infoUtente.jsp was pressed
        if (httpRequest.getParameter("hiddenGetNewUtenteContext") != null) {
            SessionInfo sessionInfo =  (SessionInfo) httpSession.getAttribute("sessionInfo");
            String getNewUtenteContext = httpRequest.getParameter("hiddenGetNewUtenteContext").toString();
            String getNewUtentePage = httpRequest.getParameter("hiddenGetNewUtentePage").toString();
            
            if (getNewUtenteContext.compareTo("admin") == 0 && getNewUtentePage.compareTo("globalSinc.jsp") == 0){
                sessionInfo.setUrlContext("adminSinc");
            } else {
                sessionInfo.setUrlContext(getNewUtenteContext);
            }
        }
    }
    
    private boolean naoExpirouSessao(ServletRequest request){
        boolean naoExpirou = true;
        if(redirectSSO_Oracle){
            try{
                String requestedSession = ((HttpServletRequest)request).getRequestedSessionId();
                String currentWebSession =  ((HttpServletRequest)request).getSession().getId();
                boolean sessionOk = currentWebSession.equalsIgnoreCase(requestedSession);
                if (!sessionOk && requestedSession != null){
                    naoExpirou = false;
                }
            } catch(Exception e){
                logger.error("",e);
            }
        }
        return naoExpirou;
    }
    
}
