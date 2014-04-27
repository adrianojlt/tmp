package ora.pt.cons.igif.sics.ldap;

import com.sun.jndi.ldap.LdapCtx;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NameAlreadyBoundException;
import javax.naming.NameNotFoundException;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.AttributeInUseException;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.directory.NoSuchAttributeException;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import org.apache.log4j.Logger;


public class LdapAccessControl {
    
    private static Logger log = Logger.getLogger(LdapAccessControl.class);
    
    private final String LDAP_USERS = "cn=Users";
    private final String LDAP_GROUPS = "cn=Groups";
    private final String LDAP_DEFAULT_GROUP = "RNP";
    private final String LDAP_INITIAL_CONTEXT_FACTORY = 
        "com.sun.jndi.ldap.LdapCtxFactory";
    private final String LDAP_SECURITY_AUTHENTICATION = "simple";

    String ldapSecurityPrincipal = "";
    String ldapSecurityCredentials = "";
    String ldapBaseDn = "";
    String ldapProviderUrl = "";

    private String OC4JADMIN = "oc4jadmin";
    private String ORCLADMIN = "orcladmin";
    private String PUBLIC = "PUBLIC";

    private List exceptionsList = new ArrayList();
    
    public static void main(String[] args) { }
    
    public LdapAccessControl(String ldapProviderUrl, 
                             String ldapSecurityPrincipal, String ldapBaseDn, 
                             String ldapSecurityCredentials) throws Exception {
        this.ldapProviderUrl = ldapProviderUrl;
        this.ldapSecurityPrincipal = ldapSecurityPrincipal;
        this.ldapBaseDn = ldapBaseDn;
        this.ldapSecurityCredentials = ldapSecurityCredentials;

        log.debug("ldapProviderUrl: " + this.ldapProviderUrl + "; " + 
                           "ldapSecurityPrincipal: " + 
                           this.ldapSecurityPrincipal + "; " + "ldapBaseDn: " + 
                           this.ldapBaseDn + "; " + 
                           "ldapSecurityCredentials: " + 
                           this.ldapSecurityCredentials + "; ");
        initJndi();
    }

    private void initJndi() throws Exception {
        try {
            Hashtable env = new Hashtable();

            env.put(Context.INITIAL_CONTEXT_FACTORY, 
                    LDAP_INITIAL_CONTEXT_FACTORY);
            env.put(Context.SECURITY_AUTHENTICATION, 
                    LDAP_SECURITY_AUTHENTICATION);
            env.put(Context.PROVIDER_URL, ldapProviderUrl);
            env.put(Context.SECURITY_PRINCIPAL, 
                    "cn=" + ldapSecurityPrincipal + "," + LDAP_USERS + "," + 
                    ldapBaseDn);
            env.put(Context.SECURITY_CREDENTIALS, ldapSecurityCredentials);

            dirctx = new InitialDirContext(env);

            exceptionsList.add(OC4JADMIN);
            exceptionsList.add(ORCLADMIN);
            exceptionsList.add(PUBLIC);
        } catch (Exception e) {
          log.error("Erro ao inicializar contexto de ligação Ldap.", e);
          throw new Exception("Erro na inicialização contexto de ligação Ldap. ");
        }
    }

    public void closeJndi() throws NamingException {
        if (dirctx != null)
            dirctx.close();
    }
    
    
    public void changeUserPassword(String username, String password) throws NamingException, 
                                                                     Exception {
       try{
            ModificationItem[] mods = new ModificationItem[2];
            
            mods[0] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("userpassword", password));
            mods[1] = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("orclPasswordHint", password));
                
            log.debug("Trying to change Password for: " + username);
                                                                
            // Perform the update
            dirctx.modifyAttributes("cn=" + username + "," + LDAP_USERS + "," + 
                                     ldapBaseDn, mods);
                                
