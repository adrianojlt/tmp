package ora.pt.cons.igif.sics.controller.idu;

import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.common.ListaParametros;
import ora.pt.cons.igif.sics.common.ListaParametrosRow;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.controller.misc.SessionInfo;
import ora.pt.cons.igif.sics.utentes.IdentificacaoUtenteModuleImpl;
import ora.pt.cons.igif.sics.utentes.ListaUtentesDupRowImpl;
import ora.pt.cons.igif.sics.utentes.ListaUtentesRowImpl;
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
import org.apache.struts.action.ActionErrors;


public class IdupesquisaUtentePageController extends PageController {
    
    private static Logger log = Logger.getLogger(IdupesquisaUtentePageController.class);
    
    HttpServletRequest request = null;
    HttpSession session = null;
    String event = null;

    public void prepareModel(LifecycleContext ctx) {
        try{
        
            request = (HttpServletRequest) ctx.getEnvironment().getRequest();
            session = request.getSession(false);
            event = request.getParameter("event")!=null?request.getParameter("event"):"";
            String event_navigation = request.getParameter("nextRangeListaUtentes")!=null?request.getParameter("nextRangeListaUtentes"):"";
            if(event_navigation.length()>0){
                event = event_navigation;
            }
            log.debug("event: " + event);
              
        } catch(Exception e){
          log.error(e);
          Misc.addMessage(ctx,"","erro",e.getMessage(),Misc.MSG_TYPE_ERROR);
        }
        super.prepareModel(ctx);
    }
    
    public void prepareRender(LifecycleContext ctx) {
        listaPaises(ctx);
        listaDistritos(ctx);
        if(event.length()==0){
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            vo.clearCache();
            vo.setMaxFetchSize(0);
        }
        super.prepareRender(ctx);
    }
    
