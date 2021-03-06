package ora.pt.cons.igif.sics.suporte;

import oracle.jbo.domain.DBSequence;
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
public class UtilizadorViewRowImpl extends ViewRowImpl {
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
    public static final int NOMEPROFISSIONAL = 11;
    public static final int NUMPROFSAUDE = 12;

    /**This is the default constructor (do not remove)
     */
    public UtilizadorViewRowImpl() {
    }

    /**Gets Utilizador entity object.
     */
    public UtilizadorImpl getUtilizador() {
        return (UtilizadorImpl)getEntity(0);
    }

    /**Gets the attribute value for ID using the alias name Id
     */
    public DBSequence getId() {
        return (DBSequence)getAttributeInternal(ID);
    }

    /**Sets <code>value</code> as attribute value for ID using the alias name Id
     */
    public void setId(DBSequence value) {
        setAttributeInternal(ID, value);
    }

    /**Gets the attribute value for ACTIVO using the alias name Activo
     */
    public String getActivo() {
        return (String) getAttributeInternal(ACTIVO);
    }

    /**Sets <code>value</code> as attribute value for ACTIVO using the alias name Activo
     */
    public void setActivo(String value) {
        setAttributeInternal(ACTIVO, value);
    }

    /**Gets the attribute value for NOME using the alias name Nome
     */
    public String getNome() {
        return (String) getAttributeInternal(NOME);
    }

    /**Sets <code>value</code> as attribute value for NOME using the alias name Nome
     */
    public void setNome(String value) {
        setAttributeInternal(NOME, value);
    }

    /**Gets the attribute value for NUM_MECANOG using the alias name NumMecanog
     */
    public Number getNumMecanog() {
        return (Number) getAttributeInternal(NUMMECANOG);
    }

    /**Sets <code>value</code> as attribute value for NUM_MECANOG using the alias name NumMecanog
     */
    public void setNumMecanog(Number value) {
        setAttributeInternal(NUMMECANOG, value);
    }

    /**Gets the attribute value for ROWID using the alias name RowID
     */
    public RowID getRowID() {
        return (RowID) getAttributeInternal(ROWID);
    }

    /**Gets the attribute value for SENHA using the alias name Senha
     */
    public String getSenha() {
        return (String) getAttributeInternal(SENHA);
    }

    /**Sets <code>value</code> as attribute value for SENHA using the alias name Senha
     */
    public void setSenha(String value) {
        setAttributeInternal(SENHA, value);
    }

    /**Gets the attribute value for CREATED_BY using the alias name CreatedBy
     */
    public String getCreatedBy() {
        return (String) getAttributeInternal(CREATEDBY);
    }

    /**Sets <code>value</code> as attribute value for CREATED_BY using the alias name CreatedBy
     */
    public void setCreatedBy(String value) {
        setAttributeInternal(CREATEDBY, value);
    }

    /**Gets the attribute value for CREATION_DATE using the alias name CreationDate
     */
    public Date getCreationDate() {
        return (Date) getAttributeInternal(CREATIONDATE);
    }

    /**Sets <code>value</code> as attribute value for CREATION_DATE using the alias name CreationDate
     */
    public void setCreationDate(Date value) {
        setAttributeInternal(CREATIONDATE, value);
    }

    /**Gets the attribute value for LAST_UPDATED_BY using the alias name LastUpdatedBy
     */
    public String getLastUpdatedBy() {
        return (String) getAttributeInternal(LASTUPDATEDBY);
    }

    /**Sets <code>value</code> as attribute value for LAST_UPDATED_BY using the alias name LastUpdatedBy
     */
    public void setLastUpdatedBy(String value) {
        setAttributeInternal(LASTUPDATEDBY, value);
    }

    /**Gets the attribute value for LAST_UPDATE_DATE using the alias name LastUpdateDate
     */
    public Date getLastUpdateDate() {
        return (Date) getAttributeInternal(LASTUPDATEDATE);
    }

    /**Sets <code>value</code> as attribute value for LAST_UPDATE_DATE using the alias name LastUpdateDate
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
        case NOMEPROFISSIONAL:
            return getNomeprofissional();
        case NUMPROFSAUDE:
            return getNumProfSaude();
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
        case NOMEPROFISSIONAL:
            setNomeprofissional((String)value);
            return;
        case NUMPROFSAUDE:
            setNumProfSaude((Number)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the attribute value for PRO_PROFISSID_PESSOAL_ID using the alias name ProProfissidPessoalId
     */
    public Number getProProfissidPessoalId() {
        return (Number) getAttributeInternal(PROPROFISSIDPESSOALID);
    }

    /**Sets <code>value</code> as attribute value for PRO_PROFISSID_PESSOAL_ID using the alias name ProProfissidPessoalId
     */
    public void setProProfissidPessoalId(Number value) {
        setAttributeInternal(PROPROFISSIDPESSOALID, value);
    }

    /**Gets the attribute value for the calculated attribute Nomeprofissional
     */
    public String getNomeprofissional() {
        return (String) getAttributeInternal(NOMEPROFISSIONAL);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute Nomeprofissional
     */
    public void setNomeprofissional(String value) {
        setAttributeInternal(NOMEPROFISSIONAL, value);
    }

    /**Gets the attribute value for the calculated attribute NumProfSaude
     */
    public Number getNumProfSaude() {
        return (Number) getAttributeInternal(NUMPROFSAUDE);
    }

    /**Sets <code>value</code> as the attribute value for the calculated attribute NumProfSaude
     */
    public void setNumProfSaude(Number value) {
        setAttributeInternal(NUMPROFSAUDE, value);
    }
}
