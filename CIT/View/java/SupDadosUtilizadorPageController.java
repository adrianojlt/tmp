package ora.pt.cons.igif.sics.controller.sup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ora.pt.cons.igif.sics.ViewObjectImpl;
import ora.pt.cons.igif.sics.controller.misc.Misc;
import ora.pt.cons.igif.sics.ldap.LdapAccessControl;
import ora.pt.cons.igif.sics.suporte.ModulosSuporteModuleImpl;

import oracle.adf.controller.v2.context.LifecycleContext;
import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.controller.v2.lifecycle.PageController;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.ViewObject;

import org.apache.log4j.Logger;


public class SupDadosUtilizadorPageController extends PageController {
    
    private static Logger log = Logger.getLogger(SupDadosUtilizadorPageController.class);
    private HttpServletRequest request = null;
    private HttpSession session = null;
    
    public void prepareModel(LifecycleContext context) {
        try{
            DCIteratorBinding dci = (DCIteratorBinding)context.getBindingContainer().get("UtilizadorViewIterator");
            request = (HttpServletRequest)context.getEnvironment().getRequest();
            session = request.getSession(false);
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            vo.clearWhereState();
        vo.clearCache();
        vo.setMaxFetchSize(-1);
            vo.setWhereClause(" nome like '" + request.getRemoteUser() + "' ");
        vo.executeQuery();
        } catch (Exception e) {
            log.error("", e);
            Misc.addMessage(context, "", "erro no prepare model", e.getMessage(), Misc.MSG_TYPE_ERROR);
        }
        super.prepareModel(context);
    }
    
    public void onChangePassword(PageLifecycleContext ctx) throws Exception {
        try {
            String actualPasswordReq = request.getParameter("actualPassword");
            String newPasswordReq = request.getParameter("newPassword");
            String confirmPasswordReq = request.getParameter("confirmPassword");
            if(actualPasswordReq.length()==0 || newPasswordReq.length()==0 || confirmPasswordReq.length()==0){
                if(actualPasswordReq.length()==0){
                    Misc.addMessage(ctx, "", "O campo 'Password Actual' é de preenchimento obrigatório.", "", Misc.MSG_TYPE_WARNG);    
                }
                if(newPasswordReq.length()==0){
                    Misc.addMessage(ctx, "", "O campo 'Nova Password' é de preenchimento obrigatório.", "", Misc.MSG_TYPE_WARNG);       
                }
                if (confirmPasswordReq.length()==0) {
                    Misc.addMessage(ctx, "", "O campo 'Confirmar' é de preenchimento obrigatório.", "", Misc.MSG_TYPE_WARNG);  
             }
            } else {
                
                if(actualPasswordReq == null || "".equals(actualPasswordReq) || !verifyUserPassword(ctx,request.getRemoteUser(),actualPasswordReq)  ){
                    Misc.addMessage(ctx, "", "password actual não está correcta", "", Misc.MSG_TYPE_WARNG);
            }
                if ( (newPasswordReq == null || confirmPasswordReq== null) || !newPasswordReq.equals(confirmPasswordReq)){
                    Misc.addMessage(ctx, "", "password de confirmação diferente da password nova", "", Misc.MSG_TYPE_WARNG);
            }
                
                if (!Misc.hasMessages(ctx)) {
                    DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("UtilizadorViewIterator");
                    ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
                    ModulosSuporteModuleImpl am = (ModulosSuporteModuleImpl)vo.getApplicationModule();
                    // -- actualiza ldap
                    resetPassword((PageLifecycleContext)ctx, request.getRemoteUser(), newPasswordReq);
                    // -- actualiza user na bd 
                    String idUser = request.getParameter("idUser")!=null?request.getParameter("idUser"):"";
                    am.alteraUserPassword(idUser,newPasswordReq);      
                    request.setAttribute("sucessChangePass", "true");
                }
            }
            request.setAttribute("showDiv", Boolean.TRUE);
        } catch (Exception e) {
          log.error("",e);
          Misc.addMessage(ctx, "", "erro ao alterar password utilizador", "", Misc.MSG_TYPE_ERROR);
        }
        }
        
    private boolean verifyUserPassword(PageLifecycleContext ctx, String login,String password) throws Exception {
        LdapAccessControl ldap = null;
        try {
            DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("UtilizadorViewIterator");
            ViewObject vo = dci.getViewObject();
            ModulosSuporteModuleImpl simpl = (ModulosSuporteModuleImpl)vo.getApplicationModule();
            ldap = simpl.ldapAccessControl();
            return ldap.verifyPassword(login,password);
        } catch (Exception e){
          log.error("",e);
          throw e;
        } finally {
          if (ldap != null)
            ldap.closeJndi();
        }
    }
 
    private void resetPassword(PageLifecycleContext ctx,
                          String login, 
                          String password) throws Exception {
        LdapAccessControl ldap = null;
        try {
            DCIteratorBinding dci = (DCIteratorBinding)ctx.getBindingContainer().get("UtilizadorViewIterator");
            ViewObjectImpl vo = (ViewObjectImpl)dci.getViewObject();
            ModulosSuporteModuleImpl am = (ModulosSuporteModuleImpl)vo.getApplicationModule();
            ldap = am.ldapAccessControl();
            ldap.changeUserPassword(login, password);
        } catch (Exception e){
          throw e;
        } finally {
          if (ldap != null)
            ldap.closeJndi();
        }
    }
    
}
