    function navigateTab(element,numTabs) {

        if( document.getElementById('mTab'+element).className == 'tabDisabled'){
        
            document.getElementById('mTab'+element).className='tabEnabled';
            document.getElementById('cTab'+element).style.display = displayProperty;
            
            for ( i=1 ; i <= numTabs ; i++ ){
                if ( i != element ){
                    if ( document.getElementById('mTab'+i) && document.getElementById('cTab'+i) ) {
                        document.getElementById('mTab'+i).className='tabDisabled';
                        document.getElementById('cTab'+i).style.display = 'none';
                    }
                }
            }
        }
        return;
    }