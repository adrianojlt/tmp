package ora.pt.cons.igif.sics.suporte.client;

import oracle.jbo.client.remote.RowImpl;
import oracle.jbo.domain.Number;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaCodigosGenericosRowClient extends RowImpl {
    /**This is the default constructor (do not remove)
     */
    public ListaCodigosGenericosRowClient() {
    }

    public Number getId() {
        return (Number)getAttribute("Id");
    }
}