import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v24;
import wso2healthcare/healthcare.hl7v25;

// --------------------------------------------------------------------------------------------#
// Source HL7 Version 2 to FHIR - Datatype Maps
// URL: https://build.fhir.org/ig/HL7/v2-to-fhir/branches/master/datatype_maps.html
// --------------------------------------------------------------------------------------------#

function HL7V2_CE_to_FHIR_CodeableConcept(hl7v23:CE|hl7v24:CE|hl7v25:CE ce) returns r4:CodeableConcept => {
    coding: HL7V2_GetCodings(ce)
};

function HL7V2_CE_to_FHIR_Coding(hl7v23:CE|hl7v24:CE|hl7v25:CE ce) returns r4:Coding => {
    code: (ce.ce1 != "") ? ce.ce1 : (),
    display: (ce.ce2 != "") ? ce.ce2 : (),
    system: (ce.ce3 != "") ? ce.ce3 : ()
};

function HL7V2_XAD_to_FHIR_Address(hl7v23:XAD|hl7v24:XAD|hl7v25:XAD xad) returns r4:Address {
    r4:Address address = {
        city: (xad.xad3 != "") ? xad.xad3 : (),
        state: (xad.xad4 != "") ? xad.xad4 : (),
        postalCode: (xad.xad5 != "") ? xad.xad5 : (),
        country: (xad.xad6 != "") ? xad.xad6 : (),
        'type: CheckComputableANTLR([{identifier: xad.xad7, comparisonOperator: "IN", valueList: ["M", "SH"]}]) ? V2ToFHIR_GetAddressType(xad.xad7) : (),
        use: CheckComputableANTLR([{identifier: xad.xad7, comparisonOperator: "IN", valueList: ["BA", "BI", "C", "B", "H", "O"]}]) ? V2ToFHIR_GetAddressUse(xad.xad7) : (),
        extension: V2ToFHIR_GetStringExtension([xad.xad7, xad.xad10]),
        district: (xad.xad9 != "") ? xad.xad9 : ()
    };
    if xad is hl7v23:XAD {
        address.line = [xad.xad1, xad.xad2];
    } else if xad is hl7v24:XAD|hl7v25:XAD {
        address.line = [xad.xad1.sad1, xad.xad2];
    }
    return address;
};

function HL7V2_XON_to_FHIR_Organization(hl7v23:XON|hl7v24:XON|hl7v25:XON xon) returns r4:Organization {
    r4:Coding coding = {
        code: xon.xon7,
        system: xon.xon7
    };

    r4:CodeableConcept codeableConcept = {
        coding: [
            coding
        ]
    };

    r4:Identifier identifier = {
        value: xon.xon3.toString(),
        'type: codeableConcept
    };

    r4:Organization organization = {
        name: xon.xon1,
        identifier: [identifier]
    };

    return organization;
};

function HL7V2_XPN_to_FHIR_HumanName(hl7v23:XPN|hl7v24:XPN|hl7v25:XPN xpn) returns r4:HumanName {
    r4:HumanName humanName = {
        use: (xpn.xpn7 != "") ? V2ToFHIR_GetHumanNameUse(xpn.xpn7) : ()
    };
    if xpn is hl7v23:XPN {
        humanName.family = (xpn.xpn1 != "") ? xpn.xpn1 : ();
    } else if xpn is hl7v24:XPN|hl7v25:XPN {
        humanName.family = (xpn.xpn1.fn1 != "") ? xpn.xpn1.fn1 : ();
    }
    //given
    if xpn.xpn2 != "" && xpn.xpn3 != "" {
        humanName.given = [xpn.xpn2, xpn.xpn3];
    } else if xpn.xpn2 != "" {
        humanName.given = [xpn.xpn2];
    } else if xpn.xpn3 != "" {
        humanName.given = [xpn.xpn3];
    }
    //suffix
    if xpn.xpn4 != "" && xpn.xpn6 != "" {
        humanName.suffix = [xpn.xpn4, xpn.xpn6];
    } else if xpn.xpn4 != "" {
        humanName.suffix = [xpn.xpn4];
    } else if xpn.xpn6 != "" {
        humanName.suffix = [xpn.xpn6];
    }
    //prefix
    if xpn.xpn5 != "" {
        humanName.prefix = [xpn.xpn5];
    }
    return humanName;
};

