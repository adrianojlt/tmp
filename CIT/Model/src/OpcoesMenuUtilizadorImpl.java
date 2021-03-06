package ora.pt.cons.igif.sics;

import oracle.jbo.server.TransactionEvent;
import ora.pt.cons.igif.sics.ViewObjectImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class OpcoesMenuUtilizadorImpl extends ViewObjectImpl {
    /**This is the default constructor (do not remove)
     */
    public OpcoesMenuUtilizadorImpl() {
    }

    /**Gets the bind variable value for perfil
     */
    public String getperfil() {
        return (String)getNamedWhereClauseParam("perfil");
    }

    /**Sets <code>value</code> for bind variable perfil
     */
    public void setperfil(String value) {
        setNamedWhereClauseParam("perfil", value);
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
