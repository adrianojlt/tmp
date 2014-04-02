package ora.pt.cons.igif.sics.controller.git;

import java.sql.SQLException;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.baixas.common.BaixasModule;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.suporte.common.ModulosSuporteModule;
import ora.pt.cons.utils.date.DateUtils;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.controller.v2.struts.actions.DataAction;
import oracle.adf.controller.v2.struts.context.StrutsPageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;
import oracle.jbo.ViewObject;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;


public class GitedicaoProrrogacaoBaixaPageController extends PageController {

    private static Logger log = Logger.getLogger(GitedicaoProrrogacaoBaixaPageController.class);
    
    public void prepareModel(LifecycleContext context) {
        DCIteratorBinding dciGCLD = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericosIteratorGCLD");
        ViewObject voListaCodigosGenericosGCLD = dciGCLD.getViewObject();
        DCIteratorBinding dciPARE = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos1IteratorPARE");
        ViewObject voListaCodigosGenericosPARE = dciGCLD.getViewObject();
        DCIteratorBinding dciIdDF = (DCIteratorBinding) context.getBindingContainer().get("ListaCodigosGenericos2IteratorIdDF");
        ViewObject voListaCodigosGenericosIdDF = dciIdDF.getViewObject();
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtilizadorIterator");
        ViewObject voInfUtente = dciInfUtil.getViewObject();
        
        
        DCIteratorBinding dciInfUtil2 = (DCIteratorBinding) context.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtil2 = dciInfUtil2.getViewObject();
        HttpServletRequest request = (HttpServletRequest) context.getEnvironment().getRequest();
        
        String doRefresh = "Y";
        
        Enumeration en = request.getParameterNames();
        Object o = null;
        
        while (en.hasMoreElements()) {
            o = en.nextElement();
            if ( o.toString().equalsIgnoreCase("event") || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ) {
                if ( request.getParameter(o.toString()).toLowerCase().indexOf("rangechangelista") >= 0 
                     || o.toString().toLowerCase().indexOf("event_rangechangelista") >= 0 ) {
                    doRefresh = "N";
                }
            }
        }
        
        
        // Is not an action of changing the range of Iterator
        if ( doRefresh.equalsIgnoreCase("Y") ) {   
            //Gets Global ID of Centro Saude
            HttpSession session = request.getSession(false);
            
            //Entidades Responsaveis
            String pubEntity = ""; // request.getParameter("entidadePublica"); nota: apenas são permitidas prorrogacoes para segurança social
            //Little workaround: If this pubEntity is not a parameter, then we create an empty string for it.
            //TODO: remove this parameter and consult InfoUtente
            if (pubEntity == null) { 
                pubEntity = new String("");
            }
            
            String utenteId;
            utenteId = voInfUtil2.getCurrentRow().getAttribute("Idutente").toString();
            
            DCIteratorBinding dciEntResp = (DCIteratorBinding) context.getBindingContainer().get("ListaEntidadesResponsaveisIterator");
            ViewObject voEntResp = dciEntResp.getViewObject();
            voEntResp.setNamedWhereClauseParam("idUtente",utenteId);
            voEntResp.executeQuery();
            
            //Get Id Centro Saude
            Integer centroSaudeId;
            centroSaudeId = new Integer(voInfUtente.getCurrentRow().getAttribute("CsId").toString());
                    
            voListaCodigosGenericosGCLD.clearCache();
            voListaCodigosGenericosPARE.clearCache();
            
            //Gets Suporte Module
            ModulosSuporteModule supModuleGCLD = (ModulosSuporteModule)voListaCodigosGenericosGCLD.getApplicationModule();        
            ModulosSuporteModule supModulePARE = (ModulosSuporteModule)voListaCodigosGenericosPARE.getApplicationModule();        
            
            //Get ID for Assistencia Familiares
            if (pubEntity.compareTo("EPUB") == 0) {
                ModulosSuporteModule supModuleIdDF = (ModulosSuporteModule)voListaCodigosGenericosIdDF.getApplicationModule();
                supModuleIdDF.listaCodigosGenericos2CodTipExecutesQuery("GITP","DF");
            } else {
                ModulosSuporteModule supModuleIdDF = (ModulosSuporteModule)voListaCodigosGenericosIdDF.getApplicationModule();
                supModuleIdDF.listaCodigosGenericos2CodTipExecutesQuery("GCLD","DF");
            }
            Row idDFRow = voListaCodigosGenericosIdDF.first();
            String idDFString = (idDFRow.getAttribute("Id")).toString();
            session.setAttribute("GitidDFAssistenciaFamiliar",idDFString);
            
            //Gets Types of Baixa
            voListaCodigosGenericosGCLD.clearCache();
            if (pubEntity.compareTo("EPUB") == 0) {
                supModuleGCLD.listaCodigosGenericosExecutesQuery("GITP");
            } else {
                supModuleGCLD.listaCodigosGenericosExecutesQuery("GCLD");
            }

            supModulePARE.listaCodigosGenericos1ExecutesQuery("PARC");
            
            // Little workaround to the query does not execute two times.
            // The refresh condition is RefreshCondition="${param['event'] != 'PageLoadEdicaoBaixa'}" on page Load, then we change it to null
            dciGCLD.setRefreshExpression("");
            dciPARE.setRefreshExpression("");
            dciIdDF.setRefreshExpression("");
        }
        
        super.prepareModel(context);
    }
    
