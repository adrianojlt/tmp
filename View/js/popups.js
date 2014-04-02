/************************************************************
    Javascript for each control of each window lov open
**************************************************************/
    function openPopUpDuplicados(nir){
          var width = 980;
          var height = 600;
          var trackingWindow = null;
       
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          trackingWindow = window.open(encodeUTF8('../idu/pesquisaDuplicado.do?popup=true&link=true&nir='+nir+'&pBackEnabled=true'),'Duplicados',settings);
          trackingWindow.focus();        
    }
    
    function openPopUpUtente(idUtente, idInsc){
          var width = 980;
          var height = 600;
          var trackingWindow = null;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          trackingWindow = window.open('../idu/consultaUtente.do?popup=true&link=true&idUtente='+idUtente+'&idInscr='+idInsc+'&pBackEnabled=false','Ficha Utente',settings);
          trackingWindow.focus();        
    }
    
    function openFaqs(){  
          var width = 980;
          var height = 600;
          var trackingWindow = null;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          trackingWindow = window.open('https://estudo.min-saude.pt/eaprender/main/newscorm/lp_controller.php?cidReq=CITINFORMACAOUTIL&id_session=0&gidReq=0&action=view&lp_id=2','faqs',settings);
          trackingWindow.focus();            
    }
    
    
    // metodo para controlar abertura de lov de pesquisa de 
    // distritos, concelhos ou freguesias 
    function openLovDistConcFreg(idObjVal,idObj,idImgLov){
        if ( document.getElementById(idObj).value.length>0 ) {
            // abrir lov para pesquisa
            if ( document.getElementById(idObjVal).value.length == 0 ){
                var obj = document.getElementById(idImgLov);
                obj.onclick();
                document.getElementById(idObj).value = '';
            }
        }
    }


/*********************************************/
//    Begin Baixas (GIT) Lovs          /
/*********************************************/
    
    function popUpGITMotivoAnulacaoLOV(gitAdmin){
          if(!gitAdmin){
            gitAdmin = false;
          }
          var width = 700;
          var height = 550;
          var trackingWindow = null;
          var txtPage          = 'motivoAnulacaoLov.do';
          var txtIdItemBaixa   = '?idItemBaixa='+document.getElementById('IdItemBaixa').value;
          var txtIdBaixa   = '&idBaixa='+document.getElementById('radioIdBaixa').value;
          var gitAdmin   = '&gitAdmin='+gitAdmin;
          /* var txtElement = '&medComercial='+replaceAll(document.getElementById('medComercial').value,'%',escape('%'));          
             txtElement +='&idUtente='+escape(document.getElementById('idUtenteId').value);
          */
          var param = '../git/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          param  += txtPage;    
          param += txtIdItemBaixa;
          param += txtIdBaixa;
          param += gitAdmin;
          /*param += txtElement;*/
          window.showModalDialog(encodeUTF8(param),'MotivoAnulacao',"dialogWidth:700px;dialogHeight:550px;edge:sunken;scroll:no;status:no;unadorned:yes;center:yes;");
          //trackingWindow = window.open(param,'MotivoAnulacao',settings);
          //trackingWindow.focus();            
        }  
        
        function popUpGITAssistenciaFamiliar(idUtenteSessao){
          var width = 750;
          var height = 500;
          var trackingWindow = null;
          var txtPage          = 'pesquisaFamiliarLov.do';
          /*
          var txtIdItemBaixa   = '?idItemBaixa='+document.getElementById('IdItemBaixa').value;
          var txtIdBaixa   = '&idBaixa='+document.getElementById('radioIdBaixa').value;
          var gitAdmin   = '&gitAdmin='+gitAdmin;
          */
          var param = '../git/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          
          param += txtPage;    
          //param += txtIdItemBaixa;
          //param += txtIdBaixa;
          //param += gitAdmin;
          //window.showModalDialog(encodeUTF8(param),'PesquisaFamiliar',"dialogWidth:1000px;dialogHeight:750px;edge:sunken;scroll:no;status:no;unadorned:yes;center:yes;");
          //param += '?idUtenteSessao='+idUtenteSessao;
          trackingWindow = window.open(param,'GitPesquisarFamiliar',settings);
          trackingWindow.focus();            
          
        } 
        
        
     function popUpGITAssistenciaFamiliarBeneficiario(){
          var width =800;
          var height = 550;
          var trackingWindow = null;
          var txtPage          = 'pesquisaBeneficiarioLov.do';

          var param = '../git/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          
          param += txtPage;    

          trackingWindow = window.open(param,'GitPesquisarBeneficiario',settings);
          trackingWindow.focus();            
          
        } 

