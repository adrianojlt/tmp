

 function prorrogar(objecto){
                var idade = getIdade(document.getElementById('hiddenInfoUtenteDtaNasc').value);
                var msg = '';
                if(idade < 18) {
                    msg = 'Atenção: O utente é menor de 18 anos. Deseja gravar os dados?';
                } else {
                    msg = 'Os dados serão gravados. Deseja continuar?';
                }
                //if(confirm(msg)) {genericAction(objecto); }
                //$.spmsDialog('confirm', { title: 'Deseja Continuar?', message: 'Os dados serão gravados. Deseja continuar?'}, callback: function() { genericAction(objecto); });
                $.spmsDialog( 'confirm', { title: 'Deseja Continuar?', message: 'Os dados serão gravados. Deseja continuar?', callback: function() { genericAction(objecto); } });
            }
  
  
   function isNumber(sText) {
                var ValidChars = "0123456789";
                var IsNumber=true;
                var Char; 
                for (i = 0; i < sText.length && IsNumber == true; i++) { 
                    Char = sText.charAt(i); 
                    if (ValidChars.indexOf(Char) == -1) {
                        IsNumber = false;
                    }
                }
                return IsNumber;
            }

            //Used to access the parameters     
            function getParameter(name) {
                name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
                var regexS = "[\\?&]"+name+"=([^&#]*)";
                var regex = new RegExp( regexS );
                var results = regex.exec( window.location.href );
                if( results == null ) {
                    return ""; 
                } else {
                    return results[1];
                }
            }
 
            // Check if format of the date is valid, with 
            function checkDate(data) {
                if (data == '') {
                    return true;
                }
                return Date.isValid(data,'dd-MM-yyyy');
            }
    
            /*
            function subtractDate(date1, date2) {
                var dateObject1 = Date.parseString (date1,"dd-MM-yyyy");
                var dateObject2 = Date.parseString (date2,"dd-MM-yyyy");        
                var one_day=1000*60*60*24;
                var diffData = Math.ceil((dateObject1.getTime()-dateObject2.getTime())/(one_day));       
                return diffData + 1;
            }
            */
    
            var dataInicioGlobal;
        
            function genericAction (buttonPressed) {
                //Para a selecção da entidade responsavel, é necessario ir buscar o 
                //valor que está seleccionado, para se manter seleccionado
                document.getElementById('hiddenSubmitIEntidadeResponsavel').value = document.getElementById('hiddenIEntidadeResponsavel').value;        
                // enable checks
                var incActProfObjCheck = document.getElementById("incActProf");
                incActProfObjCheck.disabled = false;        
                var incCuiInaObjCheck = document.getElementById("cuiIna");
                incCuiInaObjCheck.disabled = false;        
                var incImpBenefGraCheck = document.getElementById("impBenefGra");        
                incImpBenefGraCheck.disabled = false;
        
                if (buttonPressed.value == 'Gravar') {  //Inserir Baixa 
                    splash(true);
                    document.getElementById('hiddenListaItemsBaixas').value='insertNewProrrogacao';
                   document.getElementById('idEvent').value ='insertNewProrrogacao';
                    buttonPressed.form.submit();
                } else if (buttonPressed.value == 'Cancelar') {
                    splash(true);
                    document.getElementById('formProg').action='../git/baixasUtente.do';
                   document.getElementById('formProg').submit();
                }
            }
    