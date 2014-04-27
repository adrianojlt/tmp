package ora.pt.cons.igif.services.ws.federacao;

import java.io.BufferedWriter;

import java.io.File;
import java.io.FileWriter;
import java.io.StringReader;
import java.io.StringWriter;

import java.util.Iterator;

import javax.xml.soap.MessageFactory;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPMessage;

import ora.pt.cons.igif.services.proxy.federacao.IDFedValidateWellKnownFactsResponsePortClient;

import oracle.webservices.SOAPUtil;

import oracle.xml.parser.v2.DOMParser;
import oracle.xml.parser.v2.XMLElement;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class IDFedValidateWellKnownFactsResponseProxyTypeImpl {
    public SOAPElement IDFedValidateWellKnownFactsResponseProxy(SOAPElement IDFedValidateWellKnownFactsResponseProxyParameters) {
        IDFedValidateWellKnownFactsResponsePortClient proxy = null;
        SOAPElement retVal = null;
        String retValString = null;
        BufferedWriter bw = null;
        String messageId = null;
        String to = null;
        String action = null;
        String relatesTo = null;
        
        try{
            Iterator i = null;
            SOAPElement header = null;
            SOAPElement el = null;
            String headerValue = null;
            String headerName = null;
            Object o = null;
            i = IDFedValidateWellKnownFactsResponseProxyParameters.getParentElement().getParentElement().getChildElements();
            while(i.hasNext()){
                o = i.next();     
                if(o.getClass().getName().indexOf("Header") >= 0){
                    header = (SOAPElement) o;
                    break;
                }                   
            }
            i = header.getChildElements();
            while(i.hasNext()){
                o = i.next();
                if(o instanceof SOAPElement){
                    el = (SOAPElement) o;
                    headerName = el.getNodeName();
                    headerValue = el.getValue();
                    if(headerName.toUpperCase().indexOf("RELATESTO") >= 0){
                        relatesTo = headerValue;
                    }else if(headerName.toUpperCase().indexOf("MESSAGEID") >= 0){
                        messageId = headerValue;
                    }else if(headerName.toUpperCase().indexOf("ACTION") >= 0){
                        action = headerValue;
                    }else if(headerName.toUpperCase().indexOf("TO") >= 0){
                        if(!(headerName.toUpperCase().indexOf("RELATESTO") >= 0)){
                            to = headerValue;
                        }
                    }                    
                }
            }
            
            Document d = IDFedValidateWellKnownFactsResponseProxyParameters.getOwnerDocument();
            StringWriter stringWriter = new StringWriter();
            ((XMLElement) d.getDocumentElement()).print(stringWriter);
            String s = stringWriter.toString();
            
            //PRODUCAO
            //bw = new BufferedWriter(new FileWriter(new File("/oracle/product/10.1.3/federacaowsa.log"),true));
            
            //TESTES
            bw = new BufferedWriter(new FileWriter(new File("/oracle/product/10.1.3.1/federacaowsa.log"),true));
            
            bw.write("XML ORIGINAL");
            bw.write(s);
            bw.newLine();
            bw.newLine();
            bw.flush();
            //
            //            s = s.replaceAll("IDFedValidateWellKnownFactsResponseProxy","IDFedValidateWellKnownFactsResponse");
            //            System.out.println(s);
            //            s = s.substring(s.indexOf("<cc:IDFedValidateWellKnownFactsResponse"),s.indexOf("</cc:IDFedValidateWellKnownFactsResponse>") + "</cc:IDFedValidateWellKnownFactsResponse>".length());
            //
            //
            //            //bw.write("STRING");
            //            //bw.newLine();
            //            //bw.newLine();
            //            //bw.write(s);
            //            //bw.flush();
            //
            //            DOMParser builder = new DOMParser();
            //            builder.parse(new StringReader(s));
            //            Document res = builder.getDocument();
            //            SOAPElement ss = SOAPUtil.toSOAPElement(res.getDocumentElement());
            //            d = ss.getOwnerDocument();
            //            stringWriter = new StringWriter();
            //            ((XMLElement) d.getDocumentElement()).print(stringWriter);
            //            s = stringWriter.toString();
            //
            //
            //            //bw.write("DOM");
            //            //bw.newLine();
            //            //bw.newLine();
            //            //bw.write(s);
            //
            //            //bw.flush();
            //            //bw.close();
            //            //bw = null;
            //
             DOMParser builder = new DOMParser();
             builder.parse(new StringReader(s));
             Document res = builder.getDocument();    
             SOAPElement ss = SOAPUtil.toSOAPElement(res.getDocumentElement());
             d = ss.getOwnerDocument();
             ///// PRINCIPIO
             Element headerContent = d.createElementNS("http://www.w3.org/2005/08/addressing","MessageID");
             headerContent.appendChild(d.createTextNode(messageId));
             d.getFirstChild().getFirstChild().appendChild(headerContent);

             headerContent = d.createElementNS("http://www.w3.org/2005/08/addressing","RelatesTo");
             headerContent.appendChild(d.createTextNode(relatesTo));
             d.getFirstChild().getFirstChild().appendChild(headerContent);

             headerContent = d.createElementNS("http://www.w3.org/2005/08/addressing","Action");
             headerContent.appendChild(d.createTextNode(action));
             d.getFirstChild().getFirstChild().appendChild(headerContent);

             headerContent = d.createElementNS("http://www.w3.org/2005/08/addressing","To");
             headerContent.appendChild(d.createTextNode(to));
             d.getFirstChild().getFirstChild().appendChild(headerContent);
             
             ///// FIM
             stringWriter = new StringWriter();
             ((XMLElement) d.getDocumentElement()).print(stringWriter);            
             s = stringWriter.toString();

             
            bw.write("XML ALTERADO");
            bw.newLine();
            bw.newLine();
            bw.write(s);
            
            bw.flush();
            bw.close();
            bw = null;
            
            proxy = new IDFedValidateWellKnownFactsResponsePortClient();
            proxy.IDFedValidateWellKnownFactsResponse(IDFedValidateWellKnownFactsResponseProxyParameters);
            retValString = "OK";
            MessageFactory mf = MessageFactory.newInstance();
            SOAPMessage output = mf.createMessage();
            
            SOAPBody body = output.getSOAPBody();
            body.addTextNode(retValString);
            retVal = body;             
        }catch(Exception e){
            e.printStackTrace();
            retValString = "ERROR";
            try{
                MessageFactory mf = MessageFactory.newInstance();
                SOAPMessage output = mf.createMessage();
                SOAPBody body = output.getSOAPBody();
                body.addTextNode(retValString);
                retVal = body;            
            }catch(Exception ex){
                e.printStackTrace();
            }
        }finally{
            bw = null;
        }
        return retVal;
    }
}