            log.debug("Password changed for user : " + username);  
            dirctx.close();
             
        } catch(Exception e){
          log.error("Erro ao alterar password", e);
          throw e;
        }
        
    }

    public void createUserAndAddToDefaultGroup(String username, String password) throws NamingException, 
                                                                       Exception {
        try{
            createUser(username, password);
            // setPasswordToUser(username,password);
            // addUserToGroup(username, LDAP_DEFAULT_GROUP);
        } catch(Exception e){
          log.error("", e);
          throw e;
        }
    }

    public void deleteUserAndRemoveFromDefaultGroup(String username) throws NamingException, Exception {
        try{
            removeUserFromGroup(username, LDAP_DEFAULT_GROUP);
            deleteUser(username);
        } catch(Exception e){
          log.error("", e);
          throw e;
        }
    }

  
    private void createUser(String username, 
                            String password) throws NamingException, 
                                                    Exception {
        try{
            log.debug("username:<" + username + ">");
            log.debug("password:<" + password + ">");
            log.debug("LDAP_USERS:<" + LDAP_USERS + ">");
            log.debug("ldapBaseDn:<" + ldapBaseDn + ">");
            BasicAttributes basicattributes = new BasicAttributes();
            BasicAttribute basicattribute = new BasicAttribute("objectclass");
            basicattribute.add("top");
            basicattribute.add("person");
            basicattribute.add("organizationalPerson");
            basicattribute.add("inetOrgPerson");
            basicattributes.put(basicattribute);            
            // basicattributes.put(new BasicAttribute("givenname", username));
            basicattributes.put(new BasicAttribute("sn", username));
            basicattributes.put(new BasicAttribute("cn",username));
            basicattributes.put(new BasicAttribute("uid", username));
            basicattributes.put(new BasicAttribute("userpassword", password));
            dirctx.createSubcontext("cn=" + username + "," + LDAP_USERS + "," + ldapBaseDn, basicattributes);
            addUserToGroup(username, LDAP_DEFAULT_GROUP);
        } catch(Exception e){
           log.error("Erro ao criar username", e);
          // caso obtenha erro por seguranca elimino o user pois pode ter dado erro apenas na associacao ao grupo.
          deleteUserAndRemoveFromDefaultGroup(username);
          throw e;
        }
    }
   
    
    private void deleteUser(String username) throws NamingException, Exception {
        try{
            dirctx.destroySubcontext("cn=" + username + "," + LDAP_USERS + "," + ldapBaseDn);
        } catch(Exception e){
          log.error("", e);
          throw e;
        }
    }

    private void addUserToGroup(String username, 
                                String groupname) throws NamingException, 
                                                         Exception {
        try {
            ModificationItem[] mods = new ModificationItem[1];
            mods[0] = 
                    new ModificationItem(DirContext.ADD_ATTRIBUTE, new BasicAttribute("uniquemember", 
                                                                                      "cn=" + 
                                                                                      username + 
                                                                                      "," + 
                                                                                      LDAP_USERS + 
                                                                                      "," + 
                                                                                      ldapBaseDn));
            dirctx.modifyAttributes("cn=" + groupname + "," + LDAP_GROUPS + 
                                    "," + ldapBaseDn, mods);
        } catch (Exception e) {
            log.error("Erro ao adicionar user ao grupo", e);
            throw new Exception("A associação do utilizador " + username + 
                                " ao grupo " + groupname + 
                                " não foi bem sucedida.");
        }
    }

    private void removeUserFromGroup(String username, 
                                     String groupname) throws NamingException, Exception {
        try{
            ModificationItem[] mods = new ModificationItem[1];
            mods[0] = 
                    new ModificationItem(DirContext.REMOVE_ATTRIBUTE, new BasicAttribute("uniquemember", 
                                                                                         "cn=" + 
                                                                                         username + 
                                                                                         "," + 
                                                                                         LDAP_USERS + 
                                                                                         "," + 
                                                                                         ldapBaseDn));
            dirctx.modifyAttributes("cn=" + groupname + "," + LDAP_GROUPS + "," + 
                                    ldapBaseDn, mods);
        } catch(Exception e){
          log.error("Erro ao remover user do grupo", e);
          throw e;
        }
    }

    public boolean verifyPassword(String login,String password){
            boolean isOk = false;
            // Set up environment for creating initial context
            Hashtable env = new Hashtable();
            
            
            
            // Authenticate as S. User and give incorrect password
    
            env.put(Context.INITIAL_CONTEXT_FACTORY, 
                    LDAP_INITIAL_CONTEXT_FACTORY);
            env.put(Context.SECURITY_AUTHENTICATION, 
                    LDAP_SECURITY_AUTHENTICATION);
            env.put(Context.PROVIDER_URL, ldapProviderUrl);
            env.put(Context.SECURITY_PRINCIPAL, 
                    "cn=" + login + "," + LDAP_USERS + "," + 
                    ldapBaseDn);
            env.put(Context.SECURITY_CREDENTIALS, password);

            try {
                // Create initial context
                DirContext ctx = new InitialDirContext(env);

                //System.out.println(ctx.lookup("ou=NewHires"));

                // do something useful with ctx

                // Close the context when we're done
                ctx.close();
                isOk = true;
            } catch (NamingException e) {
                e.printStackTrace();
                
            }
        return isOk;
    }

    public List getLdapUsernames() {
        NamingEnumeration ne = null;
                List list = new ArrayList();
                try {
                    ne = dirctx.search(LDAP_USERS + "," + ldapBaseDn, null);
                    while (ne.hasMoreElements()) {
                        SearchResult sr = (SearchResult)ne.nextElement();
                        String name = sr.getName().substring(3);
                        if (!exceptionsList.contains(name)) {
                            list.add(name);
                        }
                    }
                } catch (NamingException namingEx) {
                    log.error(namingEx.getMessage());
                } finally {
                    return list;
                }
        
    }

    public Hashtable getLdapData(String login) {
        NamingEnumeration ne = null;
        Hashtable resultAttrs = new Hashtable();
        List list = new ArrayList();
        LdapCtx userInfo = null;
        try {
        
             // Create the default search controls
             SearchControls ctls = new SearchControls();
    
             // Specify the search filter to match
             // Ask for objects that have the attribute "sn" == "Geisel"
             // and the "mail" attribute
            String filter = "(&(cn="+login+"))";

            // Search for objects using the filter
            ne = dirctx.search(LDAP_USERS + "," + ldapBaseDn, filter, ctls);
            
            while (ne.hasMoreElements()) {
                 SearchResult sr = (SearchResult)ne.nextElement();
                 
                 Attributes attrs = sr.getAttributes();
                 
                 // There should only be one attribute in each matching entry.
                 /*
                 resultAttrs.put("funcao",attrs.get("funcao")!=null?attrs.get("funcao").toString():"");
                 
                 resultAttrs.put("userpassword",attrs.get("userpassword")!=null?attrs.get("userpassword").toString():"");
                 resultAttrs.put("name",attrs.get("name")!=null?attrs.get("name").toString():"");
                 */
                  //ALL
                  NamingEnumeration returnedAttributes = attrs.getAll();
                 
                   while (returnedAttributes.hasMore()) {
                      Attribute returnedAttribute = (Attribute) returnedAttributes.next();
                      NamingEnumeration attributeValues = returnedAttribute.getAll();
                      while (attributeValues.hasMore()) {
                          Object value = attributeValues.next();
                          System.out.println("value : " + value);
                          //list.add(value.toString());
                      }
                      
                }
              
                

         }
        } catch (Exception e) {
          log.error(e);
        } finally {
            return resultAttrs;
        }
    }
    
    /* ---------------------------------- novos métodos --------------------------------- */
    
    public static final String USERS_CN = "cn=Users,dc=dc,dc=local";
    public static final String GROUPS_CN = "cn=RNU,cn=Groups,dc=dc,dc=local";
    public static final String PERFIS_CN = "cn=Perfis,cn=RNU,cn=Groups,dc=dc,dc=local";
    public static final String ACESSOS_CN = "cn=Acessos,cn=RNU,cn=Groups,dc=dc,dc=local";
    
    private DirContext dirctx;
        
    /* 
     * metodo para criar um user
     * */
    public void addUser(String username, 
                        String firstName,
                        String lastName, 
                        String password) throws NamingException {
        
         Attributes container = new BasicAttributes();

         // Create the objectclass to add
         Attribute objClasses = new BasicAttribute("objectClass");
         objClasses.add("top");
         objClasses.add("person");
         objClasses.add("organizationalPerson");
         objClasses.add("inetOrgPerson");
         objClasses.add("orcluser");

         // Assign the username, first name, and last name
         String cnValue = new StringBuffer(firstName)
             .append(" ")
             .append(lastName)
             .toString();
         Attribute cn = new BasicAttribute("cn", cnValue);
         Attribute givenName = new BasicAttribute("givenName", firstName);
         Attribute sn = new BasicAttribute("sn", lastName);
         Attribute uid = new BasicAttribute("uid", username);

         Attribute userPassword = new BasicAttribute("userpassword", password);
         container.put(objClasses);
         container.put(cn);
         container.put(sn);
         container.put(givenName);
         container.put(uid);
         container.put(userPassword);

         // Create the entry
         dirctx.createSubcontext(getUserDN(username), container);
    }
    
    /* 
     * metodo para eliminar um user
     * */
     /*
    public void deleteUser(String username) throws NamingException {
        try {
            dirctx.destroySubcontext(getUserDN(username));
        } catch (NameNotFoundException e) {
            // If the user is not found, ignore the error
        }
    }
    */
    
    /* 
     * metodo para formatar cn de user    
     * */
    private String getUserDN(String username) {
        return new StringBuffer()
                .append("cn=")
                .append(username)
                .append(",")
                .append(USERS_CN)
                .toString();
    }
    
    private String getUserUID(String userDN) {
        int start = userDN.indexOf("=");
        int end = userDN.indexOf(",");

        if (end == -1) {
            end = userDN.length();
        }

        return userDN.substring(start+1, end);
    }
    
    public void assignUser(String username, String groupName, String cnGroupParent)
        throws NamingException {
        try {
            ModificationItem[] mods = new ModificationItem[1];
            Attribute mod = new BasicAttribute("uniqueMember", getUserDN(username));
            mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod);
            dirctx.modifyAttributes(getGroupDN(groupName, cnGroupParent), mods);
        } catch (AttributeInUseException e) {
            // If user is already added, ignore exception
        }
    }
    
     public void assignGroup(String groupNameA, String cnGroupParentA, String groupNameB, String cnGroupParentB)
         throws NamingException {
         try {
             ModificationItem[] mods = new ModificationItem[1];
             Attribute mod = new BasicAttribute("uniqueMember", getGroupDN(groupNameA,cnGroupParentA));
             mods[0] = new ModificationItem(DirContext.ADD_ATTRIBUTE, mod);
             dirctx.modifyAttributes(getGroupDN(groupNameB, cnGroupParentB), mods);
         } catch (AttributeInUseException e) {
             // If user is already added, ignore exception
         }
    }
    
    public void assignUserToPerfil(String username, String perfilName)
        throws NamingException {
        try {
            assignUser(username,perfilName,PERFIS_CN);
        } catch (AttributeInUseException e) {
            // If user is already added, ignore exception
        }
    }
    

    public void unAssignUser(String username, String groupName, String cnGroupParent)
        throws NamingException {
        try {
            ModificationItem[] mods = new ModificationItem[1];
            Attribute mod = new BasicAttribute("uniqueMember", getUserDN(username));
            mods[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, mod);
            dirctx.modifyAttributes(getGroupDN(groupName, cnGroupParent), mods);
        } catch (NoSuchAttributeException e) {
            // If user is not assigned, ignore the error
        }
    }
    
    public void unAssignUserToPerfil(String username, String perfilName)
        throws NamingException {
        try {
            unAssignUser(username,perfilName,PERFIS_CN);
        } catch (AttributeInUseException e) {
            // If user is already added, ignore exception
        }
    }
    
    public boolean userInGroup(String username, String groupName, String cnGroupParent)
        throws NamingException {
        // Set up attributes to search for
        String[] searchAttributes = new String[1];
        searchAttributes[0] = "uniqueMember";
        Attributes attributes = dirctx.getAttributes(getGroupDN(groupName, cnGroupParent), searchAttributes);
        if (attributes != null) {
            Attribute memberAtts = attributes.get("uniqueMember");
            if (memberAtts != null) {
                for (NamingEnumeration vals = memberAtts.getAll(); vals.hasMoreElements(); ) {
                    if (username.equalsIgnoreCase(getUserUID((String)vals.nextElement()))) {
                        return true;
                    }
                  }
            }
        }
        return false;
    } 
    
    public List getMembers(String groupName, String cnGroupParent) throws NamingException {
        List members = new LinkedList();

        // Set up attributes to search for
        String[] searchAttributes = new String[1];
        searchAttributes[0] = "uniqueMember";

        Attributes attributes = dirctx.getAttributes(getGroupDN(groupName, cnGroupParent), searchAttributes);
        if (attributes != null) {
            Attribute memberAtts = attributes.get("uniqueMember");
            if (memberAtts != null) {
                for (NamingEnumeration vals = memberAtts.getAll(); vals.hasMoreElements();){
                     String member = getUserUID((String)vals.nextElement());
                     System.out.println("member: " + member);
                     members.add(member) ;
                }
            }
        }

        return members;
    }
    
    public boolean isMember(String groupName, String cnGroupParent, String uid) throws NamingException {
        // Set up attributes to search for
        String[] searchAttributes = new String[1];
        searchAttributes[0] = "uniqueMember";

        Attributes attributes = dirctx.getAttributes(getGroupDN(groupName, cnGroupParent), searchAttributes);
        if (attributes != null) {
            Attribute memberAtts = attributes.get("uniqueMember");
            if (memberAtts != null) {
                for (NamingEnumeration vals = memberAtts.getAll(); vals.hasMoreElements();){
                     String member = getUserUID((String)vals.nextElement());
                     if(member.equalsIgnoreCase(uid)){
                        return true;
                     }
                }
            }
        }
        return false;
    }
    
    public boolean userInPerfil(String username, String groupName)
        throws NamingException {
        return userInGroup(username,groupName,PERFIS_CN);
    }
    
    /* 
     * adicionar grupo    
     * */
    public void addGroup(String dn, String name, String description, String displayname)
        throws NamingException {
        try{
            // Create a container set of attributes
            Attributes container = new BasicAttributes();
    
            // Create the objectclass to add
            Attribute objClasses = new BasicAttribute("objectClass");
            objClasses.add("top");
            objClasses.add("groupOfUniqueNames");
            objClasses.add("orclGroup");
    
            // Assign the name and description to the group
            Attribute cn = new BasicAttribute("cn", name);
            Attribute desc = new BasicAttribute("description", description);
            Attribute displayName = new BasicAttribute("displayName", displayname);
    
            // Add these to the container
            container.put(objClasses);
            container.put(cn);
            container.put(desc);
            container.put(displayName);
    
            // Create the entry
            dirctx.createSubcontext(dn, container);
        } catch(NameAlreadyBoundException e){
            e.printStackTrace();
            throw new NamingException("O grupo já existe.");
        } catch(NamingException ne){
            ne.printStackTrace();
            throw ne;
        }
    }
    
    /* 
     * delete grupo    
     * */
    public void deleteGroup(String dn) throws NamingException {
        try {
            dirctx.destroySubcontext(dn);
        } catch (NameNotFoundException e) {
            // If the group is not found, ignore the error
        }
    }
    
    public List getGroups(String username) throws NamingException {
         return getGroups(username, GROUPS_CN, SearchControls.SUBTREE_SCOPE);
    }
             
    public List getGroups(String username, int searchControl) throws NamingException {
        return getGroups(username, GROUPS_CN, searchControl);
    }
    
    public List getGroups(String username, String groupCN, int searchControl) throws NamingException {
         List groups = new LinkedList();
         // Set up criteria to search on
         StringBuffer filter = new StringBuffer()
             .append("(&")
             .append("(objectClass=groupOfUniqueNames)");
         if(username!=null){
             filter.append("(uniquemember=")
                 .append(getUserDN(username))
                 .append(")");
         }    
         filter.append(")");

         // Set up search constraints
         SearchControls cons = new SearchControls();
         cons.setSearchScope(searchControl);

         NamingEnumeration results = dirctx.search(groupCN, filter.toString(), cons);
         while (results.hasMore()) {
             SearchResult result = (SearchResult)results.next();
             String group = getGroupCN(result.getName());
             System.out.println("group: " + group);
             System.out.println("group: " + result.getNameInNamespace());
             groups.add(group);
         }

         return groups;
    }
                 
    private String getGroupDN(String name) {
        return new StringBuffer()
                .append("cn=")
                .append(name)
                .append(",")
                .append(GROUPS_CN)
                .toString();
    }
    
    private String getGroupCN(String groupDN) {
        int start = groupDN.indexOf("=");
        int end = groupDN.indexOf(",");

        if (end == -1) {
            end = groupDN.length();
        }

        return groupDN.substring(start+1, end);
    }
    
    private String getGroupDN(String name, String cnParent) {
        return new StringBuffer()
                .append("cn=")
                .append(name)
                .append(",")
                .append(cnParent)
                .toString();
    }
    
    private String getPerfisDN(String name) {
        return new StringBuffer()
                .append("cn=")
                .append(name)
                .append(",")
                .append(PERFIS_CN)
                .toString();
    }
    
    private String getAcessosDN(String name) {
        return new StringBuffer()
                .append("cn=")
                .append(name)
                .append(",")
                .append(ACESSOS_CN)
                .toString();
    }
    
    private String getAcessosDN(String name, String dnParent) {
        return new StringBuffer()
                .append("cn=")
                .append(name)
                .append(",")
                .append(dnParent)
                .toString();
    }
    
    public void addPerfil(String name, String description, String displayname)
        throws NamingException {
        addGroup(getPerfisDN(name), name, description, displayname);
    }
    
    public void deletePerfil(String name)
        throws NamingException {
        deleteGroup(getPerfisDN(name));
    }
    
    public List getPerfis()
        throws NamingException {
        return getGroups(null, PERFIS_CN, SearchControls.SUBTREE_SCOPE);
    }
    
    public List getPerfisUser(String name)
        throws NamingException {
        return getGroups(name, PERFIS_CN, SearchControls.SUBTREE_SCOPE);
    }
    
    public void addAcesso(String name, String description, String displayname)
        throws NamingException {
        addGroup(getAcessosDN(name), name, description, displayname);
    }
    
    public void addAcesso(String name, String dnParent, String description, String displayname)
        throws NamingException {
        addGroup(getAcessosDN(name, dnParent), name, description, displayname);
    }
    
    public void deleteAcesso(String name, String dnParent)
        throws NamingException {
        deleteGroup(getAcessosDN(name, dnParent));
    }
    
    public void getAcessosUser(String name)
        throws NamingException {
        getGroups(name, ACESSOS_CN, SearchControls.SUBTREE_SCOPE);
    }
    
    // formatar string para display de arvore de acessos
     public String getArvoreAcessos()
         throws NamingException {
         StringBuffer arvore = new StringBuffer("{id:'0', item:[ ").append(" {id:'Acessos', text:'Acessos', item:[ ");
         List result = null;
         
         // obter primeiro nivel abaixo do ramo Acessos
         result = getGroups(null, ACESSOS_CN, SearchControls.ONELEVEL_SCOPE);
         for ( int i = 0 ; i < result.size() ; i++) {
             Object o = result.get(i);
             if(o.toString().length()>0){
                 arvore.append(" {id:'").append(o.toString()).append("', text:'").append(o.toString()).append("'}");
                 if(i<(result.size()-1)){
                     arvore.append(", ");
                 }
             }
         }
         arvore.append(" ]} ").
         append(" ]} ");
 
         return arvore.toString();
     }
    
        
}
