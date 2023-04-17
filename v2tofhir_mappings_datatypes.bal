import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

// --------------------------------------------------------------------------------------------#
// Source HL7 Version 2 to FHIR - Datatype Maps
// URL: https://build.fhir.org/ig/HL7/v2-to-fhir/branches/master/datatype_maps.html
// --------------------------------------------------------------------------------------------#

// function HL7V2_CM_to_FHIR_Specimen(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CNE_to_FHIR_CodeableConcept(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CNN_to_FHIR_Practitioner(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CQ_to_FHIR_Quantity(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_Annotation(hl7v23:XCN xcn) returns r4:Practitioner => {};

function HL7V2_CE_to_FHIR_CodeableConcept(hl7v23:CE ce) returns r4:CodeableConcept => {
    coding: HL7V2_GetCodings(ce)
};

function HL7V2_CE_to_FHIR_Coding(hl7v23:CE ce) returns r4:Coding => {
    code: ce.ce1,
    display: ce.ce2,
    system: ce.ce3
};

// function HL7V2_CWE_to_FHIR_Duration(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_Organization(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_Quantity(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_code(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_string(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CWE_to_FHIR_uri(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_CX_to_FHIR_Identifier(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_DLN_to_FHIR_Identifier(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_DR_to_FHIR_DateTime(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_DR_to_FHIR_Period(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_ED_to_FHIR_Attachment(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_EI_to_FHIR_Coding(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_EI_to_FHIR_Identifier(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_EI_to_FHIR_Device(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_FN_to_FHIR_HumanName(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_HD_to_FHIR_Location(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_HD_to_FHIR_Organization(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_HD_to_FHIR_extension(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_HD_to_FHIR_MessageHeader(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_HD_to_FHIR_uri(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_ID_to_FHIR_CodeableConcept(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_IS_to_FHIR_CodeableConcept(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_MSG_to_FHIR_Coding(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_MSG_to_FHIR_MessageHeader(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_NA_to_FHIR_NumericArray(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_NDL_to_FHIR_PractitionerRole(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_NR_to_FHIR_Ranger(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_PL_to_FHIR_Location(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_PLN_to_FHIR_Identifier(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_PT_to_FHIR_Meta(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_RI_to_FHIR_Timing(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_RP_to_FHIR_Attachment(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_SAD_to_FHIR_Address(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_SN_to_FHIR_Quantity(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_SN_to_FHIR_Range(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_SN_to_FHIR_Ratio(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_ST_to_FHIR_Identifier(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_TQ_to_FHIR_MedicationRequest(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_TQ_to_FHIR_ServiceRequest(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_TQ_to_FHIR_Task(hl7v23:XCN xcn) returns r4:Practitioner => {};

function HL7V2_XAD_to_FHIR_Address(hl7v23:XAD xad) returns r4:Address => {
    line: [xad.xad1, xad.xad2],
    city: xad.xad3,
    state: xad.xad4,
    postalCode: xad.xad5,
    country: xad.xad6,
    'type: CheckComputableANTLR([{identifier: xad.xad7, comparisonOperator: "IN", valueList: ["M", "SH"]}]) ? V2ToFHIR_GetAddressType(xad.xad7) : (),
    use: CheckComputableANTLR([{identifier: xad.xad7, comparisonOperator: "IN", valueList: ["BA", "BI", "C", "B", "H", "O"]}]) ? V2ToFHIR_GetAddressUse(xad.xad7) : (),
    extension: V2ToFHIR_GetStringExtension([xad.xad7, xad.xad10]),
    district: xad.xad9
};

// function HL7V2_XCN_to_FHIR_Practitioner(hl7v23:XCN xcn) returns r4:Practitioner => {};
// function HL7V2_XCN_to_FHIR_PractitionerRole(hl7v23:XCN xcn) returns r4:PractitionerRole => {};
// function HL7V2_XCN_to_FHIR_RelatedPerson(hl7v23:XCN xcn) returns r4:RelatedPerson => {};
// function HL7V2_XON_to_FHIR_Location(hl7v23:XON xon) returns r4:Location => {};

function HL7V2_XON_to_FHIR_Organization(hl7v23:XON xon) returns r4:Organization {
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

// function HL7V2_XON_to_FHIR_string(hl7v23:XON xon) returns string => {};

function HL7V2_XPN_to_FHIR_HumanName(hl7v23:XPN xpn) returns r4:HumanName => {
    family: xpn.xpn1,
    given: [xpn.xpn2, xpn.xpn3],
    suffix: [xpn.xpn4, xpn.xpn6],
    prefix: [xpn.xpn5],
    use: V2ToFHIR_GetHumanNameUse(xpn.xpn7)
};

function HL7V2_XTN_to_FHIR_ContactPoint(hl7v23:XTN xtn) returns r4:ContactPoint => {
    value: CheckComputableANTLR([
            {identifier: xtn.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]},
            {identifier: xtn.xtn7.toString(), comparisonOperator: "IN", valueList: []}
            //, {identifier: xtn.xtn12, comparisonOperator: "IN", valueList: []}                    //TODO: xtn12 is not defined yet
        ]) ? xtn.xtn1 :
            (CheckComputableANTLR([{identifier: xtn.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]}])) ? (xtn.xtn4) : (),
    use: V2ToFHIR_GetContactPointUse(xtn.xtn2),
    system: V2ToFHIR_GetContactPointSystem(xtn.xtn3),
    extension: V2ToFHIR_GetIntegerExtension([<int>xtn.xtn5, <int>xtn.xtn6, <int>xtn.xtn7, <int>xtn.xtn8])
};

