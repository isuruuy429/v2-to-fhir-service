import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v24;
import wso2healthcare/healthcare.hl7v25;

function HL7V2_GetCodings(hl7v23:CE ce) returns r4:Coding[] {
    r4:Coding[] coding = [];
    coding.push(HL7V2_CE_to_FHIR_Coding(ce));
    return coding;
}

function HL7V2_XCN_to_FHIR_Reference(hl7v23:XCN|hl7v24:XCN|hl7v25:XCN xcn) returns r4:Reference => {
    reference: xcn.xcn1
};

function HL7V2_ID_to_FHIR_Coding(hl7v23:ID id) returns r4:Coding => {
    id: id
};

function HL7V2_GetCodeableConcepts(hl7v23:CE ce) returns r4:CodeableConcept[] {
    r4:CodeableConcept[] codeableConcept = [];
    codeableConcept.push(HL7V2_CE_to_FHIR_CodeableConcept(ce));
    return codeableConcept;
}

function HL7V2_ID_to_FHIR_CodeableConcept(hl7v23:ID id) returns r4:CodeableConcept {
    r4:Coding[] coding = [
        {
            code: id
        }
    ];

    r4:CodeableConcept codeableConcept = {
        coding: coding
    };
    return codeableConcept;
};

function HL7V2_TS_to_FHIR_dateTime(hl7v23:TS ts) returns r4:dateTime {
    return ts.ts1;
};