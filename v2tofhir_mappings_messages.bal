import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

// --------------------------------------------------------------------------------------------#
// Source HL7 Version 2 to FHIR - Message Maps
// URL: https://build.fhir.org/ig/HL7/v2-to-fhir/branches/master/message_maps.html
// --------------------------------------------------------------------------------------------#

function HL7V23_ADT_A01ToPatient(hl7v23:ADT_A01 msg) returns r4:Patient|error {
    r4:Patient patient = HL7V2_PID_to_FHIR_Patient(<hl7v23:PID>msg.pid);

    return patient;
};

function HL7V23_ADT_A04ToPatient(hl7v23:ADT_A04 msg) returns r4:Patient|error {
    r4:Patient patient = HL7V2_PID_to_FHIR_Patient(<hl7v23:PID>msg.pid);

    return patient;
};

function HL7V23_ORU_R01ToPatient(hl7v23:ORU_R01 msg) returns r4:Patient[]|error {
    hl7v23:RESPONSE[] responses = msg.response;
    r4:Patient[] patientArr = [];
    foreach hl7v23:RESPONSE res in responses {
        if res.patient.pid is hl7v23:PID {
            r4:Patient patient = HL7V2_PID_to_FHIR_Patient(<hl7v23:PID>res.patient.pid);
            patientArr.push(patient);
        }
    }
    return patientArr;
}

function HL7V23_ADR_A19ToPatient(hl7v23:ADR_A19 adrA19) returns r4:Patient[]|error {

    hl7v23:QUERY_RESPONSE[] queryResponses = adrA19.query_response;
    r4:Patient[] patientArr = [];
    foreach hl7v23:QUERY_RESPONSE queryResponse in queryResponses {
        if queryResponse.pid is hl7v23:PID {
            r4:Patient patient = HL7V2_PID_to_FHIR_Patient(<hl7v23:PID>queryResponse.pid);
            patientArr.push(patient);
        }
    }
    return patientArr;
}

// --- Patient Administration ---
// function HL7V2_ADT_A01(hl7v23:ADT_A01 adt_a01) returns r4:Bundle {};
// function HL7V2_ADT_A04(hl7v23:ADT_A04 adt_a04) returns r4:Bundle {};
// function HL7V2_ADT_A08(hl7v23:ADT_A08 adt_a08) returns r4:Bundle {};

// --- Order Entry ---
// function HL7V2_OML_O21(hl7v23:OML_O21 oml_o21) returns r4:Bundle {};
// function HL7V2_ORM_O01(hl7v23:ORM_O01 orm_o01) returns r4:Bundle {};
// function HL7V2_VXU_V04(hl7v23:VXU_V04 vxu_v04) returns r4:Bundle {};

// --- Observation Reporting ---
// function HL7V2_ORU_R01(hl7v23:ORU_R01 oru_r01) returns r4:Bundle {};