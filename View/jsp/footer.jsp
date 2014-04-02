</div>

<div style="padding-bottom:35px;"></div>
        
        <script language="Javascript" type="text/javascript">
        
            function getElementYPos(obj) {
                var curleft = curtop = 0;
                if (obj.offsetParent) {
                    do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
                    } while (obj = obj.offsetParent);
                }
                return curtop;
            }        
            
            //var x = getElementYPos('contentDiv');
            //alert("Span is at: " + x + "px top");
            //document.getElementById("topSep").style = 'padding-top: ' + x + 'px;';
            //alert(document.getElementById("topSep").style);
        </script>
<!-- Isto obriga o browser a não guardar a página! Isto é devido a bug no Internet Explorer 
http://support.microsoft.com/kb/222064/ (detectado também no Internet Explorer 7)-->        
<HEAD>
  <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
</HEAD>   