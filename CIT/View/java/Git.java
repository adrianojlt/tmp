package ora.pt.cons.igif.sics.controller.misc;

import java.io.BufferedInputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;

import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import ora.pt.cons.igif.sics.common.ListaParametros;
import ora.pt.cons.igif.sics.common.ListaParametrosRow;

import oracle.adf.controller.v2.context.PageLifecycleContext;
import oracle.adf.model.binding.DCIteratorBinding;

import oracle.jbo.Row;

import org.apache.log4j.Logger;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


public class Git {

    private static Logger log = 
            Logger.getLogger(Git.class);
  
    public static String generateReportLink(String idItemBaixa, String reportType, PageLifecycleContext ctx) throws Exception{
           //Get Lista Parametros
           DCIteratorBinding dciListaParametros     = (DCIteratorBinding) ctx.getBindingContainer().get("ListaParametrosIterator");
           ListaParametros voListaParametros        = (ListaParametros)dciListaParametros.getViewObject();      
           
           //Executes Query to Get Report Server URL
           voListaParametros.setPathForReportServerUrl();
           voListaParametros.executeQuery(); //This Query must only return one value
           ListaParametrosRow rowParametros = (ListaParametrosRow)voListaParametros.first(); 
           
           String urlLink = null;
           URL    url = null;
           BufferedInputStream bis = null;
           InputStreamReader isr = null;
           String reportsServerURL = rowParametros.getValText() + "?";
           
           //Executes Query to Get Data of Receitas Report
           voListaParametros.setPathForReportsGitParam();
           voListaParametros.executeQuery(); //This Query must only return one value
           voListaParametros.setRangeSize(-1);
           Row[] rowParametrosVec = voListaParametros.getAllRowsInRange();
           
          
           String paramDestype          = null; //= "file";
           String paramUserId           = null; //= "igif/oracle123@DCMSINUS";
           String paramReportSegSocial  = null; //= "snu_receita_sns.rdf";
           String paramReportPub        = null; //= "snu_receita_sns.rdf";
           String paramReportMod230     = null; //= "snu_receita_sns.rdf";
           String paramDesformat        = null;// = "pdf";
           String paramDesname          = null;// = "'/oracle/product/10.1.2/as/mid/frservices/Apache/Apache/htdocs/rnu/reports_cache/med<numeroReceita>.rrpa'";
           String paramBaixas           = null;// = "<numeroReceita>";
           String paramStatusformat     = null;// = "xml";
           String reportFileExtension   = null;
           String reportFileExtText     = null;
           String reportServerCacheUrl  = null;
           
           long numberRegs = rowParametrosVec.length;
           for (int i=0; i < numberRegs; i++) {
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_FORMAT") ) {
                   paramDesformat = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_NAME") ) {
                   paramDesname   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("DES_TYPE") ) {
                   paramDestype = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("PARAM_BAIXAS") ) {
                   paramBaixas   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_MOD230") ) {
                   paramReportMod230   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_PUB") ) {
                   paramReportPub   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_SEGSOCIAL") ) {
                   paramReportSegSocial   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("STATUSFORMAT") ) {
                   paramStatusformat = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("USER_ID") ) {
                   paramUserId   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_FILE_EXTENSION") ) {
                   reportFileExtension   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_FILE_EXTENSION_TEXT") ) {
                   reportFileExtText   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
               if ((((ListaParametrosRow)rowParametrosVec[i]).getNome()).equalsIgnoreCase("REPORT_SERVER_CACHE_URL") ) {
                   reportServerCacheUrl   = ((ListaParametrosRow)rowParametrosVec[i]).getValText();
               }
           }
           
           
           try{
           
               urlLink = new String();
               urlLink = urlLink + reportsServerURL;
               urlLink = urlLink + "destype=" + paramDestype + "&";
               urlLink = urlLink + "userid=" + paramUserId + "&";
               if (reportType.equals("SEGSOCIAL")) {
                   urlLink = urlLink + "report=" + paramReportSegSocial + "&";    
               } else if (reportType.equals("PUB")) {
                   urlLink = urlLink + "report=" + paramReportPub + "&";     
               } else if (reportType.equals("MOD230")) {
                   urlLink = urlLink + "report=" + paramReportMod230 + "&";     
               }
               
               urlLink = urlLink + "desformat=" + paramDesformat + "&";
               urlLink = urlLink + "p_item_baixa_id=" + idItemBaixa + "&";
               urlLink = urlLink + "statusformat=" + paramStatusformat + "&";
               urlLink = urlLink + "desname=" + paramDesname;
               if (reportType.equals("MOD230")) {
                  urlLink = urlLink.replaceAll(paramBaixas,idItemBaixa + "MOD230");     
               } else {
                  urlLink = urlLink.replaceAll(paramBaixas,idItemBaixa); 
               }
               urlLink = urlLink.replaceAll(reportFileExtText,reportFileExtension);
               log.debug("UrlLink: " + urlLink);
               url = new URL(urlLink);
               bis = new BufferedInputStream(url.openStream());
               isr = new InputStreamReader(bis);
               DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
               DocumentBuilder builder = factory.newDocumentBuilder();
               Document doc = builder.parse(new org.xml.sax.InputSource(isr)); 
               NodeList nl = doc.getElementsByTagName("job");
               urlLink = null;
               
               if(nl.getLength()>0){
                   for(int i = 0 ; i < nl.getLength() ; i++){
                       Node n = nl.item(i);
                       Transformer t = TransformerFactory.newInstance().newTransformer();
                       StringWriter sw = new StringWriter();
                       t.transform(new DOMSource(n), new StreamResult(sw));
                       String yourAnswer = sw.toString();  
                       log.debug("Resposta: " + yourAnswer);
                       if(/*yourAnswer.indexOf(idItemBaixa + reportFileExtension) >= 0 &&*/ yourAnswer.indexOf("<status code=\"4\">") >= 0){
                            // Fazer a cena do URL
                            urlLink = reportServerCacheUrl + paramBaixas + reportFileExtText;
                            if (reportType.equals("MOD230")) {
                               urlLink = urlLink.replaceAll(paramBaixas,idItemBaixa + "MOD230");     
                            } else {
                               urlLink = urlLink.replaceAll(paramBaixas,idItemBaixa); 
                            }
                            urlLink = urlLink.replaceAll(reportFileExtText,reportFileExtension);
                            break;
                       }
                   }
               } else {
                   nl = doc.getElementsByTagName("error");
                   if(nl.getLength()>0){
                   
                       for (int temp = 0; temp < nl.getLength(); temp++) {
                          Node nNode = nl.item(temp);
                          if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                              Element eElement = (Element) nNode;
                              throw new Exception(eElement.getAttribute("code") + "-" + eElement.getAttribute("message"));
                          }
                        }
                        return null;
                   }
               }
               
           } catch(Exception e){
             log.error("", e);
             throw e;
           }finally{
               try{
                   isr.close();
                   isr = null;
                   bis.close();
                   bis = null;
               } catch(Exception e){
                 log.error("Erro ao devolver objectos.",e);
                 isr = null;
                 bis = null;
               }
           }
           log.debug("urlLink a devoler: " + urlLink);
           return urlLink;
       }
    

}