    public void onSearch(PageLifecycleContext ctx) {
        
        try{
            DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
            ViewObjectImpl voListaUtentes = (ViewObjectImpl)dciListasUtentes.getViewObject();
            
            // -- obter parametros de pesquisa
            // -- nSNS             : numero de seguro nacional de saude
            // -- nOP              : numero operacional
            // -- idadeDe & idadeA : idade do utente (range de datas)
            // -- nomes & apelidos : nome do utente (concatenados para procura de utente por nome)
            // -- dataNasc         : data de nascimento do utente
            // -- paisNat          : pais naturalidade do utente
            // -- paisNac          : pais nacionalidade do utente
            // -- idConcelho       : pk do concelho do utente
            // -- idDistrito       : pk do distrito do utente
            // -- idFreguesia      : pk da freguesia do utente
            // -- pNiss            : numero
            String nSNS="", nOP="", idadeDe="", idadeA="", nomes="", apelidos="", dataNasc="", paisNat="", paisNac="", idConcelho="", idDistrito="", idFreguesia="", niss="";
            // verificar tipo de pesquisa (Simples ou Avancada)
            if(request.getParameter("pPesquisaAvancada")!=null && request.getParameter("pPesquisaAvancada").equalsIgnoreCase("true")) {
                // pesquisa avancada
                nOP = request.getParameter("nOP")==null?"":request.getParameter("nOP");
                paisNat = request.getParameter("paisNat")==null?"":request.getParameter("paisNat");
                paisNac = request.getParameter("paisNac")==null?"":request.getParameter("paisNac");
                idConcelho = request.getParameter("idConcelho")==null?"":request.getParameter("idConcelho");
                idDistrito = request.getParameter("idDistrito")==null?"":request.getParameter("idDistrito");
                idFreguesia = request.getParameter("idFreguesia")==null?"":request.getParameter("idFreguesia");
                niss = request.getParameter("pNiss")==null?"":request.getParameter("pNiss");
            }
            // fitro apenas de pesquisa simples
            nSNS = request.getParameter("nSNS")==null?"":request.getParameter("nSNS");
            idadeDe = request.getParameter("idadeDe")==null?"":request.getParameter("idadeDe");
            idadeA = request.getParameter("idadeA")==null?"":request.getParameter("idadeA");
            nomes = request.getParameter("nomes")==null?"":request.getParameter("nomes");
            apelidos = request.getParameter("apelidos")==null?"":request.getParameter("apelidos");
            dataNasc = request.getParameter("dataNasc")==null?"":request.getParameter("dataNasc");
            
            String nomeCompleto = nomes + " " + apelidos;
            nomeCompleto = nomeCompleto.trim();
            
            // -- se for introduzido o SNS ou o NISS deixa fazer a pesquisa sem mais validacoes
            if(nSNS.length()==0 && niss.length()==0){
                
                // -- verificar qtos nomes foram inroduzidos na procura pelo nome
                StringTokenizer st = new StringTokenizer(nomes.trim() + " " + apelidos.trim()," ");
                int i = st.countTokens();
                
                // -- nomes, apelidos, idadeDe, idadeA, dataNasc nao forem preenchidos,  
                // -- devolve erro de obrigatoriedade de preencher pelo menos um criterio de pesquisa.
                if( nomes.length()==0 && apelidos.length()==0 && idadeDe.length()==0 && idadeA.length()==0 && dataNasc.length()==0 && !Misc.hasMessages(ctx)){
                    Misc.addMessage(ctx, "1", "N&atilde;o &eacute possivel efectuar a opera&ccedil;&atilde;o sem preencher pelo menos um crit&eacute;rio de pesquisa.", "", Misc.MSG_TYPE_WARNG);
                }
                
                // -- se nao introduzir pelo menos 2 nomes devolve erro de obrifgatoriedade da sua introducao
                if(i<2 && !Misc.hasMessages(ctx)){
                    Misc.addMessage(ctx, "1", "Introduza pelo menos dois nomes para a sua pesquisa.", "", Misc.MSG_TYPE_WARNG);
                } 
                
                // -- se apenas forem introduzidos dois nomes obriga a que sejam preenchido um outro criterio de pesquisa. Range de Idades ou Data Nascimento.
                if(i==2 && idadeDe.length()==0 && idadeA.length()==0 && dataNasc.length()==0 && !Misc.hasMessages(ctx)){
                    Misc.addMessage(ctx, "1", "Introduza um critério adicional para a sua pesquisa. Intervalo de Idades ou Data Nascimento.", "", Misc.MSG_TYPE_WARNG);
                }
                
                // -- se idadeA for preenchida sem ter sido preenchida a idadeDe 
                // -- devolve erro, necessária introducao da idadeDe.
                if( idadeDe.length()==0 && idadeA.length()>0 && !Misc.hasMessages(ctx)){
                    Misc.addMessage(ctx, "1", "Introduza a Idade Inicial do Intervalo de Idade.", "", Misc.MSG_TYPE_WARNG);
                    
                }
                
                // -- se idadeDe for preenchida sem ter sido preenchida a idadeA 
                // -- devolve erro, introducao da idadeA.
                if( idadeA.length()==0 && idadeDe.length()>0 && !Misc.hasMessages(ctx)){
                    Misc.addMessage(ctx, "1", "Introduza a Idade máxima do Intervalo de Idade.", "", Misc.MSG_TYPE_WARNG);
                }
            }
            
            // -- caso existam mensagens, devolve-os
            if (Misc.hasMessages(ctx)) {
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext) ctx;
                actionContext.setActionForward("onError");
                return;
            }
            
            // -- controlo de opcao de criterios logicamente subrepostos
            // -- 1. caso seja introduzida uma data de nascimento e tambem um intervalo de datas de idade, opta-se apenas pela procura da data de nascimento
            if(idadeDe.length()>0 && idadeA.length()>0 && dataNasc.length()>0){
                idadeDe = idadeA = "";
            }
            
            // -- constroi objecto de parametros de query de pesquisa
            // -- nota1: se o SNS for preenchido apenas pesquisa por SNS
            // -- nota2: se o NISS for preenchido apenas pesquisa por NISS
            Collection params = new LinkedList();
            if ( nSNS.length()>0){ 
                params.add(new Object[][]{{"Number","nir", nSNS }});
            } else if(niss.length()>0){
                params.add(new Object[][]{{"Number","niss", niss }});
            } else {
                if ( nOP.length()>0 ) { params.add(new Object[][]{{"Number","nop", nOP}}); }
                if ( nomes.length()>0 ) { params.add(new Object[][]{{"String","nomes_proprios",nomes}}); }
                if ( apelidos.length()>0 ) { params.add(new Object[][]{{"String","apelidos", apelidos}}); }
                if ( idadeDe.length()>0 ) { params.add(new Object[][]{{"Number","idade", idadeDe}}); }
                if ( idadeA.length()>0 ) { params.add(new Object[][]{{"Number","idade", idadeA}}); }
                if ( dataNasc.length()>0) {
                    // -- converter string para Date 
                    java.util.Date dt = null;
                    try {
                        dt = DateUtils.parseToDate(dataNasc, DateUtils.DATE_FORMAT_STYLE_DEFAULT);
                    } catch (Exception e) {
                      // TODO: propagar excepcao
                    }
                    params.add(new Object[][]{{"Date","dta_nasc",dt}});
                }
                if ( paisNat.length()>0 ) { params.add(new Object[][]{{"Number","pais_natalidade_id",paisNat}}); }
                if ( paisNac.length()>0 ) { params.add(new Object[][]{{"Number","pais_nacionalidade_id",paisNac}}); }
                if ( idDistrito.length()>0 ) { params.add(new Object[][]{{"Number","distrito_id",idDistrito}}); }
                if ( idConcelho.length()>0 ) { params.add(new Object[][]{{"Number","concelho_id",idConcelho}}); }
                if ( idFreguesia.length()>0 ) { params.add(new Object[][]{{"Number","freguesia_id", idFreguesia}}); }
            }
            
            DCIteratorBinding dciListaParametros = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
            ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();    
            
            //Get forward action
            voListaParametros.setNamedWhereClauseParam("Path", ".ROOT.SNU.IDU.PESQUISA_UTENTE.MAX_FETCH_SIZE");
            voListaParametros.executeQuery(); //This Query must only return one value
            ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first();
            IdentificacaoUtenteModuleImpl am = (IdentificacaoUtenteModuleImpl) voListaUtentes.getApplicationModule();
            Number maxFetchSizePesquisa = rowParametros.getValNumber();
            int a = am.listaUtentesAddWhereClause(params, maxFetchSizePesquisa);
            
            //Procurar registos nos duplicados
            if (a <= 0 ){
                am.listaUtentesDupAddWhereClause(params);
                int numLinhas = am.getListaUtentesDup().getRowCount();
                if(numLinhas>0){
                    String ids = "";
                   // Row[] rowUDup = am.getListaUtentesDup().getAllRowsInRange();
                    am.getListaUtentesDup().first();
                    for(int i = 0 ; i < numLinhas ; i++){
                        ListaUtentesDupRowImpl r = (ListaUtentesDupRowImpl)am.getListaUtentesDup().getCurrentRow();
                        if (i ==0){
                          ids+= r.getIdPai();
                        } else {
                          ids+= ","+r.getIdPai();  
                        }
                        am.getListaUtentesDup().next();
                    }
                    //The query was done because of the "IN" operation, doesnt work as an bind param
                    voListaUtentes.clearWhereState();
                    voListaUtentes.setWhereClause("iiu_id in (SELECT CASE "+
                                                                      " WHEN :numLinhas=1 THEN "+
                                                                      "       :ids"+
                                                                      " WHEN LEVEL=1 THEN "+
                                                                      "      substr(:ids,LEVEL,INSTR(:ids,',',LEVEL,1)-1) "+
                                                                      " WHEN INSTR(:ids,',',1,LEVEL)!=0 THEN "+
                                                                      "      substr(:ids,INSTR(:ids,',',1,LEVEL-1)+1,INSTR(:ids,',',1,LEVEL)-INSTR(:ids,',',1,LEVEL-1)-1) "+
                                                                      " ELSE "+
                                                                      "      substr(:ids, INSTR(:ids,',',1,LEVEL-1)+1) "+
                                                                  "  END AS COL_ID "+
                                                                  " FROM DUAL T "+
                                                                " CONNECT BY LEVEL <= :numLinhas)");
                    voListaUtentes.defineNamedWhereClauseParam("numLinhas",null,null);                
                    voListaUtentes.setNamedWhereClauseParam("numLinhas",numLinhas);
                    voListaUtentes.defineNamedWhereClauseParam("ids",null,null);                
                    voListaUtentes.setNamedWhereClauseParam("ids",ids);
                    voListaUtentes.clearCache();
                    voListaUtentes.executeQuery();
                    /*
                    voListaUtentes.removeNamedWhereClauseParam("ids");
                    voListaUtentes.removeNamedWhereClauseParam("numLinhas");
                    voListaUtentes.setWhereClause(null); 
                    */
                }
                
            }
            
            // qdo forem devolvidos mais que 100 registos devolve mensagem para redefinição de pesquisa
            if(a==maxFetchSizePesquisa.intValue()-1){
                Misc.addMessage(ctx, "1", "Demasiados registos encontrados. Por favor redefina a sua pesquisa.", "", Misc.MSG_TYPE_WARNG);
            }
            
        } catch(Exception e){
          log.error("Erro na pesquisa de utentes",e);
          Misc.addMessage(ctx, "1", "Erro na pesquisa de utentes", e.getMessage(), Misc.MSG_TYPE_ERROR);
        }
    }
    
    public void onSelectUtente(PageLifecycleContext ctx) {
        try  {
            DCIteratorBinding dciInformacaoUtente = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
            ViewObject voInformacaoUtente = dciInformacaoUtente.getViewObject();
            
            DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
            ViewObject voListaUtentes = dciListasUtentes.getViewObject();
            
            ListaUtentesRowImpl rListaUtentes = null;
            Row[] rows = voListaUtentes.getAllRowsInRange();
            
            String rowNumber = request.getParameter("rowNumberSelected");
            
            rListaUtentes = (ListaUtentesRowImpl) rows[(new Integer(rowNumber)).intValue()-1];
            
            Number idUtente;
            Number idHistEntUtente;
            Number nir;
            Number niss;
            String numId;
            String nome;
            java.util.Date dtaNasc;
            
            String sexoUtente;
            
            if ( rListaUtentes.getIiuId() != null) {
                idUtente = rListaUtentes.getIiuId();
                voInformacaoUtente.setNamedWhereClauseParam("idUtente",idUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("idUtente",new Integer(-1));
            }
            if ( rListaUtentes.getIheId() != null) {
                idHistEntUtente = rListaUtentes.getIheId();
                voInformacaoUtente.setNamedWhereClauseParam("idHistEntUtente",idHistEntUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("idHistEntUtente",new Integer(-1));
            }
            if ( rListaUtentes.getNir() != null) {
                nir = rListaUtentes.getNir();
                voInformacaoUtente.setNamedWhereClauseParam("numUtente",nir);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numUtente",new Integer(-1));
            }
            if ( rListaUtentes.getNiss() != null) {
                niss = rListaUtentes.getNiss();
                voInformacaoUtente.setNamedWhereClauseParam("numSSocial",niss);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numSSocial",new Integer(-1));
            }
            if ( rListaUtentes.getNumId() != null) {
                numId = rListaUtentes.getNumId();
                voInformacaoUtente.setNamedWhereClauseParam("numBI",numId);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numBI","");
            }
            if ( rListaUtentes.getNomeCompleto() != null) {
                nome = rListaUtentes.getNomeCompleto();
                voInformacaoUtente.setNamedWhereClauseParam("nomeUtente",nome);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("nomeUtente","");
            }
            
            if ( rListaUtentes.getDtaNasc() != null) {
                dtaNasc = rListaUtentes.getDtaNasc().getValue();
                SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                String data = format.format(dtaNasc);
                System.out.println("DATA:::"+data);
                
                voInformacaoUtente.setNamedWhereClauseParam("dataNascimento",data);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("dataNascimento",null);
            }
            
            if ( rListaUtentes.getSexoutente() != null) {
                sexoUtente = rListaUtentes.getSexoutente();
                voInformacaoUtente.setNamedWhereClauseParam("sexoUtente",sexoUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("sexoUtente",null);
            }
            
            if ( rListaUtentes.getNomeCompleto() != null) {
                nome = rListaUtentes.getNomeCompleto();
                voInformacaoUtente.setNamedWhereClauseParam("nomeToNormal",nome);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("nomeToNormal","");
            }
            
            voInformacaoUtente.clearCache();
            voInformacaoUtente.setMaxFetchSize(-1);
            voInformacaoUtente.executeQuery(); //É preciso para no Misc.runEntidade para se saber qual o ID do Utente seleccionado
            
            if ( voListaUtentes.getEstimatedRowCount() > 0 ) {
                 request.setAttribute("search","Nova Pesquisa");
                 request.setAttribute("btstyle","submitButton buttonDisabled");
            }
        
            //Gets Utente Entity Information
            //this.setUtenteEntidadeResponsavel(ctx,voInformacaoUtente);
            
            //Because we don't clean the cache, we are only adding information 
            voInformacaoUtente.executeQuery();
            
            //In case we came from a redirect (forward action) we need to send it back to the point of origin
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            
            //String forwardAction    = "onGoBackToBaixas";
            String forwardAction    = sessionInfo.getUrlRedirect();
            String forwardContext   = sessionInfo.getUrlContext();
            
            if(session.getAttribute("isSAMCall")!=null && session.getAttribute("isSAMCall").toString() == "S" &&
                session.getAttribute("primeiraEntrada")!=null && session.getAttribute("primeiraEntrada").toString()=="N")
            {
                session.setAttribute("primeiraEntrada", "S");
            }
            
            if ( forwardAction != null){
                //clean forward action from sessionInfo object
                sessionInfo.setUrlRedirect(null);
                sessionInfo.setUrlContext(null);
                
                //Forward It
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
                ActionErrors errors = new ActionErrors();
                actionContext.setActionForward(forwardAction);
                actionContext.setActionErrors(errors);
                ((DataAction)actionContext.getAction()).saveErrors(actionContext);
                return;
            }
            
            if (forwardContext != null) {
                sessionInfo.setUrlContext(null);
                
                DCIteratorBinding dciListaParametros    = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
                ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();    
        
                //Get forward action
                voListaParametros.setPathForUrlsFromContext(forwardContext);
                voListaParametros.executeQuery(); //This Query must only return one value
                ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first(); 
                
                //Forward It
                StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
                ActionErrors errors = new ActionErrors();
                actionContext.setActionForward(rowParametros.getValText());
                actionContext.setActionErrors(errors);
                ((DataAction)actionContext.getAction()).saveErrors(actionContext);
            }
        } catch (Exception ex)  {
          log.error("",ex);
          Misc.addMessage(ctx,"","Erro ao seleccionar utente", ex.getMessage(),Misc.MSG_TYPE_ERROR);
        }
    }
    
    public void onNovaPesquisa(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
        ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
        vo.clearCache();
        vo.setMaxFetchSize(0);
    }
    
    public void onRangeChangeListaUtentes(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
        int selectedPos = 0; 
        if ( request.getParameter("nextRangeListaUtentes") != null ) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaUtentes"));
        }
        String navigationLinkButton = request.getParameter("event_RangeChangeListaUtentes");
        Misc.navigateListBox(dci,selectedPos,navigationLinkButton);
    }
    
    public void onIntegrateSAMBaixas(PageLifecycleContext ctx) {
        
        DCIteratorBinding dciInformacaoUtente = (DCIteratorBinding) ctx.getBindingContainer().get("InformacaoUtenteIterator");
        ViewObject voInformacaoUtente = dciInformacaoUtente.getViewObject();
        
        DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
        ViewObject voListaUtentes = dciListasUtentes.getViewObject();
        
        IdentificacaoUtenteModuleImpl am = (IdentificacaoUtenteModuleImpl) voListaUtentes.getApplicationModule();

        String pnir = request.getParameter("nir");

        Collection params = new LinkedList();
        params.add(new Object[][]{{"Number","nir", pnir }});
        am.listaUtentesAddWhereClause(params, new Number(0));
        
        ListaUtentesRowImpl rListaUtentes = null;
        Row[] rows = voListaUtentes.getAllRowsInRange();
        
        for ( int i=0 ; i < rows.length ; i++ ) {
            rListaUtentes = (ListaUtentesRowImpl) rows[i];
        }

        Number idUtente;
        Number idHistEntUtente;
        Number nir;
        Number niss;
        String numId;
        String nome;
        String entResp;
        java.util.Date dtaNasc;
        String sexoUtente;

        
        
        
        if (rListaUtentes != null) { 
            if ( rListaUtentes.getIiuId() != null) {
                idUtente = rListaUtentes.getIiuId();
                voInformacaoUtente.setNamedWhereClauseParam("idUtente",idUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("idUtente",new Integer(-1));
            }
            if ( rListaUtentes.getIheId() != null) {
                idHistEntUtente = rListaUtentes.getIheId();
                voInformacaoUtente.setNamedWhereClauseParam("idHistEntUtente",idHistEntUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("idHistEntUtente",new Integer(-1));
            }
            if ( rListaUtentes.getNir() != null) {
                nir = rListaUtentes.getNir();
                voInformacaoUtente.setNamedWhereClauseParam("numUtente",nir);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numUtente",new Integer(-1));
            }
            if ( rListaUtentes.getNiss() != null) {
                niss = rListaUtentes.getNiss();
                voInformacaoUtente.setNamedWhereClauseParam("numSSocial",niss);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numSSocial",new Integer(-1));
            }
            if ( rListaUtentes.getNumId() != null) {
                numId = rListaUtentes.getNumId();
                voInformacaoUtente.setNamedWhereClauseParam("numBI",numId);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("numBI","");
            }
            if ( rListaUtentes.getNomeCompleto() != null) {
                nome = rListaUtentes.getNomeCompleto();
                voInformacaoUtente.setNamedWhereClauseParam("nomeUtente",nome);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("nomeUtente","");
            }
            if ( rListaUtentes.getEntrespDesig() != null) {
                entResp = rListaUtentes.getEntrespDesig();
                voInformacaoUtente.setNamedWhereClauseParam("entResp",entResp);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("entResp","");
            }
            if ( rListaUtentes.getDtaNasc() != null) {
                    dtaNasc = rListaUtentes.getDtaNasc().getValue();
                    SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
                    String data = format.format(dtaNasc);
                    System.out.println("DATA:::"+data);
                    
                    voInformacaoUtente.setNamedWhereClauseParam("dataNascimento",data);
                } else {
                    voInformacaoUtente.setNamedWhereClauseParam("dataNascimento",null);
                }
            
            if ( rListaUtentes.getSexoutente() != null) {
                sexoUtente = rListaUtentes.getSexoutente();
                voInformacaoUtente.setNamedWhereClauseParam("sexoUtente",sexoUtente);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("sexoUtente",null);
            }
            
            if ( rListaUtentes.getNomeCompleto() != null) {
                nome = rListaUtentes.getNomeCompleto();
                voInformacaoUtente.setNamedWhereClauseParam("nomeToNormal",nome);
            } else {
                voInformacaoUtente.setNamedWhereClauseParam("nomeToNormal","");
            }
            
            voInformacaoUtente.clearCache();
            voInformacaoUtente.setMaxFetchSize(-1);
            voInformacaoUtente.executeQuery(); //É preciso para no Misc.runEntidade para se saber qual o ID do Utente seleccionado
            
            //Gets Utente Entity Information
            //this.setUtenteEntidadeResponsavel(ctx,voInformacaoUtente);
        }
        
        StrutsPageLifecycleContext actionContext = (StrutsPageLifecycleContext)ctx;
        actionContext.setActionForward("onIntegrateSAMBaixas");
        
    }
    
    private void listaPaises(LifecycleContext ctx){
        DCIteratorBinding dciPaises = (DCIteratorBinding) ctx.getBindingContainer().get("ListaPaisesLovIterator");
        ViewObject voPaises = dciPaises.getViewObject();
        if(voPaises.getCurrentRow()==null){
            voPaises.setWhereClause("SYS_TIPOS_CODIGOS_ID = ( SELECT ID FROM SYS_TIPOS_CODIGOS WHERE COD_TIPO = 'PAIS' )");
            voPaises.setOrderByClause("DESCRICAO");
            voPaises.setMaxFetchSize(-1);
            voPaises.executeQuery();
        }
   }
   
    private void listaDistritos(LifecycleContext ctx){
        DCIteratorBinding dciDistritos = (DCIteratorBinding) ctx.getBindingContainer().get("ListaDistritosLovIterator");
        ViewObject voDistritos = dciDistritos.getViewObject();
        IdentificacaoUtenteModuleImpl am = (IdentificacaoUtenteModuleImpl) voDistritos.getApplicationModule();
        try {
            am.getListaDistritos();
        } catch (Exception e) {
             log.error("ora.pt.cons.igif.sics.controller.idu.IduEdicaoPageController.listaDistritos",e);
             Misc.addMessage(ctx,"","Erro ao obter lista de Distritos", "",Misc.MSG_TYPE_ERROR);
        }
    }
    
    
    public void onLimpar(PageLifecycleContext ctx) {
        DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesIterator");
        ViewObjectImpl voListaUtentes = (ViewObjectImpl)dciListasUtentes.getViewObject();
        voListaUtentes.clearCache();
        voListaUtentes.executeEmptyRowSet();
    }
}
