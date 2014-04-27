<%-- Cabecalho --%>
<div id="breadtd1">
    <img src="../imagens_cit_v3/logo_cit.png" alt="CIT_logo" height="35" width="132">
</div>
<div id="breadtd2">
    <p style="margin-top: 8px; margin-right: 210px; margin-bottom: 0px;">${param.pDescricaoCentroSaude}</p>
    <p style="margin-top: 0px; margin-right: 210px; margin-bottom: 8px;">${sessionScope.username}</p>
</div>
<div id="breadtd3">                    
    <img src="../imagens_cit_v3/logout.png" alt="logout" class="selected" onclick ="javascript:window.location.href='../com/logout.jsp';"/>
</div>
<div id="breadtd4"> 
    <img src="../imagens_cit_v3/config.png" alt="config" onclick="submenu()" class="selected"/>                        
</div>

<%-- SubMenu --%>
<div id="submenu">
    <div id="submenu1">
        <a href="#" onclick="javascript:popUpDadosUtilizador();" class="submenuclass">ALTERAR SENHA</a>
    </div>
    <div id="submenu1">
        <a href="https://estudo.min-saude.pt/eaprender/courses/CITINFORMACAOUTIL/document/CIT_FAQs.pdf" onclick="" class="submenuclass" target="_blank">PERGUNTAS FREQUENTES</a>
    </div>
</div>

