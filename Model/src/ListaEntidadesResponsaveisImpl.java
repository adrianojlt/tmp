package ora.pt.cons.igif.sics.suporte;

import oracle.jbo.server.TransactionEvent;
import ora.pt.cons.igif.sics.ViewObjectImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaEntidadesResponsaveisImpl extends ViewObjectImpl {
    /**This is the default constructor (do not remove)
     */
    public ListaEntidadesResponsaveisImpl() {
    }


    /**Gets the bind variable value for idUtente
     */
    public String getidUtente() {
        return (String)getNamedWhereClauseParam("idUtente");
    }

    /**Sets <code>value</code> for bind variable idUtente
     */
    public void setidUtente(String value) {
        setNamedWhereClauseParam("idUtente", value);
    }

    /**Gets the bind variable value for tipoEntidade
     */
    public String gettipoEntidade() {
        return (String)getNamedWhereClauseParam("tipoEntidade");
    }

    /**Sets <code>value</code> for bind variable tipoEntidade
     */
    public void settipoEntidade(String value) {
        setNamedWhereClauseParam("tipoEntidade", value);
    }
    
    public void beforeRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.beforeRollback(transactionEvent);
    }

    public void afterRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.afterRollback(transactionEvent);
    }
}
