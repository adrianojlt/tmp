package ora.pt.cons.igif.sics.utentes;

import oracle.jbo.server.TransactionEvent;
import ora.pt.cons.igif.sics.ViewObjectImpl;

import org.apache.log4j.Logger;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaAgregadoFamiliarImpl extends ViewObjectImpl {
    
    private static Logger log = Logger.getLogger(IdentificacaoUtenteModuleImpl.class);
    
    /**This is the default constructor (do not remove)
     */
    public ListaAgregadoFamiliarImpl() {
        log.info("ListaAgregadoFamiliarImpl instanciada");
    }
    
    public void beforeRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.beforeRollback(transactionEvent);
    }

    public void afterRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.afterRollback(transactionEvent);
    }
    
    public void getListaAgregadoFamiliarWithIdUtente(String iduIdentUtId) throws Exception{
        try  {
            //ListaAgregadoFamiliarImpl vo = this.getListaAgregadoFamiliar();
            if(iduIdentUtId.length()>0){
                log.debug("vou obter agregado para o Utente " + iduIdentUtId);
                this.clearWhereState(); 
                this.clearCache();
                this.setMaxFetchSize(-1);
                this.setWhereClause("idu_familia_id = (select fam.idu_familia_id from idu_inscr ins, idu_hist_familia fam where ins.idu_ident_ut_id = " + iduIdentUtId+ " and ins.data_fim is null and fam.data_fim is null and ins.id = fam.idu_inscr_id)");
                this.executeQuery();
            } else {
                this.setMaxFetchSize(0);
                this.executeQuery();
            }
        } catch (Exception ex)  {
          log.error("Erro ao obter agregado famíliar para o Utente " + iduIdentUtId ,ex);
          throw new Exception("Erro ao obter agregado do Utente:" + ex.getMessage());
        }
    }
}
