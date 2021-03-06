package ora.pt.cons.igif.sics.suporte;

import oracle.jbo.Key;
import oracle.jbo.RowIterator;
import oracle.jbo.domain.DBSequence;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.domain.RowID;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.EntityDefImpl;
import oracle.jbo.server.EntityImpl;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class UtilizadorImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int ACTIVO = 1;
    public static final int NOME = 2;
    public static final int NUMMECANOG = 3;
    public static final int ROWID = 4;
    public static final int SENHA = 5;
    public static final int CREATEDBY = 6;
    public static final int CREATIONDATE = 7;
    public static final int LASTUPDATEDBY = 8;
    public static final int LASTUPDATEDATE = 9;
    public static final int PROPROFISSIDPESSOALID = 10;
    public static final int PERFISUTILIZADOR = 11;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public UtilizadorImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.suporte.Utilizador");
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

    /**Gets the attribute value for Activo, using the alias name Activo
     */
    public String getActivo() {
        return (String)getAttributeInternal(ACTIVO);
    }

    /**Sets <code>value</code> as the attribute value for Activo
     */
    public void setActivo(String value) {
        setAttributeInternal(ACTIVO, value);
    }

    /**Gets the attribute value for Nome, using the alias name Nome
     */
    public String getNome() {
        return (String)getAttributeInternal(NOME);
    }

    /**Sets <code>value</code> as the attribute value for Nome
     */
    public void setNome(String value) {
        setAttributeInternal(NOME, value);
    }

    /**Gets the attribute value for NumMecanog, using the alias name NumMecanog
     */
    public Number getNumMecanog() {
        return (Number)getAttributeInternal(NUMMECANOG);
    }

    /**Sets <code>value</code> as the attribute value for NumMecanog
     */
    public void setNumMecanog(Number value) {
        setAttributeInternal(NUMMECANOG, value);
    }

    /**Gets the attribute value for RowID, using the alias name RowID
     */
    public RowID getRowID() {
        return (RowID)getAttributeInternal(ROWID);
    }

    /**Gets the attribute value for Senha, using the alias name Senha
     */
    public String getSenha() {
        return (String)getAttributeInternal(SENHA);
    }

    /**Sets <code>value</code> as the attribute value for Senha
     */
    public void setSenha(String value) {
        setAttributeInternal(SENHA, value);
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


    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index,
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ID:
            return getId();
        case ACTIVO:
            return getActivo();
        case NOME:
            return getNome();
        case NUMMECANOG:
            return getNumMecanog();
        case ROWID:
            return getRowID();
        case SENHA:
            return getSenha();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case PROPROFISSIDPESSOALID:
            return getProProfissidPessoalId();
        case PERFISUTILIZADOR:
            return getPerfisUtilizador();
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
        case ACTIVO:
            setActivo((String)value);
            return;
        case NOME:
            setNome((String)value);
            return;
        case NUMMECANOG:
            setNumMecanog((Number)value);
            return;
        case SENHA:
            setSenha((String)value);
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
        case PROPROFISSIDPESSOALID:
            setProProfissidPessoalId((Number)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }


    /**Sets <code>value</code> as the attribute value for LastUpdateDate
     */
    public void setLastUpdateDate(Date value) {
        setAttributeInternal(LASTUPDATEDATE, value);
    }


    /**Gets the attribute value for ProProfissidPessoalId, using the alias name ProProfissidPessoalId
     */
    public Number getProProfissidPessoalId() {
        return (Number)getAttributeInternal(PROPROFISSIDPESSOALID);
    }

    /**Sets <code>value</code> as the attribute value for ProProfissidPessoalId
     */
    public void setProProfissidPessoalId(Number value) {
        setAttributeInternal(PROPROFISSIDPESSOALID, value);
    }


    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getPerfisUtilizador() {
        return (RowIterator)getAttributeInternal(PERFISUTILIZADOR);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
