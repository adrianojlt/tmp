package ora.pt.cons.igif.sics.baixas;

import oracle.jbo.Key;
import oracle.jbo.RowIterator;
import oracle.jbo.domain.DBSequence;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
import oracle.jbo.server.AttributeDefImpl;
import oracle.jbo.server.EntityDefImpl;
import oracle.jbo.server.EntityImpl;
import oracle.jbo.server.TransactionEvent;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---    Custom code may be added to this class.
// ---    Warning: Do not modify method signatures of generated methods.
// ---------------------------------------------------------------------
public class BaixaImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int IDUHISTENTUTID = 1;
    public static final int IDUIDENTUTDUPID = 2;
    public static final int IDUIDENTUTID = 3;
    public static final int NUMBOLETIM = 4;
    public static final int CREATEDBY = 5;
    public static final int CREATIONDATE = 6;
    public static final int LASTUPDATEDBY = 7;
    public static final int LASTUPDATEDATE = 8;
    public static final int NISS = 9;
    public static final int NUMBENEF = 10;
    public static final int IDUHISTENTUTDUPID = 11;
    public static final int SCGPARENTESCOID = 12;
    public static final int PARENTESCOOUTRO = 13;
    public static final int NOMEFAMILIAR = 14;
    public static final int NISSFAMILIAR = 15;
    public static final int DTANASCFAMILIAR = 16;
    public static final int IDUIDENTUTIDFAMILIAR = 17;
    public static final int NISSPROGENITORIMP = 18;
    public static final int IDUIDENTUTIDIMP = 19;
    public static final int ITEMBAIXA = 20;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public BaixaImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.baixas.Baixa");
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

    /**Gets the attribute value for IduHistEntUtId, using the alias name IduHistEntUtId
     */
    public Number getIduHistEntUtId() {
        return (Number)getAttributeInternal(IDUHISTENTUTID);
    }

    /**Sets <code>value</code> as the attribute value for IduHistEntUtId
     */
    public void setIduHistEntUtId(Number value) {
        setAttributeInternal(IDUHISTENTUTID, value);
    }

    /**Gets the attribute value for IduIdentUtDupId, using the alias name IduIdentUtDupId
     */
    public Number getIduIdentUtDupId() {
        return (Number)getAttributeInternal(IDUIDENTUTDUPID);
    }

    /**Sets <code>value</code> as the attribute value for IduIdentUtDupId
     */
    public void setIduIdentUtDupId(Number value) {
        setAttributeInternal(IDUIDENTUTDUPID, value);
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

    /**Gets the attribute value for NumBoletim, using the alias name NumBoletim
     */
    public Number getNumBoletim() {
        return (Number)getAttributeInternal(NUMBOLETIM);
    }

    /**Sets <code>value</code> as the attribute value for NumBoletim
     */
    public void setNumBoletim(Number value) {
        setAttributeInternal(NUMBOLETIM, value);
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
        case IDUHISTENTUTID:
            return getIduHistEntUtId();
        case IDUIDENTUTDUPID:
            return getIduIdentUtDupId();
        case IDUIDENTUTID:
            return getIduIdentUtId();
        case NUMBOLETIM:
            return getNumBoletim();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case NISS:
            return getNiss();
        case NUMBENEF:
            return getNumBenef();
        case IDUHISTENTUTDUPID:
            return getIduHistEntUtDupId();
        case SCGPARENTESCOID:
            return getScgParentescoId();
        case PARENTESCOOUTRO:
            return getParentescoOutro();
        case NOMEFAMILIAR:
            return getNomeFamiliar();
        case NISSFAMILIAR:
            return getNissFamiliar();
        case DTANASCFAMILIAR:
            return getDtaNascFamiliar();
        case IDUIDENTUTIDFAMILIAR:
            return getIduIdentUtIdFamiliar();
        case NISSPROGENITORIMP:
            return getNissProgenitorImp();
        case IDUIDENTUTIDIMP:
            return getIduIdentUtIdImp();
        case ITEMBAIXA:
            return getItemBaixa();
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
        case IDUHISTENTUTID:
            setIduHistEntUtId((Number)value);
            return;
        case IDUIDENTUTDUPID:
            setIduIdentUtDupId((Number)value);
            return;
        case IDUIDENTUTID:
            setIduIdentUtId((Number)value);
            return;
        case NUMBOLETIM:
            setNumBoletim((Number)value);
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
        case NISS:
            setNiss((Number)value);
            return;
        case NUMBENEF:
            setNumBenef((String)value);
            return;
        case IDUHISTENTUTDUPID:
            setIduHistEntUtDupId((Number)value);
            return;
        case SCGPARENTESCOID:
            setScgParentescoId((Number)value);
            return;
        case PARENTESCOOUTRO:
            setParentescoOutro((String)value);
            return;
        case NOMEFAMILIAR:
            setNomeFamiliar((String)value);
            return;
        case NISSFAMILIAR:
            setNissFamiliar((Number)value);
            return;
        case DTANASCFAMILIAR:
            setDtaNascFamiliar((Date)value);
            return;
        case IDUIDENTUTIDFAMILIAR:
            setIduIdentUtIdFamiliar((Number)value);
            return;
        case NISSPROGENITORIMP:
            setNissProgenitorImp((Number)value);
            return;
        case IDUIDENTUTIDIMP:
            setIduIdentUtIdImp((Number)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }


    protected void doDML(int operation, TransactionEvent transactionEvent) {
        switch (operation)
         {
         case DML_UPDATE:

             {
             super.doDML(operation, transactionEvent);

             }break;

         case DML_DELETE:
             {
             super.doDML(operation, transactionEvent);

             }break;

         case DML_INSERT:
             {
             //////////////////////////////////////
             // Pre Insert Actions //
             /////////////////////////////////////
             // Grab the child records before the update to the parent record.
             RowIterator UpdateFilesIterator = this.getItemBaixa();      
             //Call the super which saves the records.
             super.doDML(operation, transactionEvent);

             //////////////////////////////////////
             // Post Insert Actions //
             /////////////////////////////////////
             //If we did a insert of a work flow, and there are temp sequence numbers that need to be linked
             //back to the parent record, this code gets the iterator and loops through the records updating the ids
             //Create an instance of the child records.
             ItemBaixaImpl updateFile;
             
             UpdateFilesIterator.reset();
             //Loop throught he list of child records and update with new ID
             while (UpdateFilesIterator.hasNext()){
                 updateFile = (ItemBaixaImpl)UpdateFilesIterator.next();
                 updateFile.setAttribute("GitBaixasId", this.getId().getSequenceNumber());
             }
             }break;

         }
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getItemBaixa() {
        return (RowIterator)getAttributeInternal(ITEMBAIXA);
    }

    /**Gets the attribute value for Niss, using the alias name Niss
     */
    public Number getNiss() {
        return (Number)getAttributeInternal(NISS);
    }

    /**Sets <code>value</code> as the attribute value for Niss
     */
    public void setNiss(Number value) {
        setAttributeInternal(NISS, value);
    }

    /**Gets the attribute value for NumBenef, using the alias name NumBenef
     */
    public String getNumBenef() {
        return (String)getAttributeInternal(NUMBENEF);
    }

    /**Sets <code>value</code> as the attribute value for NumBenef
     */
    public void setNumBenef(String value) {
        setAttributeInternal(NUMBENEF, value);
    }

    /**Gets the attribute value for IduHistEntUtDupId, using the alias name IduHistEntUtDupId
     */
    public Number getIduHistEntUtDupId() {
        return (Number)getAttributeInternal(IDUHISTENTUTDUPID);
    }

    /**Sets <code>value</code> as the attribute value for IduHistEntUtDupId
     */
    public void setIduHistEntUtDupId(Number value) {
        setAttributeInternal(IDUHISTENTUTDUPID, value);
    }

    /**Gets the attribute value for ScgParentescoId, using the alias name ScgParentescoId
     */
    public Number getScgParentescoId() {
        return (Number)getAttributeInternal(SCGPARENTESCOID);
    }

    /**Sets <code>value</code> as the attribute value for ScgParentescoId
     */
    public void setScgParentescoId(Number value) {
        setAttributeInternal(SCGPARENTESCOID, value);
    }

    /**Gets the attribute value for ParentescoOutro, using the alias name ParentescoOutro
     */
    public String getParentescoOutro() {
        return (String)getAttributeInternal(PARENTESCOOUTRO);
    }

    /**Sets <code>value</code> as the attribute value for ParentescoOutro
     */
    public void setParentescoOutro(String value) {
        setAttributeInternal(PARENTESCOOUTRO, value);
    }

    /**Gets the attribute value for NomeFamiliar, using the alias name NomeFamiliar
     */
    public String getNomeFamiliar() {
        return (String)getAttributeInternal(NOMEFAMILIAR);
    }

    /**Sets <code>value</code> as the attribute value for NomeFamiliar
     */
    public void setNomeFamiliar(String value) {
        setAttributeInternal(NOMEFAMILIAR, value);
    }

    /**Gets the attribute value for NissFamiliar, using the alias name NissFamiliar
     */
    public Number getNissFamiliar() {
        return (Number)getAttributeInternal(NISSFAMILIAR);
    }

    /**Sets <code>value</code> as the attribute value for NissFamiliar
     */
    public void setNissFamiliar(Number value) {
        setAttributeInternal(NISSFAMILIAR, value);
    }

    /**Gets the attribute value for DtaNascFamiliar, using the alias name DtaNascFamiliar
     */
    public Date getDtaNascFamiliar() {
        return (Date)getAttributeInternal(DTANASCFAMILIAR);
    }

    /**Sets <code>value</code> as the attribute value for DtaNascFamiliar
     */
    public void setDtaNascFamiliar(Date value) {
        setAttributeInternal(DTANASCFAMILIAR, value);
    }

    /**Gets the attribute value for IduIdentUtIdFamiliar, using the alias name IduIdentUtIdFamiliar
     */
    public Number getIduIdentUtIdFamiliar() {
        return (Number)getAttributeInternal(IDUIDENTUTIDFAMILIAR);
    }

    /**Sets <code>value</code> as the attribute value for IduIdentUtIdFamiliar
     */
    public void setIduIdentUtIdFamiliar(Number value) {
        setAttributeInternal(IDUIDENTUTIDFAMILIAR, value);
    }

    /**Gets the attribute value for NissProgenitorImp, using the alias name NissProgenitorImp
     */
    public Number getNissProgenitorImp() {
        return (Number)getAttributeInternal(NISSPROGENITORIMP);
    }

    /**Sets <code>value</code> as the attribute value for NissProgenitorImp
     */
    public void setNissProgenitorImp(Number value) {
        setAttributeInternal(NISSPROGENITORIMP, value);
    }

    /**Gets the attribute value for IduIdentUtIdImp, using the alias name IduIdentUtIdImp
     */
    public Number getIduIdentUtIdImp() {
        return (Number)getAttributeInternal(IDUIDENTUTIDIMP);
    }

    /**Sets <code>value</code> as the attribute value for IduIdentUtIdImp
     */
    public void setIduIdentUtIdImp(Number value) {
        setAttributeInternal(IDUIDENTUTIDIMP, value);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
