<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%--
 | Setup page variables uses for displaying the navigation
 | "control" at the top that looks like:
 | Previous N - M of Z Next
 +--%>
 


<c:set var="rangeBinding" value="${bindings[param.rangeBindingName]}"/>
<c:set var="totalRows" value="${rangeBinding.estimatedRowCount}"/>
<span class="paginationResults">${totalRows} resultado(s)</span>

<%-- Need for passe values for java --%>
<input type="hidden" name="event" id="hidden${rangeBinding}" value=""/>
<input type="hidden" name="nextRange${rangeBinding}" id="nextRange${rangeBinding}" value=""/>

  
<c:set var="firstRowShown" value="${rangeBinding.rangeStart + 1}"/>

<c:choose>
    <c:when test="${not empty param.extraParams}">
        <c:set var="queryStrBase" value='?${param.extraParams}&'/>
    </c:when>
    <c:otherwise>
        <c:set var="queryStrBase" value="?"/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${rangeBinding.rangeSize == -1}">
        <c:set var="rowsPerPage" value="${totalRows}"/>
    </c:when>
    <c:otherwise>
        <c:set var="rowsPerPage" value="${rangeBinding.rangeSize}"/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${firstRowShown + rowsPerPage - 1 > totalRows}">
        <c:set var="lastRowShown" value="${totalRows}"/>
    </c:when>
    <c:otherwise>
        <c:set var="lastRowShown" value="${firstRowShown + rowsPerPage - 1}"/>
    </c:otherwise>
</c:choose>

<%-- Definimos o input do event --%>
<c:set var="event" value="RangeChange${rangeBinding}"/>

<%-- 1ªpágina --%>
<c:choose>
    <c:when test="${firstRowShown > 1}">
        <input 
               class="prevFirstLink defaultSize" name="event_RangeChange${rangeBinding}" type="button" 
               onclick="document.getElementById('nextRange${rangeBinding}').value=0;
                        document.getElementById('hidden${rangeBinding}').value='${event}';
                        <c:choose>
                            <c:when test='${param.requestType == \'ajaxServices\' }'>
                                retrieveNavigationList('${param.targetPageName}', '${param.rangeBindingName}', document.getElementById('nextRange${rangeBinding}').value,'${param.event}',${param.metodToCall}, '${param.otherParams}');      
                            </c:when>
                            <c:otherwise>

                                this.form.submit();  
                            </c:otherwise>
                        </c:choose>
                        ">
    </c:when>
    <c:otherwise>
        <%-- Não existem anteriores --%>
         <input class="prevFirstLinkDis defaultSize" name="prevLink" type="button" />
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${firstRowShown > 1}">
        <input 
               class="prevLink" name="event_RangeChange${rangeBinding}" type="button" 
               onclick="document.getElementById('nextRange${rangeBinding}').value=parseInt(document.getElementById('select${rangeBinding}').value,0)-1;
                        document.getElementById('hidden${rangeBinding}').value='${event}';
                        <c:choose>
                            <c:when test='${param.requestType == \'ajaxServices\' }'>
                                retrieveNavigationList('${param.targetPageName}', '${param.rangeBindingName}', document.getElementById('nextRange${rangeBinding}').value,'${param.event}',${param.metodToCall}, '${param.otherParams}');      
                            </c:when>
                            <c:otherwise>

                                this.form.submit();  
                            </c:otherwise>
                        </c:choose>
                        ">
    </c:when>
    <c:otherwise>
        <%-- Não existem anteriores --%>
         <input class="prevLinkDis" name="prevLink" type="button" />
    </c:otherwise>
</c:choose>

<%-- Definimos a css da dropdownlist --%>
<c:choose>
    <c:when test="${totalRows >= 100}">
        <c:set var="css" value="inputChoiceNavigationTwo"/>
    </c:when>
    <c:otherwise>
        <c:set var="css" value="inputChoiceNavigationOne"/>
    </c:otherwise>
</c:choose>



<%-- Fazer um Math.ceil(Double a ) --%>
<c:set var="resultInDouble" value="${(totalRows-1)/rangeBinding.rangeSize +1}"/> 
<c:set var="resultInDoubleZero" value="${resultInDouble - resultInDouble % 1}"/>

<fmt:setLocale value="pt_PT"/>
<fmt:formatNumber type="number" value="${resultInDoubleZero}" var="resultInt" pattern="0"/>

<span>Página</span>

