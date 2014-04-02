package ora.pt.cons.igif.sics.suporte;

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
public class PerfisUtilizadorImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int SYSUSERSID = 1;
    public static final int SYSPERFISID = 2;
    public static final int SYSENTIDADESID = 3;
    public static final int CREATEDBY = 4;
    public static final int CREATIONDATE = 5;
    public static final int LASTUPDATEDBY = 6;
    public static final int LASTUPDATEDATE = 7;
    public static final int UTILIZADOR = 8;
    public static final int PERFIS = 9;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public PerfisUtilizadorImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.suporte.PerfisUtilizador");
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

    /**Gets the attribute value for SysUsersId, using the alias name SysUsersId
     */
    public Number getSysUsersId() {
        return (Number)getAttributeInternal(SYSUSERSID);
    }

    /**Sets <code>value</code> as the attribute value for SysUsersId
     */
    public void setSysUsersId(Number value) {
        setAttributeInternal(SYSUSERSID, value);
    }

    /**Gets the attribute value for SysPerfisId, using the alias name SysPerfisId
     */
    public Number getSysPerfisId() {
        return (Number)getAttributeInternal(SYSPERFISID);
    }

    /**Sets <code>value</code> as the attribute value for SysPerfisId
     */
    public void setSysPerfisId(Number value) {
        setAttributeInternal(SYSPERFISID, value);
    }

    /**Gets the attribute value for SysEntidadesId, using the alias name SysEntidadesId
     */
    public Number getSysEntidadesId() {
        return (Number)getAttributeInternal(SYSENTIDADESID);
    }

    /**Sets <code>value</code> as the attribute value for SysEntidadesId
     */
    public void setSysEntidadesId(Number value) {
        setAttributeInternal(SYSENTIDADESID, value);
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
        case SYSUSERSID:
            return getSysUsersId();
        case SYSPERFISID:
            return getSysPerfisId();
        case SYSENTIDADESID:
            return getSysEntidadesId();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case UTILIZADOR:
            return getUtilizador();
        case PERFIS:
            return getPerfis();
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
        case SYSUSERSID:
            setSysUsersId((Number)value);
            return;
        case SYSPERFISID:
            setSysPerfisId((Number)value);
            return;
        case SYSENTIDADESID:
            setSysEntidadesId((Number)value);
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

    /**Gets the associated entity UtilizadorImpl
     */
    public UtilizadorImpl getUtilizador() {
        return (UtilizadorImpl)getAttributeInternal(UTILIZADOR);
    }

    /**Sets <code>value</code> as the associated entity UtilizadorImpl
     */
    public void setUtilizador(UtilizadorImpl value) {
        setAttributeInternal(UTILIZADOR, value);
    }

    /**Gets the associated entity PerfisImpl
     */
    public PerfisImpl getPerfis() {
        return (PerfisImpl)getAttributeInternal(PERFIS);
    }

    /**Sets <code>value</code> as the associated entity PerfisImpl
     */
    public void setPerfis(PerfisImpl value) {
        setAttributeInternal(PERFIS, value);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
