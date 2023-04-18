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
        "AL1" => {
            r4:BundleEntry entry = {'resource: HL7V2_AL1_to_FHIR_AllerygyIntolerance(<hl7v23:AL1>segment)};
            entries.push(entry);
            return entries;
        }
        "EVN" => {
            r4:BundleEntry entry = {'resource: HL7V2_EVN_to_FHIR_Provenance(<hl7v23:EVN>segment)};
            entries.push(entry);
            return entries;
        }
        "MSH" => {
            r4:BundleEntry entry = {'resource: HL7V2_MSH_to_FHIR_MessageHeader(<hl7v23:MSH>segment)};
            entries.push(entry);
            return entries;
        }
        "PV2" => {
            r4:BundleEntry entry = {'resource: HL7V2_PV2_to_FHIR_Encounter(<hl7v23:PV2>segment)};
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
    language: HL7V2_CE_to_FHIR_code(msh.msh19),
    eventUri: ""
};

// --- Patient Administation
function HL7V2_AL1_to_FHIR_AllerygyIntolerance(hl7v23:AL1 al1) returns r4:AllergyIntolerance {
    r4:Coding[] coding = [{
        code: al1.al11.toString(),
        system: al1.al11.toString()
    }];

    r4:AllergyIntoleranceReaction[] allergyIntoleranceReaction = [{
        manifestation: [{
            text: al1.al15
        }],
        onset: al1.al16
    }];

    r4:AllergyIntolerance allergyIntolerance = {
        clinicalStatus: {
            coding: coding
        },
        category: [V2ToFHIR_GetAllergyIntoleranceCategory(al1.al12)],
        'type: V2ToFHIR_GetAllergyIntoleranceType(al1.al12),
        code: HL7V2_CE_to_FHIR_CodeableConcept(al1.al13),
        criticality: V2ToFHIR_GetAllergyIntoleranceCriticality(al1.al14),
        reaction: allergyIntoleranceReaction,
        patient: {}
    };

    return allergyIntolerance;
};

// TODO: Ballerina FHIR EVN and HL7 EVN is different for some fields
function HL7V2_EVN_to_FHIR_Provenance(hl7v23:EVN evn) returns r4:Provenance {
    r4:Coding[] coding = [
        {
            display: evn.name
        }
    ];

    r4:Extension[] extension = [
        {
            url: evn.evn4
            // ,
            // valueCodeableConcept: evn.evn4
        }
    ];

    r4:CodeableConcept[] reason = [
        {
            extension: extension
        }
    ];

    r4:ProvenanceAgent[] agent = [
        {
            who: HL7V2_XCN_to_FHIR_Reference(evn.evn5)
        }
    ];

    r4:Provenance provenance = {
        activity: {
            coding: coding
        },
        recorded: evn.evn2.ts1,
        reason: reason,
        meta: {
            extension: extension
        },
        agent: agent,
        occurredDateTime: evn.evn6.ts1,
        target: []
    };

    return provenance;
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

function HL7V2_PV2_to_FHIR_Encounter(hl7v23:PV2 pv2) returns r4:Encounter {
    r4:EncounterLocation[] location = [
        {
            location: {
                display: pv2.pv21.pl1 // TODO: location need to mapped correctly
            }
        }
    ];

    r4:Coding[] coding = [HL7V2_ID_to_FHIR_Coding(pv2.pv222)];

    r4:EncounterParticipant[] participant = [{id: pv2.pv213.xcn1}]; // TODO: participant need to mapped correctly

    r4:Encounter encounter = {
        location: location,
        reasonCode: HL7V2_GetCodeableConcepts(pv2.pv23),
        length: {
            value: <decimal>pv2.pv211
        },
        text: {
            div: pv2.pv212,
            status: "empty"
        },
        priority: {
            text: pv2.pv225
        },
        meta: {
            security: coding
        },
        participant: participant,
        'class: {},
        status: "in-progress"
    };

    return encounter;
};


// --- Financial Management ---
function HL7V2_DG1_to_FHIR_Condition(hl7v23:DG1 dg1) returns r4:Condition => {
    code: HL7V2_CE_to_FHIR_CodeableConcept(dg1.dg13),
    onsetDateTime: (dg1.dg15.ts1 != "") ? dg1.dg15.ts1 : (),
    recordedDate: (dg1.dg119.ts1 != "") ? dg1.dg119.ts1 : (),
    subject: {}
};

