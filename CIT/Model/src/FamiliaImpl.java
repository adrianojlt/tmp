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
public class FamiliaImpl extends EntityImpl {
    public static final int ID = 0;
    public static final int PROCFAM = 1;
    public static final int SCGTIPORUAID = 2;
    public static final int RUA = 3;
    public static final int SCGTIPOPORTAID = 4;
    public static final int PORTA = 5;
    public static final int SCGTIPOANDARID = 6;
    public static final int ANDAR = 7;
    public static final int LUGAR = 8;
    public static final int LOCALIDADE = 9;
    public static final int SCHCDAINEID = 10;
    public static final int SYSENTIDADESEQCOLID = 11;
    public static final int SYSCODIGOPOSTALID = 12;
    public static final int INDICA = 13;
    public static final int TELEF = 14;
    public static final int SYSENTIDADESCENTROID = 15;
    public static final int CREATEDBY = 16;
    public static final int CREATIONDATE = 17;
    public static final int LASTUPDATEDBY = 18;
    public static final int LASTUPDATEDATE = 19;
    public static final int OBS = 20;
    public static final int IDUFAMILIAORIGID = 21;
    public static final int IDUFAMILIAORIGIDFAMILIA = 22;
    public static final int HISTFAMILIA = 23;
    public static final int FAMILIA = 24;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public FamiliaImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.utentes.Familia");
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

    /**Gets the attribute value for Procfam, using the alias name Procfam
     */
    public Number getProcfam() {
        return (Number)getAttributeInternal(PROCFAM);
    }

    /**Sets <code>value</code> as the attribute value for Procfam
     */
    public void setProcfam(Number value) {
        setAttributeInternal(PROCFAM, value);
    }

