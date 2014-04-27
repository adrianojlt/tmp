
//Check the key pressed. CRF20071030 Ponto 12
function keyCheck(p_event,p_obj){
    var KeyID = (window.event) ? event.keyCode : p_event.keyCode;
    
    switch(KeyID) {
      case 13:   //Enter
          p_obj.focus();
          return false;
          break; 
    }
}

function selectFirstItem(objIdName) {
    var inputs = document.getElementsByTagName('input');
     if (inputs) {
     
      //Chekcs if there isn't any selected baixa 
      for (var i = 0; i < inputs.length; ++i) {
        if (inputs[i].type == 'radio' && inputs[i].id   == objIdName){ 
            if (inputs[i].checked){
                return true;
            }
        }
      }
      
      // Clicks on the first Baixa
      for (var i = 0; i < inputs.length; ++i) {
        if (inputs[i].type == 'radio' && inputs[i].id   == objIdName ){
            inputs[i].click();
            return true;           
        }
      }
     }
    
    return true;
}

    //Adds days to the Date returnando o formato
    function addDaysToDateFormat(dataInicio,dias) {
        if(dataInicio){
            if(dataInicio.length>0){
                var data = Date.parseString (dataInicio,"dd-MM-yyyy");
                data.add('d',dias);
                return data.format('dd-MM-yyyy');    
            }
        }
        return '';
    }	
    
    //Adds days to the Date returnando o objecto
    function addDaysToDate(dataInicio,dias) {
        var data = Date.parseString (dataInicio,"dd-MM-yyyy");
        data.add('d',dias);
        return data; 
    }


//Prints Item Baixa   
    function imprimirItemBaixa(idItemBaixa,tipoEntidade,codClassDoenca){
        document.getElementById('IdItemBaixa').value = idItemBaixa;
        document.getElementById('hiddenListaItemsBaixas').value = 'ImprimirItemBaixa';
        document.formItemsBaixa.submit();
        /*  
          var width = 800;
          var height = 600;
          var winl = (screen.width-width)/2;
          var wint = (screen.height-height)/2;          
          var settings ='height='+height+',';
          

          //var reportServerMachine   = 'reportsrnu.min-saude.pt';
          var reportServerMachine   = 'dcdbdsnsapp01.dc.local';
          var reportServerPort      = '7779';
          var reportServerPath      = '/reports/rwservlet';
          var reportServerMisc      = 'destype=cache&userid=igif/oracle123@DEV10G1';
          var reportToPrintSegSocial= 'snu_baixa_mod141_SegSocial.rdf';
          var reportToPrintPub      = 'snu_baixa_mod141_pub.rdf';
          var reportToPrintFormat   = 'pdf';
          
          var reportToPrint;
          // Public Entity or Not
          if (tipoEntidade == 'EPUB') {
            reportToPrint = reportToPrintPub;
          } else {
            reportToPrint = reportToPrintSegSocial;
          }
          
          var path = 'http://' + reportServerMachine + ':' + reportServerPort + reportServerPath + '?' + reportServerMisc + '&report=' + reportToPrint + '&desformat=' + reportToPrintFormat + '&p_item_baixa_id=' + idItemBaixa;

          settings +='width='+width+',';
          settings +='top='+wint+',';
          settings +='left='+winl+',';
          settings +='scrollbars=no,';
          settings +='resizable=yes'; 
          
          trackingWindow = window.open(path,''+idItemBaixa+'CIT',settings);
          if(trackingWindow){
            trackingWindow.focus();
          }
          
          
          if (codClassDoenca == 'DD') {
            reportToPrint = 'snu_baixa_mod230.rdf';
            path = 'http://' + reportServerMachine + ':' + reportServerPort + reportServerPath + '?' + reportServerMisc + '&report=' + reportToPrint + '&desformat=' + reportToPrintFormat + '&p_item_baixa_id=' + idItemBaixa;
            
          
            trackingWindowDD = window.open(path,''+idItemBaixa+'QUEST',settings);
            if(trackingWindowDD){
               trackingWindowDD.focus();
            }
          }
          */
        }
        
        
//Control the values on the field dp-dinicio
function controlDataInicio(dataInicio, dataFim, NrDias) {
    if (Date.isValid(dataInicio.value,'ddMMyyyy')) {
        var dataTemp = Date.parseString (dataInicio.value,"ddMMyyyy");
        dataInicio.value = dataTemp.format('dd-MM-yyyy');
    }
    //Check if the date is valid
    if (!checkDate(dataInicio.value)) { 
        dataInicio.value='';
        alert('Data introduzida inválida!');
    }
    
    //Update campo dataFim, with base on the NrDias
    if (NrDias.value != '' && dataInicio.value != ''){
        var data      = addDaysToDateFormat(dataInicio.value,NrDias.value - 1);
        dataFim.value = data;
    }
}

