package ora.pt.cons.igif.sics.suporte.common;

import oracle.jbo.common.JboResourceBundle;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---------------------------------------------------------------------
public class FeriadoImplMsgBundle extends JboResourceBundle {


    static final Object[][] sMessageStrings = 
    {
{ "Data_FMT_FORMATTER", "oracle.jbo.format.DefaultDateFormatter" },
{ "Data_FMT_FORMAT", "dd-MM-yyyy" }};

    /**This is the default constructor (do not remove)
     */
    public FeriadoImplMsgBundle() {
    }

    /**@return an array of key-value pairs.
     */
    public Object[][] getContents() {
        return super.getMergedArray(sMessageStrings, super.getContents());
    }
}
