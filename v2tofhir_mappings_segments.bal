import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7;

// --------------------------------------------------------------------------------------------#
// Source HL7 Version 2 to FHIR - Segment Maps
// URL: https://build.fhir.org/ig/HL7/v2-to-fhir/branches/master/segment_maps.html
// --------------------------------------------------------------------------------------------#

function Generic_Segment_To_FHIR(string segmentName, hl7:Segment segment) returns r4:BundleEntry[] {
    r4:BundleEntry[] entries = [];
    match segmentName {
        "NK1" => {
            r4:BundleEntry entry = {'resource: HL7V2_NK1_to_FHIR_Patient(<hl7v23:NK1>segment)};
            entries.push(entry);
            return entries;
        }
        "PD1" => {
            r4:BundleEntry entry = {'resource: HL7V2_PD1_to_FHIR_Patient(<hl7v23:PD1>segment)};
            entries.push(entry);
            return entries;
        }
        "PID" => {
            r4:BundleEntry entry = {'resource: HL7V2_PID_to_FHIR_Patient(<hl7v23:PID>segment)};
            entries.push(entry);
            return entries;
        }
        "PV1" => {
            r4:BundleEntry entry = {'resource: HL7V2_PV1_to_FHIR_Patient(<hl7v23:PV1>segment)};
            entries.push(entry);
            return entries;
        }
        "DG1" => {
            r4:BundleEntry entry = {'resource: HL7V2_DG1_to_FHIR_Condition(<hl7v23:DG1>segment)};
            entries.push(entry);
            return entries;
        }
    }
    return entries;
}

function HL7V2_MSH_to_FHIR_MessageHeader(hl7v23:MSH msh) returns r4:MessageHeader => {
    'source: HL7V2_HD_to_FHIR_MessageHeader_source(msh.msh3),
    destination: [HL7V2_HD_to_FHIR_MessageHeader_destination(msh.msh5)],
    eventCoding: HL7V2_MSG_to_FHIR_Coding(msh.msh9),
    meta: <r4:BaseMessageHeaderMeta>HL7V2_PT_to_FHIR_Meta(msh.msh11),
    language: HL7V2_CE_to_FHIR_code(msh.msh19),
    eventUri: ""
};

function HL7V2_NK1_to_FHIR_Patient(hl7v23:NK1 nk1) returns r4:Patient => {
    contact: GetHL7v23_NK1_Contact(nk1.nk12, nk1.nk14, nk1.nk15, nk1.nk16, nk1.nk17, nk1.nk18, nk1.nk19, nk1.nk113, nk1.nk115, nk1.nk130, nk1.nk131, nk1.nk132)
};

function HL7V2_PD1_to_FHIR_Patient(hl7v23:PD1 pd1) returns r4:Patient => {
    generalPractitioner: GetHL7v23_PD1_GeneralPractitioner(pd1.pd13, pd1.pd14),
    extension: (pd1.pd16 != "") ? GetHL7v23_PD1_Extension(pd1.pd16) : ()
};

function HL7V2_PID_to_FHIR_Patient(hl7v23:PID pid) returns r4:Patient => {
    name: GetHL7v23_PID_PatientName(pid.pid5, pid.pid9),
    birthDate: (pid.pid7.ts1 != "") ? pid.pid7.ts1 : (),
    gender: GetHL7v23_PID_AdministrativeSex(pid.pid8),
    address: GetHL7v23_PID_Address(pid.pid12, pid.pid11),
    telecom: GetHL7v23_PID_PhoneNumber(pid.pid13, pid.pid14),
    communication: GetHL7v23_PID_PrimaryLanguage(pid.pid15),
    maritalStatus: {
        coding: (pid.pid16 != "") ? GetHL7v23_PID_MaritalStatus(pid.pid16) : ()
    },
    identifier: GetHL7v23_PID_SSNNumberPatient(pid.pid19),
    extension: (pid.pid23 != "") ? GetHL7v23_PID_BirthPlace(pid.pid23) : (),
    multipleBirthBoolean: (pid.pid24 != "") ? GetHL7v23_PID_MultipleBirthIndicator(pid.pid24) : (),
    multipleBirthInteger: (pid.pid25 != -1.0) ? GetHL7v23_PID_BirthOrder(pid.pid25) : (),
    deceasedDateTime: (pid.pid29.ts1 != "") ? pid.pid29.ts1 : (),
    deceasedBoolean: (pid.pid30 != "") ? GetHL7v23_PID_PatientDeathIndicator(pid.pid30) : ()
};

function HL7V2_PV1_to_FHIR_Patient(hl7v23:PV1 pv1) returns r4:Patient => {
    extension: (pv1.pv116 != "") ? GetHL7v23_PV1_Extension(pv1.pv116) : ()
};

// --- Financial Management ---
function HL7V2_DG1_to_FHIR_Condition(hl7v23:DG1 dg1) returns r4:Condition => {
    code: HL7V2_CE_to_FHIR_CodeableConcept(dg1.dg13),
    onsetDateTime: (dg1.dg15.ts1 != "") ? dg1.dg15.ts1 : (),
    recordedDate: (dg1.dg119.ts1 != "") ? dg1.dg119.ts1 : (),
    subject: {}
};

