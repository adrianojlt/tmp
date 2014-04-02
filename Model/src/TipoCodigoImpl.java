package ora.pt.cons.igif.sics.suporte;

import oracle.jbo.Key;
import oracle.jbo.RowIterator;
import oracle.jbo.domain.DBSequence;
import oracle.jbo.domain.Date;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.EntityDefImpl;
import oracle.jbo.server.EntityImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class TipoCodigoImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int CODTIPO = 1;
    public static final int DESCRICAO = 2;
    public static final int EDITAR = 3;
    public static final int CENTRAL = 4;
    public static final int DESTINO = 5;
    public static final int CREATEDBY = 6;
    public static final int CREATIONDATE = 7;
    public static final int LASTUPDATEDBY = 8;
    public static final int LASTUPDATEDATE = 9;
    public static final int CODIGOTABELA = 10;
    public static final int CODIGOGENERICO = 11;
    public static final int CODIGOHIERARQUICO = 12;
    public static final int ENTIDADE = 13;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public TipoCodigoImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.suporte.TipoCodigo");
        }
        return mDefinitionObject;
    }

    /**Gets the attribute value for Id, using the alias name Id
     */
    public DBSequence getId() {
        return (DBSequence)getAttributeInternal(ID);
    }

    /**Sets <code>value</code> as the attribute value for Id
     */
    public void setId(DBSequence value) {
        setAttributeInternal(ID, value);
    }

    /**Gets the attribute value for CodTipo, using the alias name CodTipo
     */
    public String getCodTipo() {
        return (String)getAttributeInternal(CODTIPO);
    }

    /**Sets <code>value</code> as the attribute value for CodTipo
     */
    public void setCodTipo(String value) {
        setAttributeInternal(CODTIPO, value);
    }

    /**Gets the attribute value for Descricao, using the alias name Descricao
     */
    public String getDescricao() {
        return (String)getAttributeInternal(DESCRICAO);
    }

    /**Sets <code>value</code> as the attribute value for Descricao
     */
    public void setDescricao(String value) {
        setAttributeInternal(DESCRICAO, value);
    }

    /**Gets the attribute value for Editar, using the alias name Editar
     */
    public String getEditar() {
        return (String)getAttributeInternal(EDITAR);
    }

    /**Sets <code>value</code> as the attribute value for Editar
     */
    public void setEditar(String value) {
        setAttributeInternal(EDITAR, value);
    }

    /**Gets the attribute value for Central, using the alias name Central
     */
    public String getCentral() {
        return (String)getAttributeInternal(CENTRAL);
    }

    /**Sets <code>value</code> as the attribute value for Central
     */
    public void setCentral(String value) {
        setAttributeInternal(CENTRAL, value);
    }

    /**Gets the attribute value for Destino, using the alias name Destino
     */
    public String getDestino() {
        return (String)getAttributeInternal(DESTINO);
    }

    /**Sets <code>value</code> as the attribute value for Destino
     */
    public void setDestino(String value) {
        setAttributeInternal(DESTINO, value);
    }

    /**Gets the attribute value for CreatedBy, using the alias name CreatedBy
     */
    public String getCreatedBy() {
        return (String)getAttributeInternal(CREATEDBY);
    }

    /**Sets <code>value</code> as the attribute value for CreatedBy
     */
    public void setCreatedBy(String value) {
        setAttributeInternal(CREATEDBY, value);
    }

    /**Gets the attribute value for CreationDate, using the alias name CreationDate
     */
    public Date getCreationDate() {
        return (Date)getAttributeInternal(CREATIONDATE);
    }

    /**Sets <code>value</code> as the attribute value for CreationDate
     */
    public void setCreationDate(Date value) {
        setAttributeInternal(CREATIONDATE, value);
    }

    /**Gets the attribute value for LastUpdatedBy, using the alias name LastUpdatedBy
     */
    public String getLastUpdatedBy() {
        return (String)getAttributeInternal(LASTUPDATEDBY);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdatedBy
     */
    public void setLastUpdatedBy(String value) {
        setAttributeInternal(LASTUPDATEDBY, value);
    }

    /**Gets the attribute value for LastUpdateDate, using the alias name LastUpdateDate
     */
    public Date getLastUpdateDate() {
        return (Date)getAttributeInternal(LASTUPDATEDATE);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdateDate
     */
    public void setLastUpdateDate(Date value) {
        setAttributeInternal(LASTUPDATEDATE, value);
    }

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index,
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ID:
            return getId();
        case CODTIPO:
            return getCodTipo();
        case DESCRICAO:
            return getDescricao();
        case EDITAR:
            return getEditar();
        case CENTRAL:
            return getCentral();
        case DESTINO:
            return getDestino();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case CODIGOTABELA:
            return getCodigoTabela();
        case ENTIDADE:
            return getEntidade();
        case CODIGOHIERARQUICO:
            return getCodigoHierarquico();
        case CODIGOGENERICO:
            return getCodigoGenerico();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value,
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ID:
            setId((DBSequence)value);
            return;
        case CODTIPO:
            setCodTipo((String)value);
            return;
        case DESCRICAO:
            setDescricao((String)value);
            return;
        case EDITAR:
            setEditar((String)value);
            return;
        case CENTRAL:
            setCentral((String)value);
            return;
        case DESTINO:
            setDestino((String)value);
            return;
        case CREATEDBY:
            setCreatedBy((String)value);
            return;
        case CREATIONDATE:
            setCreationDate((Date)value);
            return;
        case LASTUPDATEDBY:
            setLastUpdatedBy((String)value);
            return;
        case LASTUPDATEDATE:
            setLastUpdateDate((Date)value);
            return;
        case CODIGOTABELA:
            setCodigoTabela((String)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the attribute value for CodigoTabela, using the alias name CodigoTabela
     */
    public String getCodigoTabela() {
        return (String)getAttributeInternal(CODIGOTABELA);
    }

    /**Sets <code>value</code> as the attribute value for CodigoTabela
     */
    public void setCodigoTabela(String value) {
        setAttributeInternal(CODIGOTABELA, value);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getCodigoGenerico() {
        return (RowIterator)getAttributeInternal(CODIGOGENERICO);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getCodigoHierarquico() {
        return (RowIterator)getAttributeInternal(CODIGOHIERARQUICO);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getEntidade() {
        return (RowIterator)getAttributeInternal(ENTIDADE);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
