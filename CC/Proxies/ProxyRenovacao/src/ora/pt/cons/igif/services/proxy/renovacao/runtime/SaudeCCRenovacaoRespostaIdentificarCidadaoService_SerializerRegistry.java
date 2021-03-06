// !DO NOT EDIT THIS FILE!
// This source file is generated by Oracle tools
// Contents may be subject to change
// For reporting problems, use the following
// Version = Oracle WebServices (10.1.3.1.0, build 061008.0900.00025)

package ora.pt.cons.igif.services.proxy.renovacao.runtime;

import oracle.j2ee.ws.client.BasicService;
import oracle.j2ee.ws.common.encoding.*;
import oracle.j2ee.ws.common.encoding.simpletype.*;
import oracle.j2ee.ws.common.encoding.soap.*;
import oracle.j2ee.ws.common.encoding.literal.*;
import oracle.j2ee.ws.common.soap.SOAPVersion;
import oracle.j2ee.ws.common.soap.SOAPEncodingConstants;
import oracle.j2ee.ws.common.wsdl.document.schema.SchemaConstants;
import javax.xml.rpc.*;
import javax.xml.rpc.encoding.*;
import javax.xml.namespace.QName;

import ora.pt.cons.igif.services.proxy.renovacao.AttributedURI;
import ora.pt.cons.igif.services.proxy.renovacao.AttributedURI_LiteralSerializer;

public class SaudeCCRenovacaoRespostaIdentificarCidadaoService_SerializerRegistry extends SerializerRegistryBase implements SerializerConstants {
    public SaudeCCRenovacaoRespostaIdentificarCidadaoService_SerializerRegistry() {
    }
    
    public TypeMappingRegistry getRegistry() {
        TypeMappingRegistry registry = BasicService.createStandardTypeMappingRegistry();
        TypeMapping mapping11 = registry.getTypeMapping(SOAPEncodingConstants.getSOAPEncodingConstants(SOAPVersion.SOAP_11).getURIEncoding());
        TypeMapping mapping = registry.getTypeMapping("");
        {
            QName type = new QName("http://www.min-saude.pt/schemas/CartaoCidadao/2007/05", "SaudeCCRenovacaoRespostaIdentificarCidadao");
            CombinedSerializer serializer = new LiteralFragmentSerializer(type, NOT_NULLABLE, false, null, "",false);
            registerSerializer(mapping,javax.xml.soap.SOAPElement.class, type, serializer);
        }
        {
            QName type = new QName("http://www.w3.org/2005/08/addressing", "AttributedURI");
            CombinedSerializer serializer = new AttributedURI_LiteralSerializer(type, DONT_ENCODE_TYPE);
            registerSerializer(mapping,AttributedURI.class, type, serializer);
        } 
        ora.pt.cons.igif.services.proxy.renovacao.runtime.SaudeCCRenovacaoRespostaIdentificarCidadaoService_SerializerRegistry12 internal12Registry = new ora.pt.cons.igif.services.proxy.renovacao.runtime.SaudeCCRenovacaoRespostaIdentificarCidadaoService_SerializerRegistry12();
        return internal12Registry.getRegistry(registry);
    }
    
    private static void registerSerializer(TypeMapping mapping, Class javaType, QName xmlType,
        Serializer ser) {
        mapping.register(javaType, xmlType, new SingletonSerializerFactory(ser),
            new SingletonDeserializerFactory((Deserializer)ser));
    }
    
}
