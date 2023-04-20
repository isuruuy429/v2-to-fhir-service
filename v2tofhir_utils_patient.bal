import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v24;
import wso2healthcare/healthcare.hl7v25;
import wso2healthcare/healthcare.hl7v23;
import ballerina/log;

public function GetHL7v23_PID_AdministrativeSex(string pid8) returns r4:PatientGender {
    match pid8 {
        "M" => {
            return "male";
        }
        "F" => {
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

public function GetHL7v23_PID_PatientName(hl7v23:XPN[]|hl7v24:XPN[]|hl7v25:XPN[] pid5, hl7v23:XPN[]|hl7v24:XPN[]|hl7v25:XPN[] pid9) returns r4:HumanName[] {
    r4:HumanName[] humanNames = [];
    if pid5 is hl7v23:XPN[] {
        foreach hl7v23:XPN item in pid5 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    } else if pid5 is hl7v24:XPN[] {
        foreach hl7v24:XPN item in pid5 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    } else if pid5 is hl7v25:XPN[] {
        foreach hl7v25:XPN item in pid5 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    }

    if pid9 is hl7v23:XPN[] {
        foreach hl7v23:XPN item in pid9 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    } else if pid9 is hl7v24:XPN[] {
        foreach hl7v24:XPN item in pid9 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    } else if pid9 is hl7v25:XPN[] {
        foreach hl7v25:XPN item in pid9 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                humanNames.push(name);
            }
        }
    }

    return humanNames;
}

public function GetHL7v23_PID_Address(string pid12, hl7v23:XAD[]|hl7v24:XAD[]|hl7v25:XAD[] pid11) returns r4:Address[] {
    r4:Address[] address = [];
    if pid12 != "" {
        address.push({district: pid12});
    }

    if pid11 is hl7v23:XAD[] {
        foreach hl7v23:XAD item in pid11 {
            address.push(HL7V2_XAD_to_FHIR_Address(item));
        }
    } else if pid11 is hl7v24:XAD[] {
        foreach hl7v24:XAD item in pid11 {
            address.push(HL7V2_XAD_to_FHIR_Address(item));
        }
    } else if pid11 is hl7v25:XAD[] {
        foreach hl7v25:XAD item in pid11 {
            address.push(HL7V2_XAD_to_FHIR_Address(item));
        }
    }

    return address;
}

public function GetHL7v23_PID_PhoneNumber(hl7v23:XTN[]|hl7v24:XTN[]|hl7v25:XTN[] pid13, hl7v23:XTN[]|hl7v24:XTN[]|hl7v25:XTN[] pid14) returns r4:ContactPoint[] {
    r4:ContactPoint[] phoneNumbers = [];

    //get ContactPointFromXTN use this
    if pid13 is hl7v23:XTN[] {
        foreach hl7v23:XTN item in pid13 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    } else if pid13 is hl7v24:XTN[] {
        foreach hl7v24:XTN item in pid13 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    } else if pid13 is hl7v25:XTN[] {
        foreach hl7v25:XTN item in pid13 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    }

    if pid14 is hl7v23:XTN[] {
        foreach hl7v23:XTN item in pid14 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    } else if pid14 is hl7v24:XTN[] {
        foreach hl7v24:XTN item in pid14 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    } else if pid14 is hl7v25:XTN[] {
        foreach hl7v25:XTN item in pid14 {
            r4:ContactPoint contactPoint = HL7V2_XTN_to_FHIR_ContactPoint(item);
            if contactPoint != {} {
                phoneNumbers.push(contactPoint);
            }
        }
    }

    return phoneNumbers;
}

public function GetHL7v23_PID_PrimaryLanguage(hl7v23:CE|hl7v24:CE|hl7v25:CE pid15) returns r4:PatientCommunication[] {
    r4:CodeableConcept language = {
        id: (pid15.ce1 != "") ? pid15.ce1 : (),
        text: (pid15.ce2 != "") ? pid15.ce2 : ()
    };

    if language != {} {
        return [
            {
                language: language
            }
        ];
    }
    return [];
}

public function GetHL7v23_PID_MaritalStatus(string|hl7v24:CE|hl7v25:CE pid16) returns r4:Coding[] {
    r4:Coding[] maritialStatues = [];
    if pid16 is hl7v24:CE|hl7v25:CE {
        maritialStatues = [{code: pid16.ce1}];
    } else if pid16 is string {
        maritialStatues = [{code: pid16}];
    }
    return maritialStatues;
}

public function GetHL7v23_PID_SSNNumberPatient(string pid19) returns r4:Identifier[] {
    r4:Identifier[] identifier = [];
    if pid19 != "" {
        identifier.push({value: pid19});
    }
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

public function GetHL7v23_PID_BirthOrder(float|string pid25) returns int {
    
    if pid25 is float {
        return <int>pid25;
    } else {
        do {
	        int intResult = check int:fromString(pid25);
            return intResult;
        } on fail var e {
        	log:printError("Error while converting string to int", e);
        }
    }
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
public function GetHL7v23_PD1_GeneralPractitioner(hl7v23:XON[]|hl7v24:XON[]|hl7v25:XON[] pd13, hl7v23:XCN[]|hl7v24:XCN[]|hl7v25:XCN[] pd14) returns r4:Reference[] {
    r4:Reference[] reference = [];

    if pd13 is hl7v23:XON[] {
        foreach hl7v23:XON item in pd13 {
            if item.toString() != "" {
                reference.push({
                    'type: "Organization",
                    display: item.toString()
                });
            }
        }
    } else if pd13 is hl7v24:XON[] {
        foreach hl7v24:XON item in pd13 {
            if item.toString() != "" {
                reference.push({
                    'type: "Organization",
                    display: item.toString()
                });
            }
        }
    } else if pd13 is hl7v25:XON[] {
        foreach hl7v25:XON item in pd13 {
            if item.toString() != "" {
                reference.push({
                    'type: "Organization",
                    display: item.toString()
                });
            }
        }
    }

    if pd14 is hl7v23:XCN[] {
        foreach hl7v23:XCN item in pd14 {
            if item.toString() != "" {
                reference.push({
                    'type: "Practitioner",
                    display: item.toString()
                });
            }
        }
    } else if pd14 is hl7v24:XCN[] {
        foreach hl7v24:XCN item in pd14 {
            if item.toString() != "" {
                reference.push({
                    'type: "Practitioner",
                    display: item.toString()
                });
            }
        }
    } else if pd14 is hl7v25:XCN[] {
        foreach hl7v25:XCN item in pd14 {
            if item.toString() != "" {
                reference.push({
                    'type: "Practitioner",
                    display: item.toString()
                });
            }
        }
    }

    return reference;
}

public function GetHL7v23_PD1_Extension(string pd16) returns r4:Extension[] {
    r4:CodeableConcept codeableConcept = {text: pd16};
    r4:CodeableConceptExtension[] extension = [{url: pd16, valueCodeableConcept: codeableConcept}];

    return extension;
}

public function GetHL7v23_NK1_Contact(hl7v23:XPN[]|hl7v24:XPN[]|hl7v25:XPN[] nk12, hl7v23:XAD[]|hl7v24:XAD[]|hl7v25:XAD[] nk14,
        hl7v23:XTN[]|hl7v24:XTN[]|hl7v25:XTN[] nk15, hl7v23:XTN[]|hl7v24:XTN[]|hl7v25:XTN[] nk16, hl7v23:CE|hl7v24:CE|hl7v25:CE nk17,
        hl7v23:DT|hl7v24:DT|hl7v25:DT nk18, hl7v23:DT|hl7v24:DT|hl7v25:DT nk19, hl7v23:XON[]|hl7v24:XON[]|hl7v25:XON[] nk113,
        hl7v23:IS|hl7v24:IS|hl7v25:IS nk115, hl7v23:XPN[]|hl7v24:XPN[]|hl7v25:XPN[] nk130, hl7v23:XTN[]|hl7v24:XTN[]|hl7v25:XTN[] nk131,
        hl7v23:XAD[]|hl7v24:XAD[]|hl7v25:XAD[] nk132) returns r4:PatientContact[] {
    r4:PatientContact[] patientContact = [];

    if nk12 is hl7v23:XPN[] {
        foreach hl7v23:XPN item in nk12 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                patientContact.push({
                    name: name
                });
            }
        }
    } else if nk12 is hl7v24:XPN[] {
        foreach hl7v24:XPN item in nk12 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                patientContact.push({
                    name: name
                });
            }
        }
    } else if nk12 is hl7v25:XPN[] {
        foreach hl7v25:XPN item in nk12 {
            r4:HumanName name = HL7V2_XPN_to_FHIR_HumanName(item);
            if name != {} {
                patientContact.push({
                    name: name
                });
            }
        }
    }

    if nk14 is hl7v23:XAD[] {
        foreach hl7v23:XAD item in nk14 {
            r4:Address address = HL7V2_XAD_to_FHIR_Address(item);
            if address != {} {
                patientContact.push({
                    address: HL7V2_XAD_to_FHIR_Address(item)
                });
            }
        }
    } else if nk14 is hl7v24:XAD[] {
        foreach hl7v24:XAD item in nk14 {
            r4:Address address = HL7V2_XAD_to_FHIR_Address(item);
            if address != {} {
                patientContact.push({
                    address: HL7V2_XAD_to_FHIR_Address(item)
                });
            }
        }
    } else if nk14 is hl7v25:XAD[] {
        foreach hl7v25:XAD item in nk14 {
            r4:Address address = HL7V2_XAD_to_FHIR_Address(item);
            if address != {} {
                patientContact.push({
                    address: HL7V2_XAD_to_FHIR_Address(item)
                });
            }
        }
    }

    r4:ContactPoint[] telecoms = [];

    if nk15 is hl7v23:XTN[] {
        foreach hl7v23:XTN item in nk15 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    } else if nk15 is hl7v24:XTN[] {
        foreach hl7v24:XTN item in nk15 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    } else if nk15 is hl7v25:XTN[] {
        foreach hl7v25:XTN item in nk15 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    }

    if nk16 is hl7v23:XTN[] {
        foreach hl7v23:XTN item in nk16 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    } else if nk16 is hl7v24:XTN[] {
        foreach hl7v24:XTN item in nk16 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    } else if nk16 is hl7v25:XTN[] {
        foreach hl7v25:XTN item in nk16 {
            telecoms.push(HL7V2_XTN_to_FHIR_ContactPoint(item));
        }
    }

    patientContact.push({
        telecom: telecoms
    });

    r4:CodeableConcept[] relationship = [];
    relationship.push(HL7V2_CE_to_FHIR_CodeableConcept(nk17));
    patientContact.push({
        relationship: relationship
    });

    r4:Period period = {'start: nk18, end: nk19};
    patientContact.push({
        period: period
    });

    // nk115, nk130, nk131, nk132 needs to be considered

    return patientContact;
}