    /**Gets the attribute value for ScgTiporuaId, using the alias name ScgTiporuaId
     */
    public Number getScgTiporuaId() {
        return (Number)getAttributeInternal(SCGTIPORUAID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTiporuaId
     */
    public void setScgTiporuaId(Number value) {
        setAttributeInternal(SCGTIPORUAID, value);
    }

    /**Gets the attribute value for Rua, using the alias name Rua
     */
    public String getRua() {
        return (String)getAttributeInternal(RUA);
    }

    /**Sets <code>value</code> as the attribute value for Rua
     */
    public void setRua(String value) {
        setAttributeInternal(RUA, value);
    }

    /**Gets the attribute value for ScgTipoportaId, using the alias name ScgTipoportaId
     */
    public Number getScgTipoportaId() {
        return (Number)getAttributeInternal(SCGTIPOPORTAID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTipoportaId
     */
    public void setScgTipoportaId(Number value) {
        setAttributeInternal(SCGTIPOPORTAID, value);
    }

    /**Gets the attribute value for Porta, using the alias name Porta
     */
    public String getPorta() {
        return (String)getAttributeInternal(PORTA);
    }

    /**Sets <code>value</code> as the attribute value for Porta
     */
    public void setPorta(String value) {
        setAttributeInternal(PORTA, value);
    }

    /**Gets the attribute value for ScgTipoandarId, using the alias name ScgTipoandarId
     */
    public Number getScgTipoandarId() {
        return (Number)getAttributeInternal(SCGTIPOANDARID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTipoandarId
     */
    public void setScgTipoandarId(Number value) {
        setAttributeInternal(SCGTIPOANDARID, value);
    }

    /**Gets the attribute value for Andar, using the alias name Andar
     */
    public String getAndar() {
        return (String)getAttributeInternal(ANDAR);
    }

    /**Sets <code>value</code> as the attribute value for Andar
     */
    public void setAndar(String value) {
        setAttributeInternal(ANDAR, value);
    }

    /**Gets the attribute value for Lugar, using the alias name Lugar
     */
    public String getLugar() {
        return (String)getAttributeInternal(LUGAR);
    }

    /**Sets <code>value</code> as the attribute value for Lugar
     */
    public void setLugar(String value) {
        setAttributeInternal(LUGAR, value);
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

    /**Gets the attribute value for SchCdaineId, using the alias name SchCdaineId
     */
    public Number getSchCdaineId() {
        return (Number)getAttributeInternal(SCHCDAINEID);
    }

    /**Sets <code>value</code> as the attribute value for SchCdaineId
     */
    public void setSchCdaineId(Number value) {
        setAttributeInternal(SCHCDAINEID, value);
    }

    /**Gets the attribute value for SysEntidadesEqcolId, using the alias name SysEntidadesEqcolId
     */
    public Number getSysEntidadesEqcolId() {
        return (Number)getAttributeInternal(SYSENTIDADESEQCOLID);
    }

    /**Sets <code>value</code> as the attribute value for SysEntidadesEqcolId
     */
    public void setSysEntidadesEqcolId(Number value) {
        setAttributeInternal(SYSENTIDADESEQCOLID, value);
    }

    /**Gets the attribute value for SysCodigoPostalId, using the alias name SysCodigoPostalId
     */
    public Number getSysCodigoPostalId() {
        return (Number)getAttributeInternal(SYSCODIGOPOSTALID);
    }

    /**Sets <code>value</code> as the attribute value for SysCodigoPostalId
     */
    public void setSysCodigoPostalId(Number value) {
        setAttributeInternal(SYSCODIGOPOSTALID, value);
    }

    /**Gets the attribute value for Indica, using the alias name Indica
     */
    public String getIndica() {
        return (String)getAttributeInternal(INDICA);
    }

    /**Sets <code>value</code> as the attribute value for Indica
     */
    public void setIndica(String value) {
        setAttributeInternal(INDICA, value);
    }

    /**Gets the attribute value for Telef, using the alias name Telef
     */
    public String getTelef() {
        return (String)getAttributeInternal(TELEF);
    }

    /**Sets <code>value</code> as the attribute value for Telef
     */
    public void setTelef(String value) {
        setAttributeInternal(TELEF, value);
    }

    /**Gets the attribute value for SysEntidadesCentroId, using the alias name SysEntidadesCentroId
     */
    public Number getSysEntidadesCentroId() {
        return (Number)getAttributeInternal(SYSENTIDADESCENTROID);
    }

    /**Sets <code>value</code> as the attribute value for SysEntidadesCentroId
     */
    public void setSysEntidadesCentroId(Number value) {
        setAttributeInternal(SYSENTIDADESCENTROID, value);
    }

    /**Gets the attribute value for CreatedBy, using the alias name CreatedBy
     */
    public String getCreatedBy() {
        return (String)getAttributeInternal(CREATEDBY);
    }

    /**Gets the attribute value for CreationDate, using the alias name CreationDate
     */
    public Date getCreationDate() {
        return (Date)getAttributeInternal(CREATIONDATE);
    }

    /**Gets the attribute value for LastUpdatedBy, using the alias name LastUpdatedBy
     */
    public String getLastUpdatedBy() {
        return (String)getAttributeInternal(LASTUPDATEDBY);
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
        case PROCFAM:
            return getProcfam();
        case SCGTIPORUAID:
            return getScgTiporuaId();
        case RUA:
            return getRua();
        case SCGTIPOPORTAID:
            return getScgTipoportaId();
        case PORTA:
            return getPorta();
        case SCGTIPOANDARID:
            return getScgTipoandarId();
        case ANDAR:
            return getAndar();
        case LUGAR:
            return getLugar();
        case LOCALIDADE:
            return getLocalidade();
        case SCHCDAINEID:
            return getSchCdaineId();
        case SYSENTIDADESEQCOLID:
            return getSysEntidadesEqcolId();
        case SYSCODIGOPOSTALID:
            return getSysCodigoPostalId();
        case INDICA:
            return getIndica();
        case TELEF:
            return getTelef();
        case SYSENTIDADESCENTROID:
            return getSysEntidadesCentroId();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case OBS:
            return getObs();
        case IDUFAMILIAORIGID:
            return getIduFamiliaOrigId();
        case HISTFAMILIA:
            return getHistFamilia();
        case FAMILIA:
            return getFamilia();
        case IDUFAMILIAORIGIDFAMILIA:
            return getIduFamiliaOrigIdFamilia();
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
        case PROCFAM:
            setProcfam((Number)value);
            return;
        case SCGTIPORUAID:
            setScgTiporuaId((Number)value);
            return;
        case RUA:
            setRua((String)value);
            return;
        case SCGTIPOPORTAID:
            setScgTipoportaId((Number)value);
            return;
        case PORTA:
            setPorta((String)value);
            return;
        case SCGTIPOANDARID:
            setScgTipoandarId((Number)value);
            return;
        case ANDAR:
            setAndar((String)value);
            return;
        case LUGAR:
            setLugar((String)value);
            return;
        case LOCALIDADE:
            setLocalidade((String)value);
            return;
        case SCHCDAINEID:
            setSchCdaineId((Number)value);
            return;
        case SYSENTIDADESEQCOLID:
            setSysEntidadesEqcolId((Number)value);
            return;
        case SYSCODIGOPOSTALID:
            setSysCodigoPostalId((Number)value);
            return;
        case INDICA:
            setIndica((String)value);
            return;
        case TELEF:
            setTelef((String)value);
            return;
        case SYSENTIDADESCENTROID:
            setSysEntidadesCentroId((Number)value);
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
        case OBS:
            setObs((String)value);
            return;
        case IDUFAMILIAORIGID:
            setIduFamiliaOrigId((Number)value);
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
//                 RowIterator UpdateFilesIteratorHistFam = this.getHistFamilia();
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
//                 HistFamiliaImpl updateFile;
//                 
//                 UpdateFilesIteratorHistFam.reset();
//                 //Loop throught he list of child records and update with new ID
//                 while (UpdateFilesIteratorHistFam.hasNext()){
//                     updateFile = (HistFamiliaImpl) UpdateFilesIteratorHistFam.next();
//                     updateFile.setAttribute("IduFamiliaId", this.getId().getSequenceNumber());
//                 }
//             }break;
//
//         }
//    }


    /**Sets <code>value</code> as the attribute value for CreatedBy
     */
    public void setCreatedBy(String value) {
        setAttributeInternal(CREATEDBY, value);
    }

    /**Sets <code>value</code> as the attribute value for CreationDate
     */
    public void setCreationDate(Date value) {
        setAttributeInternal(CREATIONDATE, value);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdatedBy
     */
    public void setLastUpdatedBy(String value) {
        setAttributeInternal(LASTUPDATEDBY, value);
    }

    /**Sets <code>value</code> as the attribute value for LastUpdateDate
     */
    public void setLastUpdateDate(Date value) {
        setAttributeInternal(LASTUPDATEDATE, value);
    }

    /**Gets the attribute value for Obs, using the alias name Obs
     */
    public String getObs() {
        return (String)getAttributeInternal(OBS);
    }

    /**Sets <code>value</code> as the attribute value for Obs
     */
    public void setObs(String value) {
        setAttributeInternal(OBS, value);
    }

    /**Gets the attribute value for IduFamiliaOrigId, using the alias name IduFamiliaOrigId
     */
    public Number getIduFamiliaOrigId() {
        return (Number)getAttributeInternal(IDUFAMILIAORIGID);
    }

    /**Sets <code>value</code> as the attribute value for IduFamiliaOrigId
     */
    public void setIduFamiliaOrigId(Number value) {
        setAttributeInternal(IDUFAMILIAORIGID, value);
    }

    /**Gets the associated entity FamiliaImpl
     */
    public FamiliaImpl getIduFamiliaOrigIdFamilia() {
        return (FamiliaImpl)getAttributeInternal(IDUFAMILIAORIGIDFAMILIA);
    }

    /**Sets <code>value</code> as the associated entity FamiliaImpl
     */
    public void setIduFamiliaOrigIdFamilia(FamiliaImpl value) {
        setAttributeInternal(IDUFAMILIAORIGIDFAMILIA, value);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getFamilia() {
        return (RowIterator)getAttributeInternal(FAMILIA);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getHistFamilia() {
        return (RowIterator)getAttributeInternal(HISTFAMILIA);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}
