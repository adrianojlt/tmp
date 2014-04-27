package ora.pt.cons.igif.sics;

import oracle.jbo.Key;
import oracle.jbo.NoDefException;
import oracle.jbo.Row;
import oracle.jbo.Variable;
import oracle.jbo.VariableManager;

import org.apache.log4j.Logger;


public class ViewObjectImpl extends oracle.jbo.server.ViewObjectImpl {
    private static Logger logger =
                Logger.getLogger(ViewObjectImpl.class);
    
    private static Logger log = Logger.getLogger(ViewObjectImpl.class);
    
    private String sessionUser;
    public void setSessionUser(String sessionUser) { this.sessionUser = sessionUser; }
    public String getSessionUser() { 
        if(sessionUser==null){
            initSessionUser();
        }
        return sessionUser; 
    }
    
    public ViewObjectImpl() {
        
    }

    /**
     *  This method is overrided, because we want to avoid the make another query just to count the numbers
     *  of lines returned by the query on the ViewObject
     * @return ViewObject Row Count
     */
    public long getEstimatedRowCount() {
        return this.getRowCount();
    }
    
    public void clearWhereState() {
        Variable[] viewInstanceVars = null;
        VariableManager viewInstanceVarMgr = ensureVariableManager();
        if (viewInstanceVarMgr != null) {
            viewInstanceVars = viewInstanceVarMgr.getVariablesOfKind(Variable.VAR_KIND_WHERE_CLAUSE_PARAM);
            if (viewInstanceVars != null) {
                for (Variable v: viewInstanceVars) {
                    // only remove the variable if its not on the view def.
                    if (!hasViewDefVariableNamed(v.getName())) {
                      removeNamedWhereClauseParam(v.getName());
                    }
                }
            }
        }
        getDefaultRowSet().setExecuteParameters(null, null, true);
        setWhereClause(null);
        getDefaultRowSet().setWhereClauseParams(null);
    }

    private boolean hasViewDefVariableNamed(String name) {
        boolean ret = false;
        VariableManager viewDefVarMgr = getViewDef().ensureVariableManager();
        if (viewDefVarMgr != null) {
            try {
                ret = viewDefVarMgr.findVariable(name) != null;
            }
            catch (NoDefException ex) {
                // ignore
            }
        }
        return ret;
    }
    
    /* 
     * re-implementação do método createRow por forma a colocar por defeito nos atributos CreatedBy e LastUpdatedBy o user de sessão 
     * @autor: Rui Moura
     */
    public Row createRow() {
        Row row = super.createRow();
        log.debug("createRow user: " + this.getSessionUser());
        try{
            if(this.getSessionUser()!=null){
                row.setAttribute("CreatedBy", this.getSessionUser());
                row.setAttribute("LastUpdatedBy", this.getSessionUser());
            }
        } catch(Exception e){
          // não propaga erro por forma a não invalidar operação
          log.error("",e);
        }
        return row;
    }
    
    /* 
     * re-implementação do método findByKey para colocar por defeito nos atributos LastUpdatedBy o user de sessão,
     * desta forma aquando o commit do update e se o atributo não for explicitamente alterado será guardado o user de quem fez a alteração
     * @autor: Rui Moura
     */
    public Row[] findByKey(Key key, int ix) {
        Row[] rows = null;
        try{
            log.debug("findByKey user: " + this.getSessionUser());
            rows = super.findByKey(key, ix);
            for ( int i = 0 ; i < rows.length ; i++)  {
                try{
                    if(this.getSessionUser()!=null){
                        rows[i].setAttribute("LastUpdatedBy", this.getSessionUser());
                    }
                } catch(Exception e){
                  // não propaga erro por forma a não invalidar operação
                  log.error("",e);
                }
            }
        } catch(Exception e){
          e.printStackTrace();
        }
        return rows;
    }
    
    private void initSessionUser(){
        RootAppModuleImpl am = (RootAppModuleImpl)this.getRootApplicationModule();
        if(am!=null){
            InformacaoUtilizadorImpl userImpl = am.getInformacaoUtilizador();
            if(userImpl!=null){
                if(userImpl.getEstimatedRowCount()>0){
                    InformacaoUtilizadorRowImpl rowImpl = (InformacaoUtilizadorRowImpl)userImpl.first();
                    if(rowImpl!=null){
                        setSessionUser(rowImpl.getUsername());
                    }
                }
            }   
        }
    }

