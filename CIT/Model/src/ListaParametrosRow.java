package ora.pt.cons.igif.sics.common;

import oracle.jbo.Row;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---------------------------------------------------------------------
public interface ListaParametrosRow extends Row {
    String getNome();

    void setNome(String value);

    String getValText();

    void setValText(String value);

    Number getValNumber();

    void setValNumber(Number value);

    Date getValDate();

    void setValDate(Date value);
}
