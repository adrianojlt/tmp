package ora.pt.cons.igif.sics.controller.git;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.baixas.ListaItemsBaixasImpl;
import ora.pt.cons.igif.sics.baixas.ListaItemsBaixasRowImpl;
import ora.pt.cons.igif.sics.suporte.ListaCodigosGenericosImpl;
import ora.pt.cons.igif.sics.suporte.ListaCodigosGenericosRowImpl;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;


public class GitControllerComun {

    public static String  incapacidade = null;
    public static String  cuidadosInadiaveis = null;
    public static String  internamento = null;
    public static String  cirurgiaAmbulatorio = null;
    public static String  autorizacao = null;
    public static String  justificacao = null; 
    
    private static Logger log = Logger.getLogger(GitControllerComun.class);

    public static void opcoesItemBaixa (HttpServletRequest request, HttpSession session){
        String requestsObject;

        //Process incapacidade
        incapacidade = (request.getParameter("incActProf") != null ? new String("S") : new String("N"));
        //Process autorizacao
        autorizacao = (request.getParameter("autorizacao") != null ? new String("S") : new String("N"));
        //Process cuidadosInadiaveis
        cuidadosInadiaveis = (request.getParameter("cuiIna") != null ? new String("S") : new String("N"));
        //Process internamento
        internamento = (request.getParameter("internamento") != null ? new String("S") : new String("N"));
        //Process Cirurgia Ambulatorio
        cirurgiaAmbulatorio = (request.getParameter("cirurgiaAmbulatorio") != null ? new String("S") : new String("N"));
        //Process justificacao
        requestsObject = request.getParameter("justificacao");
        justificacao = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : new String(requestsObject)); 

        //If autorizacao is null, justificação must be null
        if (autorizacao.compareTo("N") == 0) {
            justificacao = null;
        }
        
    }
    
    public static boolean isBaixaForSegSocial(HttpServletRequest request) {
        String pubEntity = request.getParameter("entidadePublica") != null ? request.getParameter("entidadePublica") : "";
        if (pubEntity.equals("ERES")) {
            return true;
        } else {
            return false;
        }        
    }
    
    public static boolean isBaixaForSegSocial(LifecycleContext context, Number idItemBaixa) {
        DCIteratorBinding dci = (DCIteratorBinding) context.getBindingContainer().get("ListaItemsBaixasIterator");
        ListaItemsBaixasImpl voListaItemsBaixas = (ListaItemsBaixasImpl)dci.getViewObject(); 
        
        Row arrayLinhasItemsBaixa[] = voListaItemsBaixas.getAllRowsInRange();
        ListaItemsBaixasRowImpl itemBaixa;
        
        for (int i=0;i < arrayLinhasItemsBaixa.length; i++) {
            itemBaixa = (ListaItemsBaixasRowImpl)arrayLinhasItemsBaixa[i];
            
            if (itemBaixa.getId().intValue() == idItemBaixa.intValue()) {
                Number nissUtente = itemBaixa.getNissutente();
                String numBenef = itemBaixa.getNumBenefutente();    
                if (nissUtente == null) {
                    return false;
                } 
                if (numBenef == null || numBenef == "") {
                    return true;
                }
            }
        }
        return false;      
    }
    
    public static Number getNumEpisodio(HttpSession session){
        Number numEpisodio = null;
        //Obter Numero Episodio
        try {
            String numEpisodioString = session.getAttribute("numEpisodio")!=null?(String)session.getAttribute("numEpisodio"):"";
            if(numEpisodioString.length()>0){
                numEpisodio = new Number(numEpisodioString); 
            }
        } catch (Exception e) {
            log.error(e);
            numEpisodio = null;
        }
        //Limpar Numero Episodio para evitar erros (ver analise)
        session.removeAttribute("numEpisodio");
        return  numEpisodio;
    }
    
    public static Number getScgModuloIg(LifecycleContext context){
        HttpServletRequest request  = (HttpServletRequest) context.getEnvironment().getRequest();
        HttpSession session         = request.getSession(false);
        
        String coduloModulo = (String)session.getAttribute("moduloConsulta"); 
        Number idScgModulo = null;
        if (coduloModulo != null) {
            DCIteratorBinding dciIdMODS = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos4IteratorIdMODS");
            ListaCodigosGenericosImpl voListaCodigosGenericosIdMODS = (ListaCodigosGenericosImpl)dciIdMODS.getViewObject();
            voListaCodigosGenericosIdMODS.listaCodigosGenericosCodTipExecutesQuery("MODS", coduloModulo);
            ListaCodigosGenericosRowImpl rowscgModulo = (ListaCodigosGenericosRowImpl)voListaCodigosGenericosIdMODS.first();
            idScgModulo = rowscgModulo.getId();
        }
        //Limpar Numero Episodio para evitar erros (ver analise)
        session.removeAttribute("moduloConsulta");
        
        return idScgModulo;
    }
    
}