/*********************************************/
//    Begin Prescriçoes medicas Lovs          /
/*********************************************/

   function popUpMedNomeComercialLOV(){
          var width = 980;
          var height = 600;
          var trackingWindow = null;
          var txtPage    = 'nomeComercialLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&medComercial='+replaceAll(document.getElementById('medComercial').value,'%',escape('%'));          
              txtElement +='&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'NomeComercial',settings);
          trackingWindow.focus();            
    }          


   function popUpMedNomeComercialSaLOV(){
          var width = 980;
          var height = 728;
          var trackingWindow = null;
          var txtPage    = 'nomeComercialLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&dcipt_id='+escape(document.getElementById('dciIdTxtNC').value);  
              txtElement +='&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'NomeComercial',settings);
          trackingWindow.focus();            
        }      

   function popUpMedNomeComercialSaComboLOV(){
          
          var pFormaFarmaceutica = "";
          var pDosagens = "";
          var pEmbalagens = "";
          
          if(document.getElementById("sFormaFarmaceutica") && document.getElementById("sDosagens") && document.getElementById("sEmbalagens")){
                pFormaFarmaceutica = document.getElementById("sFormaFarmaceutica").value;
                pDosagens = document.getElementById("sDosagens").value;
                pEmbalagens = document.getElementById("sEmbalagens").value;
                
                if(pFormaFarmaceutica.length>0){
                    pFormaFarmaceutica = arrayFormaFarmaceutica[pFormaFarmaceutica-1][1];
                }
                
                if(pDosagens.length>0){
                    pDosagens = arrayDosagens[pDosagens-1][3];
                }
                
                if(pEmbalagens.length>0){
                    pEmbalagens = arrayEmbalagens[pEmbalagens-1][6];
                }
          }
            
          var width = 980;
          var height = 728;
          var trackingWindow = null;
          var txtPage    = 'nomeComercialLov.do';
          var txtEvent   = '?event=search'
          var txtElement = '&dcipt_id='+escape(document.getElementById('dciIdTxtNC').value);  
              txtElement +='&calledByTab='+escape(document.getElementById('TabSelect').value);
              
              txtElement +='&Form_Farm_Id='+escape(pFormaFarmaceutica);   
              txtElement +='&doseId='+escape(pDosagens);   
              txtElement +='&qty='+escape(pEmbalagens);
              
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'NomeComercial',settings);
          trackingWindow.focus();            
        }      
        
        
   function popUpMedSubsActivaLOV(){
          var width = 500;
          var height = 560;
          var trackingWindow = null;
          var txtPage    = 'substActivaLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&medSubstActiva='+replaceAll(document.getElementById('medSubstActiva').value,'%',escape('%'));          
              txtElement +='&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'SubstActiva',settings);
          trackingWindow.focus();            
        }  
        
        
   function popUpDiabetesLOV(){
          var width = 920;
          var height = 620;
          var trackingWindow = null;
          var txtPage    = 'diabetesLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&idProduto='+replaceAll(document.getElementById('idProduto').value,'%',escape('%'));          
              txtElement +='&idUtente='+document.getElementById('idUtenteId').value;
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'Diabetes',settings);
          trackingWindow.focus();            
        }          
        
   function popUpPosologiasLOV(paramFormfarmpkid,paramEmbPkId,paramDciptpkid,valorTextCalled){
          var width = 920;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'receitasPosologia.do';
          var txtEvent   = '?event=search';
          var txtElement = '&formFarmPk='+escape(document.getElementById(paramFormfarmpkid).value);
          txtElement += '&embPk='+escape(document.getElementById(paramEmbPkId).value);
          txtElement += '&dciptPk='+escape(document.getElementById(paramDciptpkid).value);          
          txtElement += '&valorTextCalled='+replaceAll(valorTextCalled,'%',escape('%'));
          txtElement +='&medico='+escape(document.getElementById('medicoId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'Posologias',settings);
          trackingWindow.focus();            
        }                  
        
        
   function popUpPrescricoesAnteriores(){
          splash(true);
          var width = 920;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'prescricoesAnteriores.do';
          var txtEvent   = '?event=search';
          //TODO:Add Utente_id
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'prescricoesAnteriores',settings);
          trackingWindow.focus();            
        }             
        
   function popUpMedicProlongada(){
          splash(true);
          var width = 920;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'medicacaoProlongada.do';
          var txtEvent   = '?event=search';
          //TODO:Add Utente_id
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'medicacaoProlongada',settings);
          trackingWindow.focus();            
        }        
        
   function popUpMedicProlongadaLov(){
          var width = 520;
          var height = 320;
          var trackingWindow = null;
          var txtPage    = 'medicacaoProlongadaLov.do';
          var txtEvent   = '?event=search';
          //TODO:Add Utente_id
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'medicacaoProlongadaLov',settings);
          trackingWindow.focus();
        }               
                
   function popUpReceitaAnterioresLov(){
          splash(true);
          var width = 620;
          var height = 600;
          var trackingWindow = null;
          var txtPage    = 'receitasAnteriores.do';
          var txtEvent   = '?event=search';
          //TODO:Add Utente_id
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
              txtElement +='&medico='+escape(document.getElementById('medicoId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'receitasAnterioresLov',settings);
          trackingWindow.focus();
        }                     
        
   function popUpReceitaAnterioreAnular(){
          var width = 380;
          var height = 390;
          var trackingWindow = null;
          var txtPage    = 'receitasAnterioresAnular.do';
          var txtEvent   = '?event=search';
          var txtElement = '&idReceitaId='+escape(document.getElementById('idReceitaId_id').value); 
              txtElement +='&scgEstadoReceita='+escape(document.getElementById('scgEstadoReceitaId').value);   
          //TODO:Add Utente_id
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param  += txtEvent;
          param  += txtElement;
          trackingWindow = window.open(param,'receitasAnterioresAnular',settings);
          trackingWindow.focus();
        }                          
        
   function popUpregimeEspCompMedicamentos(){
          splash(true);
          var width = 660;
          var height = 600;
          var trackingWindow = null;
          var txtPage    = 'regimeEspCompMedicamentos.do';
          var txtEvent   = '?event=search';
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
              txtElement +='&medico='+escape(document.getElementById('medicoId').value);
              txtElement +='&medicoNome='+escape(document.getElementById('medicoNomeId').value);
          //TODO:Add Utente_id
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param  += txtEvent;
          param  += txtElement;
          trackingWindow = window.open(param,'regimeEspCompMedicamentos',settings);
          trackingWindow.focus();
          
        }             
        
   function popUpRECMLov(){
          var width = 440;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'recmLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&idUtente='+escape(document.getElementById('idUtenteId').value);
          //TODO:Add Utente_id
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param  += txtEvent;
          param  += txtElement;
          trackingWindow = window.open(param,'recmLov',settings);
          trackingWindow.focus();
        }                                
        

   function popUpMedProntuTerapLOV(){
          var width = 980;
          var height = 728;
          var trackingWindow = null;
          // var txtPage    = 'prontuarioTerapeutico.do';
          var txtPage    = 'prontuario.do';
          var txtEvent   = '?event=search'
          var txtElement ='&idUtente='+(document.getElementById('idUtenteId').value);
          var param = '../med/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(param,'prontuarioTerapeutico',settings);
          trackingWindow.focus();            
        }                  
/*********************************************/
//    End  Prescricoes medicas Lovs           /
/*********************************************/  

/**********************************/
// ## -- centros de saude Lovs -- ##
/**********************************/  
    
        // -- lov de centros de saude (usada nos feriados)
        function popUpCentrosSaudeLOV(pCod,pDesc){
          var width = 500;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'centroSaudeLov.do';
          
          var txtEvent = "";
          if(pCod.length>0 || pDesc.length>0){
            txtEvent   = '?event=search&codCSaude='+pCod+'&codCSaudeDesc='+pDesc;
          }
          
          var txtElement = '';          
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Centro_de_Saude',settings);
          trackingWindow.focus();  
        }
        
/**************************************/
// ## -- fim centros de saude Lovs -- ##
/**************************************/

        function popUpDadosUtilizador(){
          var width = 400;
          var height =380;
          var trackingWindow = null;
          var txtPage    = 'dadosUtilizador.do';
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          trackingWindow = window.open(encodeUTF8(param),'DadosUtilizador',settings);
          trackingWindow.focus();     
        }
        

/**********************************/
// ## -- profissionais Lovs     -- ##
/**********************************/  
    
        // -- lov de profissionais (usada nos utilizadores)
        function popUpProfissionaisLOV(pCod, pDesc){
          var width = 650;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = '../sup/profissionalLov.do';
          var txtEvent = "";
          if(pDesc.length>0){
            txtEvent   = '?event=search&codigo='+pCod+'&nome='+pDesc;
          }
          var txtElement = '';          
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Profissionais',settings);
          trackingWindow.focus();  
        }
        
       
        
/**************************************/
// ## -- fim profissionais Lovs     -- ##
/**************************************/

/**********************************/
// ## -- Modulos Suporte Lovs -- ##
/**********************************/  

   function popUpCodigosHierarquicosLOV( paramIdTipoCodigo ,paramFormIdCodigo, paramFormCodigo,paramFormDescricao, tipoPesquisa){
          var width = 500;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'codHierarquicoLov.do?event=filtrar';
          var txtEvent   = '&';
          var txtElement = 'codHier='+document.getElementById(paramFormCodigo).value;
          txtElement += '&selCodHier='+document.getElementById(paramFormIdCodigo).value;
          txtElement += '&descCodHier='+document.getElementById(paramFormDescricao).value;
          txtElement += '&idCodigoDestino='+paramFormIdCodigo;
          txtElement += '&codigoDestino='+paramFormCodigo; 
          txtElement += '&descricaoDestino='+paramFormDescricao; 
          
          if(document.getElementById(paramIdTipoCodigo))
            txtElement += '&idTipoCodigo='+document.getElementById(paramIdTipoCodigo).value;
          else 
            txtElement += '&idTipoCodigo='+paramIdTipoCodigo;
            
          if(tipoPesquisa != null)
            txtElement += '&tipoPesquisa='+tipoPesquisa;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2; 
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';        
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Hierarquicos',settings);
          trackingWindow.focus();            
        }  

    function popUpCodigosPostalLOV(paramFormIdCodPost, paramFormCodPost){
          var width = 500;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'codPostalLov.do?event=filtrar';
          var txtEvent   = '&';
          var txtElement = '';          
          txtElement += '&idCodPostDestino='+paramFormIdCodPost;
          txtElement += '&codigoPostalDestino='+paramFormCodPost;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2; 
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Postais',settings);
          trackingWindow.focus();            
        }
        
        function popUpTipoCodigoLOV(paramFormIdTipoCod, paramFormCod, paramFormDesc,pageCalled){
          var width = 600;
          var height = 600;
          var trackingWindow = null;
          var txtPage    = 'tipoCodigoLov.do';
          var txtEvent   = '?';
          var txtElement = '';                
          txtElement += '&codigoTipo='+replaceAll(document.getElementById(paramFormCod).value,'%',escape('%'));
          txtElement += '&descricao='+replaceAll(document.getElementById(paramFormDesc).value,'%',escape('%'));
          txtElement += '&idTipoCodDestino='+replaceAll(document.getElementById(paramFormIdTipoCod).value,'%',escape('%'));
          txtElement += '&codDestino='+replaceAll(document.getElementById(paramFormCod).value,'%',escape('%'));
          txtElement += '&descDestino='+replaceAll(document.getElementById(paramFormDesc).value,'%',escape('%'));
          txtElement += '&pageCalled='+pageCalled;
          if (document.getElementById(paramFormCod).value.length > 0 ||
              document.getElementById(paramFormDesc).value.length > 0  ){
              txtEvent = '?event=search';
          }
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2; 
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Tipos_Codigos',settings);
          trackingWindow.focus();            
        }
        
        /*
         * lov de listagem de códigos genéricos
         **/
        function popUpCodigoGenericoLOV(idDominio, 
                                        dominio,
                                        id, 
                                        codigo,
                                        descricao){
          
          var txtPage = '../sup/codGenericoLov.do';
          
          // id dos objectos na pagina (id, codigo e descricao)
          var txtElement = '&oId='+id;
          txtElement += '&oCodigo='+codigo;
          txtElement += '&oDescricao='+descricao;
          
          // value dos objectos (codigo e descricao)
          txtElement += '&codigo='+document.getElementById(codigo).value;
          txtElement += '&descricao='+document.getElementById(descricao).value;
          
          // dominio ou dominios da dos registos para a listagem a devolver
          txtElement += '&dominio='+dominio;
          
          if( idDominio != null) {
            txtElement += '&idDominio='+document.getElementById(idDominio).value;
          }
          
          var txtEvent = '?event=search';
          var param = txtPage;    
          param += txtEvent;
          param += txtElement;
          
          // setting para a popup
          var width = 500;
          var height = 640;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2; 
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          var trackingWindow = window.open(encodeUTF8(param),'CodigosGenericos',settings);
          trackingWindow.focus();            
        }
        
   //perfilLov
   
   function popUpPerfisLOV(paramPerfil, idPerfil, codPerfil, pkPerfil){
          var width = 500;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'perfilLov.do';
          var txtEvent   = '?event=search'
          var txtElement = '&perfil='+document.getElementById(paramPerfil).value+'&primeira=false'+'&idPerfil='+idPerfil+'&codPerfil='+codPerfil+'&pkPerfil='+pkPerfil;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Perfis',settings);
          trackingWindow.focus();            
          
        }   
        
        
function popUpCodHierLovLOV(paramCampoId, paramCampoDesc, paramIdPai,paramLabel,paramTitulo){
          var width = 700;
          var height = 700;
          var trackingWindow = null;
          var txtPage    = 'popUpCodHierLovLOV.do';
          var txtEvent   = '?event=search';
          var txtElement = '&titulo='+paramTitulo;
          txtElement += '&label='+paramLabel; 
          txtElement += '&idPaiCodHier='+paramIdPai;
          txtElement += '&campoId='+paramCampoId; 
          txtElement += '&campoDesc='+paramCampoDesc;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Hierarquicos_Lov',settings);
          if(trackingWindow){
            trackingWindow.focus();
          }
        }    
                

    //opcoesMenuLov
   function popUpOpcoesMenuPerfisLOV(paramIdMenu,paramOpcaoMenu,paramPrompt){
          var width = 400;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'opcoesMenuLov.do';
          var txtEvent   = '?event=search'
          var txtElement = '';
          txtElement += '&opcaoMenu='+document.getElementById(paramOpcaoMenu).value;
          txtElement += '&idDad='+paramIdMenu;
          txtElement += '&opcaoMenuDad='+paramOpcaoMenu;
          txtElement += '&promptDad='+paramPrompt;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'OpcoesMenus',settings);
          trackingWindow.focus();            
        }      
                
    //Edição de Accesso Perfis de Utilizador
   function popUpGestaoAcessosLOV(perfilId){
          var width = 500;
          var height = 400;
          var trackingWindow = null;
          var txtPage    = 'edicaoGestaoAcesso.do';
          var txtEvent   = '?event=search'
          var txtElement = '&selId='+perfilId;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'gestao_acessos',settings);
          trackingWindow.focus();            
        }      
                                
