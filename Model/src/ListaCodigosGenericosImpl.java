package ora.pt.cons.igif.sics.suporte;


import oracle.jbo.server.TransactionEvent;
import ora.pt.cons.igif.sics.ViewObjectImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaCodigosGenericosImpl extends ViewObjectImpl {
    /**This is the default constructor (do not remove)
     */
    public ListaCodigosGenericosImpl() {
    }
    
    public void beforeRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.beforeRollback(transactionEvent);
    }

    public void afterRollback(TransactionEvent transactionEvent) {
        // -- 24.04.2008 comentado para que em caso de rollback o estado da ViewObject seja mantido
        // super.afterRollback(transactionEvent);
    }

    public long getEstimatedRowCount() {
        return this.getRowCount();
        //return super.getEstimatedRowCount();
    }
    
    public void listaCodigosGenericosCodTipExecutesQuery(String tipoCodigo, String scgCodigo) {
        ListaCodigosGenericosImpl listaCodigosGenericosVO = this;
        listaCodigosGenericosVO.clearWhereState();
        
        //Sets the query look for cods related with this Domain (tipoCodigo)
        listaCodigosGenericosVO.clearCache();
        listaCodigosGenericosVO.setMaxFetchSize(-1);
        listaCodigosGenericosVO.setWhereClause(  "TipoCodigo_CODTIPO = '" +
                                                  tipoCodigo + "'" + 
                                                  " AND CODIGO = '" + scgCodigo + 
                                                  "'");        
        listaCodigosGenericosVO.executeQuery();
    }     
}
