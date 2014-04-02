package ora.pt.cons.igif.sics.utentes;

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
public class InscricaoUtenteImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int HISTORICOEQUIPAS1 = 14;
    public static final int DATAFIM = 1;
    public static final int DATAINI = 2;
    public static final int DTAINSC = 3;
    public static final int IDUIDENTUTDUPID = 4;
    public static final int IDUIDENTUTID = 5;
    public static final int SCGTIPOINSCRID = 6;
    public static final int SCGTIPOUTENTEID = 7;
    public static final int SYSENTIDADESID = 8;
    public static final int CREATEDBY = 9;
    public static final int CREATIONDATE = 10;
    public static final int LASTUPDATEDBY = 11;
    public static final int LASTUPDATEDATE = 12;
    public static final int IDENTIFICACAOUTENTE = 13;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public InscricaoUtenteImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.utentes.InscricaoUtente");
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

    /**Gets the attribute value for DtaInsc, using the alias name DtaInsc
     */
    public Date getDtaInsc() {
        return (Date)getAttributeInternal(DTAINSC);
    }

    /**Sets <code>value</code> as the attribute value for DtaInsc
     */
    public void setDtaInsc(Date value) {
        setAttributeInternal(DTAINSC, value);
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

    /**Gets the attribute value for ScgTipoinscrId, using the alias name ScgTipoinscrId
     */
    public Number getScgTipoinscrId() {
        return (Number)getAttributeInternal(SCGTIPOINSCRID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTipoinscrId
     */
    public void setScgTipoinscrId(Number value) {
        setAttributeInternal(SCGTIPOINSCRID, value);
    }

    /**Gets the attribute value for ScgTipoutenteId, using the alias name ScgTipoutenteId
     */
    public Number getScgTipoutenteId() {
        return (Number)getAttributeInternal(SCGTIPOUTENTEID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTipoutenteId
     */
    public void setScgTipoutenteId(Number value) {
        setAttributeInternal(SCGTIPOUTENTEID, value);
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
        case DATAFIM:
            return getDataFim();
        case DATAINI:
            return getDataIni();
        case DTAINSC:
            return getDtaInsc();
        case IDUIDENTUTDUPID:
            return getIduIdentUtDupId();
        case IDUIDENTUTID:
            return getIduIdentUtId();
        case SCGTIPOINSCRID:
            return getScgTipoinscrId();
        case SCGTIPOUTENTEID:
            return getScgTipoutenteId();
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
        case DATAFIM:
            setDataFim((Date)value);
            return;
        case DATAINI:
            setDataIni((Date)value);
            return;
        case DTAINSC:
            setDtaInsc((Date)value);
            return;
        case IDUIDENTUTDUPID:
            setIduIdentUtDupId((Number)value);
            return;
        case IDUIDENTUTID:
            setIduIdentUtId((Number)value);
            return;
        case SCGTIPOINSCRID:
            setScgTipoinscrId((Number)value);
            return;
        case SCGTIPOUTENTEID:
            setScgTipoutenteId((Number)value);
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


//    protected void doDML(int operation, TransactionEvent transactionEvent) {
//        switch (operation)
//         {
//         case DML_UPDATE:
//
//             {
//             super.doDML(operation, transactionEvent);
//
//             }break;
//
//         case DML_DELETE:
//             {
//             super.doDML(operation, transactionEvent);
//
//             }break;
//
//         case DML_INSERT:
//             {
//                 //////////////////////////////////////
//                 // Pre Insert Actions //
//                 /////////////////////////////////////
//                 // Grab the child records before the update to the parent record.
//                 
//                 RowIterator UpdateFilesIteratorHistInscr = this.getHistoricoInscrEquipa();
//                 RowIterator UpdateFilesIteratorHistFam = this.getHistFamiliaInscricao();
//                 
//                 //Call the super which saves the records.
//                 super.doDML(operation, transactionEvent);
//    
//                 //////////////////////////////////////
//                 // Post Insert Actions //
//                 /////////////////////////////////////
//                 //If we did a insert of a work flow, and there are temp sequence numbers that need to be linked
//                 //back to the parent record, this code gets the iterator and loops through the records updating the ids
//                 //Create an instance of the child records.
//                 HistoricoInscrEquipaImpl updateFile;
//                 
//                 UpdateFilesIteratorHistInscr.reset();
//                 //Loop throught he list of child records and update with new ID
//                 while (UpdateFilesIteratorHistInscr.hasNext()){
//                     updateFile = (HistoricoInscrEquipaImpl) UpdateFilesIteratorHistInscr.next();
//                     updateFile.setAttribute("IduInscrId", this.getId().getSequenceNumber());
//                 }
//                 
//                 HistFamiliaImpl updateFileHistFamilia;
//                 
//                 UpdateFilesIteratorHistFam.reset();
//                 //Loop throught he list of child records and update with new ID
//                 while (UpdateFilesIteratorHistFam.hasNext()){
//                     updateFileHistFamilia = (HistFamiliaImpl) UpdateFilesIteratorHistFam.next();
//                     updateFileHistFamilia.setAttribute("IduInscrId", this.getId().getSequenceNumber());
//                 }
//             }break;
//
//         }
//    }


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