<select id="select${rangeBinding}" name="select${rangeBinding}" 
        class="${css}"
        onkeypress="javascript:keyCheck(null,null);" 
        onChange="document.getElementById('nextRange${rangeBinding}').value=this.value;
                  document.getElementById('hidden${rangeBinding}').value='${event}';
                  <c:choose>
                    <c:when test='${param.requestType == \'ajaxServices\' }'>
                        retrieveNavigationList('${param.targetPageName}', '${param.rangeBindingName}', document.getElementById('nextRange${rangeBinding}').value,'${param.event}',${param.metodToCall}, '${param.otherParams}');    
                    </c:when>
                    <c:otherwise>
                       
                        this.form.submit();  
                    </c:otherwise>
                  </c:choose>
                  ">
 
  
          <c:choose>
    <c:when test="${resultInt > 0}">
       <c:forEach var="SelectBoxItems" begin="1" end="${resultInt}">
            <%-- Descobrir o primeiro numero da select box --%>
            <c:set var="start" value="${((SelectBoxItems - 1) * rangeBinding.rangeSize) + 1}"/>
           
            <%-- Descobrir o ultimo numero da select box --%>  
            <c:choose>
                <c:when test="${(SelectBoxItems * rangeBinding.rangeSize) > totalRows}" >
                    <c:set var="end" value="${totalRows}"/>
                </c:when>
                <c:otherwise>  
                    <c:set var="end" value="${SelectBoxItems * rangeBinding.rangeSize}"/>
                </c:otherwise>
            </c:choose>  
            <%-- Que celula da select box estar selecionada --%>
            <c:choose>
            <c:when test="${((rangeBinding.rangeStart == ((SelectBoxItems-1) * rangeBinding.rangeSize)) || (rangeBinding.rangeStart != 0 && rangeBinding.rangeStart < 10))}">
                     <option value="${SelectBoxItems - 1}" selected>
                        <c:out value="${SelectBoxItems}"/> 
                     </option>
                </c:when>
                <c:otherwise>
                     <option value="${SelectBoxItems - 1}">
                        <c:out value="${SelectBoxItems}"/>
                     </option>
                </c:otherwise>
            </c:choose> 
        </c:forEach> 
    </c:when>
    <c:otherwise>
       <option> 1  </option>
    </c:otherwise>
    </c:choose>                           

</select>        
            <span>de <c:out value="${resultInt}"/></span>
 
<c:choose>
    <c:when test="${lastRowShown < totalRows}">
        <input type="button" 
               class="nextLink" name="event_RangeChange${rangeBinding}" 
               onClick="document.getElementById('nextRange${rangeBinding}').value=parseInt(document.getElementById('select${rangeBinding}').value,0)+1;
                        document.getElementById('hidden${rangeBinding}').value='${event}';
                        <c:choose>
                        <c:when test='${param.requestType == \'ajaxServices\' }'>
                            retrieveNavigationList('${param.targetPageName}', '${param.rangeBindingName}', document.getElementById('nextRange${rangeBinding}').value,'${param.event}',${param.metodToCall}, '${param.otherParams}');    
                        </c:when>
                        <c:otherwise>
                            
                            this.form.submit();    
                        </c:otherwise>
                        </c:choose>
                        ">
    </c:when>
    <c:otherwise>
        <%-- sem seguintes--%>
                 <input class="nextLinkDis" name="nextLink" type="button" />
    </c:otherwise>
</c:choose>      


<%--link para última página--%>
<c:choose>
    <c:when test="${lastRowShown < totalRows}">
        <input type="button" 
               class="nextLastLink" name="event_RangeChange${rangeBinding}" 
               onClick="document.getElementById('nextRange${rangeBinding}').value=${totalRows+1};
                        document.getElementById('hidden${rangeBinding}').value='${event}';
                        <c:choose>
                        <c:when test='${param.requestType == \'ajaxServices\' }'>
                            retrieveNavigationList('${param.targetPageName}', '${param.rangeBindingName}', document.getElementById('nextRange${rangeBinding}').value,'${param.event}',${param.metodToCall}, '${param.otherParams}');    
                        </c:when>
                        <c:otherwise>
                            
                            this.form.submit();    
                        </c:otherwise>
                        </c:choose>
                        ">
    </c:when>
    <c:otherwise>
        <%-- sem seguintes--%>
         <input class="nextLastLinkDis" name="nextLink" type="button" />
    </c:otherwise>
    </c:choose>