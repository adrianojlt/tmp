function setAllReadOnly(){
        var inputs = document.getElementsByTagName('input');
        var myArray1 = new Array();
        if (inputs) {
            for (var i = 0; i < inputs.length; ++i) {
                if (inputs[i].type != 'button'){
                    if(inputs[i].name != 'nissUtente'){
                        inputs[i].className+=' disabled'
                    }
                }
            }
        }        
    }
        
    function genericAction(buttonPressed) {
        splash(true);
        if (buttonPressed.value == 'Alterar') {
            buttonPressed.form.submit();
        }
    }        
    // -- variavel para armazenar codigos de beneficios de Medicacao Especial que o utente ja tem,
    // -- de forma a que qdo o operador tentar inserir um beneficio ja adicionado informar isso mesmo.
    // -- nota1: este array será preenchifo no forEach dos beneficios de Medicacao Especial (ListaBeneficiosDoUtente)
    var benefiosMedicacaoEspecial = new Array();
    var countBeneficiosMedicacaoEspecial = 0;