//Control the values on the field dp-dtermo
function controlDataFim(dataInicio, dataFim, NrDias) {
    if (Date.isValid(dataFim.value,'ddMMyyyy')) {
        var dataTemp = Date.parseString (dataFim.value,"ddMMyyyy");
        dataFim.value = dataTemp.format('dd-MM-yyyy');
    }
    //Check if the date is valid
    if (!checkDate(dataFim.value) || dataFim.value == '') { 
        if (!checkDate(dataFim.value)) {
            alert('Data introduzida inválida!');
        }
        dataFim.value='';
        //If a doctor whants to give a date for the end, we can delete the number of days
        NrDias.value= '';
        ast_num_dias.style.visibility = "visible";
        ast_data_termo.style.visibility = "visible";
    }
    
    var dataInicioDate      = addDaysToDate(dataInicio.value,'0');
    var dataFimDate         = addDaysToDate(dataFim.value,'0');
    
    //Set 1 day in milliseconds
    var one_day=1000*60*60*24;
    var diffData = Math.ceil((dataFimDate.getTime()-dataInicioDate.getTime())/(one_day));
    NrDias.value = diffData + 1;
    ast_num_dias.style.visibility = "hidden";
    ast_data_termo.style.visibility = "hidden";
    
    if (dataInicioDate.isAfter(dataFimDate)) {
        alert('Data introduzida é inferior á data de Inicio de Baixa!');
        dataFim.value='';
        NrDias.value= '';
        ast_num_dias.style.visibility = "visible";
        ast_data_termo.style.visibility = "visible";
    }
}        

 //Control the values on the field dp-dNrDias
function controlNrDias(dataInicio, dataFim, nrDias) {

    gNrDias = nrDias;

    //Check if NrDias is Number
    if ( !isNumber(nrDias.value) || nrDias.value == '' ) {

        //if (!isNumber(nrDias.value)) {}
        //alert('Número de Dias inválido!');
       $.spmsDialog('warning', { title: 'Aviso', message: 'Número de Dias inválido!'});

        nrDias.value  = '';
        dataFim.value = '';
        ast_num_dias.style.visibility = "visible";
        ast_data_termo.style.visibility = "visible";
        return;
    } else {
        if(eval(nrDias.value)<1){
            nrDias.value  = '';
            dataFim.value = '';
            ast_num_dias.style.visibility = "visible";
            ast_data_termo.style.visibility = "visible";
            return;
        }
        dataFim.value = addDaysToDate(dataInicio.value,nrDias.value - 1).format('dd-MM-yyyy');
        ast_num_dias.style.visibility = "hidden";
        ast_data_termo.style.visibility = "hidden";
    }

    // ... to long 
    if ( nrDias.value.length > 3 ) {

      //alert('to long ...');
       $.spmsDialog('warning', { title: 'Aviso', message: 'Número de dias demasiado longo!'});

      nrDias.value  = '';
      dataFim.value = '';
      ast_num_dias.style.visibility = "visible";
      ast_data_termo.style.visibility = "visible";
      return false;
    }
}

/*
function subtractDate(date1, date2) {

    var dateObject1 = Date.parseString (date1,"dd-MM-yyyy");
    var dateObject2 = Date.parseString (date2,"dd-MM-yyyy");
    
    var one_day=1000*60*60*24;
    var diffData = Math.floor((dateObject1.getTime()-dateObject2.getTime())/(one_day));
   
    return diffData + 1;
}
*/

/*
function subtractDate(date1, date2) {
    var dateObject1 = Date.parseString (date1,"dd-MM-yyyy");
    var dateObject2 = Date.parseString (date2,"dd-MM-yyyy");
    var one_day=1000*60*60*24.0;
    var diffData = Math.floor(((dateObject1.getTime()-dateObject2.getTime())/(one_day))+1); // Math.ceil
    return diffData;
}
*/


function cleanPopUpFamiliarSeleccionado(janela) {
    janela.document.getElementById('inputFamiliarSelected').value = "notSelected";
    janela.document.getElementById('inputFamiliarId').value = "";
    janela.document.getElementById('inputFamiliarNiss').value = "";
    janela.document.getElementById('inputFamiliarNome').value = "";
    janela.document.getElementById('inputFamiliarDtaNasc').value = "";
    janela.document.getElementById('inputFamiliarIdParentesco').value = "";
    janela.document.getElementById('inputFamiliarOutroParentesco').value = "";
    janela.document.getElementById('inputnissFamiliarImpedido').value = "";
    janela.document.getElementById('nissFamiliar').innerHTML = "";
    janela.document.getElementById('nomeFamiliar').innerHTML = "";
    janela.document.getElementById('parentescoFamiliar').innerHTML = "";
    janela.document.getElementById('dtaNascFamiliar').innerHTML = "";
    janela.document.getElementById('dtaNascFamiliar').innerHTML = "";
    janela.document.getElementById('nissFamiliarImpedido').innerHTML = "";
}

function atribuiVazio(idObj){
    var obj = document.getElementById(idObj);
    if(obj){
        obj.value = '';
    }
}

function collapseRow(row){
    if (document.getElementById(row)){
        var theRow = document.getElementById(row);
        theRow.style.display='none';
    }
    return;
}
    
function expandRow(row){
    if (document.getElementById(row)){
        var theRow = document.getElementById(row);
        theRow.style.display = displayProperty;
    }
    return;
}

function dataInicioProValida(){
    
    // controla se data inicio é superior á do ultimo item baixa
    var dataInicio = document.getElementById('dp-dinicio');
    var dataTermoLast = document.getElementById("hiddenLastItemDataTermo"); 
    
    if(dataInicio && dataTermoLast){
        
        var dataInicioDate = addDaysToDate(dataInicio.value,'0');
        var dataTermoLastDate = addDaysToDate(dataTermoLast.value,'0');
    
        if (!dataInicioDate.isAfter(dataTermoLastDate)){
            dataInicio.value='';
            return false;
        }
        
    }    
    return true;    
}


function verifyChange(param){
    if(param){
        var divSucesso = document.getElementById("sucess");
        if (divSucesso){
            divSucesso.style.display="block";
        }
    }
}