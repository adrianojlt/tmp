package ora.pt.cons.igif.sics.suporte;

import oracle.jbo.Key;
import oracle.jbo.RowIterator;
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
public class CodigoPostalImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int CODPOST = 1;
    public static final int LOCALIDADE = 2;
    public static final int SEQNUM = 3;
    public static final int CREATEDBY = 4;
    public static final int CREATIONDATE = 5;
    public static final int LASTUPDATEDBY = 6;
    public static final int LASTUPDATEDATE = 7;
    public static final int CODIGOHIERARQUICO = 8;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public CodigoPostalImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.suporte.CodigoPostal");
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

    /**Gets the attribute value for CodPost, using the alias name CodPost
     */
    public Number getCodPost() {
        return (Number)getAttributeInternal(CODPOST);
    }

    /**Sets <code>value</code> as the attribute value for CodPost
     */
    public void setCodPost(Number value) {
        setAttributeInternal(CODPOST, value);
    }

    /**Gets the attribute value for Localidade, using the alias name Localidade
     */
    public String getLocalidade() {
        return (String)getAttributeInternal(LOCALIDADE);
    }

    /**Sets <code>value</code> as the attribute value for Localidade
     */
    public void setLocalidade(String value) {
        setAttributeInternal(LOCALIDADE, value);
    }

    /**Gets the attribute value for SeqNum, using the alias name SeqNum
     */
    public Number getSeqNum() {
        return (Number)getAttributeInternal(SEQNUM);
    }

    /**Sets <code>value</code> as the attribute value for SeqNum
     */
    public void setSeqNum(Number value) {
        setAttributeInternal(SEQNUM, value);
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
        case CODPOST:
            return getCodPost();
        case LOCALIDADE:
            return getLocalidade();
        case SEQNUM:
            return getSeqNum();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case CODIGOHIERARQUICO:
            return getCodigoHierarquico();
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
        case CODPOST:
            setCodPost((Number)value);
            return;
        case LOCALIDADE:
            setLocalidade((String)value);
            return;
        case SEQNUM:
            setSeqNum((Number)value);
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
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getCodigoHierarquico() {
        return (RowIterator)getAttributeInternal(CODIGOHIERARQUICO);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
