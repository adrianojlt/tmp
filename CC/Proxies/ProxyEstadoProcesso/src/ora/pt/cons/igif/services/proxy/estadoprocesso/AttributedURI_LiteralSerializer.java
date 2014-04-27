// !DO NOT EDIT THIS FILE!
// This source file is generated by Oracle tools
// Contents may be subject to change
// For reporting problems, use the following
// Version = Oracle WebServices (10.1.3.3.0, build 070610.1800.23513)

package ora.pt.cons.igif.services.proxy.estadoprocesso;

import oracle.j2ee.ws.common.encoding.*;
import oracle.j2ee.ws.common.encoding.literal.*;
import oracle.j2ee.ws.common.encoding.literal.DetailFragmentDeserializer;
import oracle.j2ee.ws.common.encoding.simpletype.*;
import oracle.j2ee.ws.common.soap.SOAPEncodingConstants;
import oracle.j2ee.ws.common.soap.SOAPEnvelopeConstants;
import oracle.j2ee.ws.common.soap.SOAPVersion;
import oracle.j2ee.ws.common.streaming.*;
import oracle.j2ee.ws.common.wsdl.document.schema.SchemaConstants;
import oracle.j2ee.ws.common.util.xml.UUID;
import javax.xml.namespace.QName;
import java.util.List;
import java.util.ArrayList;
import java.util.StringTokenizer;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.AttachmentPart;

public class AttributedURI_LiteralSerializer extends LiteralObjectSerializerBase implements Initializable {
    
    public AttributedURI_LiteralSerializer(QName type) {
        this(type,  false);
    }
    
    public AttributedURI_LiteralSerializer(QName type, boolean encodeType) {
        super(type, true, encodeType);
        setSOAPVersion(SOAPVersion.SOAP_11);
    }
    
    public void initialize(InternalTypeMappingRegistry registry) throws Exception {
    }
    
    public java.lang.Object doDeserialize(XMLReader reader,
        SOAPDeserializationContext context) throws Exception {
        AttributedURI instance = new AttributedURI();
        java.lang.Object member=null;
        QName elementName;
        List values;
        java.lang.Object value;
        
        reader.nextContent();
        if (reader.getState() == XMLReader.CHARS) {
            if (!reader.hasBinaryValue()) {
                member = XSDAnyURIEncoder.getInstance().stringToObject(reader.getValue(), reader);
            }
            else {
                member = ((XSDBase64BinaryEncoder)XSDBase64BinaryEncoder.getInstance()).deserializeFromMTOM(reader);
            }
            reader.nextContent();
        }
        else if (reader.getState() == XMLReader.END) {
            member = XSDAnyURIEncoder.getInstance().stringToObject("", reader);
        }
        else if (reader.getState() == XMLReader.START) {
            throw new DeserializationException("literal.simpleContentExpected", new java.lang.Object[] {reader.getName()},DeserializationException.FAULT_CODE_CLIENT);
        }
        instance.set_value((java.net.URI)member);
        if( reader.getState() != XMLReader.END)
        {
            reader.skipElement();
        }
        XMLReaderUtil.verifyReaderState(reader, XMLReader.END);
        return (java.lang.Object)instance;
    }
    
    public void doSerializeAttributes(java.lang.Object obj, XMLWriter writer, SOAPSerializationContext context) throws Exception {
        AttributedURI instance = (AttributedURI)obj;
        
    }
    public void doSerializeAnyAttributes(java.lang.Object obj, XMLWriter writer, SOAPSerializationContext context) throws Exception {
        AttributedURI instance = (AttributedURI)obj;
        
    }
    public void doSerialize(java.lang.Object obj, XMLWriter writer, SOAPSerializationContext context) throws Exception {
        AttributedURI instance = (AttributedURI)obj;
        
        writer.writeChars(XSDAnyURIEncoder.getInstance().objectToString(instance.get_value(), writer));
    }
}