/*********************************************/
//    Begin Sys Hierarquia de Opcoes MENU     /
/*********************************************/

   function popUpOpcoesMenuLOV(paramFormIdDad, paramFormPromptDad, paramFormUrlDad,paramFormCheckDad){
          var width = 700;
          var height = 700;
          var trackingWindow = null;
          var txtPage    = 'hierOpcoesMenuLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&IdDad='+paramFormIdDad;
          txtElement += '&PromptDad='+paramFormPromptDad; 
          txtElement += '&UrlDad='+paramFormUrlDad;
          txtElement += '&CheckDad='+paramFormCheckDad;
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Hierarquia_de_Menus',settings);
          trackingWindow.focus();            
        }    

/*********************************************/
//   End Sys Hierarquia de Opcoes MENU        /
/*********************************************/

/*********************************************/
//    Begin Identificao LOVS                  /
/*********************************************/
        
    function popUpEntidadeLOV(titulo,     // titulo para a lov
                              tipoCodigo, // codigo de dominio de entidades a pesquisar
                              codPai, 
                              id, 
                              codigo, 
                              descricao, 
                              descAbrev){
      
      var width = 700;
      var height = 600;
      var trackingWindow = null;
      var txtPage    = 'entidadeLov.do';
      var txtEvent   = '?event=Filtrar&pTitleLov='+titulo;
      var txtElement = '';
      txtElement += '&tipoCodigo='+tipoCodigo; 
      if(codPai != null){
        txtElement += '&codPai='+document.getElementById(codPai).value;
      }
      txtElement += '&idDestino='+id;
      if ( descAbrev != '' ) {
        txtElement += '&codigoDestino='+descAbrev;
        txtElement += '&descAbrv='+document.getElementById(descAbrev).value;
      } else if ( codigo != '' ) {
        txtElement += '&codigoDestino='+codigo;
        txtElement += '&codEnt='+document.getElementById(codigo).value;
      }
      if(descricao!=null ){
        if(descricao!=''){
            txtElement += '&desc='+document.getElementById(descricao).value;
            txtElement += '&descricaoDestino='+descricao;
        }
      }

      var param = '../idu/'; 
      var winl = (screen.width-width)/2;
      var wint = (screen.height-height)/2;          
      var settings ='height='+height+',';
      settings +='width='+width+',';
      settings +='top='+wint+',';
      settings +='left='+winl+',';
      settings +='scrollbars=yes,';
      settings +='resizable=yes';             
      param  += txtPage;    
      param += txtEvent;
      param += txtElement;
      trackingWindow = window.open(encodeUTF8(param),'entidades',settings);
      trackingWindow.focus();            
     }
 
     function popUpEntidadePaiLov(id,codigo,Designacao){
        var width = 500;
        var height = 640;
        var trackingWindow = null;
        var txtPage    = '../idu/entidadeRespLov.do?';
        var txtElement = '';      
        txtElement += '&id='+id; 
        txtElement += '&codPai='+document.getElementById(id).value;
        txtElement += '&codEnt='+document.getElementById(codigo).value;
        txtElement += '&idDestino='+codigo;
        txtElement += '&codigoDestino='+codigo;
        if(Designacao!=null ){
        if(Designacao!=""){
            txtElement += '&desc='+document.getElementById(Designacao).value;
            txtElement += '&DesignacaoDestino='+Designacao;
        }
      }
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'entidades',settings);
          trackingWindow.focus();            
        }
        
    //Begin Bug Fix to edicao entidade Lov Pai Vitor Silva        
     function popUpEntidadePaiLovFx(id,codigo,InitialCodeFather,descr,CodEntidadePaiId,calledLovTipo,SpaCodigo,titLov){    
          var width = 500;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'entidadePaiLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&descrSearch='+replaceAll(document.getElementById(descr).value,'%',escape('%'));
              txtElement += '&updateOpenerFielDescr='+descr;
              txtElement += '&calledLovTipo='+calledLovTipo;  
        
            
          if(id != 'arsid' && id != 'codEntResp'){    
              // txtElement += '&codAux01='+replaceAll(document.getElementById('arsid').value,'%',escape('%'));
              txtElement += '&codAux01='+replaceAll(document.getElementById(id).value,'%',escape('%'));
              
              if(id != 'srsid'){
                // txtElement += '&codAux02='+replaceAll(document.getElementById('srsid').value,'%',escape('%'));
                txtElement += '&codAux02='+replaceAll(document.getElementById(id).value,'%',escape('%'));
              }
          }
          
          if (codigo!=''){
              txtElement += '&sysEntidadeId='+document.getElementById(codigo).value;
          }
              
          if (document.getElementById(id).value!=''){
              txtElement += '&paiSearch='+replaceAll(document.getElementById(id).value,'%',escape('%'));
          }
              
          txtElement += '&updateOpenerFielCodigo='+id;
          txtElement += '&CodEntidadePaiId='+CodEntidadePaiId;
          txtElement += '&SpaCodigo='+SpaCodigo;
          txtElement += '&lovTitulo='+replaceAll(titLov,'%',escape('%'));
              
          var param = '../sup/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Pai_Entidades',settings);
          trackingWindow.focus();        
        }
        //END Bug Fix to edicao entidade Lov Pai Vitor Silva

    
    // nota: popup UTF8 url encoded
    function abreLovDistConcFreg(paramCampoId, 
                                 paramCampoDesc, 
                                 paramIdPai,
                                 paramLabel,
                                 paramTitulo,
                                 paramValorIdCampo,
                                 paramValorCampo,
                                 objLimpar,
                                 objsChave){
          var width = 500;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'codHierLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&titulo='+paramTitulo;
          txtElement += '&pBackEnabled=true';
          txtElement += '&primeira=true';
          txtElement += '&label='+paramLabel; 
          txtElement += '&idPaiCodHier='+paramIdPai;
          txtElement += '&campoId='+paramCampoId; 
          txtElement += '&campoDesc='+paramCampoDesc;
          txtElement += '&desc='+paramValorCampo;
          txtElement += '&objLimpar='+objLimpar;
          txtElement += '&objsChave='+objsChave;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Hierarquicos_Lov',settings);
          if(trackingWindow){ trackingWindow.focus(); }      
    }
 
   
    function popUpCodHierLovLOV(paramCampoId, paramCampoDesc, paramIdPai,paramLabel,paramTitulo,paramValorCampo,bloco){
          var width = 500;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'codHierLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&titulo='+paramTitulo;
          txtElement += '&label='+paramLabel; 
          txtElement += '&idPaiCodHier='+paramIdPai;
          txtElement += '&campoId='+paramCampoId; 
          txtElement += '&campoDesc='+paramCampoDesc;
          txtElement += '&desc='+paramValorCampo;
          txtElement += '&bloco='+bloco;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Hierarquicos_Lov',settings);
           if(trackingWindow){
            trackingWindow.focus();
          }         
        }
       
        
        function popUpMedicosLOV(paramCampoId, 
                                 paramCampoDesc, 
                                 paramLabel,
                                 paramTitulo,
                                 paramDescMed){
              var width = 500;
              var height = 500;
              var trackingWindow = null;
              var txtPage    = 'medicoLov.do';
              var txtEvent   = '?event=search';
              var txtElement = '';
              txtElement += '&label='+paramLabel; 
              txtElement += '&campoId='+paramCampoId; 
              txtElement += '&campoDesc='+paramCampoDesc;
              txtElement += '&desc='+paramDescMed;
              var param = '../idu/'; 
              var winl = (screen.width-width)/2;
              var wint = (screen.height-height)/2;          
              var settings ='height='+height+',';
              settings +='width='+width+',';
              settings +='top='+wint+',';
              settings +='left='+winl+',';
              settings +='scrollbars=yes,';
              settings +='resizable=yes';             
              param  += txtPage;    
              param += txtEvent;
              param += txtElement;
              trackingWindow = window.open(encodeUTF8(param),'Medico_Lov',settings);
              trackingWindow.focus();
        }
        
   function popUpHistoricoInscricoes(paramIdUtente){
          var width = 750; 
          var height = 325;
          var trackingWindow = null;
          var txtPage    = 'pesquisaHistoricoInsc.do';
          // var txtEvent   = '?event=search';
          var txtElement = '?titulo=Historico';
          txtElement += '&pBackEnabled=true';
          txtElement += '&idUtente='+paramIdUtente;
          var param = '../idu/'; 
          // var winl = (screen.width-width)/2;
          // var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          // settings +='top='+wint+',';
          // settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          // param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Historico_Inscricoes',settings);
          trackingWindow.focus();            
        }       
        
        function popUpHistoricoMedicos(paramIdInscr,paramTipoInscr){
          var width = 400;
          var height = 300;
          var trackingWindow = null;
          var txtPage    = 'pesquisaHistoricoMedico.do';
          var txtEvent   = '?event=search';
          // var txtElement = '&titulo=Hist&oacute;rico de M&eacute;dicos';
          var txtElement = '&titulo=Historico_Medico';
          txtElement += '&idInscr='+paramIdInscr;
          txtElement += '&tipoInscr='+paramTipoInscr;
          txtElement += '&pBackEnabled=true';
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Historico_Medicos_Inscricao',settings);
          trackingWindow.focus();            
        }
        
        function popUpHistoricoFamilias(paramIdInscr){
          var width = 700;
          var height = 300;
          var trackingWindow = null;
          var txtPage    = 'pesquisaHistoricoFamilia.do';
          var txtEvent   = '?event=search';
          var txtElement = '&titulo=Historico_Familias_Inscricao';
          txtElement += '&idInscricao='+paramIdInscr;
          txtElement += '&pBackEnabled=true';
          var param = '../idu/'; 
          // var winl = (screen.width-width)/2;
          // var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          // settings +='top='+wint+',';
          // settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Historico_Familias_Inscricao',settings);
          trackingWindow.focus();            
        }
        
        function popUpHistoricoBeneficios(paramIdUtente){
          var width = 800;
          var height = 400;
          var trackingWindow = null;
          var txtPage    = 'pesquisaHistoricoBeneficios.do';
          var txtElement = '?titulo=Historico_Beneficios_Utente';
          txtElement += '&idUtente='+paramIdUtente;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Historico_Beneficios_Utente',settings);
          trackingWindow.focus();            
        }
        
        function popUpHistoricoEntidades(paramIdUtente){
          var width = 800;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'pesquisaHistoricoEntidades.do';
          var txtElement = '?titulo=Historico_Entidades_Utente';
          txtElement += '&idUtente='+paramIdUtente;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Historico_Entidades_Utente',settings);
          trackingWindow.focus();            
        }
        
        function popUpBeneficiosLov(paramCampoId,paramCampoDesc,paramCampoIdHistBenef,paramCampoData,paramTitulo,paramTipoBeneficio){
          var width = 500;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'beneficiosLov.do';
          var txtEvent   = '?event=search';
          var txtElement = '&titulo='+paramTitulo;
          txtElement += '&campoId='+paramCampoId;
          // txtElement += '&campoIdHist='+paramCampoIdHistBenef;
          txtElement += '&campoDesc='+paramCampoDesc;
          txtElement += '&campoData='+paramCampoData;
          txtElement += '&tipoBenef='+paramTipoBeneficio;
          if ( document.getElementById(paramCampoDesc).value != '' )
                txtElement += '&desc='+document.getElementById(paramCampoDesc).value;
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Beneficios_Lov',settings);
          trackingWindow.focus();            
        }
        
        function popUpCodPostalLOV(paramIdCodPost, paramCodPost,paramSeqPost,paramLugarPost){
          var width = 500;
          var height = 640;
          var trackingWindow = null;
          var txtPage    = 'codigoPostalLov.do';
          var txtEvent   = '?event=Search';
          var txtElement = '';
          txtElement += '&idCodPostDestino='+paramIdCodPost;
          txtElement += '&codPostalDestino='+paramCodPost;
          txtElement += '&seqPostalDestino='+paramSeqPost;
          if ( paramCodPost != '' )
            txtElement += '&CodPostal='+document.getElementById(paramCodPost).value;
          if ( paramSeqPost != '' )
            txtElement += '&SeqPostal='+document.getElementById(paramSeqPost).value;
          if ( paramLugarPost != '' ) {
            txtElement += '&lugarCodPostalDestino='+paramLugarPost
            txtElement += '&lugarCodPostal='+document.getElementById(paramLugarPost).value;
          }
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2; 
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'Codigos_Postais',settings);
          trackingWindow.focus();            
        }
        
        function detalheUtentePopUp(idUtente){
          var width = 900;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'detalheUtente.do';
          var txtEvent   = '';
          if (idUtente.length >0){
             var txtElement = '?idUtente='+idUtente;
          }else{
              var txtElement = '';
          }
          var param = '../com/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          //trackingWindow = window.open(encodeUTF8(param),'detalheUtente',"dialogWidth:900px;dialogHeight:700px;edge:sunken;scroll:no;status:no;unadorned:yes;resizable=yes;center:yes;"); 
          trackingWindow = window.open(encodeUTF8(param),'detalheUtente',settings);
          trackingWindow.focus();
        }
        
        function detalheUtenteDuplicadosPopUp(idUtente){
          var width = 900;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'detalheUtente.do';
          var txtEvent   = '';
          if (idUtente.length >0){
             var txtElement = '?idUtente='+idUtente;
          }else{
              var txtElement = '';
          }
          var param = '../com/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'UtenteDuplicado',settings);
          trackingWindow.focus();            
        }
        
        function compararPedidoPopUp(idPedido, idUtente){
          var width = 740;
          var height = 685;
          var trackingWindow = null;
          var txtPage    = 'compararPedido.do';
          var txtEvent   = '';
          var txtElement = '?idPedido='+idPedido;
          if (idUtente.length >0){
             txtElement += '&idUtente='+idUtente;
          }
          var param = '../com/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'compararPedido',settings);
          trackingWindow.focus();            
        }

        function detalhePedidoPopUp(idPedido){
          var width = 740;
          var height = 530;
          var trackingWindow = null;
          var txtPage    = 'detalhePedido.do';
          var txtEvent   = '';
          if (idPedido.length >0){
             var txtElement = '?idPedido='+idPedido;
          }else{
              var txtElement = '';
          }
          var param = '../com/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'detalhePedido',settings);
          trackingWindow.focus();            
        }
        
        function resolucaoPedidoPopUp(idUtentePedido,idUtente,idPedido){
          var width = 600;
          var height = 400;
          var trackingWindow = null;
          var txtPage    = 'resolucaoPedido.do';
          var txtEvent   = '';
          var txtElement = '?idPedido='+idPedido;
          if (idUtente.length >0){
             txtElement += '&idUtente='+idUtente;
          }
          if (idUtentePedido.length >0){
             txtElement += '&idUtentePedido='+idUtentePedido;
          }
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes';             
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'resolucaoPedido',settings);
          trackingWindow.focus();            
        }
        
        function imprimirReceita(linkReceita,idJanela){
           imprimirReport(linkReceita,idJanela);
        }
        
        function imprimirReport(linkReport, idJanela) {
             var width = 740;
              var height = 500;
              var winl = (screen.width-width)/2;
              var wint = (screen.height-height)/2;          
              var settings ='height='+height+',';
              settings +='width='+width+',';
              settings +='top='+wint+',';
              settings +='left='+winl+',';
              settings +='scrollbars=no,';
              settings +='resizable=yes';  
              //trackingWindow = window.open('http://reportsrnu.min-saude.pt:80/reports/rwservlet?destype=cache&userid=igif/oracle123@DCMSINUS&report=snu_receita_sns.rdf&desformat=pdf&p_receitas='+idReceita,''+idReceita,settings);
              trackingWindow = window.open(linkReport,idJanela,settings);
              if(trackingWindow){
                trackingWindow.focus();
           } 
        }

        function imprimirReceita(linkReceita,idJanela){
          var width = 740;
          var height = 500;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes';  
          //trackingWindow = window.open('http://reportsrnu.min-saude.pt:80/reports/rwservlet?destype=cache&userid=igif/oracle123@DCMSINUS&report=snu_receita_sns.rdf&desformat=pdf&p_receitas='+idReceita,''+idReceita,settings);
          trackingWindow = window.open(linkReceita,idJanela,settings);
          if(trackingWindow){
            trackingWindow.focus();
          }
        }
        
        /* função para abrir pdf de relatório de ficha de utente dado o url
         */
        function openReport(url){
              var width = 740;
              var height = 500;
              var winl = (screen.width-width)/2;
              var wint = (screen.height-height)/2;          
              var settings ='height='+height+',';
              settings +='width='+width+',';
              settings +='top='+wint+',';
              settings +='left='+winl+',';
              settings +='scrollbars=no,';
              settings +='resizable=yes';  
              trackingWindow = window.open(url,"report",settings);
              if(trackingWindow){
                trackingWindow.focus();
              }
        }
        
        function popPesquisaFamilia(objNameId, objNameNumProc, objNameMorada, origemPedido){
              var objId = document.getElementById(objNameId);
              
              var idFamilia = "";
              if(objId){
                    idFamilia = objId.value;
              }
                  
              var width = 900;
              var height = 625;
              var winl = (screen.width-width)/2;
              var wint = (screen.height-height)/2;          
              var settings ='height='+height+',';
              settings +='width='+width+',';
              settings +='top='+wint+',';
              settings +='left='+winl+',';
              settings +='scrollbars=yes,';
              settings +='resizable=yes'; 
              
              var txtParam = '../idu/pesquisaFamilia.do?idFamilia='+idFamilia+'&objNameIdFamilia='+objNameId+'&objNameNumProc='+objNameNumProc+'&objNameMorada='+objNameMorada+'&origemPedido='+origemPedido+'&pBackEnabled=false';
              
              // -- se o valor do id de familia associado for a vazio entro no módulo de gestão de famílias c/ a acção de nova pesquisa
              // -- pois provávelmente vou pesquisar nova família para associar à inscrição. 
              // -- Se pelo contrário for preenchido entro no módulo em modo d procura do id da família fornecido.
              if(idFamilia.length==0){
                txtParam += '&event=NovaPesquisa'; 
              } else {
                txtParam += '&event=SearchFamilia';
              }
        
              trackingWindow = window.open(encodeUTF8(txtParam),'Pesquisa_Familia',settings);
              trackingWindow.focus();   
        }
        
        function resolucaoDuplicadosPopUp(idUtente){
          var width = 640;
          var height = 500;
          var trackingWindow = null;
          var txtPage    = 'resolucaoDuplicado.do';
          var txtEvent   = '';
          var txtElement = '';
          if(idUtente){
            if (idUtente.length >0){
                var txtElement = '?idUtente='+idUtente;
            }
          }
          var param = '../idu/'; 
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=yes,';
          settings +='resizable=yes';  
          param  += txtPage;    
          param += txtEvent;
          param += txtElement;
          trackingWindow = window.open(encodeUTF8(param),'resolucaoDuplicados',settings);
          trackingWindow.focus();            
        }        
/*********************************************/
//    END Identificao LOVS                    /
/*********************************************/