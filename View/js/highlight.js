    // Função para highlightRow de Row Seleccionada
    function highlightRow(element,rownum){
        var trow =element;
        var table = trow.parentNode;
        var rows = table.getElementsByTagName('tr'); 
        
        --rownum;
        for(i = 0; i < rows.length; i++){ 
          
          var efectuaHighlight = 1;
          if(rows[i].className == 'navigation'){
                efectuaHighlight = 0;
          }
          
          if(efectuaHighlight == 1){
              var row = rows[i];
              if ( i == rownum ) {
                 row.className='highlight';        
              } else {
                 if ( row.title != '' ){
                    row.className=row.title;
                 } else {
                     if ( i%2 != 0 ){
                        row.className='pesquisaresultadospar';
                     } else {
                        row.className='pesquisaresultadosimpar';
                     }
                 }
              }
         }
        }
        return;			
     }
     
     
     function highlightRowComAnulados(element,rownum,items){
          
        var tcell = element.parentNode;
        var trow = tcell.parentNode;
        var table = trow.parentNode;
        var rows = table.getElementsByTagName('tr');
        
        --rownum;
        for(i = 0; i < rows.length; i++){ 
          
          if(rows[i].className == 'navigation'){
                efectuaHighlight = 0;
          }
          
          // verifica se e um registo anulado para aplicar respectivo css
          var anulado = "activo";
          var efectuaHighlightAnulado = 0;
          if(items[i-1][3] == 'S'){
                efectuaHighlightAnulado = 1;
                anulado = "anulado";
          }
          
          // alert(i + " = " + anulado + " : " + items[i-1][3] + " <indice = " + (i-1) + ">");
        
          var row = rows[i];
          if ( i == rownum ){
            
             if(efectuaHighlightAnulado == 1){
                row.className='highlightANULADO';
             } else {
                row.className='highlight'; 
             }
             
          } else {
             if ( row.title != '' )
             {
                row.className=row.title;
             } else {
             
                 if ( i%2 != 0 ){
                    if(efectuaHighlightAnulado == 1){
                        row.className='evenANULADO';
                    } else {
                        row.className='pesquisaresultadospar';
                    }
                 } else {
                   if(efectuaHighlightAnulado == 1){
                        row.className='oddANULADO';
                    } else {
                        row.className='pesquisaresultadosimpar';
                    }
                 }
            }
          }
        
        }
        return;			
     }
     
     
     function highlightRowWithObitos(element,rownum, obitos){
        var tcell = element.parentNode;
        var trow = tcell.parentNode;
        var table = trow.parentNode;
        var rows = table.getElementsByTagName('tr'); 
        
        --rownum;
        for(i = 0; i < rows.length; i++){   
          // apenas aplica highlight para registos que nao sejam obitos
          var efectuaHighlight = 1;
          for(x = 0; x < obitos.length; x++){
            if(obitos[x] == i){
                efectuaHighlight = 0;
            }
          } 
          
          if(rows[i].className == 'navigation'){
                efectuaHighlight = 0;
          }
          
          if(efectuaHighlight == 1){
              var row = rows[i];
              if ( i == rownum ){
                 row.className='highlight';        
              } else {
                 if ( row.title != '' ){
                    row.className=row.title;
                 } else {
                     if ( i%2 != 0 ){
                        row.className='pesquisaresultadosimpar';
                     } else {
                        row.className='pesquisaresultadospar';
                     }
                 }
              }
          }
          
        }
        return;			
     }
     