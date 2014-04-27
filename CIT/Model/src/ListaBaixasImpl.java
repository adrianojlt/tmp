package ora.pt.cons.igif.sics.baixas;

import oracle.jbo.domain.Number;
import oracle.jbo.server.TransactionEvent;
import ora.pt.cons.igif.sics.ViewObjectImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaBaixasImpl extends ViewObjectImpl {
    /**This is the default constructor (do not remove)
     */
    public ListaBaixasImpl() {
    }

    /**Gets the bind variable value for idUtente
     */
    public Number getidUtente() {
        return (Number)getNamedWhereClauseParam("idUtente");
    }

    /**Sets <code>value</code> for bind variable idUtente
     */
    public void setidUtente(Number value) {
        setNamedWhereClauseParam("idUtente", value);
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