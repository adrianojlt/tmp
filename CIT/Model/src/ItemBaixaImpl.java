package ora.pt.cons.igif.sics.baixas;

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
public class ItemBaixaImpl extends EntityImpl {
    public static final int ANULADO = 0;
    public static final int AUTORIZSAIDA = 1;
    public static final int COMUNICACAOANULACAOCRSS = 2;
    public static final int COMUNICACAOCRSS = 3;
    public static final int CREATEDBY = 4;
    public static final int CREATIONDATE = 5;
    public static final int CUIDADOSINADIAVEIS = 6;
    public static final int DATAANULADO = 7;
    public static final int DATAINICIO = 8;
    public static final int DATATERMO = 9;
    public static final int GITBAIXASID = 10;
    public static final int ID = 11;
    public static final int IDPAI = 12;
    public static final int INCAPACITADO = 13;
    public static final int INTERNAMENTO = 14;
    public static final int JUSTIFICACAOSAIDA = 15;
    public static final int LASTUPDATEDBY = 16;
    public static final int LASTUPDATEDATE = 17;
    public static final int SCGCLASSIFDOENCAID = 18;
    public static final int SCGTIPOALTAID = 19;
    public static final int SCGTIPOREGISTOID = 20;
    public static final int SYSENTIDADESID = 21;
    public static final int SCGMOTIVOANULACAOID = 22;
    public static final int SYSENTIDADESANULUCAOID = 23;
    public static final int COMENTARIOANULACAO = 24;
    public static final int DATACOMUNICAOCRSS = 25;
    public static final int DATACOMUNICACAOANULACAOCRSS = 26;
    public static final int PROPROFISSIDPESSOALID = 27;
    public static final int PROPROFISSIDPESANULACAOID = 28;
    public static final int CIRURGIAAMBULATORIO = 29;
    public static final int NUMEPISODIO = 30;
    public static final int SCGCODMODULOID = 31;
    public static final int BAIXA = 32;
    public static final int OPERACOESLOG = 33;
    public static final int OPERACOESLOG1 = 34;
    private static EntityDefImpl mDefinitionObject;

    /**This is the default constructor (do not remove)
     */
    public ItemBaixaImpl() {
    }


    /**Retrieves the definition object for this instance class.
     */
    public static synchronized EntityDefImpl getDefinitionObject() {
        if (mDefinitionObject == null) {
            mDefinitionObject = (EntityDefImpl)EntityDefImpl.findDefObject("ora.pt.cons.igif.sics.baixas.ItemBaixa");
        }
        return mDefinitionObject;
    }

    /**Gets the attribute value for Anulado, using the alias name Anulado
     */
    public String getAnulado() {
        return (String)getAttributeInternal(ANULADO);
    }

    /**Sets <code>value</code> as the attribute value for Anulado
     */
    public void setAnulado(String value) {
        setAttributeInternal(ANULADO, value);
    }

    /**Gets the attribute value for AutorizSaida, using the alias name AutorizSaida
     */
    public String getAutorizSaida() {
        return (String)getAttributeInternal(AUTORIZSAIDA);
    }

    /**Sets <code>value</code> as the attribute value for AutorizSaida
     */
    public void setAutorizSaida(String value) {
        setAttributeInternal(AUTORIZSAIDA, value);
    }

    /**Gets the attribute value for ComunicacaoAnulacaoCrss, using the alias name ComunicacaoAnulacaoCrss
     */
    public String getComunicacaoAnulacaoCrss() {
        return (String)getAttributeInternal(COMUNICACAOANULACAOCRSS);
    }

    /**Sets <code>value</code> as the attribute value for ComunicacaoAnulacaoCrss
     */
    public void setComunicacaoAnulacaoCrss(String value) {
        setAttributeInternal(COMUNICACAOANULACAOCRSS, value);
    }

    /**Gets the attribute value for ComunicacaoCrss, using the alias name ComunicacaoCrss
     */
    public String getComunicacaoCrss() {
        return (String)getAttributeInternal(COMUNICACAOCRSS);
    }