function HL7V2_XTN_to_FHIR_ContactPoint(hl7v23:XTN|hl7v24:XTN|hl7v25:XTN xtn) returns r4:ContactPoint {
    r4:ContactPoint contactPoint = {
        value: CheckComputableANTLR([
                {identifier: xtn.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]},
                {identifier: xtn.xtn7.toString(), comparisonOperator: "IN", valueList: []}
                //, {identifier: xtn.xtn12, comparisonOperator: "IN", valueList: []}                    //TODO: xtn12 is not defined yet
            ]) ? xtn.xtn1 :
                (CheckComputableANTLR([{identifier: xtn.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]}])) ? (xtn.xtn4) : (),
        use: V2ToFHIR_GetContactPointUse(xtn.xtn2),
        system: V2ToFHIR_GetContactPointSystem(xtn.xtn3),
        extension: V2ToFHIR_GetStringExtension([xtn.xtn5.toString(), xtn.xtn6.toString(), xtn.xtn7.toString(), xtn.xtn8.toString()])
    };
    if contactPoint.value == "" {
        return {};
    }
    return contactPoint;
};

function HL7V2_HD_to_FHIR_MessageHeader_source(hl7v23:HD|hl7v24:HD|hl7v25:HD hd) returns r4:MessageHeaderSource => {
    name: hd.hd1,
    endpoint: hd.hd2,
    extension: V2ToFHIR_GetStringExtension([hd.hd3])
};

function HL7V2_HD_to_FHIR_MessageHeader_destination(hl7v23:HD|hl7v24:HD|hl7v25:HD hd) returns r4:MessageHeaderDestination => {
    name: hd.hd1,
    endpoint: hd.hd2,
    extension: V2ToFHIR_GetStringExtension([hd.hd3])
};

function HL7V2_MSG_to_FHIR_Coding(hl7v23:CM_MSG msg) returns r4:Coding => {
    code: msg.cm_msg1,
    system: msg.cm_msg2
};

function HL7V2_PT_to_FHIR_Meta(hl7v23:PT|hl7v24:PT|hl7v25:PT pt) returns r4:Meta {
    r4:Coding[] coding = [
        {
            code: pt.pt1,
            system: pt.pt2
        }
    ];
    r4:Meta meta = {
        tag: coding
    };
    return meta;
};

function HL7V2_CE_to_FHIR_code(hl7v23:CE|hl7v24:CE|hl7v25:CE ce) returns r4:code {
    r4:code code = ce.ce1;
    return code;
};

function HL7V2_EI_to_FHIR_Identifier(hl7v23:EI|hl7v24:EI|hl7v25:EI ei) returns r4:Identifier => {
    value: (ei.ei1 != "") ? ei.ei1: ()
};

function HL7V2_GetCodeableConceptsGivenID(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:CodeableConcept[] {
    r4:CodeableConcept[] codeableConcept = [];
    codeableConcept.push(HL7V2_ID_to_FHIR_CodeableConcept(id));
    return codeableConcept;
}

function HL7V2_EI_to_FHIR_Coding(hl7v23:EI|hl7v24:EI|hl7v25:EI ei) returns r4:Coding => {
    code: (ei.ei1 != "")? ei.ei1:(),
    system: (ei.ei2 != "")? ei.ei2:()
};

function HL7V2_CE_to_FHIR_uri(hl7v23:CE|hl7v24:CE|hl7v25:CE ce) returns r4:uri {
    return ce.ce1;
};

function HL7V2_XCN_to_FHIR_CodeableConcept(hl7v23:XCN|hl7v24:XCN|hl7v25:XCN xcn) returns r4:CodeableConcept => {
    id: xcn.xcn1
};
