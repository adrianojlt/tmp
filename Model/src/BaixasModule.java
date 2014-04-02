package ora.pt.cons.igif.sics.baixas.common;

import oracle.jbo.ApplicationModule;
import oracle.jbo.domain.Date;
import oracle.jbo.domain.Number;
// ---------------------------------------------------------------------
// ---    File generated by Oracle ADF Business Components Design Time.
// ---------------------------------------------------------------------
public interface BaixasModule extends ApplicationModule {


    // Integer annulItemBaixaCascade(Number idItemBaixa, Number iduIdentUt);


    Number obtemId(String dominio, String idTipoOperacao);


    void alteraTipoComBaseItemBaixa(Number idBaixa, Number idItemBaixa, 
                                    Number scgMotivoAnulacaoId, 
                                    String comentarioAnulacao, 
                                    Number sysEntidadesId, Number proProfissId, 
                                    Number idNovoTipoRegisto, 
                                    String tipoRegistoAAlterar, 
                                    Number idItemBaixaAnularAltInicial) throws Exception;

    Integer annulItemBaixa(Number idItemBaixa, Number scgMotivoAnulacaoId,
                           String comentarioAnulacao, Number sysEntidadesId,
                           Number proProfissId) throws Exception;

    Integer registaOperacoesLog(Number idBaixa, Number idItemBaixa, 
                                String idTipoOperacao, 
                                Number scgMotivoAnulacaoId, 
                                String comentarioAnulacao, 
                                Number sysEntidadesId, Number proProfissId, 
                                boolean executaCommit);


    Integer insertNewBaixa(String novaBaixa, Number iduHistEntUtId, 
                           String entidadePublica, Number iduIdentUtIdDupId, 
                           Number iduIdentUtId, Number nissUtente, 
                           String numBeneficiario, 
                           Boolean selectedAssistenciaFamilia, 
                           String nomeFamiliar, Date dtaFamiliar, 
                           Number nissFamiliar, Number nissFamiliarImpedido, 
                           Number idFamiliar, Number scgParentescoId, 
                           String outroParentesco, 
                           Boolean selectedOutroParentesco, 
                           Number sysEntidadesId, Number proProfissidPessoalId, 
                           Date dataInicio, Date dataTermo, 
                           Date dataInicioLastBoletim, 
                           Date dataTermoLastBoletim, 
                           Number scgClassifDoencaID, String incapacitado, 
                           String cuidadosInadiaveis, String internamento, 
                           String cirurgiaAmbulatorio, String autorizSaida, 
                           String justificacaoSaida, Number idBaixaAltaAberta, 
                           String baixaManual, Number numEpisodio, 
                           Number scgModuloId) throws Exception;

    Integer insertNewAlta(Number gitBaixasId, Number scgTipoAltaId, 
                          Date dataAlta, Date dataInicioPeridoBaixa, 
                          Date dataTermoLastItem, Number sysEntidadesId, 
                          Number proProfissidPessoalId, Number idClassDoenca, 
                          Number numEpisodio, Number scgModuloId);

    Integer insertNewProgor(Number idGitBaixa, Number iduHistEntUtId, 
                            Number iduIdentUtIdDupId, Number iduIdentUtId, 
                            Number sysEntidadesId, 
                            Number proProfissidPessoalId, Date dataInicio, 
                            Date dataTermo, Date dataInicioLastBoletim, 
                            Date dataTermoLastItem, Number scgClassifDoencaID, 
                            String incapacitado, String cuidadosInadiaveis, 
                            String internamento, String cirurgiaAmbulatorio, 
                            String autorizSaida, String justificacaoSaida, 
                            String baixaManual, Number numEpisodio, 
                            Number scgModuloId);

    Integer updateItemBaixa(Number idItemBaixa, Number idBaixa, 
                            Boolean selectedAssistenciaFamilia, 
                            String nomeFamiliar, Date dtaFamiliar, 
                            Number nissFamiliar, Number nissFamiliarImpedido, 
                            Number idFamiliar, Number scgParentescoId, 
                            String outroParentesco, 
                            Boolean selectedOutroParentesco, 
                            Number sysEntidadesId, 
                            Number proProfissidPessoalId, Date dataInicio, 
                            Date oldDataInicio, Date dataTermo, 
                            Date oldDataTermo, Number scgClassifDoencaID, 
                            String incapacitado, String cuidadosInadiaveis, 
                            String internamento, String cirurgiaAmbulatorio, 
                            String autorizSaida, String justificacaoSaida, 
                            String tipoRegisto, String entidadePublica, 
                            String baixaManual, Number numEpisodio, 
                            Number scgModuloId, boolean admin) throws Exception;
}