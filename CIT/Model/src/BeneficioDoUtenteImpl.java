package ora.pt.cons.igif.sics.utentes;

import oracle.jbo.Key;
import oracle.jbo.domain.DBSequence;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.EntityDefImpl;
import oracle.jbo.server.EntityImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class BeneficioDoUtenteImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int IDUIDENTUTID = 1;
    public static final int IDUBENEFUTID = 2;
    public static final int NDOCISENT = 3;
    public static final int DTAVALIDADE = 4;
    public static final int DATAINI = 5;
    public static final int DATAFIM = 6;
    public static final int CREATEDBY = 7;
    public static final int LASTUPDATEDBY = 8;
    public static final int CREATIONDATE = 9;
    public static final int LASTUPDATEDATE = 10;
    public static final int IDENTIFICACAOUTENTE = 11;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public BeneficioDoUtenteImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.utentes.BeneficioDoUtente");
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

    /**Gets the attribute value for IduIdentUtId, using the alias name IduIdentUtId
     */
    public Number getIduIdentUtId() {
        return (Number)getAttributeInternal(IDUIDENTUTID);
    }

    /**Sets <code>value</code> as the attribute value for IduIdentUtId
     */
    public void setIduIdentUtId(Number value) {
        setAttributeInternal(IDUIDENTUTID, value);
    }

    /**Gets the attribute value for IduBenefUtId, using the alias name IduBenefUtId
     */
    public Number getIduBenefUtId() {
        return (Number)getAttributeInternal(IDUBENEFUTID);
    }

    /**Sets <code>value</code> as the attribute value for IduBenefUtId
     */
    public void setIduBenefUtId(Number value) {
        setAttributeInternal(IDUBENEFUTID, value);
    }

    /**Gets the attribute value for NdocIsent, using the alias name NdocIsent
     */
    public Number getNdocIsent() {
        return (Number)getAttributeInternal(NDOCISENT);
    }

    /**Sets <code>value</code> as the attribute value for NdocIsent
     */
    public void setNdocIsent(Number value) {
        setAttributeInternal(NDOCISENT, value);
    }

    /**Gets the attribute value for DtaValidade, using the alias name DtaValidade
     */
    public Date getDtaValidade() {
        return (Date)getAttributeInternal(DTAVALIDADE);
    }

    /**Sets <code>value</code> as the attribute value for DtaValidade
     */
    public void setDtaValidade(Date value) {
        setAttributeInternal(DTAVALIDADE, value);
    }

    /**Gets the attribute value for DataIni, using the alias name DataIni
     */
    public Date getDataIni() {
        return (Date)getAttributeInternal(DATAINI);
    }

    /**Sets <code>value</code> as the attribute value for DataIni
     */
    public void setDataIni(Date value) {
        setAttributeInternal(DATAINI, value);
    }

    /**Gets the attribute value for DataFim, using the alias name DataFim
     */
    public Date getDataFim() {
        return (Date)getAttributeInternal(DATAFIM);
    }

    /**Sets <code>value</code> as the attribute value for DataFim
     */
    public void setDataFim(Date value) {
        setAttributeInternal(DATAFIM, value);
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
        case IDUIDENTUTID:
            return getIduIdentUtId();
        case IDUBENEFUTID:
            return getIduBenefUtId();
        case NDOCISENT:
            return getNdocIsent();
        case DTAVALIDADE:
            return getDtaValidade();
        case DATAINI:
            return getDataIni();
        case DATAFIM:
            return getDataFim();
        case CREATEDBY:
            return getCreatedBy();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case IDENTIFICACAOUTENTE:
            return getIdentificacaoUtente();
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
        case IDUIDENTUTID:
            setIduIdentUtId((Number)value);
            return;
        case IDUBENEFUTID:
            setIduBenefUtId((Number)value);
            return;
        case NDOCISENT:
            setNdocIsent((Number)value);
            return;
        case DTAVALIDADE:
            setDtaValidade((Date)value);
            return;
        case DATAINI:
            setDataIni((Date)value);
            return;
        case DATAFIM:
            setDataFim((Date)value);
            return;
        case CREATEDBY:
            setCreatedBy((String)value);
            return;
        case LASTUPDATEDBY:
            setLastUpdatedBy((String)value);
            return;
        case CREATIONDATE:
            setCreationDate((Date)value);
            return;
        case LASTUPDATEDATE:
            setLastUpdateDate((Date)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the associated entity IdentificacaoUtenteImpl
     */
    public IdentificacaoUtenteImpl getIdentificacaoUtente() {
        return (IdentificacaoUtenteImpl)getAttributeInternal(IDENTIFICACAOUTENTE);
    }

    /**Sets <code>value</code> as the associated entity IdentificacaoUtenteImpl
     */
    public void setIdentificacaoUtente(IdentificacaoUtenteImpl value) {
        setAttributeInternal(IDENTIFICACAOUTENTE, value);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
