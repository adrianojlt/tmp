
    
    // Global Variables
    var displayProperty = '';

    if(navigator.appName.indexOf("Microsoft") > -1){
        displayProperty = 'block';
    }else{
        displayProperty = 'block'; // table-row 
    }

    javascript:window.history.forward(1);
   
    // evento para detectar F5 e invalidar o refresh da página
    /*document.attachEvent("onkeydown", my_onkeydown_handler); 
    document.onkeydown=my_onkeydown_handler;
    function my_onkeydown_handler() { 
        if (event.keyCode  == 116 || (event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) ) { 
            event.returnValue = false; 
            event.keyCode = 0; 
            window.status = "refresh da página não permitido..."; 
        } 
    }*/
    
    function click(e) {
        if (document.all) {
            if (event.button == 3) {
                //alert("Funcionalidade não permitida.");
                $.spmsDialog('warning', { title: '', message: 'Funcionalidade não permitida.'});
                return false;
            }
        }
        if (document.layers) {
            if (e.which == 3) {
                //alert("Funcionalidade não permitida.");
                $.spmsDialog('warning', { title: '', message: 'Funcionalidade não permitida.'});
                return false;
            }
        }
    }
    if (document.layers) {
        document.captureEvents(Event.MOUSEDOWN);
    }
    document.onmousedown=click;
    
    
    function collapseExpandRow(row){
        if (document.getElementById(row)){
            var theRow = document.getElementById(row);
            if(theRow.style.display == 'none'){
                theRow.style.display = displayProperty;
            } else {
                theRow.style.display='none';
            }
        }
        return;
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
    
    
    function transformDate(val){
        if (e == null) e = document.parentWindow.event;
        var kc = e.keyCode ? e.keyCode : e.charCode;
        if ( kc == 13 ) {
            alert(val);
                // close with update
                o.returnFormattedDate();
                o.hide();
                return o.killEvent(e);
        }
    }
    
     function handleKeyPress(field,event,e){
        
	var keycode;
	if (window.event){
		keycode = window.event.keyCode;
	}else if (e){
		keycode = e.which;
	}else{
	   return true;
	}

	if (keycode==13 && event==null ){
            return false;
        }else if (keycode==13 ){
                if(document.getElementById('idEvent')){
                    document.getElementById('idEvent').value=event;
                }
                splash(true);
                field.form.submit();
	}else{
		return true;
	}			
     }
     
     function chamaLovEnterPress(e, func){
        var keycode;
        if (window.event){
                keycode = window.event.keyCode;
        } else if (e){
                keycode = e.which;
        } else {
           return true;
        }

        if (keycode==13 && event==null ){
            return false;
        } else if (keycode==13){
            return func();
        } else {
            return true;
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
     
    // ## /////////////////////////////////// ##
    // ## -- funcoes p/ validacao de datas -- ##
    // ## /////////////////////////////////// ##
    var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
    var DAY_NAMES=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sun','Mon','Tue','Wed','Thu','Fri','Sat');
    
    function LZ(x) {
        return(x<0||x>9?"":"0")+x;
    }
    
    function isDate(val,format) {
            var date=getDateFromFormat(val,format);
            if (date==0) { return false; }
            return true;
            }
            
    function compareDates(date1,dateformat1,date2,dateformat2) {
            var d1=getDateFromFormat(date1,dateformat1);
            var d2=getDateFromFormat(date2,dateformat2);
            if (d1==0 || d2==0) {
                    return -1;
                    }
            else if (d1 > d2) {
                    return 1;
                    }
            return 0;
    }
    
    function formatDate(date,format) {
            var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
            var DAY_NAMES=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sun','Mon','Tue','Wed','Thu','Fri','Sat');
            format=format+"";
            var result="";
            var i_format=0;
            var c="";
            var token="";
            var y=date.getYear()+"";
            var M=date.getMonth()+1;
            var d=date.getDate();
            var E=date.getDay();
            var H=date.getHours();
            var m=date.getMinutes();
            var s=date.getSeconds();
            var yyyy,yy,MMM,MM,dd,hh,h,mm,ss,ampm,HH,H,KK,K,kk,k;
            // Convert real date parts into formatted versions
            var value=new Object();
            if (y.length < 4) {y=""+(y-0+1900);}
            value["y"]=""+y;
            value["yyyy"]=y;
            value["yy"]=y.substring(2,4);
            value["M"]=M;
            value["MM"]=LZ(M);
            value["MMM"]=MONTH_NAMES[M-1];
            value["NNN"]=MONTH_NAMES[M+11];
            value["d"]=d;
            value["dd"]=LZ(d);
            value["E"]=DAY_NAMES[E+7];
            value["EE"]=DAY_NAMES[E];
            value["H"]=H;
            value["HH"]=LZ(H);
            if (H==0){value["h"]=12;}
            else if (H>12){value["h"]=H-12;}
            else {value["h"]=H;}
            value["hh"]=LZ(value["h"]);
            if (H>11){value["K"]=H-12;} else {value["K"]=H;}
            value["k"]=H+1;
            value["KK"]=LZ(value["K"]);
            value["kk"]=LZ(value["k"]);
            if (H > 11) { value["a"]="PM"; }
            else { value["a"]="AM"; }
            value["m"]=m;
            value["mm"]=LZ(m);
            value["s"]=s;
            value["ss"]=LZ(s);
            while (i_format < format.length) {
                    c=format.charAt(i_format);
                    token="";
                    while ((format.charAt(i_format)==c) && (i_format < format.length)) {
                            token += format.charAt(i_format++);
                            }
                    if (value[token] != null) { result=result + value[token]; }
                    else { result=result + token; }
                    }
            return result;
            }
            
    function _isInteger(val) {
            var digits="1234567890";
            for (var i=0; i < val.length; i++) {
                    if (digits.indexOf(val.charAt(i))==-1) { return false; }
                    }
            return true;
            }
    function _getInt(str,i,minlength,maxlength) {
            for (var x=maxlength; x>=minlength; x--) {
                    var token=str.substring(i,i+x);
                    if (token.length < minlength) { return null; }
                    if (_isInteger(token)) { return token; }
                    }
            return null;
            }
            
    function getDateFromFormat(val,format) {
            
            var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
            var DAY_NAMES=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sun','Mon','Tue','Wed','Thu','Fri','Sat');
    
            val=val+"";
            format=format+"";
            var i_val=0;
            var i_format=0;
            var c="";
            var token="";
            var token2="";
            var x,y;
            var now=new Date();
            var year=now.getYear();
            var month=now.getMonth()+1;
            var date=1;
            var hh=now.getHours();
            var mm=now.getMinutes();
            var ss=now.getSeconds();
            var ampm="";
            
            while (i_format < format.length) {
                    // Get next token from format string
                    c=format.charAt(i_format);
                    token="";
                    while ((format.charAt(i_format)==c) && (i_format < format.length)) {
                            token += format.charAt(i_format++);
                            }
                    // Extract contents of value based on format token
                    if (token=="yyyy" || token=="yy" || token=="y") {
                            if (token=="yyyy") { x=4;y=4; }
                            if (token=="yy")   { x=2;y=2; }
                            if (token=="y")    { x=2;y=4; }
                            year=_getInt(val,i_val,x,y);
                            if (year==null) { return 0; }
                            i_val += year.length;
                            if (year.length==2) {
                                    if (year > 70) { year=1900+(year-0); }
                                    else { year=2000+(year-0); }
                                    }
                            }
                    else if (token=="MMM"||token=="NNN"){
                            month=0;
                            for (var i=0; i<MONTH_NAMES.length; i++) {
                                    var month_name=MONTH_NAMES[i];
                                    if (val.substring(i_val,i_val+month_name.length).toLowerCase()==month_name.toLowerCase()) {
                                            if (token=="MMM"||(token=="NNN"&&i>11)) {
                                                    month=i+1;
                                                    if (month>12) { month -= 12; }
                                                    i_val += month_name.length;
                                                    break;
                                                    }
                                            }
                                    }
                            if ((month < 1)||(month>12)){return 0;}
                            }
                    else if (token=="EE"||token=="E"){
                            for (var i=0; i<DAY_NAMES.length; i++) {
                                    var day_name=DAY_NAMES[i];
                                    if (val.substring(i_val,i_val+day_name.length).toLowerCase()==day_name.toLowerCase()) {
                                            i_val += day_name.length;
                                            break;
                                            }
                                    }
                            }
                    else if (token=="MM"||token=="M") {
                            month=_getInt(val,i_val,token.length,2);
                            if(month==null||(month<1)||(month>12)){return 0;}
                            i_val+=month.length;}
                    else if (token=="dd"||token=="d") {
                            date=_getInt(val,i_val,token.length,2);
                            if(date==null||(date<1)||(date>31)){return 0;}
                            i_val+=date.length;}
                    else if (token=="hh"||token=="h") {
                            hh=_getInt(val,i_val,token.length,2);
                            if(hh==null||(hh<1)||(hh>12)){return 0;}
                            i_val+=hh.length;}
                    else if (token=="HH"||token=="H") {
                            hh=_getInt(val,i_val,token.length,2);
                            if(hh==null||(hh<0)||(hh>23)){return 0;}
                            i_val+=hh.length;}
                    else if (token=="KK"||token=="K") {
                            hh=_getInt(val,i_val,token.length,2);
                            if(hh==null||(hh<0)||(hh>11)){return 0;}
                            i_val+=hh.length;}
                    else if (token=="kk"||token=="k") {
                            hh=_getInt(val,i_val,token.length,2);
                            if(hh==null||(hh<1)||(hh>24)){return 0;}
                            i_val+=hh.length;hh--;}
                    else if (token=="mm"||token=="m") {
                            mm=_getInt(val,i_val,token.length,2);
                            if(mm==null||(mm<0)||(mm>59)){return 0;}
                            i_val+=mm.length;}
                    else if (token=="ss"||token=="s") {
                            ss=_getInt(val,i_val,token.length,2);
                            if(ss==null||(ss<0)||(ss>59)){return 0;}
                            i_val+=ss.length;}
                    else if (token=="a") {
                            if (val.substring(i_val,i_val+2).toLowerCase()=="am") {ampm="AM";}
                            else if (val.substring(i_val,i_val+2).toLowerCase()=="pm") {ampm="PM";}
                            else {return 0;}
                            i_val+=2;}
                    else {
                            if (val.substring(i_val,i_val+token.length)!=token) {return 0;}
                            else {i_val+=token.length;}
                            }
                    }
            // If there are any trailing characters left in the value, it doesn't match
            if (i_val != val.length) { return 0; }
            // Is date valid for month?
            if (month==2) {
                    // Check for leap year
                    if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) { // leap year
                            if (date > 29){ return 0; }
                            }
                    else { if (date > 28) { return 0; } }
                    }
            if ((month==4)||(month==6)||(month==9)||(month==11)) {
                    if (date > 30) { return 0; }
                    }
            // Correct hours value
            if (hh<12 && ampm=="PM") { hh=hh-0+12; }
            else if (hh>11 && ampm=="AM") { hh-=12; }
            var newdate=new Date(year,month-1,date,hh,mm,ss);
            return newdate.getTime();
            }
    
    function parseDate(val) {
            var preferEuro=(arguments.length==2)?arguments[1]:false;
            generalFormats=new Array('y-M-d','MMM d, y','MMM d,y','y-MMM-d','d-MMM-y','MMM d');
            monthFirst=new Array('M/d/y','M-d-y','M.d.y','MMM-d','M/d','M-d');
            dateFirst =new Array('d/M/y','d-M-y','d.M.y','d-MMM','d/M','d-M');
            var checkList=new Array('generalFormats',preferEuro?'dateFirst':'monthFirst',preferEuro?'monthFirst':'dateFirst');
            var d=null;
            for (var i=0; i<checkList.length; i++) {
                    var l=window[checkList[i]];
                    for (var j=0; j<l.length; j++) {
                            d=getDateFromFormat(val,l[j]);
                            if (d!=0) { return new Date(d); }
                            }
                    }
            return null;
    }
    
    function days_between(date1, date2) {

        // The number of milliseconds in one day
        var ONE_DAY = 1000 * 60 * 60 * 24;
    
        // Convert both dates to milliseconds
        var date1_ms = date1.getTime();
        var date2_ms = date2.getTime();
    
        // Calculate the difference in milliseconds
        var difference_ms = Math.abs(date1_ms - date2_ms);
        
        // Convert back to days and return
        return Math.round(difference_ms/ONE_DAY);

    }

    // ## /////////////////////////////////// ##
    // ## -- funcoes p/ validacao de datas -- ##
    // ## /////////////////////////////////// ##
    
    
    // -- funcao para filtrar introducao de dados e deixar apenas colocar valores numericos
    function noAlpha(obj){

        //gObj = obj;
        //reg = /[^\d+$]/g;
        reg = /[^\d]/g;

        if( obj.value.search(reg) != -1 )        
            obj.value =  obj.value.replace(reg,"");
    }
    
    // -- funcao para filtrar introducao de datas e deixar apenas colocar valores com a formatacao correcta
    function valData(obj,evt){
    
        var erro = "N";
        var keycode = 1;
        var type = "";
        var valor = obj.value;
        if (window.event) {
            if ( window.event.keyCode != null ) {
                keycode = window.event.keyCode;
            }
            if ( window.event.type == 'blur' ) {
                keycode = 8;
                type = "blur";
            }
    	} else if (evt) {
                if ( evt.which != null ) {
                    keycode = evt.which;
                }
                if ( evt.type == 'blur' ) {
                    keycode = 8;
                    type = "blur";
                }
    	}
        
        if ( keycode != 8 ) {
            if ( valor.length < 10 ) {
                for ( i=0 ; i < valor.length ; i++ ) {
                    if ( i == 0 ) {
                        var pattern = new RegExp("[0-3]","g");
                    } else if ( i == 1 || i == 4 || i == 8 ) {
                        var pattern = new RegExp("[0-9]","g");
                    } else if ( i == 2 || i == 5 ) {
                        var pattern = new RegExp("-","g");
                    } else if ( i == 3 ) {
                        var pattern = new RegExp("0|1","g");
                    } else if ( i == 6 ) {
                        var pattern = new RegExp("[1-2]","g");
                    } else if ( i == 7 ) {
                        if ( valor.substring(i-1,i) == 1 ) {
                            var pattern = new RegExp("9","g");
                        } else if ( valor.substring(i-1,i) == 2 ) {
                            var pattern = new RegExp("0","g");
                        }
                    }
                    if (!(valor.substring(i,i+1)).match(pattern)) {
                        obj.value=valor.substring(0,i);
                        break;
                    }
                }
                if ( obj.value.length == 2 || obj.value.length == 5 ) {
                    var date_array = obj.value.split('-');
                    if ( obj.value.length == 2 ) {
                        if ( date_array[0] > 31 ) {
                            erro = "S";
                        }
                    } else if ( obj.value.length == 5 ) {
                        if ( date_array[1] > 12 ) {
                            erro = "S";
                        } else if ( date_array[0] == 31 ) {
                            if ( date_array[1] == 2 || date_array[1] == 4 || date_array[1] == 6 || date_array[1] == 9 || date_array[1] == 11 ) {
                                erro = "S"; 
                            }
                        } else if ( date_array[0] == 30 && date_array[1] == 2 ) {
                            erro = "S"; 
                        }
                    }
                    if ( erro == "N" ) {
                        obj.value=obj.value+'-';
                    } else {
                        obj.value=valor.substring(0,valor.length-1);
                    }
                }
                
            } else {
                var pattern = new RegExp("[0-3][0-9]-0|1[0-9]-19|20[0-9]{2}","g");
                if ( !obj.value.match(pattern) ) {
                    obj.value='';
                } else {
                    var date_array = obj.value.split('-');
                    if ( date_array[0] > 31 ) {
                        erro = "S";
                    } else if ( date_array[1] > 12 ) {
                        erro = "S";
                    } else if ( date_array[0] == 31 ) {
                        if ( date_array[1] == 2 || date_array[1] == 4 || date_array[1] == 6 || date_array[1] == 9 || date_array[1] == 11 ) {
                            erro = "S"; 
                        }
                    } else if ( date_array[0] == 30 && date_array[1] == 2 ) {
                        erro = "S"; 
                    }
                    if ( erro == "S" ) {
                        obj.value='';
                    }
                }
            }
        } else if ( type == "blur" ) {
            if ( obj.value.length < 10 ) {
                obj.value='';
            }
        } 
        
        if ( erro == "S" || ( obj.value.length < 10 && obj.value.length > 0 ) ) {
            obj.focus();
        }
    }
    
    // -- funcao para filtrar introducao de valores em campos com LOV e deixar apenas colocar valores correctos
    // -- para isso se verificar que o id do valor nao esta preenchido chama a lov correspondente
    function valLov(idObjVal,idObj,idImgLov,paramReadOnly){
        if (paramReadOnly=='false'){
            if ( document.getElementById(idObj).value != '' ) {
                if ( document.getElementById(idObjVal).value == '' ){
                    var obj = document.getElementById(idImgLov);
                    obj.click();
                    document.getElementById(idObj).value = '';
                }
            }
        }
    }
    
    // ## ///////////////////////////////////     ##
    // ## -- funcoes p/ validacao de caracters -- ##
    // ## ///////////////////////////////////     ##    
    //Added for check the value of an String injavascript
    
    function Mid(str, start, len)
    {
    // Make sure start and len are within proper bounds
        if (start < 0 || len < 0) return "";
        var iEnd, iLen = String(str).length;
        if (start + len > iLen)
              iEnd = iLen;
        else
              iEnd = start + len;
        return String(str).substring(start,iEnd);
    }

    function InStr(strSearch, charSearchFor)
    {
        for (countInStr=0; countInStr < strSearch.length; countInStr++)
        {
              if (charSearchFor == Mid(strSearch, countInStr, charSearchFor.length))
              {
                    return countInStr;
              }
        }
        return -1;
    }
    
   function setEnabledOrDisabledAndClean(){

        var inputs = document.getElementsByTagName('input');
        if (inputs) {
          for (var i = 0; i < inputs.length; ++i) {
            
            if (inputs[i].type == 'text' &&(InStr(inputs[i].id,"readTf")!=-1)){
                
                var idValue = inputs[i].id;
                var str     = inputs[i].className;
                var chkStr  = InStr(str, " ")
                
                if (chkStr > 0){
                    str = str.substr(0,chkStr);
                }else{
                    str = str.substr(0);
                }
                if (document.getElementById(idValue).readOnly){
                    document.getElementById(idValue).removeAttribute('readOnly');
                    document.getElementById(idValue).className=str;
                }else{
                    document.getElementById(idValue).value='';
                    document.getElementById(idValue).setAttribute('readOnly',true);
                    document.getElementById(idValue).className+=' disabled';
                }
            }
          }
        }
        return;
   }    
   
       
    function setEnabledOrDisabledButtons(ids, estado)
    {
        if( ids == null )
            return false;

      for (var i = 0; i < ids.length; ++i) {
      
      if (ids[i] != ''){
         if (document.getElementById(ids[i])){
         
            if (document.getElementById(ids[i]).type == 'submit' ||
                document.getElementById(ids[i]).type == 'button' ||
                document.getElementById(ids[i]).type == 'radio'  ||
                document.getElementById(ids[i]).type != 'text'
                && document.getElementById(ids[i]).type != 'hidden'
                ){
            var button = document.getElementById(ids[i]);
            
            if (button != null){
            
                var str     = button.className;
                var chkStr  = InStr(str, " ")
                
                if (chkStr > 0){
                    str = str.substr(0,chkStr);
                }else{
                    str = str.substr(0);
                }        
                if( button && estado){
                    button.disabled=estado;
                    if (document.getElementById(ids[i]).type != 'radio' &&
                       document.getElementById(ids[i]).type != 'checkbox'){
                             button.className+=' buttonDisabled';
                    }
                }else{
                    button.disabled=estado;
                    button.removeAttribute('disabled');            
                    button.className=str;
                }
            }
      
           }
        }
        
        }
      
      }
        return true;
   } 
   
   function setEnabledOrDisabled(ids, estado){
        if( ids == null )
            return false;     
        
          for (var i = 0; i < ids.length; ++i) {
            
            if (ids[i] != ''){
                if (document.getElementById(ids[i])){
                
                    var input = document.getElementById(ids[i]);
                
                
                
                    if( input ){
                        if ((input.type == 'text' || input.type == 'radio') && input.type != 'hidden'){
                            
                            var idValue = input.id;
                            var str     = input.className;
                            var chkStr  = InStr(str, " ")
                            
                            if (chkStr > 0){
                                str = str.substr(0,chkStr);
                            }else{
                                str = str.substr(0);
                            }
                            if( estado != true ){
                                 
                                if (document.getElementById(idValue).readOnly){
                                    document.getElementById(idValue).removeAttribute('readOnly');
                                    document.getElementById(idValue).className=str;
                                }
                            }else{
                                
                                if ( !document.getElementById(idValue).readOnly){
                                     if (input.type == 'radio'){
                                        document.getElementById(idValue).setAttribute('disabled', 'disabled');
                                     }else{
                                        document.getElementById(idValue).setAttribute('readOnly', 'readOnly');
                                        document.getElementById(idValue).className+=' disabled';
                                    }
                                }
                            }
                        }
                    }
                }
            }
          
        }  
        return true;
   } 
   
    // ## /////////////////////////////////// /////////////    ##
    // ## -- funcoes p/ por o fucos num input text da pagina-- ##
    // ## /////////////////////////////////// /////////////    ##    
    function setfocus(a_field_id) {
        if(document.getElementById(a_field_id)){
            document.getElementById(a_field_id).focus();
        }
    }
  
    
    // ## /////////////////////////////////////////////////////////////////////////    ##
    // ## -- funcao que muda a prompt do botao da info utente de simples para total -- ##
    // ## /////////////////////////////////////////////////////////////////////////    ##
    function changeSign(element)
    {
        if ( element.value == '+' )
        {
            element.value='-';
        } else {
            element.value='+';
        }
        return;
    }
    
    function replaceAll(oldStr,findStr,repStr) {
      var srchNdx = 0;  // srchNdx will keep track of where in the whole line
                        // of oldStr are we searching.
      var newStr = "";  // newStr will hold the altered version of oldStr.
      while (oldStr.indexOf(findStr,srchNdx) != -1)  
                        // As long as there are strings to replace, this loop
                        // will run. 
      {
        newStr += oldStr.substring(srchNdx,oldStr.indexOf(findStr,srchNdx));
                        // Put it all the unaltered text from one findStr to
                        // the next findStr into newStr.
        newStr += repStr;
                        // Instead of putting the old string, put in the
                        // new string instead. 
        srchNdx = (oldStr.indexOf(findStr,srchNdx) + findStr.length);
                        // Now jump to the next chunk of text till the next findStr.           
      }
      newStr += oldStr.substring(srchNdx,oldStr.length);
                        // Put whatever's left into newStr.             
      return newStr;
    }    
    
    // -- funcao para limpar valores de lovs
    function limpaLovs(id, cod, desc) {
        if(document.getElementById(id))
            document.getElementById(id).value = "";
        if(document.getElementById(cod))
            document.getElementById(cod).value = "";  
        if(document.getElementById(desc))
            document.getElementById(desc).value = "";  
    }
    
    // -- funcao que recebe valores para limpar (para uso p/ ex nas lovs)
    function resetValores(ids) {
        if(ids==null)
            return false;
        for (var i = 0; i < ids.length; ++i) {
             if(document.getElementById(ids[i]))
                document.getElementById(ids[i]).value = "";
        }
    }
    
    function getKeyCodeValue(event){
	if (window.event){
		keycode = window.event.keyCode;
	}else if (event){
		keycode = event.which;
	}else{
	   return true;
	}
        return keycode;
    }
    
    function noSpecialCaracters(obj){
        //reg = /[&%$#@*\~^]/g;
        reg = /[|!#$%&+()=?«»*ª_}{§£@<>\-^~º]/g;
        if(obj.value.search(reg)!=-1)
        obj.value =  obj.value.replace(reg,"");
    }    
    
    String.prototype.startsWith = function(s) { return this.indexOf(s)==0; }
    
    function splash_page(show,pagina){
        // alert(show);
        if(show){
        
            pagina.getElementById('preload').style.top = '0';
            pagina.getElementById('preload').style.left = '0';
            pagina.getElementById('preload').style.height = pagina.body.scrollHeight + "px";
            pagina.getElementById('preload').style.width = pagina.body.scrollWidth + "px";
 
            if(pagina.getElementById('preload')){
                pagina.getElementById('preload').visibility = 'visible';
                pagina.getElementById('preload').style.display='block';
            }
            if(pagina.getElementById('splash')){
                pagina.getElementById('splash').visibility = 'visible';
                pagina.getElementById('splash').style.display='block';
            }
        } else {
            if(pagina.getElementById('preload')){
                pagina.getElementById('preload').visibility = 'hidden';
                pagina.getElementById('preload').style.display='none';
            }
            if(pagina.getElementById('splash')){
                pagina.getElementById('splash').visibility = 'hidden';
                pagina.getElementById('splash').style.display='none';     
            }
        }
    }
    
    function splash(show){
        // alert(show);
        if(show){
        
            document.getElementById('preload').style.top = '0';
            document.getElementById('preload').style.left = '0';
            document.getElementById('preload').style.height =document.body.scrollHeight +1000+ "px";
            document.getElementById('preload').style.width = document.body.scrollWidth + "px";
 
            if(document.getElementById('preload')){
                document.getElementById('preload').visibility = 'visible';
                document.getElementById('preload').style.display='block';
            }
            if(document.getElementById('splash')){
                document.getElementById('splash').visibility = 'visible';
                document.getElementById('splash').style.display='block';
            }
        } else {
            if(document.getElementById('preload')){
                document.getElementById('preload').visibility = 'hidden';
                document.getElementById('preload').style.display='none';
            }
            if(document.getElementById('splash')){
                document.getElementById('splash').visibility = 'hidden';
                document.getElementById('splash').style.display='none';     
            }
        }
    }      
    
    String.prototype.trim = function() { 
        a = this.replace(/^\s+/, ''); 
        return a.replace(/\s+$/, '');
    };
    
    // -- acrescenta opcao a selected box fornecida
  function addOption(selectbox, value, text ){
     var optn = document.createElement("OPTION");
     optn.text = text;
     optn.value = value;
     selectbox.options.add(optn);
  }
  
  // -- remove as opcoes da selected box fornecida
  function removeAllOptions(selectbox, optionDefault){
     var i;
     for(i=selectbox.options.length-1;i>=0;i--){
        selectbox.remove(i);
     }
     // -- coloca opcao por defalut
     if(optionDefault.length>0){
        addOption(selectbox, "", optionDefault);
     }
  }
  
  // funcao para dado um array de objectos colocar enable or disable consuante o varable 'mode' (true-enable, false-disable)
    function enableOrDisableArrayObjects(objs,mode){
        for (i = 0; i < objs.length; i++){
            objs[i].disabled = mode;
        }
    }
    
    // metodo para controlar contexto de enable ou disable do form de escolha de distrito, concelho e freguesia
 function enableDisableDistConcFreg(distritoId, concelhoId, freguesiaId){
    // -- enable or disable objects
    var d = document.getElementById("id"+distritoId);
    var dd = document.getElementById("nome"+distritoId);
    
    var c = document.getElementById("id"+concelhoId);
    var cc = document.getElementById("nome"+distritoId);
    
    var f = document.getElementById("id"+freguesiaId);
    var ff = document.getElementById("nome"+distritoId);
    
    setEnabledOrDisabled(new Array('nome'+distritoId,'nome'+concelhoId, 'nome'+freguesiaId),false);
    
    document['popUp' + distritoId].src = '../img/application_side_list.gif';
    document['popUp' + distritoId].disabled = false;
    document['cross' + distritoId].src = '../img/cross.gif';
    document['cross' + distritoId].disabled = false;
    
    document['popUp' + concelhoId].src = '../img/application_side_list.gif';
    document['popUp' + concelhoId].disabled = false;
    document['cross' + concelhoId].src = '../img/cross.gif';
    document['cross' + concelhoId].disabled = false;
    
    document['popUp' + freguesiaId].src = '../img/application_side_list.gif';
    document['popUp' + freguesiaId].disabled = false;
    document['cross' + freguesiaId].src = '../img/cross.gif';
    document['cross' + freguesiaId].disabled = false;
    
    if(d){
        if(d.value.length==0){
            setEnabledOrDisabled(new Array('nome'+concelhoId, 'nome'+freguesiaId),true);
            document['popUp' + concelhoId].src = '../img/application_side_list_disable.gif';
            document['popUp' + concelhoId].disabled = true;
            document['cross' + concelhoId].src = '../img/cross_disabled.gif';
            document['cross' + concelhoId].disabled = true;
            
            document['popUp' + freguesiaId].src = '../img/application_side_list_disable.gif';
            document['popUp' + freguesiaId].disabled = true;
            document['cross' + freguesiaId].src = '../img/cross_disabled.gif';
            document['cross' + freguesiaId].disabled = true;
            
        } else if(c.value.length==0){
            setEnabledOrDisabled(new Array('nome'+freguesiaId),true);
            document['popUp' + freguesiaId].src = '../img/application_side_list_disable.gif';
            document['popUp' + freguesiaId].disabled = true;
            document['cross' + freguesiaId].src = '../img/cross_disabled.gif';
            document['cross' + freguesiaId].disabled = true;

        }
    }
 }

// função para chamar serviço de paginação por serviço ajax
function retrieveNavigationList(page, vo, next, event, metod, otherParams){
    url=page+"?event_RangeChange"+vo+"=RangeChange"+vo+"&nextRange"+vo+"="+next;
    if(!otherParams){
        otherParams = "";
    }
    url = url + otherParams;
    httpRequest("GET", url, false, metod);
}


// -----------------------
var objNameId;
var objNameDescricao;
var objNamePopUp;

function retriveValueDistConcFreg(valueNameId, valueNameToSearch, valueNameIdPai, valueNamePopUp){
   var valueId = document.getElementById(valueNameId).value;
   var valueToSearch = document.getElementById(valueNameToSearch).value;
   var valuePaiId = '';
   if(valueNameIdPai.length>0 && document.getElementById(valueNameIdPai)){
        valuePaiId = document.getElementById(valueNameIdPai).value;
   }
   objNameId = valueNameId;
   objNameDescricao = valueNameToSearch;
   objNamePopUp = valueNamePopUp;
   if(valueToSearch.length>3 && valueId.length==0){
        url="../com/ajaxServices.do?event=GetDistConcFreg&pDescricao="+valueToSearch+"&pIdPaiCodHier="+valuePaiId;
        httpRequest("GET", url, true, populateValueDistConcFreg);
   } else {
        openLovDistConcFreg(objNameId, objNameDescricao, objNamePopUp);
   }
}

function populateValueDistConcFreg(){
    splash(true);
    if (request.readyState == 4) { 
      if (request.status == 200) { 
         text = request.responseText
         if(text == '-1'){
            // alert("Erro ao obter valores.");
            splash(false);
            return true;
         } else {
            // fazer parse do resultado
            if(text.trim().length>0){
                var returnElements = text.split("|");
                if(returnElements.length==2){
                    document.getElementById(objNameId).value = returnElements[0];
                    document.getElementById(objNameDescricao).value = returnElements[1];
                    document.getElementById(objNameDescricao).focus();
                } else {
                    openLovDistConcFreg(objNameId, objNameDescricao, objNamePopUp);
                }
            } else {
                openLovDistConcFreg(objNameId, objNameDescricao, objNamePopUp);     
            }
            
         }
      }
    }
    splash(false);
}

// função para calcular idade através da data de nascimento em anos
function calculaIdadeAnos(data,dataHoje) {
    x = data.split("-");
    h = dataHoje.split("-");
    
    anosProvisorio = h[2] - x[2];
    
    if(h[1] < x[1]) {
        anosProvisorio -= 1;
    }
    else if(h[1] == x[1]) {
        if(h[0] < x[0]) {
            anosProvisorio -= 1;
        }
    }
    return anosProvisorio;
}

    Date.prototype.MonthsBetween = function(){
        var date1,date2,negPos;
        if(arguments[0] > this){
          date1 = this;
          date2 = arguments[0];
          negPos = 1;
        }
        else{
          date2 = this;
          date1 = arguments[0];
          negPos = -1;
        }
      
        if(date1.getFullYear() == date2.getFullYear()){
          return negPos * (date2.getMonth() - date1.getMonth());
        }
        else{
          var mT = 11 - date1.getMonth();
          mT += date2.getMonth() + 1;
          mT += (date2.getFullYear() - date1.getFullYear() - 1) * 12;
          return negPos * mT;      
        }
           
      }
      
function focusObjectOnEnterPressed(objNameToFocus, evento){
    var keyPressed;
    if(window.event){
        keyPressed = event.keyCode;
    }else{
        keyPressed = evento.which;
    }
    
    if(keyPressed==13){
        document.getElementById(objNameToFocus).onclick();
    }
}

function redirectToIndex(){
    window.location = "../pub/index.do"
}

function encodeUTF8(url) {
    url = url.replace(/\r\n/g,"\n");
    var utftext = "";

    for (var n = 0; n < url.length; n++) {

        var c = url.charCodeAt(n);

        if (c < 128) {
            utftext += String.fromCharCode(c);
        }
        else if((c > 127) && (c < 2048)) {
            utftext += String.fromCharCode((c >> 6) | 192);
            utftext += String.fromCharCode((c & 63) | 128);
        }
        else {
            utftext += String.fromCharCode((c >> 12) | 224);
            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
            utftext += String.fromCharCode((c & 63) | 128);
        }

    }
    return utftext;
}

// public method for url decoding
	function decodeUTF8(utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
 
		while ( i < utftext.length ) {
 
			c = utftext.charCodeAt(i);
 
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}
			else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
 
		}
 
		return string;
	}
        
        // Recebe uma data de nascimento e calcula a idade actual do utente
        function getIdade(dataNasc) {
            var tokens = dataNasc.split('-');
            var diaNasc = tokens[0];
            var mesNasc = tokens[1];
            var anoNasc = tokens[2];
            
            var data = new Date();
            var diaHoje = data.getUTCDate();
            var mesHoje = data.getMonth() + 1; // +1 porque os meses começam em 0
            var anoHoje = data.getFullYear();
            
            var idade = anoHoje - anoNasc - 1; //-1 porque ainda não fez anos
            
            //se resultado maior que 0, então já fez anos.
            if(mesHoje - mesNasc > 0){
                idade++;
            }
            
            //Se subtração de meses for igual a zero e a subtração dos dias der maior ou igual a zero, então já fez anos
            if( (mesHoje - mesNasc == 0) && (diaHoje - diaNasc >=0) ){
                idade++;
            }
            
            return idade;
        }