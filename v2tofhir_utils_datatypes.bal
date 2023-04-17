import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

function HL7V2_GetCodings(hl7v23:CE ce) returns r4:Coding[] {
    r4:Coding[] coding = [];

    coding.push(HL7V2_CE_to_FHIR_Coding(ce));

    return coding;
}