 /*
    public void executeQuery() {
        
        long start = System.currentTimeMillis();
        super.executeQuery();
        try {
            long elapsed = System.currentTimeMillis() - start;
            //logger.debug(this.getQuery());
            
            * Query propreties
             * 
             * xml_format
             * <query>
             *    <query_text>
             *    </query_text>
             *    <bind_variables_list>
             *      <bind_variable>
             *          <name>
             *          </value>
             *      <bind_variable/>
             *      <bind_variable>
             *          <name>
             *          </value>
             *      <bind_variable/>
             *    </bind_variables_list>
             *    <elapsed_time>
             *    </elapsed_time>
             *    <origin_view_object>
             *    </origin_view_object>
             * </query>
             * 
             * *
            
            StringBuffer queryDataString = new StringBuffer();
            
            String substQueryTextString = "<SUBST_query_data>";
            String substBindVariablesString = "<SUBST_bind_variables>";
            String substElapsedTimeString = "<SUBST_elapsed_time>";
            String substOriginViewString = "<SUBST_origin_view_object>";
            
            //Form initial String
            queryDataString.append(
            "<query>\n" +
            "   <query_text>\n" +
            "       " + substQueryTextString + "\n" +
            "   </query_text>\n" +
            "   <bind_variables_list>\n" +
            "       " + substBindVariablesString + "\n" +
            "   </bind_variables_list>\n" +
            "   <elapsed_time>\n" +
            "       " + substElapsedTimeString + "\n" +
            "   </elapsed_time>\n" +
            "   <origin_view_object>\n" +
            "       " + substOriginViewString + "\n" +
            "   </origin_view_object>\n" +
            "</query>\n");
            
            //Get Query Text
            String queryText = new String(this.getQuery());
            
            int indexOfStartSubst = queryDataString.indexOf(substQueryTextString);
            int indexOfEndSubst = indexOfStartSubst + substQueryTextString.length();
            queryDataString.replace(indexOfStartSubst,indexOfEndSubst,queryText);
            
            //Get Bind Variables
            Object temp[] = this.getWhereClauseParams();
            for (int i=0; i < temp.length; i++ ){
                Object tempIn[] = (Object[])temp[i];
                String tempString = "           <bind_variable>";//+substBindVariablesString;//+"</bind_variable>"+substBindVariablesString;
                for (int j=0; j < tempIn.length; j ++) {
                    if (j==0){ //name
                        tempString = tempString + "<name>"+tempIn[j]+"</name>"; 
                    } else {
                        tempString = tempString + "<value>"+tempIn[j]+"</value>"; 
                    }
                }
                tempString = tempString + "</bind_variable>\n"+substBindVariablesString;
                indexOfStartSubst = queryDataString.indexOf(substBindVariablesString);
                indexOfEndSubst = indexOfStartSubst + substBindVariablesString.length();
                queryDataString.replace(indexOfStartSubst,indexOfEndSubst,tempString);
                //logger.debug(tempString);
            }
            indexOfStartSubst = queryDataString.indexOf(substBindVariablesString);
            indexOfEndSubst = indexOfStartSubst + substBindVariablesString.length();
            queryDataString.delete(indexOfStartSubst,indexOfEndSubst);
           
            //Elapsed Time
            indexOfStartSubst = queryDataString.indexOf(substElapsedTimeString);
            indexOfEndSubst = indexOfStartSubst + substElapsedTimeString.length();
            queryDataString.replace(indexOfStartSubst,indexOfEndSubst,new Long(elapsed).toString());
            
            //ViewObjectTime
            indexOfStartSubst = queryDataString.indexOf(substOriginViewString);
            indexOfEndSubst = indexOfStartSubst + substOriginViewString.length();
            queryDataString.replace(indexOfStartSubst,indexOfEndSubst,this.getDefFullName());
            
            //Get Query Log SCG Id
            Statement queryStatment = this.getDBTransaction().createStatement(1);
            ResultSet resultSet = queryStatment.executeQuery("\n" + 
                                "SELECT scg.ID      \n" + 
                                "FROM SYS_COD_GENERICOS scg, SYS_TIPOS_CODIGOS stc\n" + 
                                "WHERE scg.CODIGO = '0003000100010001'\n" + 
                                "  and stc.id = scg.sys_tipos_codigos_id\n" + 
                                "  and stc.COD_TIPO = 'LOG_CODES_MENSAGEM' ");                                
            resultSet.next();
            
            
            //Insert into SYS_LOGS
            CallableStatement insertLogStatement =  this.getDBTransaction().createCallableStatement("{? = call LOGGING.INSERT_LOG_CLOB_LINE(?,?)}",1);
            try {
                insertLogStatement.setString(2,resultSet.getString(1));
                insertLogStatement.setString(3,queryDataString.toString());
                insertLogStatement.registerOutParameter(1,Types.NUMERIC);
                insertLogStatement.execute();
            
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception error) {
            error.printStackTrace();
        }
    }
    */
    
   
}