    public void onRangeChangeListaBaixas(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        
        int selectedPos = 0;
        String navigationLinkButton;   
        
        if (request.getParameter("nextRangeListaBaixas") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaBaixas"));
        }
        
        navigationLinkButton = request.getParameter("event_RangeChangeListaBaixas");
        
        // Controls the navigation on the ListBox
        Misc.navigateListBox(dci,selectedPos, navigationLinkButton);         
    }
    
    public void onInsertNewProrrogacao (PageLifecycleContext ctx) {
        
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaBaixasIterator");
        DCIteratorBinding dciInfUtil = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtilizadorIterator");
        ViewObject voInfUtili = dciInfUtil.getViewObject();
        DCIteratorBinding dciInfUten = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInfUtente = dciInfUten.getViewObject();
        HttpServletRequest request = (HttpServletRequest) ctx.getEnvironment().getRequest();
        HttpSession session = request.getSession(false);
    
        // Gets the Id of the selected Baixa
        Number idBaixa = null;
        
        try {
            idBaixa = new Number((Integer)session.getAttribute("git.idBaixa"));
        } catch (SQLException e) {
            log.error(e);
        }
        
        /*
         * Parameters given by edicaoBaixa to insert a new baixa
         *      selectClassDoenca   - Id Classificacao Doenca
         *      inputFamiliar       - Nome Familiar
         *      selectParentesco    - Id Parentesco
         *      dp-dinicio          - Data Inicio Baixa
         *      dp-dtermo           - Data Termo Baixa
         *      hiddenLastItemDataTermo - Data Termo do Ultimo de Baixa
         *      
         *      incActProf          - Inc. Act. Prof.       (on/null)
         *      cuiIna              - Cuidados Inadiáveis   (on/null)
         *      internamento        - Internamento          (on/null)
         *      autorizacao         - Autorização           (on/null)
         *      justificacao        - Justificao            (on/null)
         * */

        String requestsObject;
        java.util.Date requestsDate;
        requestsDate = null;
        Date requesDateTemp;
        requesDateTemp = null;

        Number  idClassDoenca;
        Date    dataInicio;
        Date    dataTermo;
        Date    dataInicioLastBoletim;
        Date    dataTermoLastItem;
        String  baixaManual;
        
        // Process ClassFicacao Doenca
        String classDoenca = request.getParameter("selectClassDoenca")!=null? request.getParameter("selectClassDoenca"):"";
        if(classDoenca.length()>0){
            try {
                idClassDoenca = new Number(classDoenca);
            } catch (SQLException e) {
                return;    
            }
            //Process Data Inicio
            requestsObject  = request.getParameter("dp-dinicio");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                 log.error(e);
            }
            
            dataInicio = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Process Data Termo
            requestsObject  = request.getParameter("dp-dtermo");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                 log.error(e);
            }
            