    /**Sets <code>value</code> as the attribute value for ComunicacaoCrss
     */
    public void setComunicacaoCrss(String value) {
        setAttributeInternal(COMUNICACAOCRSS, value);
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

    /**Gets the attribute value for CuidadosInadiaveis, using the alias name CuidadosInadiaveis
     */
    public String getCuidadosInadiaveis() {
        return (String)getAttributeInternal(CUIDADOSINADIAVEIS);
    }

    /**Sets <code>value</code> as the attribute value for CuidadosInadiaveis
     */
    public void setCuidadosInadiaveis(String value) {
        setAttributeInternal(CUIDADOSINADIAVEIS, value);
    }

    /**Gets the attribute value for DataAnulado, using the alias name DataAnulado
     */
    public Date getDataAnulado() {
        return (Date)getAttributeInternal(DATAANULADO);
    }

    /**Sets <code>value</code> as the attribute value for DataAnulado
     */
    public void setDataAnulado(Date value) {
        setAttributeInternal(DATAANULADO, value);
    }

    /**Gets the attribute value for DataInicio, using the alias name DataInicio
     */
    public Date getDataInicio() {
        return (Date)getAttributeInternal(DATAINICIO);
    }

    /**Sets <code>value</code> as the attribute value for DataInicio
     */
    public void setDataInicio(Date value) {
        setAttributeInternal(DATAINICIO, value);
    }

    /**Gets the attribute value for DataTermo, using the alias name DataTermo
     */
    public Date getDataTermo() {
        return (Date)getAttributeInternal(DATATERMO);
    }

    /**Sets <code>value</code> as the attribute value for DataTermo
     */
    public void setDataTermo(Date value) {
        setAttributeInternal(DATATERMO, value);
    }

    /**Gets the attribute value for GitBaixasId, using the alias name GitBaixasId
     */
    public Number getGitBaixasId() {
        return (Number)getAttributeInternal(GITBAIXASID);
    }

    /**Sets <code>value</code> as the attribute value for GitBaixasId
     */
    public void setGitBaixasId(Number value) {
        setAttributeInternal(GITBAIXASID, value);
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

    /**Gets the attribute value for IdPai, using the alias name IdPai
     */
    public Number getIdPai() {
        return (Number)getAttributeInternal(IDPAI);
    }

    /**Sets <code>value</code> as the attribute value for IdPai
     */
    public void setIdPai(Number value) {
        setAttributeInternal(IDPAI, value);
    }

    /**Gets the attribute value for Incapacitado, using the alias name Incapacitado
     */
    public String getIncapacitado() {
        return (String)getAttributeInternal(INCAPACITADO);
    }

    /**Sets <code>value</code> as the attribute value for Incapacitado
     */
    public void setIncapacitado(String value) {
        setAttributeInternal(INCAPACITADO, value);
    }

    /**Gets the attribute value for Internamento, using the alias name Internamento
     */
    public String getInternamento() {
        return (String)getAttributeInternal(INTERNAMENTO);
    }

    /**Sets <code>value</code> as the attribute value for Internamento
     */
    public void setInternamento(String value) {
        setAttributeInternal(INTERNAMENTO, value);
    }

    /**Gets the attribute value for JustificacaoSaida, using the alias name JustificacaoSaida
     */
    public String getJustificacaoSaida() {
        return (String)getAttributeInternal(JUSTIFICACAOSAIDA);
    }

    /**Sets <code>value</code> as the attribute value for JustificacaoSaida
     */
    public void setJustificacaoSaida(String value) {
        setAttributeInternal(JUSTIFICACAOSAIDA, value);
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


    /**Gets the attribute value for ScgClassifdoencaId, using the alias name ScgClassifdoencaId
     */
    public Number getScgClassifdoencaId() {
        return (Number)getAttributeInternal(SCGCLASSIFDOENCAID);
    }

    /**Sets <code>value</code> as the attribute value for ScgClassifdoencaId
     */
    public void setScgClassifdoencaId(Number value) {
        setAttributeInternal(SCGCLASSIFDOENCAID, value);
    }


    /**Gets the attribute value for ScgTipoaltaId, using the alias name ScgTipoaltaId
     */
    public Number getScgTipoaltaId() {
        return (Number)getAttributeInternal(SCGTIPOALTAID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTipoaltaId
     */
    public void setScgTipoaltaId(Number value) {
        setAttributeInternal(SCGTIPOALTAID, value);
    }

    /**Gets the attribute value for ScgTiporegistoId, using the alias name ScgTiporegistoId
     */
    public Number getScgTiporegistoId() {
        return (Number)getAttributeInternal(SCGTIPOREGISTOID);
    }

    /**Sets <code>value</code> as the attribute value for ScgTiporegistoId
     */
    public void setScgTiporegistoId(Number value) {
        setAttributeInternal(SCGTIPOREGISTOID, value);
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

    /**getAttrInvokeAccessor: generated method. Do not modify.
     */
    protected Object getAttrInvokeAccessor(int index,
                                           AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ANULADO:
            return getAnulado();
        case AUTORIZSAIDA:
            return getAutorizSaida();
        case COMUNICACAOANULACAOCRSS:
            return getComunicacaoAnulacaoCrss();
        case COMUNICACAOCRSS:
            return getComunicacaoCrss();
        case CREATEDBY:
            return getCreatedBy();
        case CREATIONDATE:
            return getCreationDate();
        case CUIDADOSINADIAVEIS:
            return getCuidadosInadiaveis();
        case DATAANULADO:
            return getDataAnulado();
        case DATAINICIO:
            return getDataInicio();
        case DATATERMO:
            return getDataTermo();
        case GITBAIXASID:
            return getGitBaixasId();
        case ID:
            return getId();
        case IDPAI:
            return getIdPai();
        case INCAPACITADO:
            return getIncapacitado();
        case INTERNAMENTO:
            return getInternamento();
        case JUSTIFICACAOSAIDA:
            return getJustificacaoSaida();
        case LASTUPDATEDBY:
            return getLastUpdatedBy();
        case LASTUPDATEDATE:
            return getLastUpdateDate();
        case SCGCLASSIFDOENCAID:
            return getScgClassifdoencaId();
        case SCGTIPOALTAID:
            return getScgTipoaltaId();
        case SCGTIPOREGISTOID:
            return getScgTiporegistoId();
        case SYSENTIDADESID:
            return getSysEntidadesId();
        case SCGMOTIVOANULACAOID:
            return getScgMotivoAnulacaoId();
        case SYSENTIDADESANULUCAOID:
            return getSysEntidadesAnulucaoId();
        case COMENTARIOANULACAO:
            return getComentarioAnulacao();
        case DATACOMUNICAOCRSS:
            return getDataComunicaoCrss();
        case DATACOMUNICACAOANULACAOCRSS:
            return getDataComunicacaoAnulacaoCrss();
        case PROPROFISSIDPESSOALID:
            return getProProfissidPessoalId();
        case PROPROFISSIDPESANULACAOID:
            return getProProfissidPesAnulacaoId();
        case CIRURGIAAMBULATORIO:
            return getCirurgiaAmbulatorio();
        case NUMEPISODIO:
            return getNumEpisodio();
        case SCGCODMODULOID:
            return getScgCodModuloId();
        case OPERACOESLOG:
            return getOperacoesLog();
        case OPERACOESLOG1:
            return getOperacoesLog1();
        case BAIXA:
            return getBaixa();
        default:
            return super.getAttrInvokeAccessor(index, attrDef);
        }
    }

    /**setAttrInvokeAccessor: generated method. Do not modify.
     */
    protected void setAttrInvokeAccessor(int index, Object value,
                                         AttributeDefImpl attrDef) throws Exception {
        switch (index) {
        case ANULADO:
            setAnulado((String)value);
            return;
        case AUTORIZSAIDA:
            setAutorizSaida((String)value);
            return;
        case COMUNICACAOANULACAOCRSS:
            setComunicacaoAnulacaoCrss((String)value);
            return;
        case COMUNICACAOCRSS:
            setComunicacaoCrss((String)value);
            return;
        case CREATEDBY:
            setCreatedBy((String)value);
            return;
        case CREATIONDATE:
            setCreationDate((Date)value);
            return;
        case CUIDADOSINADIAVEIS:
            setCuidadosInadiaveis((String)value);
            return;
        case DATAANULADO:
            setDataAnulado((Date)value);
            return;
        case DATAINICIO:
            setDataInicio((Date)value);
            return;
        case DATATERMO:
            setDataTermo((Date)value);
            return;
        case GITBAIXASID:
            setGitBaixasId((Number)value);
            return;
        case ID:
            setId((DBSequence)value);
            return;
        case IDPAI:
            setIdPai((Number)value);
            return;
        case INCAPACITADO:
            setIncapacitado((String)value);
            return;
        case INTERNAMENTO:
            setInternamento((String)value);
            return;
        case JUSTIFICACAOSAIDA:
            setJustificacaoSaida((String)value);
            return;
        case LASTUPDATEDBY:
            setLastUpdatedBy((String)value);
            return;
        case LASTUPDATEDATE:
            setLastUpdateDate((Date)value);
            return;
        case SCGCLASSIFDOENCAID:
            setScgClassifdoencaId((Number)value);
            return;
        case SCGTIPOALTAID:
            setScgTipoaltaId((Number)value);
            return;
        case SCGTIPOREGISTOID:
            setScgTiporegistoId((Number)value);
            return;
        case SYSENTIDADESID:
            setSysEntidadesId((Number)value);
            return;
        case SCGMOTIVOANULACAOID:
            setScgMotivoAnulacaoId((Number)value);
            return;
        case SYSENTIDADESANULUCAOID:
            setSysEntidadesAnulucaoId((Number)value);
            return;
        case COMENTARIOANULACAO:
            setComentarioAnulacao((String)value);
            return;
        case DATACOMUNICAOCRSS:
            setDataComunicaoCrss((Date)value);
            return;
        case DATACOMUNICACAOANULACAOCRSS:
            setDataComunicacaoAnulacaoCrss((Date)value);
            return;
        case PROPROFISSIDPESSOALID:
            setProProfissidPessoalId((Number)value);
            return;
        case PROPROFISSIDPESANULACAOID:
            setProProfissidPesAnulacaoId((Number)value);
            return;
        case CIRURGIAAMBULATORIO:
            setCirurgiaAmbulatorio((String)value);
            return;
        case NUMEPISODIO:
            setNumEpisodio((Number)value);
            return;
        case SCGCODMODULOID:
            setScgCodModuloId((Number)value);
            return;
        default:
            super.setAttrInvokeAccessor(index, value, attrDef);
            return;
        }
    }

    /**Gets the associated entity BaixaImpl
     */
    public BaixaImpl getBaixa() {
        return (BaixaImpl)getAttributeInternal(BAIXA);
    }

    /**Sets <code>value</code> as the associated entity BaixaImpl
     */
    public void setBaixa(BaixaImpl value) {
        setAttributeInternal(BAIXA, value);
    }

    /**Gets the attribute value for ScgMotivoAnulacaoId, using the alias name ScgMotivoAnulacaoId
     */
    public Number getScgMotivoAnulacaoId() {
        return (Number)getAttributeInternal(SCGMOTIVOANULACAOID);
    }

    /**Sets <code>value</code> as the attribute value for ScgMotivoAnulacaoId
     */
    public void setScgMotivoAnulacaoId(Number value) {
        setAttributeInternal(SCGMOTIVOANULACAOID, value);
    }


    /**Gets the attribute value for SysEntidadesAnulucaoId, using the alias name SysEntidadesAnulucaoId
     */
    public Number getSysEntidadesAnulucaoId() {
        return (Number)getAttributeInternal(SYSENTIDADESANULUCAOID);
    }

    /**Sets <code>value</code> as the attribute value for SysEntidadesAnulucaoId
     */
    public void setSysEntidadesAnulucaoId(Number value) {
        setAttributeInternal(SYSENTIDADESANULUCAOID, value);
    }

    /**Gets the attribute value for ComentarioAnulacao, using the alias name ComentarioAnulacao
     */
    public String getComentarioAnulacao() {
        return (String)getAttributeInternal(COMENTARIOANULACAO);
    }

    /**Sets <code>value</code> as the attribute value for ComentarioAnulacao
     */
    public void setComentarioAnulacao(String value) {
        setAttributeInternal(COMENTARIOANULACAO, value);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getOperacoesLog() {
        return (RowIterator)getAttributeInternal(OPERACOESLOG);
    }

    /**Gets the associated entity oracle.jbo.RowIterator
     */
    public RowIterator getOperacoesLog1() {
        return (RowIterator)getAttributeInternal(OPERACOESLOG1);
    }

    /**Gets the attribute value for DataComunicaoCrss, using the alias name DataComunicaoCrss
     */
    public Date getDataComunicaoCrss() {
        return (Date)getAttributeInternal(DATACOMUNICAOCRSS);
    }

    /**Sets <code>value</code> as the attribute value for DataComunicaoCrss
     */
    public void setDataComunicaoCrss(Date value) {
        setAttributeInternal(DATACOMUNICAOCRSS, value);
    }

    /**Gets the attribute value for DataComunicacaoAnulacaoCrss, using the alias name DataComunicacaoAnulacaoCrss
     */
    public Date getDataComunicacaoAnulacaoCrss() {
        return (Date)getAttributeInternal(DATACOMUNICACAOANULACAOCRSS);
    }

    /**Sets <code>value</code> as the attribute value for DataComunicacaoAnulacaoCrss
     */
    public void setDataComunicacaoAnulacaoCrss(Date value) {
        setAttributeInternal(DATACOMUNICACAOANULACAOCRSS, value);
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

    /**Gets the attribute value for ProProfissidPesAnulacaoId, using the alias name ProProfissidPesAnulacaoId
     */
    public Number getProProfissidPesAnulacaoId() {
        return (Number)getAttributeInternal(PROPROFISSIDPESANULACAOID);
    }

    /**Sets <code>value</code> as the attribute value for ProProfissidPesAnulacaoId
     */
    public void setProProfissidPesAnulacaoId(Number value) {
        setAttributeInternal(PROPROFISSIDPESANULACAOID, value);
    }

    /**Gets the attribute value for CirurgiaAmbulatorio, using the alias name CirurgiaAmbulatorio
     */
    public String getCirurgiaAmbulatorio() {
        return (String)getAttributeInternal(CIRURGIAAMBULATORIO);
    }

    /**Sets <code>value</code> as the attribute value for CirurgiaAmbulatorio
     */
    public void setCirurgiaAmbulatorio(String value) {
        setAttributeInternal(CIRURGIAAMBULATORIO, value);
    }

    /**Gets the attribute value for NumEpisodio, using the alias name NumEpisodio
     */
    public Number getNumEpisodio() {
        return (Number)getAttributeInternal(NUMEPISODIO);
    }

    /**Sets <code>value</code> as the attribute value for NumEpisodio
     */
    public void setNumEpisodio(Number value) {
        setAttributeInternal(NUMEPISODIO, value);
    }

    /**Gets the attribute value for ScgCodModuloId, using the alias name ScgCodModuloId
     */
    public Number getScgCodModuloId() {
        return (Number)getAttributeInternal(SCGCODMODULOID);
    }

    /**Sets <code>value</code> as the attribute value for ScgCodModuloId
     */
    public void setScgCodModuloId(Number value) {
        setAttributeInternal(SCGCODMODULOID, value);
    }

    /**Creates a Key object based on given key constituents
     */
    public static Key createPrimaryKey(DBSequence id) {
        return new Key(new Object[]{id});
    }
}