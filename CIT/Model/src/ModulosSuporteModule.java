package ora.pt.cons.igif.sics.suporte.common;

import oracle.jbo.ApplicationModule;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---------------------------------------------------------------------
public interface ModulosSuporteModule extends ApplicationModule {
    void listaCodigosGenericosExecutesQuery(String tipoCodigo);

    void listaCodigosGenericos1ExecutesQuery(String tipoCodigo);

    void listaCodigosGenericos1ExecutesQuery(String tipoCodigo,
                                             Integer sysEntidadesId);


    void listaCodigosGenericosCodTipExecutesQuery(String tipoCodigo,
                                                  String scgCodigo);

    void listaCodigosGenericos2CodTipExecutesQuery(String tipoCodigo,
                                                   String scgCodigo);

    void listaCodigosGenericos3CodTipExecutesQuery(String tipoCodigo,
                                                   String scgCodigo);
}