            dataTermo = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            //Process Data Inicio Ultimo Boletim
            requestsObject  = request.getParameter("DataInicioTotal");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(), DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                 log.error(e);
            }
            dataInicioLastBoletim = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp); 
            
            
            //Process Data Termo Last Item
            requestsObject = request.getParameter("hiddenLastItemDataTermo");
            try {
                requestsDate = DateUtils.parseToDate(requestsObject.toString(),DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                java.sql.Date d1 = new java.sql.Date(requestsDate.getTime());
                requesDateTemp = new Date(d1);
            } catch (Exception e) {
                 log.error(e);
            }
            dataTermoLastItem = (requestsObject == null || requestsObject.equalsIgnoreCase("") ? null : requesDateTemp);
            
            //Manual Baixa Item
            baixaManual = (request.getParameter("checkBaixaManual") != null ? new String("S") : new String("N"));
            
            //Opcoes de Item de Baixa
            GitControllerComun.opcoesItemBaixa(request,session);
            
            //Get Global Information
            //Get IdHistEntUtId
            Number iduHistEntUtId;
            try {
                Object iddHistEntUtIdObject = voInfUtente.getCurrentRow().getAttribute("Idhistentutente");
                if (iddHistEntUtIdObject == null){
                    iduHistEntUtId = null; 
                }else {
                    iduHistEntUtId = new Number(iddHistEntUtIdObject.toString());
                }
            } catch (SQLException e) {
                //error - nao consegui obter num Profissional
                log.error(e);
                System.out.println(voInfUtente.getCurrentRow().getAttribute("Idhistentutente"));
                iduHistEntUtId = null;  
            }
              
            //Get Id Utente
            Number iduIdentUtId;
            try {
                iduIdentUtId = new Number(voInfUtente.getCurrentRow().getAttribute("Idutente").toString());
            } catch (SQLException e) {
                //error - nao consegui obter num Profissional
                log.error(e);
                System.out.println(voInfUtente.getCurrentRow().getAttribute("Idutente"));
                iduIdentUtId = null;  
            }
              
            Number iduIdentUtDupId   = null;
             
            //Get Id Centro Saude
            Number sysEntidadesId;
            try {
                sysEntidadesId = new Number(voInfUtili.getCurrentRow().getAttribute("CsId").toString());
            } catch (SQLException e) {
                //error - nao consegui obter num Profissional
                System.out.println(voInfUtili.getCurrentRow().getAttribute("CsId"));
                sysEntidadesId = null; 
                log.error(e);
            }
             
            //Get ID Profissional
            Number proProfissidPessoalId;
            try {
                proProfissidPessoalId = new Number(voInfUtili.getCurrentRow().getAttribute("ProfissidPessoalId").toString());
            } catch (SQLException e) {
                // error - nao consegui obter num Profissional
                proProfissidPessoalId = null;
                log.error(e);
            }
            
            //Obter Numero Episodio
            Number numEpisodio = GitControllerComun.getNumEpisodio(session);
            
            //Obter Modulo da Consulta
            Number idScgModulo = GitControllerComun.getScgModuloIg(ctx);
            
            //Try to insert de information on the Oracle DB          
            ViewObject voListaBaixas = dci.getViewObject();
            BaixasModule baixasModule = (BaixasModule) voListaBaixas.getApplicationModule();
            
            Integer result = baixasModule.insertNewProgor(  idBaixa,
                                                            iduHistEntUtId,
                                                            iduIdentUtDupId,
                                                            iduIdentUtId,
                                                            sysEntidadesId,
                                                            proProfissidPessoalId,
                                                            dataInicio,
                                                            dataTermo,
                                                            dataInicioLastBoletim,
                                                            dataTermoLastItem,
                                                            idClassDoenca,
                                                            GitControllerComun.incapacidade,
                                                            GitControllerComun.cuidadosInadiaveis,
                                                            GitControllerComun.internamento,
                                                            GitControllerComun.cirurgiaAmbulatorio,
                                                            GitControllerComun.autorizacao,
                                                            GitControllerComun.justificacao,
                                                            baixaManual,
                                                            numEpisodio,
                                                            idScgModulo);
            
            //After insert, clear View Object Cache
            voListaBaixas.clearCache();
            
            //For error handling
            ActionErrors errors = new ActionErrors();
            StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
            
            switch (result.intValue()){
                //Success
                case  0:     actionContext.setActionForward("onSuccess");
                             break;
                //DataInicio is null
                case -1:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6201","Data Início vazia"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Inicio não pode ser vazia"));
                             actionContext.setActionForward("onError");
                             break;
                //DataTermo is null
                case -2:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6202","Data Termo vazia"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Termo não pode ser vazia"));
                             actionContext.setActionForward("onError");
                             break;
                //Numero de dias Invalido
                case -4:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6204","Número de dias inválido"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Nº de dias para uma Prorrogação não pode ser superior a 30."));
                             actionContext.setActionForward("onError");
                             break;
                //Data de incio Invalido
                case -5:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6205","Data Início inválida"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início tem que ser consecutiva com o Item de Baixa anterior."));
                             actionContext.setActionForward("onError");
                             break;
                //Justificacao nao atribuida
                case -7:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6207","Justificação não atribuida"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Justificação de Saida é obrigatória quando é dada autorização de saida."));
                             actionContext.setActionForward("onError");
                             break;
                //Data Inicio Invalida
                case -30:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6106","Data Início Inválida"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser inferior a 10 dias em relação à data actual."));
                             actionContext.setActionForward("onError");
                             break;
                //Data de inicio Invalido
                case -33:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6208","Data Início inválida"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ultrapassar a data de sistema em mais de 3 dias."));
                             actionContext.setActionForward("onError");
                             break;
                case -9:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6109","Data Início/Data Termo"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Inicio não pode ser superior à Data Termo."));
                             actionContext.setActionForward("onError");
                             break;
                case -10:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6101","Data Início"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Inicio já está incluida num Boletim de Baixa"));
                             actionContext.setActionForward("onError");
                             break;
                case -11:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6111","Necessário Incapacitado ou Cuidados Inadiáveis!"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Necessario ter pelo menos uma das duas opções seleccionadas"));
                             actionContext.setActionForward("onError");
                             break;
                case -20:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6112","Internamento e Cirurgia Ambulatório!"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Estas opções não podem ser seleccionadas em conjunto!"));
                             actionContext.setActionForward("onError");
                             break;
                case -23:    errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6123","Necessário Incapacitado ou Cuidados Inadiáveis!"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Necessario ter pelo menos uma das duas opções seleccionadas"));
                             actionContext.setActionForward("onError");
                             break;
                case -20000: errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6128","Prescrição inválida!"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Não é possível criar um novo Boletim. Utente tem Boletim sem Alta, por favor verifique boletins anteriores."));
                             actionContext.setActionForward("onError");
                             break; 
                case -20001: errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6129","Prescrição inválida!"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Não é possível criar a baixa. Utente já tem baixa para o período, por favor verifique baixas anteriores."));
                             actionContext.setActionForward("onError");
                             break; 
                //Numero de dias Invalido
                case -43:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6130","Número de dias Inválido"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Nº de dias para Assistência a Familiares não pode ser superior a 30."));
                             actionContext.setActionForward("onError");
                             break;
                //Numero de dias Invalido
                case -44:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","6130","Número de dias Inválido"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Data de Início não pode ser inferior a 30 dias em relação à data actual."));
                             actionContext.setActionForward("onError");
                             break;
                default:     errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Codigo","62" + result.toString(),"Erro Grave"));
                             errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("error.Mensagem","Erro na aplicação. Contactar Direcção Informática do Centro"));
                             actionContext.setActionForward("onError");
                             break;
            }   
            
            actionContext.setActionErrors(errors);
            ((DataAction)actionContext.getAction()).saveErrors(actionContext);
        }else{
            // redirect consulta baixas para obrigar a que o contexto seja reconstruido
            StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
            actionContext.setActionForward("onWarning");
        }
    }

}
