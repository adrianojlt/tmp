package ora.pt.cons.igif.sics.client;

import ora.pt.cons.igif.sics.common.ListaParametros;

import oracle.jbo.client.remote.ViewUsageImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaParametrosClient extends ViewUsageImpl implements ListaParametros {
    /**This is the default constructor (do not remove)
     */
    public ListaParametrosClient() {
    }


    public void setPathForUrlsRedirect() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsRedirect",null,null);
        return;
    }

    public void setPathForUrlsRedirectBaixa() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsRedirectBaixa",null,null);
        return;
    }

    public String getPath() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"getPath",null,null);
        return (String)_ret;
    }

    public void setPath(String value) {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPath",new String [] {"java.lang.String"},new Object[] {value});
        return;
    }

    public void setPathForUrlsRedirectPesquisaUtente() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsRedirectPesquisaUtente",null,null);
        return;
    }

    public void setPathForUrlsRedirectReceitas() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsRedirectReceitas",null,null);
        return;
    }

    public void setPathForUrlsFromContext(String context) {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsFromContext",new String [] {"java.lang.String"},new Object[] {context});
        return;
    }

    public long getEstimatedRowCount() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"getEstimatedRowCount",null,null);
        return ((Long)_ret).longValue();
    }

    public void setPathForReportServerUrl() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForReportServerUrl",null,null);
        return;
    }

    public void setPathForReportsMedParam() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForReportsMedParam",null,null);
        return;
    }

    public void setPathForReportsGitParam() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForReportsGitParam",null,null);
        return;
    }

    public void setPathForUrlsRedirectAdminSinc() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForUrlsRedirectAdminSinc",null,null);
        return;
    }

    public void setPathForReportsIdentificacaoParam() {
        Object _ret = 
            getApplicationModuleProxy().riInvokeExportedMethod(this,"setPathForReportsIdentificacaoParam",null,null);
        return;
    }
}
