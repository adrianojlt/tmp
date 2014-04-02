package ora.pt.cons.igif.sics.controller.misc;

import java.io.Serializable;

public class SessionInfo implements Serializable{
    
    /*
     * This Class holds information for usage during the session of a given User 
     * */ 
     
     /* Application Name */
     String appAplcCode;
     /* Used to hold the value of the Url Redirec used on Recitas e Baixas */ 
     String urlRedirect;
     /* We need this variable because on Context Filter we don't have acess to ListaParametros */
     String urlContext;
     
     public SessionInfo() {
         urlRedirect = null;
         urlContext = null;
         appAplcCode = null;
     }


     public void setUrlRedirect(String urlRedirect) {
         if (urlRedirect == null){
             this.urlRedirect = urlRedirect;
         } else {
             this.urlRedirect = new String (urlRedirect);   //I want a new copy of the string
         }       
     }

     /** 
      * @return if it returns null, then it's not set
      */
     public String getUrlRedirect() {
         return this.urlRedirect;
     }

     public void setUrlContext(String urlContext) {
         if (urlContext == null){
             this.urlContext = urlContext;
         } else {
             this.urlContext = new String (urlContext);   //I want a new copy of the string
         }       
     }

     public String getUrlContext() {
         return urlContext;
     }

    public void setAppAplcCode(String appAplcCode) {
        this.appAplcCode = appAplcCode;
    }

    public String getAppAplcCode() {
        return appAplcCode;
    }
}
