import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

public function GetHL7v23_PID_AdministrativeSex(string pid8) returns r4:PatientGender {
    match pid8 {
        "F" => {
            return "male";
        }
        "M" => {
            return "female";
        }
        "O" => {
            return "other";
        }
        "U" => {
            return "unknown";
        }
        _ => {
            return "unknown";
        }
    }
}

public function GetHL7v23_PID_PatientName(hl7v23:XPN[] pid5, hl7v23:XPN[] pid9) returns r4:HumanName[] {
    r4:HumanName[] humanNames = [];

    foreach hl7v23:XPN item in pid5 {
        humanNames.push(HL7V2_XPN_to_FHIR_HumanName(item));
    }

    foreach hl7v23:XPN item in pid9 {
        humanNames.push(HL7V2_XPN_to_FHIR_HumanName(item));
    }

    return humanNames;
}

public function GetHL7v23_PID_Address(string pid12, hl7v23:XAD[] pid11) returns r4:Address[] {
    r4:Address[] address = [{district: pid12}];

    foreach hl7v23:XAD item in pid11 {
        address.push(HL7V2_XAD_to_FHIR_Address(item));
    }

    return address;
}

public function GetHL7v23_PID_PhoneNumber(hl7v23:XTN[] pid13, hl7v23:XTN[] pid14) returns r4:ContactPoint[] {
    r4:ContactPoint[] phoneNumbers = [];

    //get ContactPointFromXTN use this
    foreach hl7v23:XTN item in pid13 {
        phoneNumbers.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
    }

    foreach hl7v23:XTN item in pid14 {
        phoneNumbers.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
    }

    return phoneNumbers;
}

public function GetHL7v23_PID_PrimaryLanguage(hl7v23:CE pid15) returns r4:PatientCommunication[] {
    r4:CodeableConcept language = {
        id: pid15.ce1,
        // extension:
        // coding: 
        text: pid15.ce2
    };

    r4:PatientCommunication[] languages = [
        {
            language: language
        }
    ];

    return languages;
}

public function GetHL7v23_PID_MaritalStatus(string pid16) returns r4:Coding[] {
    r4:Coding[] maritialStatues = [{code: pid16}];

    return maritialStatues;
}

// public function GetHL7v23_PID_Religion(string pid17) returns r4:Extension[]{
//     r4:Extension[] extensions = [{url: pid16}];

//     return  extensions;
// }

public function GetHL7v23_PID_SSNNumberPatient(string pid19) returns r4:Identifier[] {
    r4:Identifier[] identifier = [{value: pid19}];

    return identifier;
}

public function GetHL7v23_PID_BirthPlace(string pid23) returns r4:Extension[] {
    r4:StringExtension[] extension = [{url: pid23, valueString: pid23}];

    return extension;
}

public function GetHL7v23_PID_MultipleBirthIndicator(string pid24) returns boolean {
    match pid24 {
        "N" => {
            return false;
        }
        "Y" => {
            return true;
        }
        _ => {
            return false;
        }
    }
}

public function GetHL7v23_PID_BirthOrder(float pid25) returns int {
    return <int>pid25;
}

public function GetHL7v23_PID_PatientDeathIndicator(string pid30) returns boolean {
    match pid30 {
        "false" => {
            return false;
        }
        "true" => {
            return true;
        }
        _ => {
            return false;
        }
    }
}

// PV1
public function GetHL7v23_PV1_Extension(string pv116) returns r4:Extension[] {
    r4:CodeableConcept codeableConcept = {text: pv116};
    r4:CodeableConceptExtension[] extension = [{url: pv116, valueCodeableConcept: codeableConcept}];

    return extension;
}

// PD1
public function GetHL7v23_PD1_GeneralPractitioner(hl7v23:XON[] pd13, hl7v23:XCN[] pd14) returns r4:Reference[] {
    r4:Reference[] reference = [];

    foreach hl7v23:XON item in pd13 {

        reference.push({
            // id: 
            // extension:
            // reference:
            'type: "Organization",
            // identifier:
            display: item.toString()
        });
    }

    foreach hl7v23:XCN item in pd14 {
        reference.push({
            // id: 
            // extension:
            // reference:
            'type: "Practitioner",
            // identifier:
            display: item.toString()
        });
    }

    return reference;
}

public function GetHL7v23_PD1_Extension(string pd16) returns r4:Extension[] {
    r4:CodeableConcept codeableConcept = {text: pd16};
    r4:CodeableConceptExtension[] extension = [{url: pd16, valueCodeableConcept: codeableConcept}];

    return extension;
}

public function GetHL7v23_NK1_Contact(hl7v23:XPN[] nk12, hl7v23:XAD[] nk14, hl7v23:XTN[] nk15, hl7v23:XTN[] nk16, hl7v23:CE nk17, hl7v23:DT nk18, hl7v23:DT nk19, hl7v23:XON[] nk113, hl7v23:IS nk115, hl7v23:XPN[] nk130, hl7v23:XTN[] nk131, hl7v23:XAD[] nk132) returns r4:PatientContact[] {
    r4:PatientContact[] patientContact = [];

    foreach hl7v23:XPN item in nk12 {
        patientContact.push({
            // extension: 
            // period:
            // address:
            // gender:
            // modifierExtension:
            // organization:
            name: HL7V2_XPN_to_FHIR_HumanName(item)
            // telecom:
            // id:
            // relationship:
        });
    }

    foreach hl7v23:XAD item in nk14 {
        patientContact.push({
            // extension: 
            // period:
            address: HL7V2_XAD_to_FHIR_Address(item)
            // gender:
            // modifierExtension:
            // organization:
            // name:
            // telecom:
            // id:
            // relationship:
        });
    }

    r4:ContactPoint[] telecoms = [];
    foreach hl7v23:XTN item in nk15 {
        telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
    }
    foreach hl7v23:XTN item in nk16 {
        telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
    }
    patientContact.push({
        // extension: 
        // period:
        // address:
        // gender:
        // modifierExtension:
        // organization:
        // name:
        telecom: telecoms
        // id:
        // relationship:
    });

    r4:CodeableConcept[] relationship = [];
    relationship.push(HL7V2_CE_to_FHIR_CodeableConcept(nk17));
    patientContact.push({
        // extension: 
        // period:
        // address:
        // gender:
        // modifierExtension:
        // organization:
        // name:
        // telecom:
        // id:
        relationship: relationship
    });

    r4:Period period = {'start: nk18, end: nk19};
    patientContact.push({
        // extension: 
        period:period
        // address:
        // gender:
        // modifierExtension:
        // organization:
        // name:
        // telecom:
        // id:
        // relationship: 
    });

    // nk115, nk130, nk131, nk132 needs to be considered

    return patientContact;
}
