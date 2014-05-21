package ora.pt.cons.igif.sics.controller.com;

import java.io.PrintWriter;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.common.ListaParametros;
import ora.pt.cons.igif.sics.common.ListaParametrosRow;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.gmf.GestaoMedicosFamiliaImpl;
import ora.pt.cons.igif.sics.suporte.ModulosSuporteModuleImpl;
import ora.pt.cons.igif.sics.utentes.IdentificacaoUtenteModuleImpl;

import ora.pt.cons.igif.sics.utils.DataValidationException;
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
            
            log.debug("event:<"+request.getParameter("event")+">");
            
            // -- dar ordem de nao carregamento de view
            // nota: as view serão carregadas apenas qdo necessárias
            // obter ligacao à imlementacao do modulo de identificacao
            
            DCIteratorBinding dci = (DCIteratorBinding)context.getBindingContainer().get("ListaAgregadoFamiliarIterator");
            ViewObject vo = dci.getViewObject();
            amIdent = (IdentificacaoUtenteModuleImpl)vo.getApplicationModule();
            
            
            
        } catch(Exception ex){
          log.error("Erro no prepareModel", ex);
          Misc.addMessage(context,"as001","Erro no prepareModel",ex.getMessage(),Misc.MSG_TYPE_ERROR);
        }
        super.prepareModel(context);
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
            boolean viaNovoUtente = request.getParameter("viaNovoUtente")!=null?request.getParameter("viaNovoUtente").equals("true"):false;
            String centroSaudeMae= request.getParameter("centroSaudeMae")!=null?  request.getParameter("centroSaudeMae").toString():null; 
            String centroSaudeUsar = (viaNovoUtente&&centroSaudeMae!=null)?centroSaudeMae:centroSaude;
            String[] grausAtribuidos =  amIdent.getParentescosAtribuidos(idFamilia);
            DCIteratorBinding  dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaCodigosGenericos1Iterator");
            ViewObject vo = dci.getViewObject();
            vo.clearCache();
            vo.setMaxFetchSize(-1);
            String whereClause = "TipoCodigo_codtipo IN ('PARE') AND ";
            whereClause = whereClause.concat("( tipocod_central = 'S' OR ( tipocod_central = 'N' AND scg_sys_entidades_id = " + centroSaudeUsar + ") ) ");
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
    
    public void onGetListaDocsMigrantes(PageLifecycleContext ctx) throws Exception {
        try{
            // para a familia em causa obter parentescos já atribuidos
            String codPais = request.getParameter("codPais")!=null?request.getParameter("codPais"):"";
            DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaTiposCartaoEntidadeIterator");
            ViewObject vo = dci.getViewObject();
            if(codPais.length()>0){
                ModulosSuporteModuleImpl am = (ModulosSuporteModuleImpl)vo.getApplicationModule();
                String extraClause = " and IDU.IS_DOC_ASSOCIADO( Codigo , '" + codPais + "') = 1 ";
                am.listaCodigosGenericosGeral("MIGA_MTDOC",null,null,am.tiposCartaoEntidade,extraClause);
            }
        } catch(Exception e){
          log.error("", e);
          try{
                PrintWriter out = response.getWriter();
                out.print("-1");
          } catch(Exception ex){} 
        }
    }

    public void onRangeChangeListaHistoricoEstadoInscricao(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaListaHistoricoEstadoInscricaoIterator");
            int selectedPos = 0;
            if ( request.getParameter("nextRangeListaHistoricoEstadoInscricao") != null ) {
                selectedPos = Integer.parseInt(request.getParameter("nextRangeListaHistoricoEstadoInscricao"));
            }
            String navigationLinkButton = request.getParameter("event_RangeChangeListaHistoricoEstadoInscricao");
            Misc.navigateListBox(dci,selectedPos,navigationLinkButton);  
        } catch(Exception e){
            
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
    
    public void onGetListaEntidades(PageLifecycleContext ctx) {
        try{
            String idEntidade = request.getParameter("idEntidade")!=null?request.getParameter("idEntidade"):"";
            String dominio = request.getParameter("dominio")!=null?request.getParameter("dominio"):"";
            
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            ModulosSuporteModuleImpl am = (ModulosSuporteModuleImpl)vo.getApplicationModule();
            am.listaEntidades(dominio, idEntidade);
        } catch(Exception e){
          log.error("",e);
        }
    }
    
    
    /* Métodos Indicadores */
    public void onGetIndicadoresMedicosFamiliaUnidade(PageLifecycleContext ctx) {
         try{
             String idUnidade = request.getParameter("idUnidade")!=null?request.getParameter("idUnidade"):"";
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaIndicadorMedEntidadeIterator");
             ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
             GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
             am.listaIndicadorMedEntidade(idUnidade);
         } catch(Exception e){
           log.error("",e);
         }
    }
    
    public void onGetIndicadoresGMF(PageLifecycleContext ctx) {
         try{
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaIndicadoresIterator");
             ViewObject vo = dci.getViewObject();
             GestaoMedicosFamiliaImpl gmfi = (GestaoMedicosFamiliaImpl) vo.getApplicationModule();
             String idEntidade = request.getParameter("idEntidade")!=null?request.getParameter("idEntidade"):"";
             gmfi.listaIndicadores(idEntidade);
         } catch(Exception e){
           log.error("",e);
         }
    }    
    
    public void onListaUnisCs(PageLifecycleContext ctx) {
         try{
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesIterator");
             ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
             ModulosSuporteModuleImpl am = (ModulosSuporteModuleImpl)vo.getApplicationModule();
             String idEntidade = request.getParameter("idEntidade")!=null?request.getParameter("idEntidade"):"";
             am.listaEntidadesUNIS(idEntidade);
         } catch(Exception e){
           log.error("",e);
         }
    }  
    
    public void onGetListaMedicosDestino(PageLifecycleContext ctx) {
         try{
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaMedicosFamiliaDestinoIterator");
             ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
             GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
             String idEquipa = request.getParameter("idEquipa")!=null?request.getParameter("idEquipa"):"";
             String idUnidade = request.getParameter("idEntidade")!=null?request.getParameter("idEntidade"):"";
             am.listaMedicosFamiliaDestino(idUnidade,idEquipa);
         } catch(Exception e){
           log.error("",e);
         }
    }  
    
    public void onGetListaMedicosFamiliaPorUnis(PageLifecycleContext ctx) {
         try{
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaMedicosFamiliaDestinoIterator");
             ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
             GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
             String idUnis = request.getParameter("idUnis")!=null?request.getParameter("idUnis"):"";
             am.listaMedicosFamilia(idUnis);
         } catch(Exception e){
           log.error("",e);
         }
    }  
    
    
    public void onGetListaGruposPorUnis(PageLifecycleContext ctx) {
         try{
             DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaGruposIterator");
             ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
             GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
             String idUnis = request.getParameter("idUnis")!=null?request.getParameter("idUnis"):"";
             am.listaGrupos(idUnis);
         } catch(Exception e){
           log.error("",e);
         }
    }  
    
    
    public void onGetObitosParaIndicadores(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaObitosIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
            String idUnis = request.getParameter("idUnidade")!=null?request.getParameter("idUnidade"):"";
            String tipoUnis = request.getParameter("tipoUnis")!=null?request.getParameter("tipoUnis"):"";
            
            String dtaObitDe = request.getParameter("dtaObitDe")!=null?request.getParameter("dtaObitDe"):null;
            String dtaObitA = request.getParameter("dtaObitA")!=null?request.getParameter("dtaObitA"):null;
            String dtaNascDe = request.getParameter("dtaNascDe")!=null?request.getParameter("dtaNascDe"):null;
            String dtaNascA = request.getParameter("dtaNascA")!=null?request.getParameter("dtaNascA"):null;
            
            String medico = request.getParameter("med")!=null?request.getParameter("med"):null;
            
            am.ListaObitosIndicadores(idUnis,tipoUnis,dtaObitDe,dtaObitA,dtaNascDe, dtaNascA, medico);
        } catch(Exception e){
          log.error("",e);
        }
    }
    
    public void onRangeChangeListaObitos(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaObitosIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        if (request.getParameter("nextRangeListaObitos") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaObitos"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaObitos");
        Misc.navigateListBox(dci, selectedPos, navigationLinkButton);
    }
    
    public void onGetNovosUtentesParaListagens(PageLifecycleContext ctx) {
        DCIteratorBinding dciListasUtentes = (DCIteratorBinding) ctx.getBindingContainer().get("ListaNovosUtentesIterator");
        ViewObjectImpl voListaUtentes = (ViewObjectImpl)dciListasUtentes.getViewObject();
        
        DCIteratorBinding dciE = (DCIteratorBinding) ctx.getBindingContainer().get("ListaEntidadesCSIterator");
        ViewObject voE = dciE.getViewObject(); 
        ModulosSuporteModuleImpl ams = (ModulosSuporteModuleImpl)voE.getApplicationModule();
        
        voListaUtentes.clearCache();
        String unisId = null;
        String ars = null;
        String aces = null;
        String centro = null;
        String medicoId = null;
        String dataDe = null;
        String dataA = null;
        
        
        try{
        // Unidade Saude
        //unisId = request.getParameter("hiddenUSDefaultDestinoValue")==null?"":request.getParameter("hiddenUSDefaultDestinoValue");
        unisId = request.getParameter("us")==null?"":request.getParameter("us"); 
        if(unisId==null || unisId.trim().equals("")) {
            unisId = request.getParameter("hiddenPpUS")==null?"":request.getParameter("hiddenPpUS"); 
        }
        
        ars = request.getParameter("ars")!=null?request.getParameter("ars").trim():"";
        aces = request.getParameter("aces")!=null?request.getParameter("aces").trim():"";
        centro = request.getParameter("cs")!=null?request.getParameter("cs").trim():"";
        
        Object[] unidades = null;
        if(unisId.length()>0){
            unidades = new Object[1];
            unidades[0] = unisId;
        } else if(centro.length()>0){
            unidades = ams.devolveEntidadesHieInf(centro);
            request.setAttribute("procuraPorTodasAsUnidades", true);
        } else if(aces.length()>0){
            unidades = ams.devolveUnisDaAces(aces);
            request.setAttribute("procuraPorTodasAsUnidades", true);
        } else if(ars.length()>0){
            unidades = ams.devolveUnisDaArs(ars);
            request.setAttribute("procuraPorTodasAsUnidades", true);
        }
            
        
        // Medico
        medicoId = request.getParameter("ppMedicoFamilia")==null?"":request.getParameter("ppMedicoFamilia");
        // Data De
        dataDe = request.getParameter("dataNascDe")==null?"":request.getParameter("dataNascDe");
        // Data A
        dataA = request.getParameter("dataNascA")==null?"":request.getParameter("dataNascA");
        
        if(unidades == null || unidades.length ==0){
             throw new DataValidationException("Deve seleccionar uma Unidade de Saúde, Centro de Saúde, ACES ou ARS");
        }
        
        java.util.Date dataDeFinal = null;
        if (dataDe.length()>0) {
            // -- converter string para Date 
            try {
                dataDeFinal = DateUtils.parseToDate(dataDe, DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            } catch (Exception e) {
                throw new DataValidationException("Data final com formato errado");
            }
        }
        
        java.util.Date dataAFinal = null;
        if (dataA.length()>0) {
            try {
                dataAFinal = DateUtils.parseToDate(dataA, DateUtils.DATE_FORMAT_STYLE_DEFAULT);
            } catch (Exception e) {
                throw new DataValidationException("Data inicial com formato errado");
            }
        }
        
        DCIteratorBinding dciListaParametros = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
        ListaParametros voListaParametros = (ListaParametros)dciListaParametros.getViewObject();    
          
        voListaParametros.setNamedWhereClauseParam("Path", ".ROOT.SNU.IDU.PESQUISA_UTENTE.MAX_FETCH_SIZE");
        voListaParametros.executeQuery(); //This Query must only return one value
        ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first();
        IdentificacaoUtenteModuleImpl am = (IdentificacaoUtenteModuleImpl) voListaUtentes.getApplicationModule();
        Number maxFetchSizePesquisa = rowParametros.getValNumber();
        int a = am.listaNovosUtentesAddWhereClause(medicoId, unidades, dataDeFinal, dataAFinal, maxFetchSizePesquisa);
        
        if(a==maxFetchSizePesquisa.intValue()-1){
            Misc.addMessage(ctx, "1", "Demasiados registos encontrados. Por favor redefina a sua pesquisa.", "", Misc.MSG_TYPE_WARNG);
        }
        
        if(a==0){
            request.setAttribute("pesquisaFoiEfectuada","S");
        }
        
        }catch(DataValidationException e)
        {
            log.error(e);
            Misc.addMessage(ctx, "", "Erro ao efectuar a pesquisa de novos utentes.", e.getMessage(), Misc.MSG_TYPE_ERROR);
        }catch(Exception e1){
            log.error(e1);
            Misc.addMessage(ctx, "", "Erro ao efectuar a pesquisa de novos utentes.", e1.getMessage(), Misc.MSG_TYPE_ERROR);
        }
    }
    
    public void onRangeChangeListaNovosUtentes(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaNovosUtentesIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        if (request.getParameter("nextRangeListaNovosUtentes") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaNovosUtentes"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaNovosUtentes");
        Misc.navigateListBox(dci, selectedPos, navigationLinkButton);
    }
    
    public void onGetListaFreguesiasPesquisaListas(PageLifecycleContext ctx) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaFreguesiasDeFamiliaUnidadeIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            GestaoMedicosFamiliaImpl am = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
            String idUnis = request.getParameter("idUnis")!=null?request.getParameter("idUnis"):"";
            am.listaFreguesiaDeFamilias(idUnis);
        } catch(Exception e){
                   log.error("",e);
        }
    }
    

    
    public void onRangeChangeListaUtentesGrupo(PageLifecycleContext ctx) {
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("ListaUtentesGrupoIterator");
        int selectedPos = 0;
        String navigationLinkButton;
        if (request.getParameter("nextRangeListaUtentesGrupo") != null) {
            selectedPos = Integer.parseInt(request.getParameter("nextRangeListaUtentesGrupo"));
        }
        navigationLinkButton = request.getParameter("event_RangeChangeListaUtentesGrupo");
        Misc.navigateListBox(dci, selectedPos, navigationLinkButton);
    }    
    
    public void onGetListasOutros(PageLifecycleContext context){
        try {
                
            request = (HttpServletRequest)context.getEnvironment().getRequest();
            session = request.getSession(false);
            
            String idEquipa = request.getParameter("idEquipa") != null && !(request.getParameter("idEquipa").trim().equals("0"))? request.getParameter("idEquipa") : "";
            String p_grupo = request.getParameter("idGrupo") != null ? request.getParameter("idGrupo") :  "null";
            String p_entidadeid = request.getParameter("idUnidade") != null ? request.getParameter("idUnidade") : "";
            String p_proequipa =request.getParameter("proequipa") != null ? request.getParameter("proequipa") : "null";
            String p_dta_nascimento = request.getParameter("dta_nascimento") != null ? "'" + request.getParameter("dta_nascimento") + "'" : "null";
            String p_idade_ini = request.getParameter("idade_ini") != null ? "'" + request.getParameter("idade_ini") + "'" : "null";
            String p_idade_fim = request.getParameter("idade_fim") != null ? "'" + request.getParameter("idade_fim") + "'" : "null";
            String p_sexo =request.getParameter("sexo") != null ? "'" + request.getParameter("sexo") + "'" : "null";
            String p_tipo = request.getParameter("tipo") != null ? "'" + request.getParameter("tipo") + "'" : "null";
            String p_sem_medico =request.getParameter("sem_medico") != null ? "'" +request.getParameter("sem_medico") + "'" : "null";
            String p_top =request.getParameter("top") != null ? "'" + request.getParameter("top") + "'" : "null";
                
            String p_freguesias =request.getParameter("freguesias") != null ? request.getParameter("freguesias") : "";
            
            DCIteratorBinding dci =(DCIteratorBinding)context.getBindingContainer().get("ListaUtentesGrupoIterator");
            ViewObject vo = dci.getViewObject();
            GestaoMedicosFamiliaImpl gmfi = (GestaoMedicosFamiliaImpl)vo.getApplicationModule();
            gmfi.listaUtentesPorGrupo("", p_entidadeid,
                                                               p_proequipa, p_dta_nascimento,
                                                               p_idade_ini, p_idade_fim,
                                                               p_sexo, p_tipo, p_sem_medico,
                                                               p_top, p_freguesias, p_grupo);
              
            
        } catch (Exception ex) {
            log.error("", ex);
            Misc.addMessage(context, "", "", "", Misc.MSG_TYPE_ERROR);
        }
    
    
    }
    public void naoCarregarIterador(LifecycleContext ctx, String it){
        DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get(it);
        ViewObject vo = dci.getViewObject();
        vo.reset();
        vo.clearCache();
        vo.setMaxFetchSize(0);

    }
    
    public void onValidateDoc(PageLifecycleContext ctx) {
        try{
            String idTipoId = request.getParameter("idTipoId")!=null?request.getParameter("idTipoId"):null;
            String numId = request.getParameter("numId")!=null?request.getParameter("numId"):null;
            String nif = request.getParameter("nif")!=null?request.getParameter("nif"):null;
            String niss = request.getParameter("niss")!=null?request.getParameter("niss"):null;
            String idUtente = request.getParameter("idUtente")!=null?request.getParameter("idUtente"):null;
            
            if (nif!=null){
                boolean isNifValid =  amIdent.validarDocumento('F', nif);
                if (!isNifValid){
                    request.setAttribute("InvalidNif", "true");
                } else{
                    request.setAttribute("InvalidNif", "");
                    int nDuplicados = amIdent.listaUtentesNifDuplicado(idUtente,nif);
                    if (nDuplicados>0){
                        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesNifDuplicadoIterator");
                        ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
                    }
                    else {naoCarregarIterador(ctx,"ListaUtentesNifDuplicadoIterator" );}
                }
                
            } else {request.setAttribute("InvalidNif", "");}
                
             if (niss!=null ){
                  boolean isNissValid =  amIdent.validarDocumento('N', niss);
                 if (!isNissValid){
                      request.setAttribute("InvalidNiss", "true");
                } else{
                     request.setAttribute("InvalidNiss", "");
                     int nDuplicados = amIdent.listaUtentesNissDuplicado(idUtente,niss);
                     if (nDuplicados>0){
                         DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesNissDuplicadoIterator");
                         ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
                     }
                     else {naoCarregarIterador(ctx,"ListaUtentesNissDuplicadoIterator" );}
                 }     
            } else {request.setAttribute("InvalidNiss", "");}
            
            if (numId!=null ){
            
                    int nDuplicados = amIdent.listaUtentesDocIdentDuplicado(idUtente,idTipoId,numId);
                    if (nDuplicados>0){
                        DCIteratorBinding dci = (DCIteratorBinding) ctx.getBindingContainer().get("ListaUtentesDocIdentDuplicadoIterator");
                        ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
                    }
                    else {naoCarregarIterador(ctx,"ListaUtentesDocIdentDuplicadoIterator" );}
                }     
            
        
        } catch(Exception e){
          log.error("",e);
        }
    }



    public void onValidateMaternidade(PageLifecycleContext ctx) {
    
        String codigoPerfil = request.getParameter("codigoPerfil");
        String IinId = request.getParameter("IinId");

        int rowCount = amIdent.listaUsersMaternidadeByIduInscrId(IinId);
        
        request.setAttribute("editable", "10");
        //request.setAttribute("editable", "false");
    }
}
