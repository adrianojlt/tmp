package ora.pt.cons.igif.sics.utentes;

import oracle.jbo.RowIterator;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.domain.RowID;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.ViewRowImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class ListaUtentesRowImpl extends ViewRowImpl {
    public static final int IIUID = 0;
    public static final int ROWID1 = 31;
    public static final int IINID = 1;
    public static final int NOMECOMPLETO = 2;
    public static final int NISS = 3;
    public static final int NIR = 4;
    public static final int NOMESPROPRIOS = 5;
    public static final int APELIDOS = 6;
    public static final int NOP = 7;
    public static final int DTANASC = 8;
    public static final int NUMID = 9;
    public static final int CODIGOID = 10;
    public static final int TIPOID = 11;
    public static final int CSAUDECOD = 12;
    public static final int CSAUDEDESIG = 13;
    public static final int PAISNATALIDADE = 14;
    public static final int PAISNATALIDADEID = 15;
    public static final int PAISNACIONALIDADE = 16;
    public static final int PAISNACIONALIDADEID = 17;
    public static final int DISTRITO = 18;
    public static final int DISTRITOID = 19;
    public static final int CONCELHO = 20;
    public static final int CONCELHOID = 21;
    public static final int FREGUESIA = 22;
    public static final int FREGUESIAID = 23;
    public static final int MORADA = 24;
    public static final int IDADE = 25;
    public static final int NUMBENEF = 26;
    public static final int IHEID = 27;
    public static final int ENTRESPDESIG = 28;
    public static final int ENTRESPABRV = 29;
    public static final int CSAUDEID = 30;
    public static final int OBITO = 31;
    public static final int TABINSCR = 32;
    public static final int IDPPOTDUP = 33;
    public static final int SEXOUTENTE = 34;
    public static final int NOMENORMALIZADO = 35;

    /**This is the default constructor (do not remove)
     */
    public ListaUtentesRowImpl() {
    }

    /**Gets the attribute value for the calculated attribute IiuId
     */
    public Number getIiuId() {
        return (Number) getAttributeInternal(IIUID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute IiuId
     */
    public void setIiuId(Number value) {
        setAttributeInternal(IIUID, value);
    }

    /**Gets the attribute value for the calculated attribute NomeCompleto
     */
    public String getNomeCompleto() {
        return (String) getAttributeInternal(NOMECOMPLETO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NomeCompleto
     */
    public void setNomeCompleto(String value) {
        setAttributeInternal(NOMECOMPLETO, value);
    }

    /**Gets the attribute value for the calculated attribute Niss
     */
    public Number getNiss() {
        return (Number) getAttributeInternal(NISS);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Niss
     */
    public void setNiss(Number value) {
        setAttributeInternal(NISS, value);
    }

    /**Gets the attribute value for the calculated attribute Nir
     */
    public Number getNir() {
        return (Number) getAttributeInternal(NIR);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Nir
     */
    public void setNir(Number value) {
        setAttributeInternal(NIR, value);
    }

    /**Gets the attribute value for the calculated attribute NomesProprios
     */
    public String getNomesProprios() {
        return (String) getAttributeInternal(NOMESPROPRIOS);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NomesProprios
     */
    public void setNomesProprios(String value) {
        setAttributeInternal(NOMESPROPRIOS, value);
    }

    /**Gets the attribute value for the calculated attribute Apelidos
     */
    public String getApelidos() {
        return (String) getAttributeInternal(APELIDOS);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Apelidos
     */
    public void setApelidos(String value) {
        setAttributeInternal(APELIDOS, value);
    }

    /**Gets the attribute value for the calculated attribute Numbenef
     */
    public String getNumbenef() {
        return (String) getAttributeInternal(NUMBENEF);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Numbenef
     */
    public void setNumbenef(String value) {
        setAttributeInternal(NUMBENEF, value);
    }

    /**Gets the attribute value for the calculated attribute Nop
     */
    public Number getNop() {
        return (Number) getAttributeInternal(NOP);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Nop
     */
    public void setNop(Number value) {
        setAttributeInternal(NOP, value);
    }

    /**Gets the attribute value for the calculated attribute DtaNasc
     */
    public Date getDtaNasc() {
        return (Date) getAttributeInternal(DTANASC);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute DtaNasc
     */
    public void setDtaNasc(Date value) {
        setAttributeInternal(DTANASC, value);
    }

    /**Gets the attribute value for the calculated attribute Idade
     */
    public Number getIdade() {
        return (Number) getAttributeInternal(IDADE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Idade
     */
    public void setIdade(Number value) {
        setAttributeInternal(IDADE, value);
    }

    /**Gets the attribute value for the calculated attribute Morada
     */
    public String getMorada() {
        return (String) getAttributeInternal(MORADA);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Morada
     */
    public void setMorada(String value) {
        setAttributeInternal(MORADA, value);
    }

    /**Gets the attribute value for the calculated attribute NumId
     */
    public String getNumId() {
        return (String) getAttributeInternal(NUMID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NumId
     */
    public void setNumId(String value) {
        setAttributeInternal(NUMID, value);
    }

    /**Gets the attribute value for the calculated attribute TipoId
     */
    public String getTipoId() {
        return (String) getAttributeInternal(TIPOID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute TipoId
     */
    public void setTipoId(String value) {
        setAttributeInternal(TIPOID, value);
    }

    /**Gets the attribute value for the calculated attribute CsaudeCod
     */
    public Number getCsaudeCod() {
        return (Number) getAttributeInternal(CSAUDECOD);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute CsaudeCod
     */
    public void setCsaudeCod(Number value) {
        setAttributeInternal(CSAUDECOD, value);
    }

    /**Gets the attribute value for the calculated attribute CsaudeDesig
     */
    public String getCsaudeDesig() {
        return (String) getAttributeInternal(CSAUDEDESIG);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute CsaudeDesig
     */
    public void setCsaudeDesig(String value) {
        setAttributeInternal(CSAUDEDESIG, value);
    }

    /**Gets the attribute value for the calculated attribute PaisNatalidade
     */
    public String getPaisNatalidade() {
        return (String) getAttributeInternal(PAISNATALIDADE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PaisNatalidade
     */
    public void setPaisNatalidade(String value) {
        setAttributeInternal(PAISNATALIDADE, value);
    }

    /**Gets the attribute value for the calculated attribute PaisNatalidadeId
     */
    public Number getPaisNatalidadeId() {
        return (Number) getAttributeInternal(PAISNATALIDADEID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PaisNatalidadeId
     */
    public void setPaisNatalidadeId(Number value) {
        setAttributeInternal(PAISNATALIDADEID, value);
    }

    /**Gets the attribute value for the calculated attribute PaisNacionalidade
     */
    public String getPaisNacionalidade() {
        return (String) getAttributeInternal(PAISNACIONALIDADE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PaisNacionalidade
     */
    public void setPaisNacionalidade(String value) {
        setAttributeInternal(PAISNACIONALIDADE, value);
    }

    /**Gets the attribute value for the calculated attribute PaisNacionalidadeId
     */
    public Number getPaisNacionalidadeId() {
        return (Number) getAttributeInternal(PAISNACIONALIDADEID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute PaisNacionalidadeId
     */
    public void setPaisNacionalidadeId(Number value) {
        setAttributeInternal(PAISNACIONALIDADEID, value);
    }

    /**Gets the attribute value for the calculated attribute Distrito
     */
    public String getDistrito() {
        return (String) getAttributeInternal(DISTRITO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Distrito
     */
    public void setDistrito(String value) {
        setAttributeInternal(DISTRITO, value);
    }

    /**Gets the attribute value for the calculated attribute DistritoId
     */
    public Number getDistritoId() {
        return (Number) getAttributeInternal(DISTRITOID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute DistritoId
     */
    public void setDistritoId(Number value) {
        setAttributeInternal(DISTRITOID, value);
    }

    /**Gets the attribute value for the calculated attribute Concelho
     */
    public String getConcelho() {
        return (String) getAttributeInternal(CONCELHO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Concelho
     */
    public void setConcelho(String value) {
        setAttributeInternal(CONCELHO, value);
    }

    /**Gets the attribute value for the calculated attribute ConcelhoId
     */
    public Number getConcelhoId() {
        return (Number) getAttributeInternal(CONCELHOID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute ConcelhoId
     */
    public void setConcelhoId(Number value) {
        setAttributeInternal(CONCELHOID, value);
    }

    /**Gets the attribute value for the calculated attribute Freguesia
     */
    public String getFreguesia() {
        return (String) getAttributeInternal(FREGUESIA);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Freguesia
     */
    public void setFreguesia(String value) {
        setAttributeInternal(FREGUESIA, value);
    }

    /**Gets the attribute value for the calculated attribute FreguesiaId
     */
    public Number getFreguesiaId() {
        return (Number) getAttributeInternal(FREGUESIAID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute FreguesiaId
     */
    public void setFreguesiaId(Number value) {
        setAttributeInternal(FREGUESIAID, value);
    }

    /**Gets the attribute value for the calculated attribute EntrespDesig
     */
    public String getEntrespDesig() {
        return (String) getAttributeInternal(ENTRESPDESIG);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute EntrespDesig
     */
    public void setEntrespDesig(String value) {
        setAttributeInternal(ENTRESPDESIG, value);
    }

    /**Gets the attribute value for the calculated attribute IheId
     */
    public Number getIheId() {
        return (Number) getAttributeInternal(IHEID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute IheId
     */
    public void setIheId(Number value) {
        setAttributeInternal(IHEID, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index,
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case IIUID:
            return getIiuId();
        case IINID:
            return getIinId();
        case NOMECOMPLETO:
            return getNomeCompleto();
        case NISS:
            return getNiss();
        case NIR:
            return getNir();
        case NOMESPROPRIOS:
            return getNomesProprios();
        case APELIDOS:
            return getApelidos();
        case NOP:
            return getNop();
        case DTANASC:
            return getDtaNasc();
        case NUMID:
            return getNumId();
        case CODIGOID:
            return getCodigoId();
        case TIPOID:
            return getTipoId();
        case CSAUDECOD:
            return getCsaudeCod();
        case CSAUDEDESIG:
            return getCsaudeDesig();
        case PAISNATALIDADE:
            return getPaisNatalidade();
        case PAISNATALIDADEID:
            return getPaisNatalidadeId();
        case PAISNACIONALIDADE:
            return getPaisNacionalidade();
        case PAISNACIONALIDADEID:
            return getPaisNacionalidadeId();
        case DISTRITO:
            return getDistrito();
        case DISTRITOID:
            return getDistritoId();
        case CONCELHO:
            return getConcelho();
        case CONCELHOID:
            return getConcelhoId();
        case FREGUESIA:
            return getFreguesia();
        case FREGUESIAID:
            return getFreguesiaId();
        case MORADA:
            return getMorada();
        case IDADE:
            return getIdade();
        case NUMBENEF:
            return getNumbenef();
        case IHEID:
            return getIheId();
        case ENTRESPDESIG:
            return getEntrespDesig();
        case ENTRESPABRV:
            return getEntrespAbrv();
        case CSAUDEID:
            return getCsaudeId();
        case OBITO:
            return getObito();
        case TABINSCR:
            return getTabInscr();
        case IDPPOTDUP:
            return getIdpPotDup();
        case SEXOUTENTE:
            return getSexoutente();
        case NOMENORMALIZADO:
            return getNomeNormalizado();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value,
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case IIUID:
            setIiuId((Number)value);
            return;
        case IINID:
            setIinId((Number)value);
            return;
        case NOMECOMPLETO:
            setNomeCompleto((String)value);
            return;
        case NISS:
            setNiss((Number)value);
            return;
        case NIR:
            setNir((Number)value);
            return;
        case NOMESPROPRIOS:
            setNomesProprios((String)value);
            return;
        case APELIDOS:
            setApelidos((String)value);
            return;
        case NOP:
            setNop((Number)value);
            return;
        case DTANASC:
            setDtaNasc((Date)value);
            return;
        case NUMID:
            setNumId((String)value);
            return;
        case CODIGOID:
            setCodigoId((String)value);
            return;
        case TIPOID:
            setTipoId((String)value);
            return;
        case CSAUDECOD:
            setCsaudeCod((Number)value);
            return;
        case CSAUDEDESIG:
            setCsaudeDesig((String)value);
            return;
        case PAISNATALIDADE:
            setPaisNatalidade((String)value);
            return;
        case PAISNATALIDADEID:
            setPaisNatalidadeId((Number)value);
            return;
        case PAISNACIONALIDADE:
            setPaisNacionalidade((String)value);
            return;
        case PAISNACIONALIDADEID:
            setPaisNacionalidadeId((Number)value);
            return;
        case DISTRITO:
            setDistrito((String)value);
            return;
        case DISTRITOID:
            setDistritoId((Number)value);
            return;
        case CONCELHO:
            setConcelho((String)value);
            return;
        case CONCELHOID:
            setConcelhoId((Number)value);
            return;
        case FREGUESIA:
            setFreguesia((String)value);
            return;
        case FREGUESIAID:
            setFreguesiaId((Number)value);
            return;
        case MORADA:
            setMorada((String)value);
            return;
        case IDADE:
            setIdade((Number)value);
            return;
        case NUMBENEF:
            setNumbenef((String)value);
            return;
        case IHEID:
            setIheId((Number)value);
            return;
        case ENTRESPDESIG:
            setEntrespDesig((String)value);
            return;
        case ENTRESPABRV:
            setEntrespAbrv((String)value);
            return;
        case CSAUDEID:
            setCsaudeId((Number)value);
            return;
        case OBITO:
            setObito((String)value);
            return;
        case TABINSCR:
            setTabInscr((String)value);
            return;
        case IDPPOTDUP:
            setIdpPotDup((Number)value);
            return;
        case SEXOUTENTE:
            setSexoutente((String)value);
            return;
        case NOMENORMALIZADO:
            setNomeNormalizado((String)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }


    /**Gets the attribute value for the calculated attribute IinId
     */
    public Number getIinId() {
        return (Number) getAttributeInternal(IINID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute IinId
     */
    public void setIinId(Number value) {
        setAttributeInternal(IINID, value);
    }


    /**Gets the attribute value for the calculated attribute RowId1
     */
    public RowID getRowId1() {
        return (RowID) getAttributeInternal(ROWID1);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute RowId1
     */
    public void setRowId1(RowID value) {
        setAttributeInternal(ROWID1, value);
    }


    /**Gets the attribute value for the calculated attribute CsaudeId
     */
    public Number getCsaudeId() {
        return (Number) getAttributeInternal(CSAUDEID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute CsaudeId
     */
    public void setCsaudeId(Number value) {
        setAttributeInternal(CSAUDEID, value);
    }

    /**Gets the attribute value for the calculated attribute TabInscr
     */
    public String getTabInscr() {
        return (String) getAttributeInternal(TABINSCR);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute TabInscr
     */
    public void setTabInscr(String value) {
        setAttributeInternal(TABINSCR, value);
    }

    /**Gets the attribute value for the calculated attribute Obito
     */
    public String getObito() {
        return (String) getAttributeInternal(OBITO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Obito
     */
    public void setObito(String value) {
        setAttributeInternal(OBITO, value);
    }

    /**Gets the attribute value for the calculated attribute EntrespAbrv
     */
    public String getEntrespAbrv() {
        return (String) getAttributeInternal(ENTRESPABRV);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute EntrespAbrv
     */
    public void setEntrespAbrv(String value) {
        setAttributeInternal(ENTRESPABRV, value);
    }

    /**Gets the attribute value for the calculated attribute CodigoId
     */
    public String getCodigoId() {
        return (String) getAttributeInternal(CODIGOID);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute CodigoId
     */
    public void setCodigoId(String value) {
        setAttributeInternal(CODIGOID, value);
    }

    /**Gets the attribute value for the calculated attribute IdpPotDup
     */
    public Number getIdpPotDup() {
        return (Number) getAttributeInternal(IDPPOTDUP);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute IdpPotDup
     */
    public void setIdpPotDup(Number value) {
        setAttributeInternal(IDPPOTDUP, value);
    }

    /**Gets the attribute value for the calculated attribute Sexoutente
     */
    public String getSexoutente() {
        return (String) getAttributeInternal(SEXOUTENTE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Sexoutente
     */
    public void setSexoutente(String value) {
        setAttributeInternal(SEXOUTENTE, value);
    }

    /**Gets the attribute value for the calculated attribute NomeNormalizado
     */
    public String getNomeNormalizado() {
        return (String) getAttributeInternal(NOMENORMALIZADO);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NomeNormalizado
     */
    public void setNomeNormalizado(String value) {
        setAttributeInternal(NOMENORMALIZADO, value);
    }
}
